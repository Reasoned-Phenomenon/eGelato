<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재 재고현황</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>원자재 재고현황</h1><br>
	<form action="">
		자재명 : <input type="text" id="rwmNameM">
		<button type="button" id="rwmatrSearch" class="btn cur-p btn-outline-primary">조회</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</form>
	
	<div id="rwmatrStcListGrid" style="width: 100%"></div>
	
<script>
var Grid = tui.Grid;

var rwmNameM;

//자재명검색
document.getElementById("rwmatrSearch").addEventListener("click", function () {
	rwmNameM = document.getElementById("rwmNameM").value;
	
	rwmatrStcListGrid.readData(1,{'rwmName':rwmNameM}, true);
});

//checkOnlyOne(element);
//그리드 테마
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      background: '#fee'
	    },
	    invalid: {
	    	background: 'red',
	    	text: 'white'
	    }
	  }
	});
	
// 그리드 생성
var rwmatrStcListGrid = new Grid({
	el: document.getElementById('rwmatrStcListGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/rwmatr/rwmatrStcMList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
 		  {
		    header: '발주디테일코드',
		    name: 'rwmatrOrderDetaId',
		    hidden:true
		  },
  		  {
		    header: '자재LOT번호',
		    name: 'lotNo',
		    sortable: true
		  },
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
		    header: '수량',
		    align: 'right',
		    name: 'qy',
		    formatter({value}) { // 추가
				  let a = `\${value}`
			  	  let b = a.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			      return b;
			  },
		    sortable: true,
	        validation: {
	        	validatorFn: (value, row, columnName) => Number(value) > Number(row['safStc'])
	        }
		  },
		  {
		    header: '유통기한',
		    name: 'expdate',
		    sortable: true
		  }
		]
});

//커스텀 이벤트
rwmatrStcListGrid.on('dblclick', (ev) => {	
	
	//cell 선택시 row 선택됨.
	rwmatrStcListGrid.setSelectionRange({
	      start: [ev.rowKey, 0],
	      end: [ev.rowKey, rwmatrStcListGrid.getColumns().length-1]
	  });
	
	
	getRwmatrData(rwmatrStcListGrid.getRow(ev.rowKey));
});

</script>
</body>
</html>