<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품코드 조회 modal</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	
	<br>
	<h1>제품 목록</h1><br>
    <form action="">
    	<table>
	        <tbody>
	            <tr>
	                <th>제품명</th>
	                <td>
	                	<input type="text" id="prdtNameM">
	                	<button type="button" id="prdtSearch" class="btn cur-p btn-dark">조회</button>
	                </td>
	                <td><button type="reset" class="btn cur-p btn-dark">초기화</button></td>
	            </tr>
	        </tbody>
	    </table>
	</form>
	
	<div id="prdtListGrid" style="width: 100%"></div>
	
<script>
var Grid = tui.Grid;

// 검색 조건
var prdtNameM;

document.getElementById("prdtSearch").addEventListener("click", function () {
	prdtNameM = document.getElementById("prdtNameM").value;
	
	prdtListGrid.readData(1,{'prdtNm':prdtNameM}, true);
});


	
// 그리드 생성
var prdtListGrid = new Grid({
	el: document.getElementById('prdtListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/biz/prdtListModal.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:[ 'rowNum'],
  	selectionUnit: 'row',
  	bodyHeight: 295,
  	columns:[
  		  {
		    header: '제품 코드',
		    name: 'prdtId',
		    align: 'center'
		  },
		  {
		    header: '제품 명',
		    name: 'prdtNm',
		    align: 'center'
		  },
		  {
		    header: '규격',
		    name: 'spec',
		    align: 'center'
			  }
		]
});

// 모달창에서 더블클릭하면 제품코드 인풋태그에 넣어주기.
prdtListGrid.on("dblclick", (ev) => {
	prdtListGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, prdtListGrid.getColumns().length-1]
});
	
	var prdtParam = prdtListGrid.getRow(ev.rowKey);
	getModal(prdtParam);
	console.log(prdtParam);
});


</script>
</body>
</html>