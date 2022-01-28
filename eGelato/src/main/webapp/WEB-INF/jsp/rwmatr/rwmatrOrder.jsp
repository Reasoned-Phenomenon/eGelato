<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 발주관리</title> 
 <!-- <link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> -->
</head>
<body>
<h3>원자재 발주관리</h3>
<div style="margin: 20px;">
	<form action="">
		자재명 : <input type="text" id="rwmName">업체명 : <input type="text" id="vendName"><br>
		발주신청일 :   <input type="date" id="startDate"> ~ <input type="date" id="endDate">
		<button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
		<!-- <button type="button" class="btn cur-p btn-outline-primary" id="btnReset">전체검색</button> -->
	</form>
</div>
<div style="float: right;">
	<button type="button" class="btn cur-p btn-outline-primary" id="btnAdd">추가</button>
	<button type="button" class="btn cur-p btn-outline-primary" id="btnDel">삭제</button>
	<button type="button" class="btn cur-p btn-outline-primary" id="btnSave">저장</button>
</div>
<hr>
<br>

	<!-- 발주목록 조회 -->
	<div id="rwmatrOrderList" style="width: 80%"></div>

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

//날짜검색 조건
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

//그리드 생성
var rwmatrOrderList = new Grid({
	el: document.getElementById('rwmatrOrderList'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrOrderList.do', method: 'GET'},
	    modifyData : { url: '${path}/rwmatr/rwmatroModifyData.do', method: 'PUT'} 
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders: ['checkbox'],
	selectionUnit: 'row',
	bodyHeight: 600,
	columns:[
				{
				  header: '발주디테일코드',
				  name: 'rwmatrOrderDetaId',
				  hidden:true
				},
				{
				  header: '발주코드',
				  name: 'orderId',
				  //rowSpan: true,
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
				  header: '자재코드',
				  name: 'rwmatrId',
				  sortable: true
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
				  sortable: true
				},
				{
				  header: '납기요청일',
				  name: 'dudt',
				  editor: 'datePicker',
				  sortable: true,
			      validation: {
			          required: true
			      }
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
	
	//자재명 클릭시 모달
	rwmatrOrderList.on('click', (ev) => {
		rk = ev.rowKey;
		console.log(ev)
		console.log(ev.columnName)
		console.log(ev.rowKey)
	    if (ev.columnName === 'nm') {
	    	if(ev.targetType === 'columnHeader'){
	    		return;
	    	}
			console.log("자재리스트")
			ig = 'g';
    		callRwmatrModal();
		} else if(ev.columnName === 'untprc' || ev.columnName === 'qy') {
			if(rwmatrOrderList.getValue(rk, "nm") == '' || rwmatrOrderList.getValue(rk, "rwmatrId") == '' ) {
				//toastr
				toastr.clear()
				toastr.success( ('자재를 선택해주세요.'),'Gelato',{timeOut:'1000'} );
				return;
			}
		} else if(ev.columnName === 'orderId' || ev.columnName === 'orderDt') {
			//toastr
			toastr.clear()
			toastr.success( ('저장시 자동으로 기입되는 값입니다.'),'Gelato',{timeOut:'1000'} );
			return;
		} else if(ev.columnName === 'rwmatrId' || ev.columnName === 'vendName') {
			//toastr
			toastr.clear()
			toastr.success( ('자재를 선택해주세요.'),'Gelato',{timeOut:'1000'} );
			return;
		}
		
	});
	
	
	//구현중..
	/* rwmatrOrderList.on('editingStart', (ev) => {
		 if(ev.columnName === 'orderId' || 
		   ev.columnName === 'nm' || 
		   ev.columnName === 'rwmatrId' || 
		   ev.columnName === 'utnprc' || 
		   ev.columnName === 'qy' || 
		   ev.columnName === 'orderDt' ||
		   ev.columnName === 'dudt') { 
		   var getRw = rwmatrOrderList.getRow(ev.rowKey);
		   if(getRw != '') {
				//toastr
				toastr.clear()
				toastr.success( ('변경불가'),'Gelato',{timeOut:'1000'} );
				ev.stop();
		   }
		
	}); */
	
	
	 rwmatrOrderList.on('editingFinish', (ev) => {
		console.log(ev);
		rk = ev.rowKey;
		let untprc = parseInt(rwmatrOrderList.getValue(rk, "untprc"));
		let qy = parseInt(rwmatrOrderList.getValue(rk, "qy"));
		let totalPrice = untprc * qy;
		
		// 숫자 정규식 유효성검사
		var pattern_num = /[0-9]/;
		if(rwmatrOrderList.getValue(rk, "untprc") != ''){
			if((pattern_num.test(rwmatrOrderList.getValue(rk, "untprc"))) == false) {
				rwmatrOrderList.setValue(rk, "untprc", "", true);
				toastr.clear()
				toastr.success( ("숫자만 입력이 가능합니다."),'Gelato',{timeOut:'1000'} );
				return;
			}
		}
		
		if(rwmatrOrderList.getValue(rk, "qy") != ''){
			if((pattern_num.test(rwmatrOrderList.getValue(rk, "qy"))) == false) {
				rwmatrOrderList.setValue(rk, "qy", "", true);
				toastr.clear()
				toastr.success( ("숫자만 입력이 가능합니다."),'Gelato',{timeOut:'1000'} );
				return;			
			} 
		}
		
		//총액 자동계산
		if( (pattern_num.test(rwmatrOrderList.getValue(rk, "untprc"))) && (pattern_num.test(rwmatrOrderList.getValue(rk, "qy"))) ) {
			rwmatrOrderList.setValue(rk, "totalPrice", totalPrice, true);
		} 
		
	});

	//자재리스트 모달에서 받아온 데이터를 새로운 행에 넣어줌 or 텍스트박스에
	function getRwmatrData(rwmatrData) {
		console.log("Rwmatr정보 기입")
		if(ig == 'g'){
			console.log(rwmatrData.rwmatrId);
			console.log(rwmatrData.nm);
			console.log(rwmatrData.vendName);
			rwmatrOrderList.setValue(rk, "rwmatrId", rwmatrData.rwmatrId, true)
			rwmatrOrderList.setValue(rk, "nm", rwmatrData.nm, true)
			rwmatrOrderList.setValue(rk, "vendName", rwmatrData.vendName, true)
		} else if(ig == 'i'){
			document.getElementById("rwmName").value = rwmatrData.nm;
		}
		
		rwmatrDialogFrm.dialog( "close" );
	}
	
	//자재명 textbox
	document.getElementById("rwmName").addEventListener("click", function() {
		  ig = 'i';
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

	//조회
	btnFind.addEventListener("click", function(){
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		console.log(startDate);
		console.log(endDate);
		
		rwmatrOrderList.readData(1,{'startDate':startDate,
									'endDate':endDate, 
									'rwmName':rwmName,
									'vendName': vendName}, true);
	});
	
	/* //검색초기화
	btnReset.addEventListener("click", function(){
		console.log("검색초기화");
		document.getElementById("startDate").value = '';
		document.getElementById("endDate").value = '';
		document.getElementById("rwmName").value = '';
		document.getElementById("vendName").value = '';
		
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		
		rwmatrOrderList.readData(1,{'startDate':startDate,
									'endDate':endDate, 
									'rwmName':rwmName,
									'vendName': vendName}, true);
	}); */
	
	//추가
	btnAdd.addEventListener("click", function(){
		rwmatrOrderList.prependRow();
	});
	
	//삭제
	btnDel.addEventListener("click", function(){
		
		if(confirm("선택하신 항목을 삭제하시겠습니까?")){ 
			rwmatrOrderList.removeCheckedRows(false)
			rwmatrOrderList.request('modifyData',{showConfirm:false});
			
			toastr.clear()
			toastr.success( ('삭제되었습니다.'),'Gelato',{timeOut:'1000'} );
		}
		
	});
	
	//저장
	btnSave.addEventListener("click", function(){
		
		if (rwmatrOrderList.getRow(0) != null) {
			rwmatrOrderList.blur();
			if (confirm("저장하시겠습니까?")) {
				rwmatrOrderList.request('modifyData', {
					showConfirm : false
				});
				flag = 'O';
				toastr.clear()
				toastr.success( ('저장되었습니다.'),'Gelato',{timeOut:'1000'} );
			}
		} else {
			toastr.clear()
			toastr.success( ('저장할 데이터가 없습니다.'),'Gelato',{timeOut:'1000'} );
		}
	});

</script>
</body>
</html>