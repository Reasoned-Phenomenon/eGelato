<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 불량조회</title> 
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
<h3>원자재 불량조회</h3>
<div style="margin: 20px;">

	<div>
		<form action="">
		    <table>
		        <tbody>
		            <tr>
		                <th>자재명</th>
		                <td><input type="text" id="rwmName" style="width: 100%;"></td>
		                <th>업체명</th>
		                <td><input type="text" id="vendName"></td>
		            </tr>
		            <tr>
		                <th>불량코드</th>
		                <td><input type="text" id="inferId" style="width: 100%;"></td>
		                <th>불량상세내용</th>
		                <td><input type="text" id="inferContent" readonly="readonly"></td>
		            </tr>
		            <tr>
		                <th>검사일자</th>
		                <td><input type="date" id="startDate"> ~ <input type="date" id="endDate"></td>
		                <td><button type="button" id="btnFind">조회</button><button type="reset" style="margin-left: 9px;">초기화</button></td>
		            </tr>
		        </tbody>
		    </table>
	    </form>
	</div>
</div>
 <hr>
<br>

	<!-- 불량내역 조회 -->
	<div id="rwmatrInferList" style="width: 80%"></div>

	<!-- 모달창 -->
	<div id="rwmatrDialogFrm" title="원자재 목록"></div>
	<div id="vendDialogFrm" title="업체 목록"></div>
	<div id="inferCodeDialogFrm" title="불량코드 목록"></div>
	

<script>
var Grid = tui.Grid;
let dialog;

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
var inferId;

//그리드 생성
var rwmatrInferList = new Grid({
	el: document.getElementById('rwmatrInferList'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrInferList.do', method: 'GET'},
	    modifyData : { url: '${path}/rwmatr/rwmatrInferModifyData.do', method: 'PUT'} 
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
	bodyHeight: 600,
	columns:[
		{
		    header: '발주코드',
		    name: 'orderId',
		    sortable: true,
			hidden:true
		  },
  		  {
		    header: '발주코드',	//발주디테일코드
		    name: 'rwmatrOrderDetaId',
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
		    header: '불량량',
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
		    header: '검사일자',
		    name: 'dt',
			editor: 'datePicker',
		    sortable: true
		  },
		  {
		    header: '불량코드',
		    name: 'inferId',
		    sortable: true
		  },
		  {
		    header: '불량상세내용',
		    name: 'deta',
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

//불량코드 모달
let inferCodeDialogFrm = $( "#inferCodeDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 500,
      width: 600,
      modal: true
});

function callInferCodeModal(){

	inferCodeDialogFrm.dialog( "open" );
    $("#inferCodeDialogFrm").load("${path}/rwmatr/rwmatrInferCodeModal.do", function(){console.log("불량코드 목록")})
}


	//불량리스트 모달에서 받아온 데이터를 새로운 행에 넣어줌 or 텍스트박스에
	function getRwmatrData(rwmatrData) {
		document.getElementById("rwmName").value = rwmatrData.nm;
		
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
	
	//불량코드 모달에서 받아온 텍스트박스에 넣어줌
	function getInferData(inferData) {
		document.getElementById("inferId").value = inferData.inferId;
		document.getElementById("inferContent").value = inferData.deta;
		
		inferCodeDialogFrm.dialog( "close" );
	}
	
	//불량코드 textbox
	document.getElementById("inferId").addEventListener("click", function() {
		callInferCodeModal();
	});
	
	
	//컨트롤러 응답
	rwmatrInferList.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			rwmatrInferList.readData(1);
			flag = 'X';
		}
		//rwmatrInferList.resetOriginData();
	});

	//조회
	btnFind.addEventListener("click", function(){
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		inferId = document.getElementById("inferId").value;
		console.log(startDate);
		console.log(endDate);
		console.log(inferId);
		
		rwmatrInferList.readData(1,{'startDate':startDate,
									'endDate':endDate, 
									'rwmName':rwmName,
									'vendName': vendName,
									'inferId': inferId}, true);
	});
	

</script>
</body>
</html>