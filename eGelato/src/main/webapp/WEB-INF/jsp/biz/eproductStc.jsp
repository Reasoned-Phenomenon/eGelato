<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 재고조회</title> 
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
<h3>완제품 재고조회</h3>
<div style="margin: 20px;">
	<div>
		<form action="">
		    <table>
		        <tbody>
		            <tr>
		                <th>제품명</th>
		                <td>
		                	<input type="text" id="prdtNm"><button type="button" id="prdtNmM" class="btn-modal"></button>
		                	<input type="text" id="prdtId" readOnly>
		                </td>
		            </tr>
		            <tr>
		                <th>제조일자</th>
		                <td><input type="date" id="startDate"> ~ <input type="date" id="endDate"></td>
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
	<div id="eproductStcList" style="width: 80%"></div>

	<!-- 모달창 -->
	<div id="eprdtDialogFrm" title="제품 목록"></div>

<script>
var Grid = tui.Grid;

//modify구분하기위한 변수
let flag;

//모달 구분하기위한 변수
let ig;

//모달에서 선택한 rowKey값 세팅
let rk = '';

//검색 조건
var prdtNm;
var startDate;
var endDate;

//날짜기본값
const d = new Date();

const year = d.getFullYear(); // 년
const month = d.getMonth();   // 월
const day = d.getDate();      // 일

document.getElementById('startDate').value = new Date(year, month, day - 5).toISOString().substring(0,10);
document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);

//그리드 생성
var eproductStcList = new Grid({
	el: document.getElementById('eproductStcList'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/biz/eproductStcList.do', method: 'GET'},
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
	bodyHeight: 600,
	columns:[
  		  {
		    header: '제품코드',
		    name: 'prdtId',
		    sortable: true
		  },
		  {
		    header: '제품명',
		    name: 'prdtNm',
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
		    sortable: true
		  },
		  {
			 header: '제조일자',
			 name: 'prodDt',
			 sortable: true
		  },
		  {
		    header: '제품LOT번호',
		    name: 'lotNo',
		    sortable: true
		  },
		  {
			 header: '유통기한',
			 name: 'expdate',
			 sortable: true
		  },
		  {
			 header: '비고',
			 name: 'remk',
			 sortable: true,
			 formatter({value}) { 
				 let a = `\${value}`
			  	 if(a == 'null' || a == 'undefined'){
			  	     a = '';
			  	 }
			     return a;
			 }
		  }
		]
});

//완제품 textbox
document.getElementById("prdtNmM").addEventListener("click", function() {
	calleprdtModal();
});

//완제품 모달
let eprdtDialogFrm = $( "#eprdtDialogFrm" ).dialog({
	  modal:true,
	  autoOpen:false,
      height: 500,
      width: 600,
      modal: true
});

function calleprdtModal(){
	
	eprdtDialogFrm.dialog( "open" );
    $("#eprdtDialogFrm").load("${path}/biz/prdtModal.do", function(){console.log("완제품 목록")})
}

function getModal(prdtParam) {
	console.log(prdtParam);
	$("#prdtNm").val(prdtParam);
	eprdtDialogFrm.dialog("close");
}
	
	//컨트롤러 응답
	eproductStcList.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			eproductStcList.readData(1);
			flag = 'X';
		}
		//eproductStcList.resetOriginData();
	});

	//조회
	btnFind.addEventListener("click", function(){
		prdtNm = document.getElementById("prdtNm").value;
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		
		eproductStcList.readData(1,{'prdtNm':prdtNm,
								    'startDate': startDate,
								    'endDate':endDate}, true);
	});
	
</script>
</body>
</html>