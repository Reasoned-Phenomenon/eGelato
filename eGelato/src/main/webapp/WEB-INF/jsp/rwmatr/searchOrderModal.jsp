<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 목록</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>발주 목록</h1>
	<br>
	<div id="orderDetailListGrid" style="width: 100%"></div>
	
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
var orderDetailListGrid = new Grid({
	el: document.getElementById('orderDetailListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/orderDetailList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '발주번호',
		    name: 'orderId',
		    sortable: true
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
		    sortable: true
		  }
		]
});


//커스텀 이벤트
orderDetailListGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	orderDetailListGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, orderDetailListGrid.getColumns().length-1]
	  });
	
	
	getOrderData(orderDetailListGrid.getRow(ev.rowKey));
});

</script>
</body>
</html>