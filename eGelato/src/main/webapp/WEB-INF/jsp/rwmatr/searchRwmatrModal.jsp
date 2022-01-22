<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 목록</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>원자재</h1><br>
	<form action="">
		자재명 : <input type="text" id="rwmNameM">
		<button type="button" id="rwmatrSearch" class="btn cur-p btn-outline-primary">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</form>
	
	
	<div id="rwmatrListGrid" style="width: 100%"></div>
	
<script>
var Grid = tui.Grid;

//검색조건
var rwmNameM;

document.getElementById("rwmatrSearch").addEventListener("click", function () {
	rwmNameM = document.getElementById("rwmNameM").value;
	
	rwmatrListGrid.readData(1,{'rwmName':rwmNameM}, true);
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
var rwmatrListGrid = new Grid({
	el: document.getElementById('rwmatrListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/searchRwmatrList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '자재코드',
		    name: 'rwmatrId'
		  },
		  {
		    header: '자재명',
		    name: 'nm',
		  },
		  {
		    header: '업체명',
		    name: 'vendName',
		  },
		  {
		    header: '규격',
		    align: 'right',
		    name: 'spec'
		  },
		  {
		    header: '작업단위',
		    align: 'right',
		    name: 'wkUnit'
		  }
		]
});

//커스텀 이벤트
rwmatrListGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	rwmatrListGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, rwmatrListGrid.getColumns().length-1]
	  });
	
	//해당 행의 모든값 객체형태로 매개값으로 담음	
	getRwmatrData(rwmatrListGrid.getRow(ev.rowKey))
	
});

</script>
</body>
</html>