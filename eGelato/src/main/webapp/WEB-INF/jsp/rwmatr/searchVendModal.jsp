<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업체 목록</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>업체 목록</h1>
	<br>
	
	<form action="">
		거래처 : <input type="text" id="vendNameM">
		<button type="button" id="vendSearch" class="btn cur-p btn-outline-primary">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</form>
	
	<div id="vendListGrid" style="width: 100%"></div>
	
<script>
var Grid = tui.Grid;

//검색조건
var vendNameM;

document.getElementById("vendSearch").addEventListener("click", function () {
	vendNameM = document.getElementById("vendNameM").value;
	
	vendListGrid.readData(1,{'vendName':vendNameM}, true);
});

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
var vendListGrid = new Grid({
	el: document.getElementById('vendListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/searchVendList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	bodyHeight: 300,
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '업체코드',
		    name: 'vendId'
		  },
		  {
		    header: '업체명',
		    name: 'vendName',
		  },
		  {
		    header: '비고',
		    name: 'remk',
		  }
		]
});

/* rwmatrListGrid.on("click", (ev) => {
	console.log(rwmatrListGrid.getRow(ev.rowKey).rwmatrId);
	console.log(rwmatrListGrid.getRow(ev.rowKey).nm);
	let rmId = rwmatrListGrid.getRow(ev.rowKey).rwmatrId;
	let rmnm = rwmatrListGrid.getRow(ev.rowKey).nm;
	
	
}); */

//커스텀 이벤트
vendListGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	vendListGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, vendListGrid.getColumns().length-1]
	  });
	
	getVendData(vendListGrid.getRow(ev.rowKey))
});

</script>
</body>
</html>