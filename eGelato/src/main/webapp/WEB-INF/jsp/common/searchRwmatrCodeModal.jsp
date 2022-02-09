<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 코드 검색 Modal</title>
</head>
<body>
    <br>
	<h3>자재 코드 검색</h3>
	<br>
	<div id="rwmatrCodeGrid" style="width: 100%"></div>
	
	<script>
	var Grid = tui.Grid;
	

	
	
	// 그리드 생성
	var rwmatrCodeGrid = new Grid({
		el: document.getElementById('rwmatrCodeGrid'),
	  	data : {
		  api: {
		    readData: { url:'${path}/com/rwmatrCodeModal.do', method: 'GET'}
		  },
		  contentType: 'application/json'
		},
	  	rowHeaders:[ 'rowNum'],
	  	selectionUnit: 'row',
	  	bodyHeight: 400,
	  	columns:[
	  		  {
			    header: '자재 코드',
			    name: 'rwmatrId',
			    align: 'center'
			  },
			  {
			    header: '자재 명',
			    name: 'nm',
			    align: 'center'
			  }
			 
			]
	});
	
	// 모달에서 클릭 이벤트
	rwmatrCodeGrid.on('dblclick', (ev) => {
		
		// cell 선택시 row 선택.
		rwmatrCodeGrid.setSelectionRange({
		      start: [ev.rowKey, 0],
		      end: [ev.rowKey, rwmatrCodeGrid.getColumns().length-1]
	});
		// 해당 행의 모든값 객체형태로 매개값으로 담음.
	 getRwmatrData(rwmatrCodeGrid.getRow(ev.rowKey))
		
	});	
	
	</script>
	
</body>
</html>