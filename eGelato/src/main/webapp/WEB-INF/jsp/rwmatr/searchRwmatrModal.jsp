<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 목록</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>원자재 목록</h1><br>
	<div>
		<form action="">
		    <table>
		        <tbody>
		            <tr>
		                <th>자재명</th>
		                <td><input type="text" id="rwmNm"></td>
		            </tr>
		            <tr>
		            	<th>자재코드</th>
		                <td><input type="text" id="rwmatrId"></td>
		                <td><button type="button" id="rwmatrSearch" class="btn cur-p btn-dark">조회</button></td>
		                <td><button type="reset" class="btn cur-p btn-dark">초기화</button></td>
		            </tr>
		        </tbody>
		    </table>
	    </form>
	</div>
	
	<div id="rwmatrListGrid" style="width: 100%"></div>
	
<script>
var Grid = tui.Grid;

//검색조건
var rwmNm;
var rwmatrId;

document.getElementById("rwmatrSearch").addEventListener("click", function () {
	rwmNm = document.getElementById("rwmNm").value;
	rwmatrId = document.getElementById("rwmatrId").value;
	
	console.log(rwmNm);
	console.log(rwmatrId);
	
	rwmatrListGrid.readData(1,{'rwmName':rwmNm,
							   'rwmatrId':rwmatrId}, true);
});

// 그리드 생성
var rwmatrListGrid = new Grid({
	el: document.getElementById('rwmatrListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/searchRwmatrList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	bodyHeight: 290,
  	selectionUnit: 'row',
  	columns:[
  		  {
		    header: '자재코드',
		    name: 'rwmatrId',
		    sortable: true
		  },
		  {
		    header: '자재명',
		    name: 'nm',
		    sortable: true
		  },
		  {
		    header: '업체명',
		    name: 'vendName',
		    sortable: true
		  },
		  {
		    header: '규격',
		    align: 'right',
		    name: 'spec',
		    sortable: true
		  },
		  {
		    header: '작업단위',
		    align: 'right',
		    name: 'wkUnit',
	    	formatter({value}) { // 추가
			  let a = `\${value}`
		  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
		      return b;
		    },
		    sortable: true
		  }
		]
});

//커스텀 이벤트
rwmatrListGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	rwmatrListGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, rwmatrListGrid.getColumns().length-1]
	  });
	
	//해당 행의 모든값 객체형태로 매개값으로 담음	
	getRwmatrData(rwmatrListGrid.getRow(ev.rowKey))
	
});

</script>
</body>
</html>