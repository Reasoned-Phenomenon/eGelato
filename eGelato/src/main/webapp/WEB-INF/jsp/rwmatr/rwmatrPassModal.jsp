<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고예정 목록</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>입고예정 목록</h1>
	<br>
	<div id="rwmatrPassListGrid" style="width: 100%"></div>
	<br>
	<div style="text-align: center;">
		<button type="button" class="btn btn-secondary" id="btnchoose">확인</button>
		<button type="button" class="btn btn-secondary" id="btnExit">취소</button>
	</div>
	
<script>
var Grid = tui.Grid;

// 그리드 생성
var rwmatrPassListGrid = new Grid({
	el: document.getElementById('rwmatrPassListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/rwmatrPassList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
	rowHeaders: ['rowNum','checkbox'],
  	bodyHeight: 235,
  	selectionUnit: 'row',
  	columns:[
 		  {
		    header: '발주코드',
		    name: 'orderId',
		    sortable: true
		  },
		  {
		    header: '발주디테일코드',
		    name: 'rwmatrOrderDetaId',
			hidden:true
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
		    header: '입고량',
		    align: 'right',
		    name: 'passQy',
		    sortable: true
		  },
		  {
		    header: '검사일자',
		    name: 'dt',
		    editor: 'datePicker'
		  }
		]
});


$("#btnchoose").on("click", function(){
			
	console.log(rwmatrPassListGrid.getCheckedRows());
	
	let oust = rwmatrPassListGrid.getCheckedRows();
	console.log(oust);
	
	for(let i=0; i < oust.length; i++) {
		rwmatrIstList.prependRow({'rwmatrOrderDetaId':oust[i].rwmatrOrderDetaId, 
								 'rwmatrId':oust[i].rwmatrId, 
								 'nm':oust[i].nm,
								 'vendName':oust[i].vendName,
								 'istQy':oust[i].passQy})
	}
	
	rwmatrPassDialogFrm.dialog( "close" );
	
});

$("#btnExit").on("click", function(){
	
	rwmatrPassDialogFrm.dialog( "close" );
	
});

</script>
</body>
</html>