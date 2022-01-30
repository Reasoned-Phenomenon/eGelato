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
	<h1>공정 구분 목록</h1>
	<br>
	<div id="prcsDetaListGrid"></div>

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
var prcsDetaListGrid = new Grid({
	el: document.getElementById('prcsDetaListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '공정 구분 코드',
		    name: 'prcsSelDeta'
		  },{
		    header: '공정 구분명',
		    name: 'prcsDetaName',
		  }
	  ]
});


prcsDetaListGrid.on("dblclick", (ev) => {
	
	prcsDetaListGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, prcsDetaListGrid.getColumns().length-1]
	});
	
	var prid = prcsDetaListGrid.getRow(ev.rowKey).prdtId;
	console.log(prid);
	
	//selectPr(prid,prnm);

});

</script>
</body>
</html>