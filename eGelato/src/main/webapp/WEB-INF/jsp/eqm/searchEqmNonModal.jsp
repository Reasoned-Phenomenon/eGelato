<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비가동사유코드 모달</title>
</head>
<body>
<div id="eqmNonResnGrid"></div>
<script>
var codeParam;

var Grid = tui.Grid;

var eqmNonRsnGrid = new Grid({
	el: document.getElementById('eqmNonResnGrid'),
  	data : {
	  api: {
	    readData: 	{ url: '${path}/eqm/eqmNonResnGrid.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	bodyHeight : 300,
  	columns:[
			{
			  header: '비가동코드',
			  name: 'resnId'
			},
			{
			  header: '비가동명',
			  name: 'resnName'
			}
		]
});

function getEqmNonResnData (str){
	//목표 태그의 ID값을 입력하면 해당 태그의 value에 모달에서 가져온 값 넣어줌
	let target1 = document.getElementById('resnId');
	let target2 = document.getElementById('resnName');
	console.log(str);
	target1.value = str.resnId;
	target2.value = str.resnName;
	dialogSearch.dialog("close");
}

//이벤트
eqmNonRsnGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	eqmNonRsnGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, eqmNonRsnGrid.getColumns().length-1]
	  });
	
	//클릭한 row의 codeId에 해당하는 code를 읽어옴
	codeParam = eqmNonRsnGrid.getRow(ev.rowKey);
	console.log(codeParam)
	getEqmNonResnData(codeParam);
});

</script>
</body>
</html>