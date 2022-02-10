<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 입고검사관리</title> 
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
<h2>원자재 입고검사관리</h2>
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
		                <th>담당자</th>
		                <td><input type="text" id="mngr"><button type="button" id="mngrM" class="btn-modal"></button></td>
		                
		            </tr>
		            <tr>
		                <th>검사일자</th>
		                <td><input type="date" id="startDate" style="margin-right:8px;"> ~ <input type="date" id="endDate" style="margin-left:8px;"></td>
		                <td><button type="button" id="btnFind">조회</button></td>
		                <td><button type="reset">초기화</button></td>
		            </tr>
		        </tbody>
		    </table>
	    </form>
	</div>
</div>
<div style="float: right; margin-bottom:10px; margin-top:25px;">
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
</div>
<hr>
<br>

	<!-- 입고검사내역 조회 -->
	<div id="rwmatrIstInspList" style="width: 100%"></div>

	<!-- 모달창 -->
	<div id="rwmatrDialogFrm" title="원자재 목록"></div>
	<div id="vendDialogFrm" title="업체 목록"></div>
	
	<div id="orderDialogFrm" title="검사예정 목록"></div>
	<div id="inferCodeDialogFrm" title="불량코드 목록"></div>
	<div id="empDialogFrm" title="사원 목록"></div>

<script>
var Grid = tui.Grid;

//modify구분하기위한 변수
let flag;

//모달에서 선택한 rowKey값 세팅
let rk = '';

let ig = '';

//검색 조건
var startDate;
var endDate;
var rwmName;
var mngr;

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

//그리드 생성
var rwmatrIstInspList = new Grid({
	el: document.getElementById('rwmatrIstInspList'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrIstInspList.do', method: 'GET'},
	    modifyData : { url: '${path}/rwmatr/rwmatrIstInspModifyData.do', method: 'PUT'} 
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders: ['checkbox','rowNum'],
	selectionUnit: 'row',
	bodyHeight: 550,
	columns:[
				{
				  header: '발주코드',  //발주디테일코드
				  name: 'rwmatrOrderDetaId',
			      validation: {
			          required: true
			      }
				},
				{
				  header: '발주코드', //코드
				  name: 'orderId',
				  hidden:true,
				  sortable: true
				},
				{
				  header: '자재명',
				  name: 'nm',
				  sortable: true
				},
				{
				  header: '자재코드',
				  name: 'rwmatrId',
				  sortable: true
				},
				{
				  header: '발주총량',
				  align: 'right',
				  name: 'qy',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
				      return b;
				    },
				  sortable: true
				},
				{
				  header: '합격량',
				  align: 'right',
				  name: 'passQy',
				  editor: 'text',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
				      return b;
				    },
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '불량량',
				  align: 'right',
				  name: 'inferQy',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
				      return b;
				    },
				  sortable: true
				},
				{
				  header: '담당자ID',
				  name: 'mngr',
				  sortable: true,
				  hidden:true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '담당자',
				  name: 'mberNm',
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '검사일자',
				  name: 'dt',
				  editor: 'datePicker',
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '비고',
				  name: 'remk',
				  editor: 'text',
				  hidden:true,
				  sortable: true
				},
				{
				  header: '불량코드',
				  name: 'inferId',
				  sortable: true
				},
				{
				  header: '불량내용',
				  name: 'deta',
				  sortable: true
				}
		]
});


//발주 모달
let orderDialogFrm = $( "#orderDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 400,
      width: 600,
      modal: true
}); 

function callModal(){
	orderDialogFrm.dialog( "open" );
    $("#orderDialogFrm").load("${path}/rwmatr/searchOrderDialog.do", function(){console.log("발주 목록")})
}

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
	
//원자재 불량코드 모달
let inferCodeDialogFrm = $( "#inferCodeDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 400,
      width: 600,
      modal: true
}); 

function callrwmatrInferCodeModal(){

	inferCodeDialogFrm.dialog( "open" );
    $("#inferCodeDialogFrm").load("${path}/rwmatr/rwmatrInferCodeModal.do", function(){console.log("원자재 불합격 리스트")})
}

//사원 모달
let empDialogFrm = $( "#empDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 500,
      width: 430,
      modal: true
}); 

