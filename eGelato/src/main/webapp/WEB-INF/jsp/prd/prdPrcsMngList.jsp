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
							<button type="button"  id="btnPrcSel">검색</button>
							<button type="button"  id="btnClear">초기화</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-sm-2">
			<button type="button"  id="btnAdd">추가</button>
			<button type="button"  id="btnDel">삭제</button>
			<button type="button"  id="btnIns">저장</button>
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
	/* Grid.applyTheme('striped', {
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
	}); */
	
	// 그리드 생성 : 관리
	const prcsMngList = new Grid({
		el : document.getElementById('prcsMngList'),
		data : {
			api : {
				readData : {url : '${path}/prd/prcsMngList.do',method : 'GET'},
				modifyData : { url: '${path}/prd/prcsModifyData.do', method: 'PUT'} 
			},
			contentType : 'application/json',
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
			align: 'center',
			editor: {
	            type: GelatoSelectEditor,
	            options: {
	            	listItems : [
	            		{text: '선택', value: ''},
						{text: '냉동공정', value: 'FREZ'},
						{text: '성형공정', value: 'SHAP'},
						{text: '혼합공정', value: 'BLEN'},
						{text: '분쇄공정', value: 'CRSH'},
						{text: '코팅공정', value: 'COAT'},
						{text: '개별포장공정', value: 'UNIT'},
						{text: '박스포장공정', value: 'BOXI'},
						{text: '품질검사공정', value: 'FORE'},
						{text: '무게검사공정', value: 'WIGH'},
	            		]}
		      		},
		    renderer: {
		            type: GelatoSelect
		      },
			validation: {
				required: true
			}
		}, {
			header : '공정명',
			name : 'nm',
			editor : 'text',
			validation: {
				required: true
			}
		}, {
			header : '설비코드',
			name : 'eqmId',
			validation: {
				required: true
			}
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
		    if (ev.columnName === 'eqmId') {
				calleqmId();
			} else if (ev.columnName === 'eqmName' || ev.columnName === 'modelNo' || ev.columnName === 'mngr') {
				toastr.clear()
				toastr.error( ('공정코드를 선택해주세요.'),'Gelato',{timeOut:'1000'} );
			} else if (ev.columnName === 'prcsId') {
				toastr.clear()
				toastr.error( ('공정코드를 선택해주세요.'),'Gelato',{timeOut:'1000'} );
			}
		});
	
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
	
	function chooseEq(uei,uen,umn,umg) {
		console.log(uei);
		console.log(uen);
		console.log(umn);
		console.log(umg);
		
		prcsMngList.setValue(rk, "eqmId", uei, true);
		prcsMngList.setValue(rk, "eqmName", uen, true);
		prcsMngList.setValue(rk, "modelNo", umn, true);
		prcsMngList.setValue(rk, "mngr", umg, true);
		
		eqmDialog.dialog( "close" );
	}
	
	
	// 행추가
	btnAdd.addEventListener("click", function() {
		prcsMngList.prependRow();
	});
	
	// 토스트옵션
	toastr.options = {
			positionClass : "toast-top-center",
			progressBar : true,
			timeOut: 1500 // null 입력시 무제한.
		}
	
	// 행삭제
	btnDel.addEventListener("click", function() {
		if(confirm("삭제하시겠습니까?")){ 
			prcsMngList.removeCheckedRows(false) //true -> 확인 받고 삭제 / false는 바로 삭제
			prcsMngList.request('modifyData', { showConfirm : false });
			
			toastr.clear()
			toastr.success( ('삭제되었습니다.'),'Gelato',{timeOut:'1000'} );
		}
	});
	
	// 등록, 수정
	btnIns.addEventListener("click", function() {
		prcsMngList.blur();
		if(confirm("저장하시겠습니까?")){ 
			prcsMngList.request('modifyData', { showConfirm : false });
			
			toastr.clear()
			toastr.success( ('저장되었습니다.'),'Gelato',{timeOut:'1000'} )
		}
	})
	
	
	
</script>
</body>
</html>