<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<!DOCTYPE html>
<html lang="en">
<head>
   <!-- basic -->
   <meta charset="utf-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <!-- mobile metas -->
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <meta name="viewport" content="initial-scale=1, maximum-scale=1">
   <!-- site metas -->
   <title>Gelato</title>
   <meta name="keywords" content="">
   <meta name="description" content="">
   <meta name="author" content="">
   
   <!-- 제이쿼리 -->
   <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
   
   <!-- 제이쿼리 UI -->
   <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
   <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
   
   <!-- 데이트 픽커 -->
   <link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
   <script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
   
   <!-- grid -->
   <link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
   <script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
	
   <!-- 아이콘 -->
   <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
   <!-- site icon -->
   <link rel="icon" href="${path}/resources/images/fevicon.png" type="image/png" />
   <!-- bootstrap css -->
   <link rel="stylesheet" href="${path}/resources/css/bootstrap.min.css" />
   <!-- site css -->
   <link rel="stylesheet" href="${path}/resources/css/style.css" />
   <!-- responsive css -->
   <link rel="stylesheet" href="${path}/resources/css/responsive.css" />
   <!-- color css -->
   <%-- <link rel="stylesheet" href="${path}/resources/css/colors.css" /> --%>
   <!-- select bootstrap -->
   <link rel="stylesheet" href="${path}/resources/css/bootstrap-select.css" />
   <!-- scrollbar css -->
   <link rel="stylesheet" href="${path}/resources/css/perfect-scrollbar.css" />
   <!-- custom css -->
   <link rel="stylesheet" href="${path}/resources/css/custom.css" />
   <!--[if lt IE 9]>
   <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
   <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
   <![endif]-->
   
	<!-- 모달 -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
   
	<!-- toastr css라이브러리 -->
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
	<!-- toastr cdn 라이브러리 둘다 제이쿼리 밑에 있어야함 -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

	<!-- ToastR -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<!-- gelato.js -->
	<script src="${path }/resources/js/gelatoCom.js"></script>

</head>
   <body class="dashboard dashboard_1">
      <div class="full_container">
         <div class="inner_container">
         
            <tiles:insertAttribute name="navBar"/>
            
            <!-- right content -->
            <div id="content">
            
               <!-- 헤더 시작 -->
               <tiles:insertAttribute name="header"/>
               <!-- 헤더 끝 -->
               
               <!-- 컨텐츠 시작 -->
               <tiles:insertAttribute name="content"/>
               <!-- 컨텐츠 끝 -->
               </div>
         </div>
      </div>
      <!-- jQuery -->
      
      <script src="${path}/resources/js/popper.min.js"></script>
      <script src="${path}/resources/js/bootstrap.min.js"></script>
      <!-- wow animation -->
      <script src="${path}/resources/js/animate.js"></script>
      <!-- select country -->
      <script src="${path}/resources/js/bootstrap-select.js"></script>
      <!-- owl carousel -->
      <script src="${path}/resources/js/owl.carousel.js"></script> 
      <!-- chart js -->
      <script src="${path}/resources/js/Chart.min.js"></script>
      <script src="${path}/resources/js/Chart.bundle.min.js"></script>
      <script src="${path}/resources/js/utils.js"></script>
      <script src="${path}/resources/js/analyser.js"></script>
       <!-- nice scrollbar -->
      <script src="${path}/resources/js/perfect-scrollbar.min.js"></script>
      <script>
         var ps = new PerfectScrollbar('#sidebar');
      </script> 
      <!-- custom js -->
      <script src="${path}/resources/js/custom.js"></script>
      <%-- <script src="${path}/resources/js/chart_custom_style1.js"></script> --%>
      
   </body>
</html>
