<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 관리</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<div>
		<br>
		<h2>공정관리</h2>
		<br>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-10">
			<table>
				<tbody>
					<tr>
						<!-- <th>공정 분류</th>
						<td>
							<select name="infer">
							  <option value="non" selected>선택</option>
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
						</td> -->
						
					</tr>
					<tr>
						<th>공정명</th>
						<td>
							<input type="text" id="prcsDeta" readonly>
						</td>
						<td>
							<button type="button" class="btn btn-secondary" id="btnPrcs">조회</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-sm-2">
			<button type="button" class="btn btn-secondary" id="btnAdd">추가</button>
			<button type="button" class="btn btn-secondary" id="btnDel">삭제</button>
			<button type="button" class="btn btn-secondary" id="btnIns">저장</button>
		</div>
	</div>
	<br><hr><br>
	<div id="prcsList"></div> 
	
	<!-- 공정 모달-->
	<div id="prcsDialog" title="공정 목록"></div>
	<!-- 설비 모달-->
	<div id="eqmDialog" title="비사용 설비 목록"></div>
	
<script>
	//계획 조회 그리드 생성
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
	
	// 그리드 생성 : 관리
	const prcsList = new Grid({
		el : document.getElementById('prcsList'),
		data : {
			api : {
				readData : {url : '${path}',method : 'GET'}
			},
			contentType : 'application/json',
			initialRequest: false
		},
		rowHeaders : ['rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 600,
		columns : [ {
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
		}, {
			header : '모델명',
			name : 'modelNo',
		}, {
			header : '담당자명',
			name : 'mngr',
		}]
	});
</script>
</body>
</html>