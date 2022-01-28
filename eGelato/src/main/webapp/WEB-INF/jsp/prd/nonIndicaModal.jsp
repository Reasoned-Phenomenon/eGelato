<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미지시 계획 조회</title>
</head>
<body>
	<br>
	<h1>미지시 계획 목록</h1>
	<br>
	<div id="nonIndicaGrid"></div>

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
		
	//그리드 생성
	var nonIndicaGrid = new Grid({
		el: document.getElementById('nonIndicaGrid'),
		data : {
		  api: {
		    readData: { url:'${path}/prd/nonIndicaList.do', method: 'GET'}
		  },
		  contentType: 'application/json'
		},
		rowHeaders:['rowNum'],
		selectionUnit: 'row',
		columns:[
			  {
			    header: '계획코드',
			    name: 'planId'
			  },
			  {
			    header: '계획명',
			    name: 'name',
			  }
		  ]
	});
	
	//그리드 클릭 이벤트
	nonIndicaGrid.on("dblclick", (ev) => {
	
		nonIndicaGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, nonIndicaGrid.getColumns().length-1]
	});
	
	var nip = nonIndicaGrid.getRow(ev.rowKey).planId;
	console.log(nip);
	choosePI(nip);

	});
	
</script>	
</body>
</html>