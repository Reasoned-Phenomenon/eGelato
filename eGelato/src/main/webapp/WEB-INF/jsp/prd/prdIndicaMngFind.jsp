<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
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
	<div>
		<br>
		<h2>생산지시조회</h2>
		<br>
	</div>
	<br>
	<div>
		<table>
			<tbody>
				<tr>
					<th>지시 일자</th>
					<td><input type="date" id="indicaD" required></td>
					<td><button type="button" class="btn btn-secondary" id="btnSer">검색</button></td>
					<td><button type="button" class="btn btn-secondary" id="btnRes">초기화</button></td>
				</tr>
			</tbody>
		</table>
	</div>
	<hr>
	<!-- 지시 그리드 -->
	<div id="IndicaGrid"></div>
</body>

<script>
	//생산계획일자 현재날짜 기본 설정
	document.getElementById('indicaD').value = new Date().toISOString()
			.substring(0, 10);
	
	//초기화버튼
	$("#btnRes").on(
			"click",
			function() {
				$("#indicaD").val('');
				document.getElementById('indicaD').value = new Date().toISOString().substring(0, 10);
				IndicaGrid.clear();
			});
	
	//지시그리드
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

	//지시조회 그리드
	const IndicaGrid = new Grid({
		el : document.getElementById('IndicaGrid'),
		data : {
			api : {
				readData : {url : '${path}/prd/indicaList.do',method : 'GET'},
			},
			contentType : 'application/json',
			initialRequest: false
		},
		rowHeaders : ['rowNum' ],
		selectionUnit : 'row',
		columns : [ {
			header : '생산지시코드',
			name : 'indicaDetaId'
		},{
			header : '제품코드',
			name : 'prdtId',
		}, {
			header : '제품명',
			name : 'prdtNm',
		},{
			header : '생산수량',
			name : 'qy',
		}, {
			header : '라인코드',
			name : 'lineId',
		}, {
			header : '지시우선순위',
			name : 'ord',
		},{
			header : '비고',
			name : 'remk',
		}]
	});
	
	//검색 클릭시
	$("#btnSer").on(
			"click", function(){
				indicaD = document.getElementById("indicaD").value;
				console.log(indicaD);
				
				IndicaGrid.readData(1,{'indicaD':indicaD}, true);
			})
</script>
</html>