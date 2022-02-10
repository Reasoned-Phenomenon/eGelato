<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 입고관리</title> 
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
<h2>원자재 입고관리</h2>
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
		                <th>입고일자</th>
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

	<!-- 입고내역 조회 -->
	<div id="rwmatrIstList" style="width: 95%"></div>

	<!-- 모달창 -->
	<div id="rwmatrDialogFrm" title="원자재 목록"></div>
	<div id="vendDialogFrm" title="업체 목록"></div>
	<div id="rwmatrPassDialogFrm" title="입고예정 목록"></div>
	

<script>
var Grid = tui.Grid;

//modify구분하기위한 변수
let flag;

//모달 구분하기위한 변수
let ig;

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
var rwmatrIstList = new Grid({
	el: document.getElementById('rwmatrIstList'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrIstList.do', method: 'GET'},
	    modifyData : { url: '${path}/rwmatr/rwmatrIstModifyData.do', method: 'PUT'} 
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders: ['checkbox', 'rowNum'],
	selectionUnit: 'row',
	bodyHeight: 600,
	columns:[
				{
				  header: '발주코드',
				  name: 'rwmatrOrderDetaId',
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '자재코드',
				  name: 'rwmatrId',
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
				  header: '입고량',
				  align: 'right',
				  name: 'istQy',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
				      return b;
				  },
				  sortable: true
				},
				{
				  header: '입고일시',
				  name: 'istOustDttm',
				  sortable: true
				},
				{
				  header: '자재LOT번호',
				  name: 'lotNo',
				  sortable: true
				},
				{
				  header: '유통기한',
				  name: 'expdate',
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


//검사완료리스트 모달
let rwmatrPassDialogFrm = $( "#rwmatrPassDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 450,
      width: 850,
      modal: true
});

function callrwmatrPassModal(){

	rwmatrPassDialogFrm.dialog( "open" );
    $("#rwmatrPassDialogFrm").load("${path}/rwmatr/rwmatrPassModal.do", function(){console.log("검수완료 리스트")})
}
	
	//자재명 클릭시 검수완료리스트 모달
	rwmatrIstList.on('click', (ev) => {
		rk = ev.rowKey;
		console.log(ev)
		console.log(ev.columnName)
		console.log(ev.rowKey)
	    if (ev.columnName === 'rwmatrOrderDetaId') {
	    	if(ev.targetType === 'columnHeader'){
	    		return;
	    	}
			console.log("검수완료리스트")
			ig = 'g';
			//callrwmatrPassModal();
		} else if(ev.columnName === 'expdate' || 
				  ev.columnName === 'rwmatrId' || 
				  ev.columnName === 'nm' || 
				  ev.columnName === 'vendName' || 
				  ev.columnName === 'istQy') {
			if(rwmatrIstList.getValue(rk, "rwmatrOrderDetaId") == '') {
				//toastr
				toastr.clear()
				toastr.error( ('발주코드를 선택해주세요.'),'Gelato',{timeOut:'1500'} );
			}
		} else if(ev.columnName === 'lotNo' || ev.columnName === 'istOustDttm') {
			//toastr
			toastr.clear()
			toastr.warning( ('저장시 자동으로 기입되는 값입니다.'),'Gelato',{timeOut:'1500'} );
		}
	});
	

	//검수합격리스트 모달에서 받아온 데이터를 새로운 행에 넣어줌 or 텍스트박스에
	function getRwmatrData(rwmatrData) {
		console.log("입고정보 기입")
		if(ig == 'g'){
			//rwmId = rwmatrData.rwmatrId;
			//rwmNm = rwmatrData.nm;
			//rwmQy = rwmatrData.passQy;
			rwmatrIstList.setValue(rk, "rwmatrOrderDetaId", rwmatrData.rwmatrOrderDetaId, true)
			rwmatrIstList.setValue(rk, "rwmatrId", rwmatrData.rwmatrId, true)
			rwmatrIstList.setValue(rk, "nm", rwmatrData.nm, true)
			rwmatrIstList.setValue(rk, "vendName", rwmatrData.vendName, true)
			rwmatrIstList.setValue(rk, "istQy", rwmatrData.passQy, true)
			
			rwmatrPassDialogFrm.dialog( "close" );
		} else if(ig == 'i'){
			document.getElementById("rwmName").value = rwmatrData.nm;
			document.getElementById("rwmId").value = rwmatrData.rwmatrId;
		}
		
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
	
	
	//컨트롤러 응답
	rwmatrIstList.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			rwmatrIstList.readData(1);
			flag = 'X';
		}
		//rwmatrIstList.resetOriginData();
	});

	//조회
	btnFind.addEventListener("click", function(){
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		
		console.log(startDate);
		console.log(endDate);
		
		rwmatrIstList.readData(1,{'startDate':startDate,
									'endDate':endDate, 
									'rwmName':rwmName,
									'vendName': vendName}, true);
	});
	
	
	//추가
	btnAdd.addEventListener("click", function(){
		callrwmatrPassModal();
		//rwmatrIstList.prependRow();
	});
	
	//삭제
	btnDel.addEventListener("click", function(){
		
		if(confirm("선택하신 항목을 삭제하시겠습니까?")){ 
			rwmatrIstList.removeCheckedRows(false)
			rwmatrIstList.request('modifyData',{showConfirm:false});
			
			toastr.clear()
			toastr.success( ('삭제되었습니다.'),'Gelato',{timeOut:'1000'} );
		}
		
	});
	
	//저장
	btnSave.addEventListener("click", function(){
		
		if (rwmatrIstList.getRow(0) != null) {
			rwmatrIstList.blur();
			if (confirm("저장하시겠습니까?")) {
				rwmatrIstList.request('modifyData', {
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
		
	});

</script>
</body>
</html>