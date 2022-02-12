<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 조회 modal</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	
	<br>
	<h1>거래처 목록</h1><br>
	    <form action="">
	    
	    	<table>
		        <tbody>
		            <tr>
		                <th>업체명</th>
		                <td>
		                	<input type="text" id="vendNameM">
		                	<button type="button" id="vendSearch" class="btn cur-p btn-dark">조회</button>
		                </td>
		                <td><button type="reset" class="btn cur-p btn-dark">초기화</button></td>
		            </tr>
		        </tbody>
		    </table>
	    
			<!-- 업체명 : <input type="text" id="vendNameM">
			<button type="button" id="vendSearch" class="btn cur-p btn-outline-primary">조회</button>
			<button type="reset" class="btn cur-p btn-outline-primary">초기화</button> -->
		</form>
	
	<div id="vendListGrid" style="width: 100%"></div>
	
<script>

var Grid = tui.Grid;

//검색 조건
var vendNameM;

document.getElementById("vendSearch").addEventListener("click", function () {
	vendNameM = document.getElementById("vendNameM").value;
	
	vendListGrid.readData(1,{'vendName':vendNameM}, true);
});


	
// 그리드 생성
var vendListGrid = new Grid({
	el: document.getElementById('vendListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/biz/vendList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:[ 'rowNum'],
  	selectionUnit: 'row',
  	bodyHeight: 295,
  	columns:[
  		  {
		    header: '업체 코드',
		    name: 'vendId',
		    align: 'center'
		  },
		  {
		    header: '업체 명',
		    name: 'vendName',
		    align: 'center'
		  },
		  {
		    header: '사업자 등록번호',
		    name: 'bizno',
		    align: 'center'
		  },
		  {
			header: '전화 번호',
			name:'telno',
			align: 'center'
		  }
		]
});

	
// 모달창에서 더블클릭하면 거래처 인풋태그에 넣어주기.
vendListGrid.on("dblclick", (ev) => {
	
	vendListGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, vendListGrid.getColumns().length-1]
	});
	
	
	
	var vendParam = vendListGrid.getRow(ev.rowKey);
	getModalData(vendParam);
	console.log(vendParam);
});
	
	
</script>
</body>
</html>