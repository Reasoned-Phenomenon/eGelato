<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 설비 상태(온도/UPH/생산량)</title>
</head>
<body>
	<br>
	<h2>모니터링 관리</h2>
	<br>
	<div>
		<div>
			<button type="button" class="btn btn-large btn-dark"
				style="width: 70%; height: 100px; font-size: 40px; margin: auto; display:block;">온도</button>
		</div>
		<br>
		<div>
			<button type="button" class="btn btn-large btn-dark"
				style="width: 70%; height: 100px; font-size: 40px; margin: auto; display:block;">생산량</button>
		</div>
		<br>
		<div>
			<button type="button" class="btn btn-large btn-dark"
				style="width: 70%; height: 100px; font-size: 40px; margin: auto; display:block;">UPH</button>
		</div>
		<br>
		
	</div>
</body>
</html>