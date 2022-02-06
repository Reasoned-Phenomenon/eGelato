<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- 제이쿼리 UI -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<!-- 바코드 -->
<script src="${path}/resources/js/jquery-barcode.js" type="text/javascript"></script>

<body>
	<br><br>
	<h2 style = 'text-align: center;'>공정이동표</h2>
	<br>
	
	<div id="bcTarget"></div> 
	<div>
		<table>
		<tbody>
			<tr>
				<th>라인코드</th>
				<td><input type="text"></td>
			</tr>
			<tr>
				<th>제품코드</th>
				<td><input type="text"></td>
			</tr>
			<tr>
				<th>제품명</th>
				<td><input type="text"></td>
			</tr>
			<tr>
				<th>수량</th>
				<td><input type="text"></td>
			</tr>
		</tbody>
		</table>
	</div>
	
	<input type="button" value="인쇄하기" id="print" onclick="window.print()"/>
</body>

<script>
	let mid = '${param.mid}';
	console.log(mid);
	
	$("#bcTarget").barcode(mid, "code128",{barWidth:4, barHeight:75});  
	
	$.ajax({
		url : "${path}/prd/prdtMoveInfo.do?indicaDetaId="+mid,
		dataType : 'json',
		error : function(result) {
			console.log('에러', result)
		}
	}).done(function(result) {
		console.log('확인');
		console.log(result);
		console.log(result.data.contents[0].lineId);
		console.log(result.data.contents[0].prdtId);
		console.log(result.data.contents[0].prdtNm);
		console.log(result.data.contents[0].qy);
	})
</script>

</html>