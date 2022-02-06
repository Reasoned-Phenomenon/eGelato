<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>불량코드 목록</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>불량코드 목록</h1>
	<br>
	<div id="rwmatrInferCodeListGrid" style="width: 100%"></div>
	
<script>
var Grid = tui.Grid;
	
// 그리드 생성
var rwmatrInferCodeListGrid = new Grid({
	el: document.getElementById('rwmatrInferCodeListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/rwmatrInferCodeList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	bodyHeight: 330,
  	columns:[
 		  {
		    header: '불량코드',
		    name: 'inferId',
		    sortable: true
		  },
		  {
		    header: '불량명',
		    name: 'name',
		    sortable: true
		  },
  		  {
		    header: '불량내용',
		    name: 'deta',
		    sortable: true
		  }
		]
});


//커스텀 이벤트
rwmatrInferCodeListGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	rwmatrInferCodeListGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, rwmatrInferCodeListGrid.getColumns().length-1]
	  });
	
	
	getInferData(rwmatrInferCodeListGrid.getRow(ev.rowKey));
});

</script>
</body>
</html>