<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산관리</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<div>
		<br>
		<h2>생산관리</h2>
		<br>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-10">
			<button type="button" class="btn btn-secondary" id="btnSearchPlan">생산지시목록</button>
		</div>
		<div class="col-sm-2">
			<button type="button" class="btn btn-secondary" id="btnPrcsMove">공정이동표 출력</button>
		</div>
	</div>
	<hr>
	<div>
		<h3>진행생산지시</h3>
		<hr>
		<div id="IndicaGrid"></div>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-7">
			<h3>공정목록</h3>
			<hr>
			<div id="prcsListGrid"></div>
		</div>
		<div class="col-sm-5">
			<h3>공정상세사항</h3>
			<hr>
			<table>
				<tbody>
					<tr>
						<th>시작시간</th>
						<td><input type="time" id="startT" readonly></td>
					</tr>
					<tr>
						<th>종료예정시간</th>
						<td><input type="time" id="endT" readonly></td>
					</tr>
				</tbody>
			</table>
			<br><br>
			<button type="button" class="btn btn-secondary" id="btnPrcs">생산시작</button>&nbsp;
		</div>
	</div>	
	
	<!-- 생산지시 조회 모달-->
	<div id="nonPrcsDialog" title="생산 지시 목록"></div>
	<!-- 공정이동표 -->
	<div id="prcsMoveDialog" title="공정이동표"></div>
	
<script>
	// 생산 시작 버튼 
	document.getElementById('btnPrcs').innerText = '생산 시작';
	
	// 그리드 생성
		var Grid = tui.Grid;

		//그리드 테마
		Grid.applyTheme('striped', {
			cell : {
				header : {
					background : '#eef'
				},
				evenRow : {
					background : '#fee'
				},
				selectedHeader : {
			    	background : '#FFFFFF'
			    }
			}
		});
		
		// 그리드1
		const IndicaGrid = new Grid({
			el : document.getElementById('IndicaGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/selectIndica.do',method : 'GET'},
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '생산지시코드',
				name : 'indicaDetaId'
			}, {
				header : '제품명',
				name : 'prdtNm',
			}, {
				header : '제품코드',
				name : 'prdtId',
			}, {
				header : '수량',
				name : 'qy',
			}, {
				header : '라인코드',
				name : 'lineId',
			}, {
				header : '지시순번',
				name : 'ord',
			}]
		});
		
		//그리드2  
		const prcsListGrid = new Grid({
			el : document.getElementById('prcsListGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/prcsList.do',method : 'GET'},
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '진행공정코드',
				name : 'prcsNowId'
			}, {
				header : '공정코드',
				name : 'prcsId'
			}, {
				header : '공정명',
				name : 'nm',
			}, {
				header : '설비코드',
				name : 'eqmId',
			}, {
				header : '설비명',
				name : 'eqmName',
			},{
				header : '담당자',
				name : 'mngr',
			}]
		});
	
	
	// 모달창
	var nonPrcsDialog = $("#nonPrcsDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 1000
		});
	
	$("#btnSearchPlan").on(
			"click",
			function() {
				nonPrcsDialog.dialog("open");
				$("#nonPrcsDialog").load("${path}/prd/nonPrcsDialog.do",
						function() {
							console.log("주문창 로드")
						})
			});
	
	// indicaId 받아서 readData 넘기기
	function choosePi(cid,cpn){
		console.log(cid);
		console.log(cpn);
		
		IndicaGrid.clear();
		prcsListGrid.clear();
		
		IndicaGrid.readData(1, {'indicaDetaId':cid}, true);
		prcsListGrid.readData(1, {'prdtNm':cpn, 'indicaDetaId':cid}, true);
		
		nonPrcsDialog.dialog("close");
		
	}
	
	// 시간입력
	btnPrcs.addEventListener('click', function () {
		
		let now = new Date();
		startT.value = ("00"+now.getHours()).slice(-2)+":"+("00"+now.getMinutes()).slice(-2);
		console.log(startT.value)
		
	})
	
	function lpad(val, padLength, padString){
		while(val.length < padLength)
			{val = padString + val;}
		    return val;
		}
	
	// 공정이동표
	var prcsMoveDialog = $("#prcsMoveDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 1000
		});
	
	$("#btnPrcsMove").on(
			"click",
			function() {
				prcsMoveDialog.dialog("open");
				$("#prcsMoveDialog").load("${path}/prd/prcsMoveDialog.do",
						function() {
							console.log("공정이동표 로드")
						})
			});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	
</script>
</body>
</html>