<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 재고조회</title> 
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
<h3>원자재 재고조회</h3>
<div style="margin: 20px;">
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
	<div id="rwmatrStcList" style="width: 80%"></div>

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
var rwmName;
var vendName;

//그리드 생성
var rwmatrStcList = new Grid({
	el: document.getElementById('rwmatrStcList'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/rwmatr/rwmatrStcList.do', method: 'GET'},
	    modifyData : { url: '${path}/rwmatr/rwmatrStcModifyData.do', method: 'PUT'} 
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
	bodyHeight: 600,
	columns:[
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
		    header: '수량',
		    align: 'right',
		    name: 'qy',
		    formatter({value}) { // 추가
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			      return b;
			  },
		    sortable: true,
	        validation: {
	        	validatorFn: (value, row, columnName) => Number(value) > Number(row['safStc'])
	        }
		  },
		  {
		    header: '안전재고',
		    align: 'right',
		    name: 'safStc',
		    formatter({value}) { // 추가
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			      return b;
			  },
		    sortable: true
		  },
		  {
		    header: '홀딩수량',
		    align: 'right',
		    name: 'excpQy',
		    formatter({value}) { // 추가
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			      return b;
			  },
		    sortable: true
		  },
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
	rwmatrStcList.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			rwmatrStcList.readData(1);
			flag = 'X';
		}
		//rwmatrStcList.resetOriginData();
	});

	//조회
	btnFind.addEventListener("click", function(){
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		
		rwmatrStcList.readData(1,{'rwmName':rwmName,
								  'vendName': vendName}, true);
	});
	

</script>
</body>
</html>