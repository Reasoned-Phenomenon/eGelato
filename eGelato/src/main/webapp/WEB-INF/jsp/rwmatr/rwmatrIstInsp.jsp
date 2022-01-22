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
<body>
<h3>원자재 입고검사관리</h3>
<div style="margin: 20px;">
	<form action="">
		자재명 : <input type="text" id="rwmName">담당자 : <input type="text" id="mngr"><br>
		검사일자 :   <input type="date" id="startDate"> ~ <input type="date" id="endDate">
		<button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</form>
</div>
<div style="float: right;">
	<button type="button" class="btn cur-p btn-outline-primary" id="btnAdd">추가</button>
	<button type="button" class="btn cur-p btn-outline-primary" id="btnDel">삭제</button>
	<button type="button" class="btn cur-p btn-outline-primary" id="btnSave">저장</button>
</div>
<hr>
<br>

	<!-- 입고검사내역 조회 -->
	<div id="rwmatrIstInspList" style="width: 80%"></div>

	<!-- 모달창 -->
	<div id="dialogFrm"></div>

<script>
let dialog;
var Grid = tui.Grid;

//modify구분하기위한 변수
let flag;

//모달에서 선택한 rowKey값 세팅
let rk = '';

//검색 조건
var startDate;
var endDate;
var rwmName;
var mngr;



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
	rowHeaders: ['checkbox'],
	selectionUnit: 'row',
	bodyHeight: 600,
	columns:[
				{
				  header: '발주코드',  //발주디테일코드
				  name: 'rwmatrOrderDetaId',
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
				  sortable: true
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
				  header: '담당자',
				  name: 'mngr',
				  editor: 'text',
				  sortable: true
				},
				{
				  header: '검사일자',
				  name: 'dt',
				  editor: 'datePicker',
				  sortable: true
				},
				{
				  header: '비고',
				  name: 'remk',
				  editor: 'text',
				}
		]
});


//발주 모달
function callModal(){
	dialog = $( "#dialogFrm" ).dialog({
		  modal:true,
		  autoOpen:false,
	      height: 400,
	      width: 600,
	      modal: true
	}); 

    dialog.dialog( "open" );
    console.log("111112222")
    $("#dialogFrm").load("${path}/rwmatr/searchOrderDialog.do", function(){console.log("발주 목록")})
}

//자재모달
function callRwmatrModal(){
	dialog = $( "#dialogFrm" ).dialog({
		  modal:true,
		  autoOpen:false,
	      height: 400,
	      width: 600,
	      modal: true
	}); 
	
    console.log("11111")
    dialog.dialog( "open" );
    console.log("111112222")
    $("#dialogFrm").load("${path}/rwmatr/searchRwmatrDialog.do", function(){console.log("원자재 목록")})
}
	
	
	//발주코드 클릭시 모달
	rwmatrIstInspList.on('click', (ev) => {
		rk = ev.rowKey;
		console.log(ev)
		console.log(ev.columnName)
		console.log(ev.rowKey)
	    if (ev.columnName === 'rwmatrOrderDetaId') {
			console.log("발주디테일리스트")
    		callModal();
		}
		
		//불량량 자동계산
		rwmatrIstInspList.on('editingFinish', (ev) => {
			console.log("11111111")
			console.log(ev);
			console.log("11111111")
			rk = ev.rowKey;
			if(rwmatrIstInspList.getValue(rk, "passQy") != '') {
				console.log("sdfjklsdfjsdfljsdlf")
				let totalq = parseInt(rwmatrIstInspList.getValue(rk, "qy"));
				let passq = parseInt(rwmatrIstInspList.getValue(rk, "passQy"));
				let inferq = totalq - passq;
				rwmatrIstInspList.setValue(rk, "inferQy", inferq, true);
			} 
		});
	});

	
	function getOrderData(orderData) {
		console.log("발주정보 기입")
		
		rwmatrIstInspList.setValue(rk, "rwmatrOrderDetaId", orderData.rwmatrOrderDetaId, true)
		rwmatrIstInspList.setValue(rk, "orderId", orderData.orderId, true)
		rwmatrIstInspList.setValue(rk, "nm", orderData.nm, true)
		rwmatrIstInspList.setValue(rk, "rwmatrId", orderData.rwmatrId, true)
		rwmatrIstInspList.setValue(rk, "qy", orderData.qy, true)
		
		dialog.dialog( "close" );
	}
	
	//자재명 textbox
	document.getElementById("rwmName").addEventListener("click", function() {
		  callRwmatrModal();
	});
	
	//자재리스트 모달에서 받아온 데이터 인풋박스에 세팅
	function getRwmatrData(rwmatrData) {
		console.log("Rwmatr정보 기입")
		document.getElementById("rwmName").value = rwmatrData.nm;
		
		dialog.dialog( "close" );
	}
	
	

	
	rwmatrIstInspList.on('response', function (ev) {
		console.log("1111");
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
		if(rwmatrIstInspList.removeCheckedRows(true)){
			rwmatrIstInspList.request('modifyData');
		}
	});
	
	//저장
	btnSave.addEventListener("click", function(){
		rwmatrIstInspList.blur();
		rwmatrIstInspList.request('modifyData');
		rwmatrIstInspList.clearModifiedData();
	});

</script>
</body>
</html>