<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안전재고 관리</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
</head>
<body>
<h3>안전재고 관리</h3>
<div style="margin: 20px;">
	<form action="">
		자재명 : <input type="text" id="rwmName">업체명 : <input type="text" id="vendName"><br>
		<button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</form>
</div>
<div style="float: right;">
	<button type="button" class="btn cur-p btn-outline-primary" id="btnSave">저장</button>
</div>
<hr>
<br>
<div class="container">
	<div class="flex row">
	<!-- 안전재고 그리드 -->
		<div class="col-7">
			<div id="rwmatrSafStcGrid" style="width: 80%"></div>
		</div>
		<div style="display: inline;">
			<h2 class="detailTitle">상세조회</h2><br>
				<form method="post" name="frm" id="frm" enctype="multipart/form-data">
					<table>
						<tbody>
							<tr>
								<th>BOM</th>
								<td><input id="bomId" name="bomId" readOnly></td>
							</tr>
							<tr>
								<th>공정코드</th>
								<td><input id="prcsId" name="prcsId" readOnly></td>
							</tr>
							<tr>
								<th>공정명</th>
								<td><input id="nm" name="nm" readOnly></td>
							</tr>
							<tr>
								<th>설비</th>
								<td><input id="eqmId" name="eqmId" readOnly></td>
							</tr>
							<tr>
								<th>UPH</th>
								<td><input id="uph" name="uph" readOnly></td>
							</tr>
							<tr>
								<td>
									<button type="button" id="btnUpd"
										class="btn cur-p btn-outline-dark">수정</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 모달창 -->
	<div id="rwmatrDialogFrm" title="원자재 목록"></div>
	<div id="vendDialogFrm" title="업체 목록"></div>
	
<script>
var Grid = tui.Grid;

//검색조건
var rwmName;
var vendName;

document.getElementById("btnFind").addEventListener("click", function () {
	rwmName = document.getElementById("rwmName").value;
	vendName = document.getElementById("vendName").value;
	
	rwmatrSafStcGrid.readData(1,{'rwmName':rwmName,
								 'vendName':vendName}, true);
});

//그리드 테마
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      background: '#fee'
	    }
	  }
	});

toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
	}
	
// 그리드 생성
var rwmatrSafStcGrid = new Grid({
	el: document.getElementById('rwmatrSafStcGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/rwmatrSafStcList.do', method: 'GET'},
		modifyData : { url: '${path}/rwmatr/rwmatrModifyData.do', method: 'PUT'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	bodyHeight: 600,
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '자재코드',
		    name: 'rwmatrId',
		    sortable: true
		  },
		  {
		    header: '자재명',
		    name: 'nm',
		    sortable: true
		  },
		  {
		    header: '업체명',
		    name: 'vendName',
		    sortable: true
		  },
		  {
		    header: '규격',
		    align: 'right',
		    name: 'spec',
		    sortable: true
		  },
		  {
		    header: '작업단위',
		    align: 'right',
		    name: 'wkUnit',
	    	formatter({value}) { // 추가
			  let a = `\${value}`
		  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
		      return b;
		    },
		    sortable: true
		  },
		  {
		    header: '안전재고',
		    align: 'right',
		    name: 'safStc',
		    editor: 'text',
	    	formatter({value}) { // 추가
			  let a = `\${value}`
		  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
		      return b;
		    },
		    sortable: true
		  }
		]
});

//자재모달
let rwmatrDialogFrm = $( "#rwmatrDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 500,
      width: 600,
      modal: true
});

function callRwmatrModal(){
	
    rwmatrDialogFrm.dialog( "open" );
    $("#rwmatrDialogFrm").load("${path}/rwmatr/searchRwmatrDialog.do", function(){console.log("원자재 목록")})
}
 
//업체명 모달
let vendDialogFrm = $( "#vendDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 500,
      width: 600,
      modal: true
});

function callVendModal(){

    vendDialogFrm.dialog( "open" );
    $("#vendDialogFrm").load("${path}/rwmatr/searchVendDialog.do", function(){console.log("업체명 목록")})
}

	//모달에서 텍스트박스로
	function getRwmatrData(rwmatrData) {
		console.log("입고정보 기입")
		document.getElementById("rwmName").value = rwmatrData.nm;
		
		rwmatrDialogFrm.dialog( "close" );
	}
	
	//자재명 textbox
	document.getElementById("rwmName").addEventListener("click", function() {
		  callRwmatrModal();
	});
	
	//업체리스트 모달에서 받아온 텍스트박스에 넣어줌
	function getVendData(vendData) {
		document.getElementById("vendName").value = vendData.vendName;
		
		vendDialogFrm.dialog( "close" );
	}
	
	//업체명 textbox
	document.getElementById("vendName").addEventListener("click", function() {
		callVendModal();
	});
	
	//저장
	btnSave.addEventListener("click", function(){
		console.log("저장")
		if (rwmatrSafStcGrid.getRow(0) != null) {
			rwmatrSafStcGrid.blur();
			if (confirm("저장하시겠습니까?")) {
				rwmatrSafStcGrid.request('modifyData', {
					showConfirm : false
				});
				toastr.clear()
				toastr.success( ('저장되었습니다.'),'Gelato',{timeOut:'1000'} );
			}
		} else {
			toastr.clear()
			toastr.warning( ('저장할 데이터가 없습니다.'),'Gelato',{timeOut:'1000'} );
		}
		
	});

	
</script>
</body>
</html>