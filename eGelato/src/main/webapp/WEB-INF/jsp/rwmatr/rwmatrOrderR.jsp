<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 발주조회</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<h2>원자재 발주조회</h2>
	<div class="flex row" style="margin-bottom:10px;">
		<div class="col-5">
			<form action="">
				<table>
					<tbody>
						<tr>
							<th>발주신청일</th>
							<td><input type="date" id="startDate"> ~ <input
								type="date" id="endDate"></td>
							<td><button type="button" id="btnFindM">조회</button></td>
							<td><button type="reset">초기화</button></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div class="col-7">
			<form action="">
				<table>
					<tbody>
						<tr>
							<th>자재명</th>
							<td><input type="text" id="rwmName">
							<button type="button" id="rwmNameM" class="btn-modal"></button> <input
								type="text" id="rwmId" readOnly></td>
							<th>업체명</th>
							<td><input type="text" id="vendName">
							<button type="button" id="vendNameM" class="btn-modal"></button>
								<input type="text" id="vendId" readOnly></td>
							<td><button type="button" id="btnFindS">조회</button></td>
							<td><button type="reset">초기화</button></td>

						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-5">
			<!-- 발주목록 조회 -->
			<div id="rwmatrOrderMasterList"></div>
		</div>
		<div class="col-sm-7">
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
let rk = '-1';

//검색 조건
var orderId;
var startDate;
var endDate;
var rwmName;
var vendName;

//날짜기본값
const d = new Date();

const year = d.getFullYear(); // 년
const month = d.getMonth();   // 월
const day = d.getDate();      // 일

document.getElementById('startDate').value = new Date(year, month, day - 5).toISOString().substring(0,10);
document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);

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
	bodyHeight: 650,
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
	bodyHeight: 650,
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
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '단가(원)',
				  align: 'right',
				  name: 'untprc',
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
	rk = ev.rowKey;
	console.log(rk)
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
      height: 550,
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
		document.getElementById("rwmId").value = rwmatrData.rwmatrId;
		
		rwmatrDialogFrm.dialog( "close" );
	}
	
	//자재명 textbox
	document.getElementById("rwmNameM").addEventListener("click", function() {
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
		console.log(rk);
		if(rk === '-1') {
			toastr.clear()
			toastr.warning( ("발주를 선택해주세요."),'Gelato',{timeOut:'1500'} );
			return;
		}
		
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