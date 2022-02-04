<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미생산 지시 조회</title>
</head>
<body>
	<br>
	<h1>생산 지시 목록</h1>
	<br>
	<div>
	<input type="date" id="indicaD">
	<button type="button" id="selectDate" class="btn btn-find-small" data-bs-toggle="modal" aria-label="Close">검색</button>
	</div>
	<br>
	<div id="chooseIndicaGrid"></div>
</body>

<script>
//생산계획일자 현재날짜 기본 설정
	/* document.getElementById('indicaD').value = new Date().toISOString()
			.substring(0, 10); */
		
//그리드 생성
var Grid = tui.Grid;

	//그리드 테마
	/* Grid.applyTheme('striped', {
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
		}); */
		
	// 그리드 생성
	var chooseIndicaGrid = new Grid({
		el: document.getElementById('chooseIndicaGrid'),
	  	data : {
		  api: {
		    readData: { url:'${path}/prd/chooseIndica.do', method: 'GET'}
		  },
		  contentType: 'application/json',
		},
	  	rowHeaders:['rowNum'],
	  	selectionUnit: 'row',
	  	columns:[
	  		  {
			    header: '생산지시코드',
			    name: 'indicaDetaId'
			  },
			  {
			    header: '제품명',
			    name: 'prdtNm',
			  },
			  {
			    header: '생산량',
			    name: 'qy',
			  }
			],
			 rowHeaders: ['rowNum'],
		/* pageOptions: {
		  useClient: true,
		  perPage: 10
		} */
	});
	
	//검색 클릭시
	$("#selectDate").on(
		"click", function chooseDate() {
			indicaD = document.getElementById("indicaD").value;
			console.log(indicaD);
			
			chooseIndicaGrid.readData(1,{'indicaD':indicaD}, true);
		});

	//그리드 이벤트
	chooseIndicaGrid.on(
		"dblclick", (ev) => {
		
		chooseIndicaGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, chooseIndicaGrid.getColumns().length-1]
		});	
		
		var cid = chooseIndicaGrid.getRow(ev.rowKey).indicaDetaId;
		console.log(cid);
		var cpn = chooseIndicaGrid.getRow(ev.rowKey).prdtNm;
		console.log(cpn);
		choosePi(cid,cpn);
	});
</script>
</html>