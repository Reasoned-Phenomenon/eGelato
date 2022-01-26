<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 코드 관리 페이지</title>
</head>
<body>
	<div>
		<br>
		<h3>완제품 코드 관리</h3>
	</div>
	<form>
	<div>
		<br>
		<label>완제품 코드</label>
			<input type="text" id="prdtId" name="prdtId">
			
		<label>제품명</label>
		    <input type="text" id="prdtNm" name="prdtNm">
		  
		<label>규격</label>
			<input type="text" id="spec" name="spec">
			
		<label>단위</label>
			<input type="text" id="unit" name="unit">	
			
		<label>안전 재고</label>
			<input type="text" id="safStc" name="safStc">	   
		<br>	 	
	</div>
	<div>
		<button type="button" class="btn cur-p btn-outline-primary" id="SearchBtn">조회</button>
					<button type="button" class="btn cur-p btn-outline-primary" id="AddBtn">추가</button>
					<button type="button" class="btn cur-p btn-outline-primary" id="SaveBtn">저장</button>
					<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</div>
</form>

<div id="prdtCodeGrid" style="width: 100%"></div>

<script>
let dialog;

var Grid = tui.Grid;

//그리드 테마.
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


//그리드 생성.
var prdtCodeGrid = new Grid({
	el: document.getElementById('prdtCodeGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/prdtCodeList.do', method: 'GET'},
	    
	  },
	  contentType: 'application/json',
	
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	columns:[
			{
			  header: '완제품 코드',
			  name: 'prdtId',
			  align: 'center'
		      
			},
			{
			  header: '제품명',
			  name: 'prdtNm',
			  align: 'center'
	          
			},
			{
			  header: '규격',
			  name: 'spec',
			  align: 'center'
		      
			},
			{
			  header: '단위',
			  name: 'unit',
			  align: 'center'
			      
			},
			{
			  header: '안전 재고',
			  name: 'safStc',
			  align: 'center'
				      
			}

		]
});
	
	// 조회버튼 이벤트.
	SearchBtn.addEventListener("click", function() {
		console.log("조회버튼 클릭");
		
	});


</script>
</body>
</html>