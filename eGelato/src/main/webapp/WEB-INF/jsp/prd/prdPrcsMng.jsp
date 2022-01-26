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
	<div>
		<button type="button" class="btn btn-secondary" id="btnSearchPlan">생산지시조회</button>
	</div>
	<hr>
	<div>
		<h3>진행생산지시</h3>
		<hr>
		<div id="IndicaGrid"></div>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-6">
			<h3>공정목록</h3>
			<hr>
			<div id="prcsListGrid"></div>
		</div>
		<div class="col-sm-6">
			<h3>공정상세사항</h3>
			<hr>
			<table>
				<tbody>
					<tr>
						<th>공정명</th>
						<td><input type="text" id="mngr" readonly></td>
					</tr>
					<tr>
						<th>담당자명*</th>
						<td><input type="text" id="mngr" required></td>
					</tr>
					<tr>
						<th>작업량*</th>
						<td><input type="text" id="inptQy" required></td>
					</tr>
					</tr>
					<tr>
						<th>시작시간</th>
						<td><input type="time" id="startT" readonly></td>
					</tr>
					<tr>
						<th>종료예정시간</th>
						<td><input type="time" id="endT" readonly></td>
					</tr>
					<tr>
						<th>불량량</th>
						<td><input type="text" id="inferQy"></td>
					</tr>
					<tr>
						<th>불량사유</th>
						<td>
							<select name="infer">
							  <option value="PDB-00101" selected>불순물 검출</option>
							  <option value="PDB-00100">포장지 훼손</option>
							  <option value="PDB-00102">아이스크림 제형 파손</option>
							  <option value="PDB-00103">용기 파손</option>
							  <option value="PDB-00104">용량 미달</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
			<br><br>
			<button type="button" class="btn btn-secondary" id="btnPrcs"></button>
		</div>
	</div>	
	
	<!-- 생산지시 조회 모달-->
	<div id="nonPrcsDialog" title="생산 지시 목록"></div>
	
	
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
		
		IndicaGrid.readData(1, {'IndicaDetaId':cid}, true);
		prcsListGrid.readData(1, {'prdtNm':cpn}, true);
		
		nonPrcsDialog.dialog("close");
		
	}
	
	// 시간입력
	btnPrcs.addEventListener('click', function () {
		
		let now = new Date();
		startT.value = ("00"+now.getHours()).slice(-2)+":"+("00"+now.getMinutes()).slice(-2);
		console.log(startT.value)
		
	})
</script>
</body>
</html>