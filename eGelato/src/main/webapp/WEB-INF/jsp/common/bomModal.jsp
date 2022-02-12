<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bom 관리페이지 제품코드와 제품명 찾는 모달창 </title>
</head>
<body>
	
	<br>
	<h3>제품코드 검색</h3>
	<div id="findGrid" style="width: 100%"></div>
	
<script>
	console.log("11111115");
	var Grid = tui.Grid;

	// 그리드 생성
	var findGrid = new Grid({
		el: document.getElementById('findGrid'),
	  	data : {
		  api: {
		    readData: { url:'${path}/com/bomModalModal.do', method: 'GET'}
		  },
		  contentType: 'application/json'
		},
	  	rowHeaders:[ 'rowNum'],
	  	selectionUnit: 'row',
	  	bodyHeight: 400,
	  	columns:[
	  		  {
			    header: '제품 코드',
			    name: 'prdtId',
			    align: 'center'
			  },
			  {
			    header: '제품 명',
			    name: 'prdtNm',
			    align: 'center'
			  },
			  {
			    header: '규격',
			    name: 'spec',
			    align: 'center'
			  }, 
			  {
				header: '단위',
				name: 'unit',
				align: 'center'
			  }, 
			  {
				header: '규격 코드',
				name: 'specCode',
				hidden: true
			   }, 
			   {
				 header: '단위 코드',
				 name: 'unitCode',
				 hidden: true
				}
			 
			]
	});
	
 	// 모달창에서 더블클릭하면 제품코드 인풋태그에 넣어주기.
	findGrid.on("dblclick", (ev) => {
		
		findGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, findGrid.getColumns().length-1]
		});
		
		
		var Param = findGrid.getRow(ev.rowKey); // 컬럼 네임을 해서 한줄에 있는 값 다 들고 오게 하기.
		getModal(Param);
		console.log(Param);
	}); 
	
	
</script>
	
	
</body>
</html>