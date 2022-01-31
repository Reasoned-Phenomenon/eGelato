<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출고 관리 페이지</title>
</head>
<body>

	<div>
	<br>
		<h1>출고 관리</h1>
	<br>
	</div>
	<br>
	<form>
		<div class="row">
		<div class="col-sm-5">
			
			<br>
			<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	    	<button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
			<div id=""></div>
			<br>
			
		</div>
		<div class="col-sm-7">
			
			<hr>
			<div id=""></div>
			<br>
			<div class="col-sm-2">
			</div>
		</div>
	</div>
</form>
</body>

<script>
	
// 그리드 생성
var Grid = tui.Grid;

//그리드 테마
Grid.applyTheme('striped', {
	cell : {
		header : {
			background : '#eef'
		},
		evenRow : {
			background : '#fee'
		},
		selectedHeader : {
	    	background : '#FFFFFF'
	    }
	}
});


// 출고 관리 그리드 1. (좌측 생성.)
 var oustGrid = new Grid({
	el: document.getElementById('oustGrid'),
  	data : dataSources,
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	columns:[
  			{
			  header: '',
			  name: ''
			
			},
			{
			  header: '',
			  name: ''
			  
			},
			{
			  header: '',
			  name: ''
			},
			{
			  header: '',
			  name: ''
			  
			},
			
		]
});

// 출고 관리 그리드 2. (우측에 생성.)


	

</script>
</html>