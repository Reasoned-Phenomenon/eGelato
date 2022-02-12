<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미생산 지시 조회</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
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
					<button type="button" id="selectDate" class="btn btn-find-small" data-bs-toggle="modal" aria-label="Close">검색</button>
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
	//생산계획일자 현재날짜 기본 설정
	var d = new Date();

	var year = d.getFullYear(); // 년
	var month = d.getMonth();   // 월
	var day = d.getDate();      // 일
	
	document.getElementById('startD').value = new Date(year, month, day - 7).toISOString().substring(0,10);
	document.getElementById('endD').value = new Date().toISOString().substring(0, 10);
		
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
	var IndicaGrid = new Grid({
		el: document.getElementById('IndicaGrid'),
	  	data : {
		  api: {
		    readData: { url:'${path}/prd/indicaDialogDeta.do', method: 'GET'}
		  },
		  contentType: 'application/json',
		},
	  	rowHeaders:['rowNum'],
	  	selectionUnit: 'row',
	  	bodyHeight:350,
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
	});
	
	//검색 클릭시
	$("#selectDate").on(
		"click", function chooseDate() {
			startD = document.getElementById("startD").value;
			console.log(startD);
			endD = document.getElementById("endD").value;
			console.log(endD);
			
			IndicaGrid.readData(1,{'startD':startD,'endD':endD }, true);
		});
	
	IndicaGrid.on("dblclick", (ev) => {
		
		IndicaGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, IndicaGrid.getColumns().length-1]
		});
		
		var idi = IndicaGrid.getRow(ev.rowKey).indicaDetaId;
		console.log(idi);
		chooseId(idi);
		
	});
</script>
</html>