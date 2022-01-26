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
<body>
	
	<br>
	<h3>업체 검색</h3>
	<br>
	<div id="vendGrid" style="width: 100%"></div>
	
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
	    }
	  }
	});
	
// 그리드 생성
var vendGrid = new Grid({
	el: document.getElementById('vendGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/com/vendModalModal.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:[ 'rowNum'],
  	selectionUnit: 'row',
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

// 그리드 이벤트.
/*  vendListGrid.on("dblclick", (ev) => {
	console.log("777777777");
	vendListGrid.setSelectionRange({
		start : [ev.rowkey, 0],
		end : [ev.rowKey, vendListGrid.getColumns().length-1]
	});
	console.log("88888888");
	/* var vlg = vendListGrid.getRow(ev2.rowKey).vendId;
	console.log(vlg);
	chooseVI(vlg); */
	
	// 클릭한 row의 vendId에 해당하는 코드를 읽어옴.
//	var vendParam = vendListGrid.getRow(ev.rowKey).vendId;
//	console.log(vendParam);
//	getModalData(vendParam);
	
//});  */

	
// 모달창에서 더블클릭하면 거래처 인풋태그에 넣어주기.
 vendGrid.on("dblclick", (ev) => {
	
	 vendGrid.setSelectionRange({
	    start: [ev.rowKey, 0],
	    end: [ev.rowKey, vendGrid.getColumns().length-1]
	});
	
	var vendParam = vendGrid.getRow(ev.rowKey);
	getModalData(vendParam);
	console.log(vendParam);
}); 
	
	
</script>
</body>
</html>