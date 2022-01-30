<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 관리</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<div>
		<br>
		<h2>공정관리</h2>
		<br>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-10">
			<table>
				<tbody>
					<tr>
						<th>공정구분</th>
						<td>
							<select name="prcsSelDeta" id="prcsSelDeta">
								<option value="" selected>선택</option>
								<option value="FREZ">냉동공정</option>
								<option value="SHAP">성형공정</option>
								<option value="BLEN">혼합공정</option>
								<option value="CRSH">분쇄공정</option>
								<option value="COAT">코팅공정</option>
								<option value="UNIT">개별포장공정</option>
								<option value="BOXI">박스포장공정</option>
								<option value="FORE">품질검사공정</option>
								<option value="WIGH">무게검사공정</option>
							</select>
						</td>
						<td>
							<button type="button" class="btn btn-secondary" id="btnPrcSel">검색</button>
							<button type="button" class="btn btn-secondary" id="btnClear">초기화</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-sm-2">
			<button type="button" class="btn btn-secondary" id="btnAdd">추가</button>
			<button type="button" class="btn btn-secondary" id="btnDel">삭제</button>
			<button type="button" class="btn btn-secondary" id="btnIns">저장</button>
		</div>
	</div>
	<br><hr><br>
	<div id="prcsMngList"></div> 
	
	<!-- 공정 모달-->
	<div id="prcsDetaDialog" title="상세 공정 코드 목록"></div>
	<!-- 설비 모달-->
	<div id="eqmDialog" title="미사용 설비 목록"></div>
	
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
	const prcsMngList = new Grid({
		el : document.getElementById('prcsMngList'),
		data : {
			api : {
				readData : {url : '${path}/prd/prcsMngList.do',method : 'GET'}
			},
			contentType : 'application/json',
			initialRequest: false
		},
		rowHeaders : [ 'checkbox', 'rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 600,
		columns : [ {
			header : '공정코드',
			name : 'prcsId',
		}, {
			header : '공정구분',
			name : 'prcsSelDeta',
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
			header : '모델명',
			name : 'modelNo',
		}, {
			header : '담당자명',
			name : 'mngr',
		}]
	});
	
	// 초기화
	$("#btnClear").on(
		"click",
		function() {
			$("#prcsSelDeta").val('');
			prcsMngList.clear();
	});
	
	// 검색
	$("#btnPrcSel").on(
			"click", function(){
				prcsSelDeta = document.getElementById("prcsSelDeta").value;
				
				console.log(prcsSelDeta);
				
				prcsMngList.readData(1,{'prcsSelDeta':prcsSelDeta }, true);
			})

	// 그리드 클릭
	prcsMngList.on('dblclick', (ev) => {
			rk = ev.rowKey;
			console.log(ev)
		    if (ev.columnName === 'prcsSelDeta') {
				callprcsSelDeta();
			} else if (ev.columnName === 'eqmId') {
				calleqmId();
			}
		});
	
	function callprcsSelDeta(){
		prcsDetaDialog = $("#prcsDetaDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 400,
			width: 600
		});
		
	    console.log("11111")
	    prcsDetaDialog.dialog( "open" );
	    $("#prcsDetaDialog").load(
							"${path}/prd/prcsDetaDialog.do", function() {
								console.log("공정코드목록 로드")
							})
	}
	
	function calleqmId(){
	    	eqmDialog = $("#eqmDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 800
		});
		
	    console.log("11111")
	    eqmDialog.dialog( "open" );
	    $("#eqmDialog").load(
							"${path}/prd/eqmDialog.do", function() {
								console.log("설비목록 로드")
							})
    }					
	
	// 행추가
	btnAdd.addEventListener("click", function() {
		prcsMngList.prependRow();
	});
	
	// 행삭제
	btnDel.addEventListener("click", function() {
		if(confirm("삭제하시겠습니까?")){ 
			prcsMngList.removeCheckedRows(false) //true -> 확인 받고 삭제 / false는 바로 삭제
		}
	});
</script>
</body>
</html>