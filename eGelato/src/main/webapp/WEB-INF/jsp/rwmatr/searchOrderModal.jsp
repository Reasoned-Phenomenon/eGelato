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
	
//토스트옵션
toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
	}
	
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
		    formatter({value}) { // 추가
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			      return b;
			  },
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
	
	//검사할 자재주문 중복선택 방지
	let rowLength = rwmatrIstInspList.findRows({
		rwmatrOrderDetaId: orderDetailListGrid.getRow(ev.rowKey).rwmatrOrderDetaId
	}).length;
	
	if(rowLength > 0) {
		console.log("중복체크")
		//toastr
		toastr.clear()
		toastr.success( ('이미 선택한 주문입니다.'),'Gelato',{timeOut:'1800'} );
		return;
		
	} /* else {
		selectList.push(orderDetailListGrid.getRow(ev.rowKey).rwmatrOrderDetaId);
	} */
	
	
	getOrderData(orderDetailListGrid.getRow(ev.rowKey));
});

</script>
</body>
</html>