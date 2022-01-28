<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 코드 모달</title>
</head>
<body>

	<br>
	<h3>공정 코드 검색</h3>
	<br>
	<div id="prcsCodeGrid" style="width: 100%"></div>
	
	<script>
var Grid = tui.Grid;
	
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
	
	// 그리드 생성
	var prcsCodeGrid = new Grid({
		el: document.getElementById('prcsCodeGrid'),
	  	data : {
		  api: {
		    readData: { url:'${path}/com/prcsCodeModal.do', method: 'GET'}
		  },
		  contentType: 'application/json'
		},
	  	rowHeaders:[ 'rowNum'],
	  	selectionUnit: 'row',
	  	bodyHeight: 400,
	  	columns:[
	  		  {
			    header: '공정 코드',
			    name: 'prcsId',
			    align: 'center'
			  },
			  {
			    header: '공정 명',
			    name: 'prcsNm',
			    align: 'center'
			  }
			 
			]
	});
	
	// 모달에서 클릭 이벤트
	prcsCodeGrid.on('dblclick', (ev) => {
		
		// cell 선택시 row 선택.
		prcsCodeGrid.setSelectionRange({
		      start: [ev.rowKey, 0],
		      end: [ev.rowKey, prcsCodeGrid.getColumns().length-1]
	});
		// 해당 행의 모든값 객체형태로 매개값으로 담음.
	 prcsCodeData(prcsCodeGrid.getRow(ev.rowKey))
		
	});	
	
	</script>
	
</body>
</html>