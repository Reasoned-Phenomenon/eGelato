<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<br>
		<h2>제품공정흐름도</h2>
		<br>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-5">
			<h3>제품공정흐름도</h3>
			<br>
			<hr>
			<div id="lineGrid"></div>
		</div>
		<div class="col-sm-7">
			<h3>제품공정흐름도 관리</h3>
			<button type="button" class="btn btn-secondary" id="btnAdd" >추가</button>
			<button type="button" class="btn btn-secondary" id="btnDel" >삭제</button>
			<button type="button" class="btn btn-secondary" id="btnIns" >등록</button>
			<hr>
			<div id="linePrcsGrid"></div>
		</div>
	</div>
	
	<div id="prcsModal"></div>
<script>
	//토스트옵션
	toastr.options = {
			positionClass : "toast-top-center",
			progressBar : true,
			timeOut: 1500 // null 입력시 무제한.
		}
	
	//계획상세 그리드 생성
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
	
	// 그리드 생성 1
	const lineGrid = new Grid({
		el : document.getElementById('lineGrid'),
		data : {
			api : {
				readData : {url : '${path}/prd/lineListGrid.do' , method : 'GET'}
			},
			contentType : 'application/json',
			initialRequest: false
		},
		rowHeaders : ['rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 610,
		columns : [ {
			header : '제품코드',
			name : 'prdtId'
		}, {
			header : '제품명',
			name : 'prdtNm',
		}, {
			header : '라인코드',
			name : 'lineId',
		}]
	});
	
	// 그리드 생성 2
	const linePrcsGrid = new Grid({
		el : document.getElementById('linePrcsGrid'),
		data : {
			api : {
				readData : {url : '${path}',method : 'GET'},
				modifyData : { url: '${path}', method: 'PUT'} 
			},
			contentType : 'application/json',
			initialRequest: false
		},
		rowHeaders : [ 'checkbox', 'rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 600,
		columns : [ {
			header : '제품코드',
			name : 'prdtId',
			hidden : false
		}, {
			header : '공정코드',
			name : 'prcsId',
		}, {
			header : '공정명',
			name : 'nm',
		}, {
			header : '설비코드',
			name : 'eqmId',
		}, {
			header : '설비명',
			name : 'eqmName',
		}]
	});
	
	// 행추가
	btnAdd.addEventListener("click", function() {
		linePrcsGrid.appendRow();
	});
	
	// 행삭제
	btnDel.addEventListener("click", function() {
		if(confirm("삭제하시겠습니까?")){ 
			linePrcsGrid.removeCheckedRows(false) //true -> 확인 받고 삭제 / false는 바로 삭제
			//linePrcsGrid.request('modifyData', { showConfirm : false });
			
			toastr.clear()
			toastr.success( ('삭제되었습니다.'),'Gelato',{timeOut:'1000'} );
		}
	});
</script>
</body>
</html>