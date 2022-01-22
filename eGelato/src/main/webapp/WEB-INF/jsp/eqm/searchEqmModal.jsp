<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비코드 모달창</title>
</head>
<body>
<div id="eqmGrid"></div>
<script>
var codeParam;

var Grid = tui.Grid;

var eqmGrid = new Grid({
	el: document.getElementById('eqmGrid'),
  	data : {
	  api: {
	    readData: 	{ url: '${path}/eqm/eqmList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	bodyHeight : 300,
  	columns:[
			{
			  header: '설비코드',
			  name: 'eqmId'
			},
			{
			  header: '설비명',
			  name: 'eqmName'
			}
		]
});

function getEqmData (str){
	//목표 태그의 ID값을 입력하면 해당 태그의 value에 모달에서 가져온 값 넣어줌
	let target1 = document.getElementById('searchId');
	let target2 = document.getElementById('searchNm');
	console.log(str);
	target1.value = str.eqmId;
	target2.value = str.eqmName;
	dialog.dialog("close");
}

//이벤트
eqmGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	eqmGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, eqmGrid.getColumns().length-1]
	  });
	
	//클릭한 row의 codeId에 해당하는 code를 읽어옴
	codeParam = eqmGrid.getRow(ev.rowKey);
	console.log(codeParam)
	getEqmData(codeParam);
});

</script>
</body>
</html>