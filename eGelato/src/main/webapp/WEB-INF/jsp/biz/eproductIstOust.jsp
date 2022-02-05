<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 입/출고조회</title>
</head>
<style>
th, td {
	padding: 5px;
}
.ui-state-active a, .ui-state-active a:link, .ui-state-active a:visited {
    color: #ffffff;
    text-decoration: none;
    background: black;
}
</style>
<body>

<div>
	<br>
	<h2 id="title">완제품 입/출고조회</h2>
	<br>
</div>

<div id="tabs">

	<ul>
		<li><a href="#eprdtIst">입고 조회</a></li>
		<li><a href="#eprdtOust">출고 조회</a></li>
	</ul>
	
	
	<div id="eprdtIst">
		<div style="margin: 20px;">
		
			<div>
				<form id="eprdtI">
				    <table>
				        <tbody>
				            <tr>
				                <th>제품명</th>
				                <td><input type="text" id="prdtNmI"></td>
				            </tr>
				            <tr>
				                <th>입고일자</th>
				                <td><input type="date" id="startDateI"> ~ <input type="date" id="endDateI"></td>
				                <td><button type="button" id="btnFindI">조회</button></td>
				                <td><button type="reset">초기화</button></td>
				            </tr>
				        </tbody>
				    </table>
			    </form>
			</div>
		
		</div>
		<div id="eprdtIstGrid"></div> <br>
	</div>
	
	<div id="eprdtOust">
		<div style="margin: 20px;">
			<div>
				<form id="eprdtO">
				    <table>
				        <tbody>
				            <tr>
				                <th>제품명</th>
				                <td><input type="text" id="prdtNmO"></td>
				            </tr>
				            <tr>
				                <th>출고일자</th>
				                <td><input type="date" id="startDateO"> ~ <input type="date" id="endDateO"></td>
				                <td><button type="button" id="btnFindO">조회</button></td>
				                <td><button type="reset">초기화</button></td>
				            </tr>
				        </tbody>
				    </table>
			    </form>
			</div>
		</div>
		<div id="eprdtOustGrid"></div> <br>
	</div>
	
</div>

<!-- 모달창 -->
<div id="eprdtDialogFrm" title="제품 목록"></div>

<!-- 제품 입고 -->
<div id="eprdtIstGrid"></div>

<!-- 제품 출고 -->
<div id="eprdtOustGrid"></div>

<script>
//탭 생성
$( "#tabs" ).tabs();

//검색조건
var startDateI;
var endDateI;
var prdtNmI;

var startDateO;
var endDateO;
var prdtNmO;

//텍스트박스 구분자
let flag;

//토스트옵션
toastr.options = {
	positionClass : "toast-top-center",
	progressBar : true,
	timeOut: 1500 // null 입력시 무제한.
	}
	
//계획상세 그리드 생성
var Grid = tui.Grid;

//입고 조회 그리드
var eprdtIstGrid = new Grid({
	el: document.getElementById('eprdtIstGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/biz/rwmatrIstList.do', method: 'GET'},
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders:['rowNum'],
	selectionUnit: 'row',
	bodyHeight: 550,
	width:1500,
	columns:[
				{
				  header: '제품코드',
				  name: 'prdtId',
				},
				{
				  header: '제품명',
				  name: 'prdtNm',
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
				  header: '제품LOT번호',
				  name: 'lotNo',
				  sortable: true
				},
				{
				  header: '유통기한',
				  name: 'expdate',
				  sortable: true,
			      validation: {
			          required: true
			      }
				}
		]
});
	
//출고 조회 그리드
var eprdtOustGrid = new Grid({
	el: document.getElementById('eprdtOustGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/biz/rwmatrOustList.do', method: 'GET'},
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders:['rowNum'],
	selectionUnit: 'row',
	bodyHeight: 550,
	width:1500,
	columns:[
				{
				  header: '제품LOT번호',
				  name: 'lotNo',
				  sortable: true
				},
				{
				  header: '제품코드',
				  name: 'prdtId',
				},
				{
				  header: '제품명',
				  name: 'prdtNm',
				  sortable: true
				},
				{
				  header: '출고량',
				  align: 'right',
				  name: 'oustQy',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
				      return b;
				  },
				  sortable: true
				},
				{
				  header: '출고일시',
				  name: 'istOustDttm',
				  sortable: true
				},
				{
				  header: '유통기한',
				  name: 'expdate',
				  sortable: true,
			      validation: {
			          required: true
			      }
				}
		]
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
 


$("#prdtNmI, #prdtNmO").click(function() {
	calleprdtModal();
	
	if( $(this).is("#prdtNmI") ) {
		console.log($(this).is("#prdtNmI"))
		flag = 'I';
	} else if( $(this).is("#prdtNmO") ) {
		console.log($(this).is("#prdtNmO"))
		flag = 'O';
	}
	
})

//모달에서 텍스트박스로
function getModal(prdtParam) {
	if(flag == 'I') {
		document.getElementById("prdtNmI").value = prdtParam;
	} else if(flag == 'O') {
		document.getElementById("prdtNmO").value = prdtParam;
	}
	eprdtDialogFrm.dialog( "close" );
}

//입고 조회 버튼
btnFindI.addEventListener("click", function(){
	startDateI = document.getElementById("startDateI").value;
	endDateI = document.getElementById("endDateI").value;
	prdtNmI = document.getElementById("prdtNmI").value;
	
	console.log(startDateI);
	console.log(endDateI);
	console.log("입고조회");
	
	eprdtIstGrid.readData(1,{'startDate':startDateI,
								'endDate':endDateI, 
								'prdtNm':prdtNmI}, true);
});

//출고 조회 버튼
btnFindO.addEventListener("click", function(){
	startDateO = document.getElementById("startDateO").value;
	endDateO = document.getElementById("endDateO").value;
	prdtNmO = document.getElementById("prdtNmO").value;
	
	console.log(startDateO);
	console.log(endDateO);
	console.log("출고조회");
	
	eprdtOustGrid.readData(1,{'startDate':startDateO,
								'endDate':endDateO, 
								'prdtNm':prdtNmO}, true);
});
	
		
	
	</script>
</body>
</html>