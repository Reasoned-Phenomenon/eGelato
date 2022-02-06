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
</body>

<script>
	let mid = '${param.mid}';
	console.log(mid);
	
	$("#bcTarget").barcode(mid, "code128",{barWidth:2, barHeight:70});  
</script>

</html>