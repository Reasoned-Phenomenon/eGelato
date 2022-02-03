<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 발주조회</title> 
 <!-- <link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> -->
</head>
<body>
<h3>원자재 발주조회</h3>
<div style="margin: 20px;">
	<form>
		발주신청일 : <input type="date" id="startDate"> ~ <input type="date" id="endDate">
		<button type="button" class="btn cur-p btn-outline-primary" id="btnFindM">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</form>
	<form style="float: right;">
		자재명 : <input type="text" id="rwmName">업체명 : <input type="text" id="vendName">
		<button type="button" class="btn cur-p btn-outline-primary" id="btnFindS">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</form><br>
</div>
<hr>
<br>

	<div class="row">
		<div class="col-sm-4">
			<!-- 발주목록 조회 -->
			<div id="rwmatrOrderMasterList"></div>
		</div>
		<div class="col-sm-8">
			<div id="rwmatrOrderList"></div>
		</div>
	</div>

	<!-- 모달창 -->
	<div id="rwmatrDialogFrm" title="원자재 목록"></div>
	<div id="vendDialogFrm" title="업체 목록"></div>


<script>
var Grid = tui.Grid;

//modify구분하기위한 변수
let flag;

//모달 구분하기위한 변수
let ig;

//모달에서 선택한 rowKey값 세팅
let rk = '';

//검색 조건
var orderId;
var startDate;
var endDate;
var rwmName;
var vendName;

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


//토스트옵션
toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
	}

var rwmatrOrderMasterList = new Grid({
	el: document.getElementById('rwmatrOrderMasterList'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrOrderMasterList.do', method: 'GET'},
	  },
	  contentType: 'application/json'
	},
	rowHeaders:['rowNum'],
	selectionUnit: 'row',
	bodyHeight: 400,
	columns:[
				{
				  header: '발주코드',
				  name: 'orderId',
				  sortable: true
				},
				{
				  header: '발주신청일',
				  name: 'orderDt',
				  sortable: true
				}
			]
});

//발주디테일 그리드
var rwmatrOrderList = new Grid({
	el: document.getElementById('rwmatrOrderList'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrOrderSubList.do', method: 'GET'},
	  },
	  contentType: 'application/json'
	},
	rowHeaders:['rowNum'],
	selectionUnit: 'row',
	bodyHeight: 400,
	columns:[
				{
				  header: '발주디테일코드',
				  name: 'rwmatrOrderDetaId',
				  hidden:true
				},
				{
				  header: '발주코드',
				  name: 'orderId',
				  sortable: true,
				  hidden:true
				},
				{
				  header: '자재코드',
				  name: 'rwmatrId',
				  sortable: true
				},
				{
				  header: '자재명',
				  name: 'nm',
				  editor: 'text',
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '단가(원)',
				  align: 'right',
				  name: 'untprc',
				  editor: 'text',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
				  	  if(b == 'null'){
				  		  b = '';
				  	  }
				      return b;
				  }, 
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '발주량',
				  align: 'right',
				  name: 'qy',
				  editor: 'text',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
				  	  if(b == 'null'){
				  		  b = '';
				  	  }
				      return b;
				  }, 
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '총액',
				  align: 'right',
				  name: 'totalPrice',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
				  	  if(b == 'null'){
				  		  b = '';
				  	  }
				      return b;
				  },
				  sortable: true
				},
				{
				  header: '업체코드',
				  name: 'vendId',
				  hidden:true
				},
				{
				  header: '업체명',
				  name: 'vendName',
				  sortable: true
				},
				{
				  header: '발주신청일',
				  name: 'orderDt',
				  sortable: true,
				  hidden:true
				},
				{
				  header: '납기요청일',
				  name: 'dudt',
				  sortable: true,
			      validation: {
			          required: true
			      }
				}
		]
});


rwmatrOrderMasterList.on('click', (ev) => {	
	console.log(ev)
	//cell 선택시 row 선택됨.
	rwmatrOrderMasterList.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, rwmatrOrderMasterList.getColumns().length-1]
	  });
	
	//클릭한 row의 orderId에 해당하는 code를 읽어옴
	orderId = rwmatrOrderMasterList.getRow(ev.rowKey).orderId;
	rwmatrOrderList.readData(1, {'orderId':orderId}, true);
	
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
function callVendModal(){

    vendDialogFrm.dialog( "open" );
    $("#vendDialogFrm").load("${path}/rwmatr/searchVendDialog.do", function(){console.log("업체명 목록")})
}

let vendDialogFrm = $( "#vendDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 500,
      width: 600,
      modal: true
});
	
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
	
	
	//컨트롤러 응답
	rwmatrOrderList.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			rwmatrOrderList.readData(1);
			flag = 'X';
		}
		//rwmatrOrderList.resetOriginData();
	});

	//발주 조회
	btnFindM.addEventListener("click", function(){
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		console.log(startDate);
		console.log(endDate);
		
		rwmatrOrderMasterList.readData(1,{'startDate':startDate,
										  'endDate':endDate}, true);
	});
	
	//발주디테일 조회
	btnFindS.addEventListener("click", function(){
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		console.log(startDate);
		console.log(endDate);
		
		rwmatrOrderList.readData(1,{'orderId':orderId,
									'rwmName':rwmName,
									'vendName': vendName}, true);
	});
	
</script>
</body>
</html>