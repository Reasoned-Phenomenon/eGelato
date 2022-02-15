<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검사예정 목록</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>검사예정 목록</h1>
	<br>
	<div id="orderDetailListGrid" style="width: 100%"></div>
	<br>
	<div style="text-align: center;">
		<button type="button" class="btn btn-secondary" id="btnchoose">확인</button>
		<button type="button" class="btn btn-secondary" id="btnExit">취소</button>
	</div>
	
<script>
var Grid = tui.Grid;

//토스트옵션
toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
	}
	
// 그리드 생성
var orderDetailListGrid = new Grid({
	el: document.getElementById('orderDetailListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/orderDetailList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum','checkbox'],
  	bodyHeight: 235,
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '발주번호',
		    name: 'orderId',
		    sortable: true,
		    width: 135
		  },
		  {
		    header: '발주디테일번호',
		    name: 'rwmatrOrderDetaId',
		    hidden:true 
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
		  }
		]
});


$("#btnchoose").on("click", (ev) => {	
	
	let oList = orderDetailListGrid.getCheckedRows();
	
	for(let i=0; i < oList.length; i++) {
		rwmatrIstInspList.prependRow({'rwmatrOrderDetaId':oList[i].rwmatrOrderDetaId, 
									  'rwmatrId':oList[i].rwmatrId, 
									  'nm':oList[i].nm,
									  'qy':oList[i].qy});
	}
	
	orderDialogFrm.dialog( "close" );
	
});

$("#btnExit").on("click", function(){
	orderDialogFrm.dialog( "close" );
	
});
</script>
</body>
</html>