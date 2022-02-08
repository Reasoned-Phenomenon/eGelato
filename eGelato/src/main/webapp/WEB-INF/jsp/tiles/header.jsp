<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!-- topbar -->
<div class="topbar">
	<nav class="navbar navbar-expand-lg navbar-light">
		<div class="full">
			<button type="button" id="sidebarCollapse" class="sidebar_toggle">
				<i class="fa fa-bars"></i>
			</button>
			<div class="logo_section">
				<a href="${path}"><img class="img-responsive"
					src="${path}/resources/images/logo/imsiLogo.png" alt="#" /></a>
			</div>
			<div class="right_topbar">
				<div class="icon_info">
				<c:if test="${empty loginVO }">
					<a class="dropdown-item" href="${path }/uat/uia/egovLoginUsr.do">
					<span>LogIn</span> <i class="fa fa-sign-in"></i></a>
				</c:if>
				<c:if test="${not empty loginVO }">
					<a class="dropdown-item" href="${path }/uat/uia/actionLogout.do">
					<span>LogOut</span> <i class="fa fa-sign-out"></i></a>
				</c:if>
					
				</div>
			</div>
		</div>
	</nav>
</div>
<!-- end topbar -->

