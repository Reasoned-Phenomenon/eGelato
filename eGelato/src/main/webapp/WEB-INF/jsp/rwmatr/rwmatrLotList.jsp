<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 출고관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
<h3>원자재LOT 재고조회</h3>
<div style="margin: 20px;">
	<form action="">
		자재명 : <input type="text" id="rwmName">업체명 : <input type="text" id="vendName"><br>
		유통기한 :   <input type="date" id="startDate"> ~ <input type="date" id="endDate">
		<button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
		<button type="button" class="btn cur-p btn-outline-primary" id="btnReset">전체검색</button>
	</form>
</div>
<hr>
<br>

<!-- 입고내역 조회 -->
<div id="rwmatrLotList" style="width: 80%"></div>

<!-- 모달창 -->
<div id="dialogFrm"></div>


<script>
var Grid = tui.Grid;
let dialog;

//모달에서 선택한 rowKey값 세팅
let rk = '';

//검색 조건
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

toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
	}

//그리드 생성
var rwmatrLotList = new Grid({
	el: document.getElementById('rwmatrLotList'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/RwmatrLotList.do', method: 'GET'}
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
 		  {
		    header: '발주디테일코드',
		    name: 'rwmatrOrderDetaId',
		    hidden:true
		  },
  		  {
		    header: '자재LOT번호',
		    name: 'lotNo',
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
		    header: '유통기한',
		    name: 'expdate',
		    sortable: true
		  }
		]
});

//자재모달
function callRwmatrModal(){
	dialog = $( "#dialogFrm" ).dialog({
		  modal:true,
		  autoOpen:false,
	      height: 400,
	      width: 600,
	      modal: true
	}); 
	
    dialog.dialog( "open" );
    $("#dialogFrm").load("${path}/rwmatr/searchRwmatrDialog.do", function(){console.log("원자재 목록")})
}

//업체명 모달
function callVendModal(){
	dialog = $( "#dialogFrm" ).dialog({
		  modal:true,
		  autoOpen:false,
	      height: 400,
	      width: 600,
	      modal: true
	}); 

    dialog.dialog( "open" );
    $("#dialogFrm").load("${path}/rwmatr/searchVendDialog.do", function(){console.log("업체명 목록")})
}

//검수완료리스트 모달
function callrwmatrPassModal(){
	dialog = $( "#dialogFrm" ).dialog({
		  modal:true,
		  autoOpen:false,
	      height: 400,
	      width: 600,
	      modal: true
	}); 

    dialog.dialog( "open" );
    $("#dialogFrm").load("${path}/rwmatr/rwmatrPassModal.do", function(){console.log("검수완료 리스트")})
}

//현재고 리스트 모달
function callrwmatrStcModal(){
	dialog = $( "#dialogFrm" ).dialog({
		  modal:true,
		  autoOpen:false,
	      height: 600,
	      width: 1200,
	      modal: true
	}); 

    dialog.dialog( "open" );
    $("#dialogFrm").load("${path}/rwmatr/rwmatrStcModal.do", function(){console.log("검수완료 리스트")})
}
	

	//검수합격리스트 모달에서 받아온 데이터를 새로운 행에 넣어줌 or 텍스트박스에
	function getRwmatrData(rwmatrData) {
		document.getElementById("rwmName").value = rwmatrData.nm;
		
		dialog.dialog( "close" );
	}
	
	//자재명 textbox
	document.getElementById("rwmName").addEventListener("click", function() {
		  ig = 'i';
		  callRwmatrModal();
	});
	
	//업체리스트 모달에서 받아온 텍스트박스에 넣어줌
	function getVendData(vendData) {
		document.getElementById("vendName").value = vendData.vendName;
		
		dialog.dialog( "close" );
	}
	
	//업체명 textbox
	document.getElementById("vendName").addEventListener("click", function() {
		callVendModal();
	});
	

	//조회
	btnFind.addEventListener("click", function(){
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		console.log(startDate);
		console.log(endDate);
		
		rwmatrLotList.readData(1,{'startDate':startDate,
									'endDate':endDate, 
									'rwmName':rwmName,
									'vendName': vendName}, true);
	});
	
	//검색초기화
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
		
		rwmatrLotList.readData(1,{'startDate':startDate,
									'endDate':endDate, 
									'rwmName':rwmName,
									'vendName': vendName}, true);
	});
	

</script>
</body>
</html>