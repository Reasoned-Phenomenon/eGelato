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
	<div>
		<table>
			<tbody>
				<tr>
					<th>공정 분류</th>
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
					</td>
					<td>
						<button type="button" class="btn btn-secondary" id="btnPrcs">조회</button>
					</td>
				</tr>
			</tbody>
		</table>
		<br>
		<hr>
		<br>
		<div id="prcsList"></div> 
	</div>
	
	<!-- 설비 모달-->
	<div id="eqmDialog" title="비사용 설비 목록"></div>
	
<script>

</script>
</body>
</html>