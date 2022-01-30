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
		<table>
		<tbody>
			<tr>
				<th>지시 기간</th>
				<td><input type="date" id="startD"> ~ <input type="date" id="endD"></td>
				<td>
					<button type="button" id="selectDate" class="btn btn-secondary">검색</button>
				</td>	
			</tr>
		</tbody>
		</table>
		</div>
	<br>
	<div id="IndicaGrid"></div>
</body>

<script>
//생산계획일자 현재날짜 기본 설정
	/* document.getElementById('indicaD').value = new Date().toISOString()
			.substring(0, 10); */
		
//그리드 생성
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
	var chooseIndicaGrid = new Grid({
		el: document.getElementById('chooseIndicaGrid'),
	  	data : {
		  api: {
		    readData: { url:'${path}/prd/indicaDialogDeta.do', method: 'GET'}
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
			  },
			  {
			    header: '지시일자',
			    name: 'indicaDt',
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
		
	});
</script>
</html>