function callEmpModal() {
	
	empDialogFrm.dialog( "open" );
    $("#empDialogFrm").load("${path}/com/empModal.do", function(){console.log("사원 리스트")})
}

	//발주코드 클릭시 모달
	rwmatrIstInspList.on('click', (ev) => {
		if(ev.targetType === 'columnHeader'){
    		return;
    	}
		rk = ev.rowKey;
		console.log(ev)
		console.log(ev.columnName)
		console.log(ev.rowKey)
	    if (ev.columnName === 'rwmatrOrderDetaId') {
			console.log("발주디테일리스트")
    		callModal();
		} else if(ev.columnName === 'inferId') {
			if(rwmatrIstInspList.getValue(rk, "rwmatrOrderDetaId") == '') {
				//toastr
				toastr.clear()
				toastr.error( ('발주코드를 선택해주세요.'),'Gelato',{timeOut:'1500'} );
				return;
			}
			callrwmatrInferCodeModal();
			
		} else if(ev.columnName === 'nm' || ev.columnName === 'rwmatrId' || ev.columnName === 'qy' || ev.columnName === 'passQy') {
			if(rwmatrIstInspList.getValue(rk, "rwmatrOrderDetaId") == '') {
				//toastr
				toastr.clear()
				toastr.error( ('발주코드를 선택해주세요.'),'Gelato',{timeOut:'1500'} );
			}
		} else if(ev.columnName === 'inferQy') {
			if(rwmatrIstInspList.getValue(rk, "rwmatrOrderDetaId") == '') {
				//toastr
				toastr.clear()
				toastr.warning( ('합격량 입력시 자동입력됩니다.'),'Gelato',{timeOut:'1500'} );
			}
		} else if(ev.columnName === 'mberNm') {
			ig = 'g';
			callEmpModal()
		}
		
	});
	
	
	//불량량 자동계산
	rwmatrIstInspList.on('editingFinish', (ev) => {
		console.log(ev);
		rk = ev.rowKey;
		let totalq = parseInt(rwmatrIstInspList.getValue(rk, "qy"));
		let passq = parseInt(rwmatrIstInspList.getValue(rk, "passQy"));
		let inferq = totalq - passq;
		
		// 숫자 정규식 유효성검사
		var pattern_num = /[0-9]/;
		if(rwmatrIstInspList.getValue(rk, "passQy") != ''){
			if((pattern_num.test(rwmatrIstInspList.getValue(rk, "passQy"))) == false) {
				rwmatrIstInspList.setValue(rk, "passQy", "", true);
				toastr.clear()
				toastr.warning( ("숫자만 입력이 가능합니다."),'Gelato',{timeOut:'1500'} );
				return;
			}
		}
		
		if( (pattern_num.test(rwmatrIstInspList.getValue(rk, "passQy"))) ) {
			console.log("불량량 자동계산")
			if(passq <= totalq){
				rwmatrIstInspList.setValue(rk, "inferQy", inferq, true);
			} else {
				rwmatrIstInspList.setValue(rk, "passQy", '', true);
				//toastr
				toastr.clear()
				toastr.warning( ('합격량은 발주총량보다 높을수 없습니다.'),'Gelato',{timeOut:'1800'} );
			}
		} 
		
	});

	
	function getOrderData(orderData) {
		console.log("발주정보 기입")
		
		rwmatrIstInspList.setValue(rk, "rwmatrOrderDetaId", orderData.rwmatrOrderDetaId, true)
		rwmatrIstInspList.setValue(rk, "orderId", orderData.orderId, true)
		rwmatrIstInspList.setValue(rk, "nm", orderData.nm, true)
		rwmatrIstInspList.setValue(rk, "rwmatrId", orderData.rwmatrId, true)
		rwmatrIstInspList.setValue(rk, "qy", orderData.qy, true)
		
		orderDialogFrm.dialog( "close" );
	}
	
	//불량코드리스트 모달에서 받아온 데이터를 새로운 행에 넣어줌 or 텍스트박스에
	function getInferData(inferData) {
		console.log("불량내용 기입")
		rwmatrIstInspList.setValue(rk, "inferId", inferData.inferId, true)
		rwmatrIstInspList.setValue(rk, "deta", inferData.deta, true)
		
		inferCodeDialogFrm.dialog( "close" );
	}
	
	//자재명 textbox
	document.getElementById("rwmNameM").addEventListener("click", function() {
		  callRwmatrModal();
	});
	
	//담당자 textbox
	document.getElementById("mngrM").addEventListener("click", function() {
		ig = "i";
		callEmpModal();
	});
	
	//자재리스트 모달에서 받아온 데이터 인풋박스에 세팅
	function getRwmatrData(rwmatrData) {
		console.log("Rwmatr정보 기입")
		document.getElementById("rwmName").value = rwmatrData.nm;
		document.getElementById("rwmId").value = rwmatrData.rwmatrId;
		
		rwmatrDialogFrm.dialog( "close" );
	}
	
	function getEmpModalData(mberNm, esntlId){
		if(ig == 'g'){
			rwmatrIstInspList.setValue(rk, "mngr", esntlId, true)
			rwmatrIstInspList.setValue(rk, "mberNm", mberNm, true)
		} else if(ig == 'i'){
			console.log(mberNm);
			document.getElementById("mngr").value = mberNm;
		}
		
		empDialogFrm.dialog( "close" );
	}
	
	
	rwmatrIstInspList.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			rwmatrIstInspList.readData(1);
			flag = 'X';
		}
	});

	//조회
	btnFind.addEventListener("click", function(){
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		rwmName = document.getElementById("rwmName").value;
		mngr = document.getElementById("mngr").value;
		console.log(startDate);
		console.log(endDate);
		
		rwmatrIstInspList.readData(1,{'startDate':startDate, 
									  'endDate':endDate, 
									  'rwmName':rwmName,
									  'mngr':mngr}, true);
	});
	
	
	//추가
	btnAdd.addEventListener("click", function(){
		rwmatrIstInspList.prependRow();
	});
	
	//삭제
	btnDel.addEventListener("click", function(){
		
		if(confirm("선택하신 항목을 삭제하시겠습니까?")){ 
			rwmatrIstInspList.removeCheckedRows(false)
			rwmatrIstInspList.request('modifyData',{showConfirm:false});
			
			toastr.clear()
			toastr.success( ('삭제되었습니다.'),'Gelato',{timeOut:'1000'} );
		}
	});
	
	//저장
	btnSave.addEventListener("click", function(){
		if (rwmatrIstInspList.getRow(0) != null) {
			rwmatrIstInspList.blur();
			if (confirm("저장하시겠습니까?")) {
				rwmatrIstInspList.request('modifyData', {
					showConfirm : false
				});
				flag = 'O';
				toastr.clear()
				toastr.success( ('저장되었습니다.'),'Gelato',{timeOut:'1000'} );
			}
		} else {
			toastr.clear()
			toastr.warning( ('저장할 데이터가 없습니다.'),'Gelato',{timeOut:'1000'} );
		}
		
		//rwmatrIstInspList.clearModifiedData();
	});

</script>
</body>
</html>