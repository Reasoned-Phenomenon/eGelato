<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 지시 조회</title>
<style>
th, td {
	padding: 5px;
}
</style>
</head>
<body>
	<h2>생산지시조회</h2>
	<div>
		<table>
			<tbody>
				<tr>
					<th>진행 구분</th>
					<td><input type="radio" id="fgAll" name="fg" value="ALL"
						checked>전체 <input type="radio" id="fgPro" name="fg"
						value="PROCEE">진행 <input type="radio" id="fgFin" name="fg"
						value="FINISH">완료</td>
				</tr>
				<tr>
					<th>지시 일자</th>
					<td><input type="date" id="startD" required> ~ <input
						type="date" id="endD" required></td>
					<td><button type="button" id="btnSer">검색</button></td>
					<td><button type="button" id="btnRes">초기화</button></td>
				</tr>
			</tbody>
		</table>
	</div>
	<hr>
	<br>
	<!-- 지시 그리드 -->
	<div id="IndicaGrid"></div>
</body>

<script>
	//생산계획일자 현재날짜 기본 설정
	const d = new Date();

	const year = d.getFullYear(); // 년
	const month = d.getMonth(); // 월
	const day = d.getDate(); // 일

	document.getElementById('startD').value = new Date(year, month, day - 7)
			.toISOString().substring(0, 10);
	document.getElementById('endD').value = new Date().toISOString().substring(
			0, 10);

	//초기화버튼
	$("#btnRes").on(
			"click",
			function() {
				$("#indicaD").val('');
				document.getElementById('startD').value = new Date(year, month,
						day - 7).toISOString().substring(0, 10);
				document.getElementById('endD').value = new Date()
						.toISOString().substring(0, 10);
				IndicaGrid.clear();
			});

	//지시그리드
	var Grid = tui.Grid;

	//그리드 테마
	/* Grid.applyTheme('striped', {
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
	}); */

	//지시조회 그리드
	const IndicaGrid = new Grid({
		el : document.getElementById('IndicaGrid'),
		data : {
			api : {
				readData : {
					url : '${path}/prd/indicaList.do',
					method : 'GET'
				},
			},
			contentType : 'application/json',
			initialRequest : false
		},
		rowHeaders : [ 'rowNum' ],
		selectionUnit : 'row',
		bodyHeight : 600,
		columns : [ {
			header : '생산지시코드',
			name : 'indicaDetaId'
		}, {
			header : '제품코드',
			name : 'prdtId',
		}, {
			header : '제품명',
			name : 'prdtNm',
		}, {
			header : '생산수량',
			name : 'qy',
			align : 'right',
		}, {
			header : '라인코드',
			name : 'lineId',
			align : 'right',
		}, {
			header : '지시우선순위',
			name : 'ord',
			align : 'right',
		}, {
			header : '진행구분',
			name : 'fg',
		}, {
			header : '비고',
			name : 'remk',
		} ]
	});

	//검색 클릭시
	$("#btnSer").on("click", function() {
		startD = document.getElementById("startD").value;
		console.log(startD);
		endD = document.getElementById("endD").value;
		console.log(endD);

		fg = $("input[name=fg]:checked").val();

		IndicaGrid.readData(1, {
			'fg' : fg,
			'startD' : startD,
			'endD' : endD
		}, true);
	})
</script>
</html>