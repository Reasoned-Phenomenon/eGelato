<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 입/출고조회</title>
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
	<h2>원자재 입/출고조회</h2>
</div>

<div id="tabs">

	<ul>
		<li><a href="#rwmatrIst">입고 조회</a></li>
		<li><a href="#rwmatrOust">출고 조회</a></li>
	</ul>
	<div id="rwmatrIst">
		<div style="margin: 20px;">
			<div>
				<form id="rwmatrI">
				    <table>
				        <tbody>
				            <tr>
				                <th>자재명</th>
				                <td>
				                	<input type="text" id="rwmNameI"><button type="button" id="rwmNameIM" class="btn-modal"></button>
				                	<input type="text" id="rwmIdI" readOnly>
				                </td>
				            </tr>
				            <tr>
				                <th>업체명</th>
				                <td>
				                	<input type="text" id="vendNameI"><button type="button" id="vendNameIM" class="btn-modal"></button>
				                	<input type="text" id="vendIdI" readOnly>
				                </td>
				            </tr>
				            <tr>
				                <th>입고일자</th>
				                <td><input type="date" id="startDateI" style="margin-right:7px;"> ~ <input type="date" id="endDateI" style="margin-left:7px;"></td>
				                <td><button type="button" id="btnFindI">조회</button></td>
				                <td><button type="reset">초기화</button></td>
				            </tr>
				        </tbody>
				    </table>
			    </form>
			</div>
		</div>
		<div id="rwmatrIstGrid" style="width:100%;"></div> <br>
	</div>
	
	<div id="rwmatrOust">
		<div style="margin: 20px;">
			<div>
				<form id="rwmatrO">
				    <table>
				        <tbody>
				            <tr>
				                <th>자재명</th>
				                <td>
				                	<input type="text" id="rwmNameO"><button type="button" id="rwmNameOM" class="btn-modal"></button>
				                	<input type="text" id="rwmIdO" readOnly>
				                </td>
				            </tr>
				            <tr>
				                <th>업체명</th>
				                <td>
				                	<input type="text" id="vendNameO"><button type="button" id="vendNameOM" class="btn-modal"></button>
				                	<input type="text" id="vendIdO" readOnly>
				                </td>
				            </tr>
				            <tr>
				                <th>출고일자</th>
				                <td><input type="date" id="startDateO" style="margin-right:7px;"> ~ <input type="date" id="endDateO" style="margin-left:7px;"></td>
				                <td><button type="button" id="btnFindO">조회</button></td>
				                <td><button type="reset">초기화</button></td>
				            </tr>
				        </tbody>
				    </table>
			    </form>
			</div>
		</div>
		<div id="rwmatrOustGrid" style="width:100%;"></div> <br>
	</div>
</div>

<!-- 모달창 -->
<div id="rwmatrDialogFrm" title="원자재 목록"></div>
<div id="vendDialogFrm" title="업체 목록"></div>

<!-- 계획 상세 그리드 - 주문서 -->
<div id="rwmatrIstGrid"></div>

<!-- 계획 상세 그리드 - 추가-->
<div id="rwmatrOustGrid"></div>

<script>
//탭 생성
$( "#tabs" ).tabs();

//검색조건
var startDateI;
var endDateI;
var rwmNameI;
var vendNameI;

var startDateO;
var endDateO;
var rwmNameO;
var vendNameO;

//텍스트박스 구분자
let flag;

//날짜기본값
const d = new Date();

const year = d.getFullYear(); // 년
const month = d.getMonth();   // 월
const day = d.getDate();      // 일

document.getElementById('startDateI').value = new Date(year, month, day - 5).toISOString().substring(0,10);
document.getElementById('endDateI').value = new Date().toISOString().substring(0, 10);

document.getElementById('startDateO').value = new Date(year, month, day - 5).toISOString().substring(0,10);
document.getElementById('endDateO').value = new Date().toISOString().substring(0, 10);

//토스트옵션
toastr.options = {
	positionClass : "toast-top-center",
	progressBar : true,
	timeOut: 1500 // null 입력시 무제한.
	}
	
//계획상세 그리드 생성
var Grid = tui.Grid;

