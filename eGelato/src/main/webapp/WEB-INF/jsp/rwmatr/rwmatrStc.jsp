<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 재고관리</title> 
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
<h3>원자재 재고관리</h3>
<div style="margin: 20px;">
	<form action="">
		자재명 : <input type="text" id="rwmName">업체명 : <input type="text" id="vendName"><br>
		발주신청일 :   <input type="date" id="startDate"> ~ <input type="date" id="endDate">
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

	<!-- 입고내역 조회 -->
	<div id="rwmatrStcList" style="width: 80%"></div>

	<!-- 모달창 -->
	<div id="dialogFrm"></div>

<script>
var Grid = tui.Grid;
let dialog;

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
	rowHeaders: ['checkbox'],
	selectionUnit: 'row',
	bodyHeight: 600,
	columns:[
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
		    header: '수량',
		    align: 'right',
		    name: 'qy',
		    sortable: true
		  },
		  {
		    header: '안전재고',
		    align: 'right',
		    name: 'safStc',
		    sortable: true
		  },
		  {
		    header: '홀딩수량',
		    align: 'right',
		    name: 'excpQy',
		    sortable: true
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
	
	//자재명 클릭시 현재고리스트 모달
	rwmatrStcList.on('click', (ev) => {
		rk = ev.rowKey;
		console.log(ev)
		console.log(ev.columnName)
		console.log(ev.rowKey)
	    if (ev.columnName === 'lotNo') {
			console.log("검수완료리스트")
			ig = 'g';
			callrwmatrStcModal();
		} else {
			
		}
	});

	//검수합격리스트 모달에서 받아온 데이터를 새로운 행에 넣어줌 or 텍스트박스에
	function getRwmatrData(rwmatrData) {
		console.log("입고정보 기입")
		if(ig == 'g'){
			rwmatrStcList.setValue(rk, "rwmatrId", rwmatrData.rwmatrId, true)
			rwmatrStcList.setValue(rk, "nm", rwmatrData.nm, true)
			rwmatrStcList.setValue(rk, "vendName", rwmatrData.vendName, true)
		} else if(ig == 'i'){
			document.getElementById("rwmName").value = rwmatrData.nm;
		}
		
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
		startDate = document.getElementById("startDate").value;
		endDate = document.getElementById("endDate").value;
		rwmName = document.getElementById("rwmName").value;
		vendName = document.getElementById("vendName").value;
		console.log(startDate);
		console.log(endDate);
		
		rwmatrStcList.readData(1,{'startDate':startDate,
									'endDate':endDate, 
									'rwmName':rwmName,
									'vendName': vendName}, true);
	});
	
	//추가
	btnAdd.addEventListener("click", function(){
		rwmatrStcList.prependRow();
	});
	
	//삭제
	btnDel.addEventListener("click", function(){
		
		if(rwmatrStcList.removeCheckedRows(true)){
			rwmatrStcList.request('modifyData');
		}
	});
	
	//저장
	btnSave.addEventListener("click", function(){
		rwmatrStcList.blur();
		rwmatrStcList.request('modifyData');
		flag = 'O'
	});

</script>
</body>
</html>