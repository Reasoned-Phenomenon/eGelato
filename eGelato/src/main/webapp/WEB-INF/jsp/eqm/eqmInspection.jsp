<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비 점검 페이지(점검등록/점검내역조회)</title>
</head>
<body>
	<h2>설비 정기점검 관리</h2>
	<div class="container">
		<br> <br>
		<div class="row">
			<div class="col-12">
				<button type="reset" class="btn btn-reset float-right" id="resetBtn">초기화</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-search float-right"
					id="searchBtn">조회</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-exel float-right" id="saveBtn">저장</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-print float-right"
					id="removeBtn">삭제</button>
			</div>
		</div>
		<form id="dataForm" name="dataForm" method="post">
			<div class="grid-option-area row">
				<div class="col-6">
					<div>
						<label>점검일자</label><input type="date" id="chckDate">
					</div>
					<div>
						<label>특이사항</label> <input type="text" id="remk">
					</div>
					<div>
						<label>설비구분</label> <select id="gubun" onchange="selectGubun()">
							<option value="전체">전체
							<option value="배합기">배합기
							<option value="운송기">운송기
							<option value="측정기">측정기
							<option value="가공기">가공기
						</select>
					</div>
				</div>
				<div class="col-6 border" style="width:500px;">
					<div>
						<ul>
							<li>
								<h5>설비 점검대상기간</h5>
							</li>
							<li>
								<div>
									<label>점검일자</label> <input id="fromCkDate" name="fromCkDate"
										type="date"><label>~</label><input id="toCkDate"
										name="toCkDate" type="date">
									<button class="btn btn-print float-right">설비조회</button>
								</div>
							<li>
						</ul>
					</div>
				</div>
			</div>
		</form>
		<div>
			<div id="eqmInsGrid"></div>
		</div>
	</div>
	<script>
		var Grid = tui.Grid;

		const eqmInsGrid = new Grid({
			el : document.getElementById('eqmInsGrid'),
			data : {
				api : {
					readData : {
						url : '${path}/eqm/eqmInspectionList.do',
						method : 'GET'
					}
				},
				contentType : 'application/json'
			},
			rowHeaders : [ 'rowNum' ],
			selectionUnit : 'row',
			bodyHeight : 500,
			columns : [ {
				header : '설비코드',
				name : 'eqmId'
			}, {
				header : '설비명',
				name : 'eqmName'
			}, {
				header : '점검주기',
				name : 'chckPerd'
			}, {
				header : '점검일자',
				name : 'chckDt'
			}, {
				header : '차기점검일',
				name : 'nCkDt'
			}, {
				header : '판정',
				name : 'judt'
			}, {
				header : '점검내역',
				name : 'chckDeta'
			}, {
				header : '구분',
				name : 'chckDeta'
			} ]
		});

		//드롭다운 선택시 바로 조회
		function selectGubun() {
			let gubun = $('#gubun option:selected').val();
			eqmListGrid.readData(1, {
				'gubun' : gubun
			}, true);
		}
	</script>
</body>
</html>