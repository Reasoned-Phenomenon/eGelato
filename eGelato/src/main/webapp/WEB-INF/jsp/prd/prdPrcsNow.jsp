<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 실적</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<div>
		<br>
		<h2>공정실적관리</h2>
		<br>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-11">
			<table>
			<tbody>
				<tr>
					<th>공정명</th>
					<td>
						<input type="text" id="prcsDeta" readonly>
					</td>
					<td rowspan="3">
	                    <button type="button" class="btn btn-secondary" id="btnSearch">검색</button>
	                    <button type="button" class="btn btn-secondary" id="btnClear">초기화</button>
	                </td>
				</tr>
				<tr>
					<th>생산 지시 목록</th>
					<td>
						<input type="text" id="indicaList" readonly>
					</td>
				</tr>
				<tr>
				<th>불량 분류</th>
					<td>
						<select name="infer">
							<option value="choose" selected>선택</option>
							  <option value="PDB-00101">불순물 검출</option>
							  <option value="PDB-00100">포장지 훼손</option>
							  <option value="PDB-00102">아이스크림 제형 파손</option>
							  <option value="PDB-00103">용기 파손</option>
							  <option value="PDB-00104">용량 미달</option>
						</select>
					</td>
				</tr>
			</tbody>
			</table>
		</div>
		<div class="col-sm-1">
			<button type="button" class="btn btn-secondary" id="btnIns">등록</button>
		</div>
	</div>
	<hr>
	<div id="prcsList"></div>
	
	<!-- 공정 모달-->
	<div id="prcsDialog" title="공정 목록"></div>
	<!-- 지시 모달-->
	<div id="indicaDialog" title="생산 지시 목록"></div>
	
<script>
	//계획 조회 그리드 생성
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
	
	// 그리드 생성 : 관리
	const prcsList = new Grid({
		el : document.getElementById('prcsList'),
		data : {
			api : {
				readData : {url : '${path}',method : 'GET'}
			},
			contentType : 'application/json',
			initialRequest: false
		},
		rowHeaders : ['rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 600,
		columns : [ {
			header : '생산계획코드',
			name : 'indicaDetaId'
		}, {
			header : '생산코드',
			name : 'prcsNowId',
		}, {
			header : '공정명',
			name : 'nm',
		}, {
			header : '설비코드',
			name : 'eqmId',
		}, {
			header : '설비명',
			name : 'eqmName',
		}, {
			header : '투입량',
			name : 'inptQy',
		},{
			header : '생산량',
			name : 'qy',
		},{
			header : '불량량',
			name : 'inferQy',
		},{
			header : '불량코드',
			name : 'inferId',
		},{
			header : '불량상세',
			name : 'deta',
		},{
			header : '공정시작시간',
			name : 'qy',
			align: 'frTm',
		}, {
			header : '공정종료시간',
			name : 'toTm',
		}, {
			header : '담당자명',
			name : 'mngr',
		},{
			header : '지시일자',
			name : 'indicaDt',
		}]
	});
	
	//모달창 출력
	document.getElementById("prcsDeta").addEventListener("click", function() {
		  callPrcsModal();
	});
	document.getElementById("indicaList").addEventListener("click", function() {
		  callIndicaModal();
	});
	
	// 공정명 출력, 삭제
	function chooseNm(pcn) {
		console.log(pcn);
		document.getElementById("prcsDeta").value = pcn;
		
		prcsDialog.dialog( "close" );
	}
	
	function callPrcsModal() {
		var prcsDialog = $("#prcsDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 1000
		});

		prcsDialog.dialog("open");
		$("#prcsDialog").load("${path}/prd/prcsDialog.do", function() {
					console.log("공정목록모달")
				})
	}
	
	//지시 출력
	function callIndicaModal() {
		var indicaDialog = $("#indicaDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 1000
		});

		indicaDialog.dialog("open");
		$("#indicaDialog").load("${path}/prd/indicaDialog.do", function() {
					console.log("지시목록모달")
				})
	}
	
	
</script>
</body>
</html>