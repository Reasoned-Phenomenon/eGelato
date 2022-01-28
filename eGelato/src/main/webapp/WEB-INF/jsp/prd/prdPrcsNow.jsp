<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 실적</title>
</head>
<body>
	<div>
		<br>
		<h2>공정실적</h2>
		<br>
	</div>
	<br>
	<div>
		<button type="button" class="btn btn-secondary" id="btnSearchPlan">생산지시목록</button>
	</div>
	<hr>
	<div class="row">
		<div class="col-sm-5">
			<h3>공정목록</h3>
			<hr>
			<div id="prcsListGrid"></div>
		</div>
		<div class="col-sm-7">
			<h3>공정별실적</h3>
			<hr>
			<div id="prcsDetaGrid"></div>
		</div>
	</div>
	
	<!-- 생산지시 조회 모달-->
	<div id="nonPrcsDialog" title="생산 지시 목록"></div>
<script>

	//그리드 생성
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
	
		//그리드1
		const prcsListGrid = new Grid({
			el : document.getElementById('prcsListGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/prcsNowList.do',method : 'GET'},
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
				header : '지시디테일',
				name : 'indicaDetaId',
				hidden : true
			}]
		});
		
		//그리드2
		const prcsDetaGrid = new Grid({
			el : document.getElementById('prcsDetaGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/prcsDetaList.do',method : 'GET'},
				},
				contentType : 'application/json',
				initialRequest: false
			},
			//rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '시작시간',
				name : 'frTm',
			}, {
				header : '종료시간',
				name : 'toTm',
			}, {
				header : '담당자명',
				name : 'mngr',
			}, {
				header : '지시량',
				name : 'inptQy',
			}, {
				header : '생산량',
				name : 'qy',
			}, {
				header : '불량코드',
				name : 'inferId',
			},  {
				header : '불량사유',
				name : 'deta',
			}, {
				header : '불량량',
				name : 'inferQy',
			}]
		});
		
	// 생산지시조회 모달창
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
				$("#nonPrcsDialog").load("${path}/prd/chooseIndicaDialog.do",
						function() {
							console.log("모달 로드")
						})
			});
	
	function choosePi(cid,cpn){
		nonPrcsDialog.dialog("close");
		
		//cid : 선택 지시디테일 아이디
		//cpn : 선택제품명
		
		prcsListGrid.readData(1, {'indicaDetaId':cid}, true);
	}
	
	prcsListGrid.on(
			"dblclick", (ev) => {
			
				prcsListGrid.setSelectionRange({
			    start: [ev.rowKey, 0],
			    end: [ev.rowKey, prcsListGrid.getColumns().length-1]
			});	
			
			var pni = prcsListGrid.getRow(ev.rowKey).prcsNowId;
			console.log(pni);
			var idi = prcsListGrid.getRow(ev.rowKey).indicaDetaId;
			console.log(idi);
			
			choosePl(pni, idi);
		});
	
	function choosePl(pni, idi) {
		console.log(pni);
		console.log(idi);
		
		prcsDetaGrid.readData(1, {'prcsNowId':pni, 'indicaDetaId':idi}, true);
	}
</script>
</body>
</html>