//입고 조회 그리드
var rwmatrIstGrid = new Grid({
	el: document.getElementById('rwmatrIstGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrIstList.do', method: 'GET'},
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders:['rowNum'],
	selectionUnit: 'row',
	bodyHeight: 500,
	width:1500,
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
				  sortable: true,
			      validation: {
			          required: true
			      }
				}
		]
});
	
//출고 조회 그리드
var rwmatrOustGrid = new Grid({
	el: document.getElementById('rwmatrOustGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrOustList.do', method: 'GET'},
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
			      header: '발주디테일코드',
			      name: 'rwmatrOrderDetaId',
			      hidden:true
			    },
				{
				  header: '자재LOT번호',
				  name: 'lotNo',
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
			      header: '수량',
			      name: 'qy',
			      hidden:true
			    },
				{
				  header: '출고량',
				  align: 'right',
				  name: 'oustQy',
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
					  if(b == null){
						return '';  
					  } else {
				        return b;
					  }
				  },
				  sortable: true,
			      validation: {
			          required: true
			      }
				},
				{
				  header: '출고일시',
				  name: 'istOustDttm',
				  sortable: true
				},
				{
				  header: '유통기한',
				  name: 'expdate',
				  sortable: true
				},
				{
				  header: '담당자',
				  name: 'remk',
				  sortable: true ,
				  formatter({value}) { // 추가
					  let a = `\${value}`
				  	  if(a == 'null'){
				  		  a = '';
				  	  }
				      return a;
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


$("#rwmNameIM, #rwmNameOM").click(function() {
	callRwmatrModal();
	
	if( $(this).is("#rwmNameIM") ) {
		console.log($(this).is("#rwmNameIM"))
		flag = 'I';
	} else if( $(this).is("#rwmNameOM") ) {
		console.log($(this).is("#rwmNameOM"))
		flag = 'O';
	}
	
})

$("#vendNameIM, #vendNameOM").click(function() {
	callVendModal();
	
	if( $(this).is("#vendNameIM") ) {
		console.log($(this).is("#vendNameIM"))
		flag = 'I';
	} else if( $(this).is("#vendNameOM") ) {
		console.log($(this).is("#vendNameOM"))
		flag = 'O';
	}
})

//모달에서 텍스트박스로
function getRwmatrData(rwmatrData) {
	if(flag == 'I') {
		console.log(rwmatrData);
		document.getElementById("rwmNameI").value = rwmatrData.nm;
		document.getElementById("rwmIdI").value = rwmatrData.rwmatrId;
	} else if(flag == 'O') {
		document.getElementById("rwmNameO").value = rwmatrData.nm;
		document.getElementById("rwmIdO").value = rwmatrData.rwmatrId;
	}
	rwmatrDialogFrm.dialog( "close" );
}

//업체리스트 모달에서 받아온 텍스트박스에 넣어줌
function getVendData(vendData) {
	if(flag == 'I') {
		document.getElementById("vendNameI").value = vendData.vendName;
		document.getElementById("vendIdI").value = vendData.vendId;
	} else if(flag == 'O') {
		document.getElementById("vendNameO").value = vendData.vendName;
		document.getElementById("vendIdO").value = vendData.vendId;
	}
	vendDialogFrm.dialog( "close" );
}



//입고 조회 버튼
btnFindI.addEventListener("click", function(){
	startDateI = document.getElementById("startDateI").value;
	endDateI = document.getElementById("endDateI").value;
	rwmNameI = document.getElementById("rwmNameI").value;
	vendNameI = document.getElementById("vendNameI").value;
	
	console.log(startDateI);
	console.log(endDateI);
	console.log("입고조회");
	
	rwmatrIstGrid.readData(1,{'startDate':startDateI,
								'endDate':endDateI, 
								'rwmName':rwmNameI,
								'vendName': vendNameI}, true);
});

//출고 조회 버튼
btnFindO.addEventListener("click", function(){
	startDateO = document.getElementById("startDateO").value;
	endDateO = document.getElementById("endDateO").value;
	rwmNameO = document.getElementById("rwmNameO").value;
	vendNameO = document.getElementById("vendNameO").value;
	
	console.log(startDateO);
	console.log(endDateO);
	console.log("출고조회");
	
	rwmatrOustGrid.readData(1,{'startDate':startDateO,
								'endDate':endDateO, 
								'rwmName':rwmNameO,
								'vendName': vendNameO}, true);
});
	
		
	
	</script>
</body>
</html>