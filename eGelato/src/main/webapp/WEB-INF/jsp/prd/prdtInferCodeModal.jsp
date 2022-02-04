<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>
	<h1>불량코드 목록</h1>
	<br>
	<div id="prdtInferCodeGrid"></div>
	
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
	    }
	  }
	}); */
	
// 그리드 생성
var prdtInferCodeGrid = new Grid({
	el: document.getElementById('prdtInferCodeGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/prd/prdtInferCodeGrid.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	bodyHeight: 250,
  	columns:[
 		  {
		    header: '불량코드',
		    name: 'inferId',
		    sortable: true
		  },
		  {
		    header: '불량명',
		    name: 'name',
		    sortable: true
		  },
  		  {
		    header: '불량내용',
		    name: 'deta',
		    sortable: true
		  }
		]
});


prdtInferCodeGrid.on('dblclick', (ev) => {	
	
	prdtInferCodeGrid.setSelectionRange({
		      start: [ev.rowKey, 0],
		      end: [ev.rowKey, prdtInferCodeGrid.getColumns().length-1]
		  });
	
		var picid = prdtInferCodeGrid.getRow(ev.rowKey).inferId;
		console.log(picid);
		var picdt = prdtInferCodeGrid.getRow(ev.rowKey).deta;
		console.log(picdt);
		
	choosePic(picid,picdt);
});

</script>
</body>
</html>