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
	<h1>미사용 설비 목록</h1>
	<br>
	<div id="unUseEqmGrid"></div>

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
var unUseEqmGrid = new Grid({
	el: document.getElementById('unUseEqmGrid'),
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
		    header: '설비코드',
		    name: 'eqmId'
		  },{
		    header: '설비명',
		    name: 'eqmName',
		  },{
		    header: '모델명',
		    name: 'modelNo',
		  },{
		    header: '관리자',
		    name: 'mngr',
		  }
	  ]
});


unUseEqmGrid.on("dblclick", (ev) => {
	
	unUseEqmGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, unUseEqmGrid.getColumns().length-1]
	});
	
	var prid = unUseEqmGrid.getRow(ev.rowKey).eqmId;
	var prnm = unUseEqmGrid.getRow(ev.rowKey).eqmName;
	var prnm = unUseEqmGrid.getRow(ev.rowKey).modelNo;
	var prnm = unUseEqmGrid.getRow(ev.rowKey).mngr;
	
	console.log(prid);
	console.log(prnm);
	
	//selectPr(prid,prnm);

});

</script>
</body>
</html>