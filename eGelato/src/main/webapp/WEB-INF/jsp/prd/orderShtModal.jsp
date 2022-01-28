<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 조회 modal</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>주문서</h1>
	<br>
	<div id="ordershtGrid"></div>

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
	    },
	    selectedHeader : {
	    	background : '#FFFFFF'
	    }
	  }
	});
	
// 그리드 생성
var ordershtGrid = new Grid({
	el: document.getElementById('ordershtGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/prd/orderShtModal.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '주문서코드',
		    name: 'orderId'
		  },
		  {
		    header: '주문날짜',
		    name: 'orderDt',
		  },
		  {
		    header: '고객사명',
		    name: 'vendName'
		  },
		  {
			header: '납기일자',
			name:'oustDt',
		  },
		  {
			header: '총량',
			name:'qy',
			align: 'right',
		  }
 		  
		]
});

//그리드 이벤트
// 클릭 이벤트
/* ordershtGrid.on("click", (ev) => {
		
	//cell 선택시 row 선택되도록 하기
	ordershtGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, ordershtGrid.getColumns().length-1]
	});
	
}); */


ordershtGrid.on("dblclick", (ev2) => {
	
	ordershtGrid.setSelectionRange({
	    start: [ev2.rowKey, 0],
	    end: [ev2.rowKey, ordershtGrid.getColumns().length-1]
	});
	
	var osg = ordershtGrid.getRow(ev2.rowKey).orderId;
	console.log(osg);
	chooseOI(osg);

});

</script>
</body>
</html>