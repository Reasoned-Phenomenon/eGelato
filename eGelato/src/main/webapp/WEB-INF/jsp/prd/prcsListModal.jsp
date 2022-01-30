<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 목록</title>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script> -->
</head>
<body>
	<br>
	<h1>공정 목록</h1>
	<br>
	<div>
	<table>
	<tbody>
	<tr>
		<th>공정분류</th>
		<td>
			<select name="prcsSelDeta" id="prcsSelDeta">
				<option value="" selected>선택</option>
				<option value="FREZ">냉동공정</option>
				<option value="SHAP">성형공정</option>
				<option value="BLEN">혼합공정</option>
				<option value="CRSH">분쇄공정</option>
				<option value="COAT">코팅공정</option>
				<option value="UNIT">개별포장공정</option>
				<option value="BOXI">박스포장공정</option>
				<option value="FORE">품질검사공정</option>
				<option value="WIGH">무게검사공정</option>
			</select>
		</td>	
		<td>
			<button type="button" id="btnSel" class="btn btn-secondary">검색</button>
		</td>	
	</tr>
	</tbody>
	</table>
	</div>
	<div id="prcsGrid"></div>
	
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
		    },
			selectedHeader : {
		    	background : '#FFFFFF'
		    }
		  }
		});
		
	// 그리드 생성
	var prcsGrid = new Grid({
		el: document.getElementById('prcsGrid'),
	  	data : {
		  api: {
		    readData: { url:'${path}/prd/prcsDialogDeta.do', method: 'GET'}
		  },
		  contentType: 'application/json',
		},
	  	rowHeaders:['rowNum'],
	  	selectionUnit: 'row',
	  	columns:[
	  		  {
			    header: '공정코드',
			    name: 'prcsId'
			  },
			  {
			    header: '공정명',
			    name: 'nm',
			  },
			  {
			    header: '설비코드',
			    name: 'eqmId',
			  },
			  {
			    header: '설비명',
			    name: 'eqmName',
			  }
			],
	});
	
	$("#btnSel").on(
			"click", function selectPrcs() {
				let prcsSelDeta = $('#prcsSelDeta option:selected').val();
				console.log(prcsSelDeta);
				
				prcsGrid.readData(1,{'prcsSelDeta':prcsSelDeta}, true);
			});
	
	prcsGrid.on("dblclick", (ev) => {
		
		prcsGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, prcsGrid.getColumns().length-1]
		});
		
		var pcn = prcsGrid.getRow(ev.rowKey).nm;
		console.log(pcn);
		chooseNm(pcn);
		
	});
</script>
</body>
</html>