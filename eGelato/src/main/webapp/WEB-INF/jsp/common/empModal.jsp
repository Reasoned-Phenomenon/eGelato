<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	이름 <input type="text" id="empNm" name="empNm">
	<button type="button" id="btnEmpFind">검색</button>
</div>
<hr>
<div id="empModalGrid"></div>

<script>

var empModalDataSource = {
		api: {
		    readData: 	{url: '${path}/com/findMber.do', method: 'GET' }
	  	},
		contentType: 'application/json'
	};

var columns = 	[
		{
		    header: '이름',
		    name: 'mberNm'
		  },
		  {
		    header: '아이디',
		    name: 'mberId'
		  },
		  {
		    header: 'esntlId',
		    name: 'esntlId',
		    hidden:true
		  }
	];
		
var empModalGrid = new tui.Grid({
	el: document.getElementById('empModalGrid'),
	data: empModalDataSource,
	width: 650,
	bodyHeight: 280,
	selectionUnit: 'row',
	columns 
});

//이벤트
empModalGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	empModalGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, empModalGrid.getColumns().length-1]
	  });
	
	getEmpModalData(empModalGrid.getValue(ev.rowKey,'mberNm'), empModalGrid.getValue(ev.rowKey,'esntlId'));
	
});

btnEmpFind.addEventListener("click",function(){ 
	
	empModalGrid.readData(1, {mberNm:$("#empNm").val()}, true);
	
	$("#empNm").val('');
})

</script>

</body>
</html>