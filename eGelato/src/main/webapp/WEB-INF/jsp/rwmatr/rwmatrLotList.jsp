<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재LOT 재고조회</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
<h2>원자재 LOT 재고조회</h2>
<div>
	<div>
		<form action="">
		    <table>
		        <tbody>
		            <tr>
		                <th>자재명</th>
		                <td>
		                	<input type="text" id="rwmName"><button type="button" id="rwmNameM" class="btn-modal"></button>
		                	<input type="text" id="rwmId" readOnly>
		                </td>
		            </tr>
		            <tr>
		                <th>업체명</th>
		                <td>
		                	<input type="text" id="vendName"><button type="button" id="vendNameM" class="btn-modal"></button>
		                	<input type="text" id="vendId" readOnly>
		                </td>
		            </tr>
		            <tr>
		                <th>유통기한</th>
		                <td><input type="date" id="startDate" style="margin-right:8px;"> ~ <input type="date" id="endDate" style="margin-left:8px;"></td>
		                <td><button type="button" id="btnFind">조회</button></td>
		                <td><button type="reset">초기화</button></td>
		            </tr>
		        </tbody>
		    </table>
	    </form>
	</div>
</div>
<hr>
<br>

	<!-- 입고내역 조회 -->
	<div id="rwmatrLotList" style="width: 100%"></div>
	
	<!-- 모달창 -->
	<div id="rwmatrDialogFrm" title="원자재 목록"></div>
	<div id="vendDialogFrm" title="업체 목록"></div>


<script>
var Grid = tui.Grid;

//모달에서 선택한 rowKey값 세팅
let rk = '';

//검색 조건
var startDate;
var endDate;
var rwmName;
var vendName;

toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
	}

//그리드 생성
var rwmatrLotList = new Grid({
	el: document.getElementById('rwmatrLotList'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/RwmatrLotList.do', method: 'GET'}
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
  	rowHeaders:['rowNum'],
  	bodyHeight: 550,
  	selectionUnit: 'row',
  	columns:[
 		  {
		    header: '발주디테일코드',
		    name: 'rwmatrOrderDetaId',
		    hidden:true
		  },
  		  {
		    header: '자재LOT번호',
		    name: 'lotNo',
		    sortable: true
		  },
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
		    header: '수량',
		    align: 'right',
		    name: 'qy',
		    formatter({value}) { // 추가
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			      return b;
			  },
		    sortable: true,
	        validation: {
	        	validatorFn: (value, row, columnName) => Number(value) > Number(row['safStc'])
	        }
		  },
		  {
		    header: '유통기한',
		    name: 'expdate',
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

	// 모달에서 텍스트박스로
	function getRwmatrData(rwmatrData) {
		document.getElementById("rwmName").value = rwmatrData.nm;
		document.getElementById("rwmId").value = rwmatrData.rwmatrId;
		
		rwmatrDialogFrm.dialog( "close" );
	}
	
	//자재명 textbox
	document.getElementById("rwmNameM").addEventListener("click", function() {
		  ig = 'i';
		  callRwmatrModal();
	});
	
	//업체리스트 모달에서 받아온 텍스트박스에 넣어줌
	function getVendData(vendData) {
		document.getElementById("vendName").value = vendData.vendName;
		document.getElementById("vendId").value = vendData.vendId;
		
		vendDialogFrm.dialog( "close" );
	}
	
	//업체명 textbox
	document.getElementById("vendNameM").addEventListener("click", function() {
		callVendModal();
	});
	

	//조회
	btnFind.addEventListener("click", function(){
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		console.log(startDate);
		console.log(endDate);
		
		rwmatrLotList.readData(1,{'startDate':startDate,
									'endDate':endDate, 
									'rwmName':rwmName,
									'vendName': vendName}, true);
	}); 
	
	

</script>
</body>
</html>