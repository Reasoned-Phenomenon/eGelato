<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 재고현황</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>원자재 재고현황</h1>
	<br>
	<div id="rwmatrStcListGrid" style="width: 100%"></div>
	
<script>
var Grid = tui.Grid;
//checkOnlyOne(element);
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
var rwmatrStcListGrid = new Grid({
	el: document.getElementById('rwmatrStcListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/rwmatrStcMList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
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

//커스텀 이벤트
rwmatrStcListGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	rwmatrStcListGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, rwmatrStcListGrid.getColumns().length-1]
	  });
	
	
	getRwmatrData(rwmatrStcListGrid.getRow(ev.rowKey));
});

</script>
</body>
</html>