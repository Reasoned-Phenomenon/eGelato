<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비구분 모달창</title>
</head>
<body>
<div id="seolbiGrid"></div>

<script>
var codeParam;

var Grid = tui.Grid;

const seolbiGrid = new Grid({
	el: document.getElementById('seolbiGrid'),
  	data : {
	  api: {
	    readData: 	{ url: '${path}/com/findComCodeDeta.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
			{
			  header: '구분코드',
			  name: 'code'
			},
			{
			  header: '구분명',
			  name: 'codeNm'
			}
		]
});
function getSeolbiData (str){
	//목표 태그의 ID값을 입력하면 해당 태그의 value에 모달에서 가져온 값 넣어줌
	let target1 = document.getElementById('fg');
	let target2 = document.getElementById('fgName');
	console.log(str);
	target1.value = str.code;
	target2.value = str.codeNm;
	dialog.dialog("close");
}

//이벤트
seolbiGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	seolbiGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, seolbiGrid.getColumns().length-1]
	  });
	
	//클릭한 row의 codeId에 해당하는 code를 읽어옴
	codeParam = seolbiGrid.getRow(ev.rowKey);
	console.log(codeParam)
	getSeolbiData(codeParam);
});
</script>
</body>
</html>