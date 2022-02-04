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
	<h1>제품목록</h1>
	<br>
	<div id="prdtListGrid"></div>

<script>
var Grid = tui.Grid;

//그리드 테마
/* Grid.applyTheme('striped', {
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
	}); */
	
// 그리드 생성
var prdtListGrid = new Grid({
	el: document.getElementById('prdtListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/prd/prdtList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	width: 450,
  	columns:[
  		  {
		    header: '제품코드',
		    name: 'prdtId'
		  },
		  {
		    header: '제품명',
		    name: 'prdtNm',
		  }
	  ]
});


prdtListGrid.on("dblclick", (ev) => {
	
	prdtListGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, prdtListGrid.getColumns().length-1]
	});
	
	var prid = prdtListGrid.getRow(ev.rowKey).prdtId;
	var prnm = prdtListGrid.getRow(ev.rowKey).prdtNm;
	console.log(prid);
	console.log(prnm);
	selectPr(prid,prnm);

});

</script>
</body>
</html>