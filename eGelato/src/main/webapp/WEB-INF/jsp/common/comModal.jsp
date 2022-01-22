<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="modalGrid"></div>

<script>

var modalDataSource = {
		api: {
		    readData: 	{url: '${path}/com/findComCodeDeta.do', method: 'GET' }
	  	},
		contentType: 'application/json'
	};
	
var columns = 	[
	  {
		    header: 'CODE',
		    name: 'code'
		  },
		  {
		    header: 'CODE_NM',
		    name: 'codeNm'
		  },
		  {
		    header: 'CODE_DC',
		    name: 'codeDc'
		  },
		  {
		    header: 'USE_AT',
		    name: 'useAt',
		    align: 'center'
		  }
		];
		
var modalGrid = new tui.Grid({
	el: document.getElementById('modalGrid'),
	data: modalDataSource,
	width: 450,
	bodyHeight:300,
	selectionUnit: 'row',
	columns 
});

//이벤트
modalGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	modalGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, modalGrid.getColumns().length-1]
	  });
	
	//클릭한 row의 codeId에 해당하는 code를 읽어옴
	//console.log(modalGrid.getRow(ev.rowKey))
	codeParam = modalGrid.getRow(ev.rowKey).codeNm;
	console.log(codeParam)
	getModalData(codeParam);

});

</script>

</body>
</html>