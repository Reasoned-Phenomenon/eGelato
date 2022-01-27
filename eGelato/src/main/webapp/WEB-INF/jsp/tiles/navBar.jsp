<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!-- Sidebar  -->
         <nav id="sidebar">
            <div class="sidebar_blog_1">
               <div class="sidebar-header">
                  <div class="logo_section">
                     <a href="index.html"><img class="logo_icon img-responsive" src="${path}/resources/images/fevicon.png" alt="#" /></a>
                  </div>
               </div>
               <div class="sidebar_user_info">
                  <div class="icon_setting"></div>
                  <div class="user_profle_side">
                     <div class="user_img"><img class="img-responsive" src="${path}/resources/images/layout_img/user_img.jpg" alt="#" /></div>
                     <div class="user_info">
                        <h6>John David</h6>
                        <p><span class="online_animation"></span> Online</p>
                     </div>
                  </div>
               </div>
            </div>
            <div class="sidebar_blog_2">
               <h4>Gelato</h4>
               <!-- 메뉴 시작 -->
               <ul class="list-unstyled components">
               
               	<!-- 정보 메뉴 -->
                  <li class="active">
                     <a href="#common" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-object-group blue2_color"></i> <span>정보 관리</span></a>
                     <ul class="collapse list-unstyled" id="common">
                        <li>
                           <a href="${path }/com/comCode.do">> <span>공통 코드 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path}/com/rwmatrCode.do">> <span>자재 코드 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path}/com/prdtCode.do">> <span>완제품 코드 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path}/com/comBom.do">> <span>BOM 코드 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path}/com/vendCode.do">> <span>거래처 코드 관리</span></a>
                        </li>
                      
                     </ul>
                  </li>
                  
                  <!-- 영업 관리 메뉴 -->
                  <li class="active">
                     <a href="#sales" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-briefcase blue1_color"></i> <span>영업 관리</span></a>
                     <ul class="collapse list-unstyled" id="sales">
                        <li>
                           <a href="${path}/biz/ordSearch.do">> <span>주문서 관리</span></a>
                        </li>
                                               
                        <li>
                           <a href="#">> <span>출고 관리</span></a>
                        </li>
                        
                     </ul>
                  </li>
                  
                  <!-- 자재관리 메뉴 -->
                  <li class="active">
                     <a href="#MATERIAL" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-diamond purple_color"></i> <span>원자재 관리</span></a>
                     <ul class="collapse list-unstyled" id="MATERIAL">
                        <li>
                           <a href="${path }/rwmatr/rwmatrOrder.do">> <span>원자재 발주관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/rwmatr/rwmatrIstInsp.do">> <span>원자재 입고검사관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/rwmatr/rwmatrIst.do">> <span>원자재 입고관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/rwmatr/rwmatrOust.do">> <span>원자재 출고관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/rwmatr/rwmatrLot.do">> <span>원자재LOT 재고조회</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/rwmatr/rwmatrStc.do">> <span>원자재 재고조회</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/rwmatr/rwmatrInfer.do">> <span>원자재 불량조회</span></a>
                        </li>
                        
                     </ul>
                  </li>
                  
                <!-- 생산관리 메뉴 -->
                  <li class="active">
                     <a href="#production" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-cog yellow_color"></i> <span>생산 관리</span></a>
                     <ul class="collapse list-unstyled" id="production">
                        <li>
                           <a href="${path }/prd/prdPlanMng.do">> <span>생산 계획 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/prd/prdPlanMngFind.do">> <span>생산 계획 조회</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/prd/prdIndicaMng.do">> <span>생산 지시 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/prd/prdIndicaMngFind.do">> <span>생산 지시 조회</span></a>
                        </li>
                        <li>
                           <a href="${path }/prd/prdPrcsMng.do">> <span>생산 관리</span></a>
                        </li>
                        <li>
                           <a href="${path }/prd/prdPrcsNow.do">> <span>공정 실적</span></a>
                        </li>
                        <li>
                           <a href="#">> <span>공정 관리</span></a>
                        </li>
                        <li>
                           <a href="#">> <span>제품 공정 흐름도</span></a>
                        </li>
                        <li>
                           <a href="#">> <span>완제품 품질 관리</span></a>
                        </li>
                     </ul>
                  </li>
                  
                  <!-- 설비관리 메뉴 -->
                  <li class="active">
                     <a href="#EQUIPMENT" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-wrench yellow_color"></i> <span>설비 관리</span></a>
                     <ul class="collapse list-unstyled" id="EQUIPMENT">
                        <li>
                           <a href="${path }/eqm/eqmRegister.do">> <span>설비 등록</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/eqm/eqmManagement.do">> <span>설비 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/eqm/eqmInspection.do">> <span>설비 점검 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/eqm/eqmNonMoving.do">> <span>설비 비가동 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/eqm/eqmState.do">> <span>실시간 설비 상태</span></a>
                        </li>
                        
                     </ul>
                  </li>
                  
                  <!-- 관리자 메뉴 -->
                  <li class="active">
                     <a href="#ADMIN" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-lock green_color"></i> <span>관리자</span></a>
                     <ul class="collapse list-unstyled" id="ADMIN">
                     
                     	<li>
                           <a href="${path }/mng/egovMberManage.do">> <span>사용자 계정 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/mng/egovRoleList.do">> <span>사용자 롤 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/mng/egovRoleHierarchyInsert.do">> <span>롤 상하관계 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/mng/egovAuthorList.do">> <span>사용자 권한 관리</span></a>
                        </li>
                        
                        <li>
                           <a href="${path }/mng/egovAuthorGroupList.do">> <span> 권한 부여 관리</span></a>
                        </li>
                        
                     </ul>
                  </li>
                  
                  <!-- 
                  <li class="active">
                     <a href="#dashboard" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-dashboard yellow_color"></i> <span>Dashboard</span></a>
                     <ul class="collapse list-unstyled" id="dashboard">
                        <li>
                           <a href="#">> <span>Default Dashboard</span></a>
                        </li>
                        <li>
                           <a href="#">> <span>Dashboard style 2</span></a>
                        </li>
                     </ul>
                  </li>
                  <li><a href="widgets.html"><i class="fa fa-clock-o orange_color"></i> <span>Widgets</span></a></li>
                  <li>
                     <a href="#element" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-diamond purple_color"></i> <span>Elements</span></a>
                     <ul class="collapse list-unstyled" id="element">
                        <li><a href="#">> <span>General Elements</span></a></li>
                        <li><a href="#">> <span>Media Gallery</span></a></li>
                        <li><a href="#">> <span>Icons</span></a></li>
                        <li><a href="#">> <span>Invoice</span></a></li>
                     </ul>
                  </li>
                  <li><a href="tables.html"><i class="fa fa-table purple_color2"></i> <span>Tables</span></a></li>
                  <li>
                     <a href="#apps" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-object-group blue2_color"></i> <span>Apps</span></a>
                     <ul class="collapse list-unstyled" id="apps">
                        <li><a href="#">> <span>Email</span></a></li>
                        <li><a href="#">> <span>Calendar</span></a></li>
                        <li><a href="#">> <span>Media Gallery</span></a></li>
                     </ul>
                  </li>
                  <li><a href="price.html"><i class="fa fa-briefcase blue1_color"></i> <span>Pricing Tables</span></a></li>
                  <li>
                     <a href="contact.html">
                     <i class="fa fa-paper-plane red_color"></i> <span>Contact</span></a>
                  </li>
                  <li class="active">
                     <a href="#additional_page" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle"><i class="fa fa-clone yellow_color"></i> <span>Additional Pages</span></a>
                     <ul class="collapse list-unstyled" id="additional_page">
                        <li>
                           <a href="#">> <span>Profile</span></a>
                        </li>
                        <li>
                           <a href="#">> <span>Projects</span></a>
                        </li>
                        <li>
                           <a href="#">> <span>Login</span></a>
                        </li>
                        <li>
                           <a href="#">> <span>404 Error</span></a>
                        </li>
                     </ul>
                  </li>
                  <li><a href="#"><i class="fa fa-map purple_color2"></i> <span>Map</span></a></li>
                  <li><a href="#"><i class="fa fa-bar-chart-o green_color"></i> <span>Charts</span></a></li>
                  <li><a href="#"><i class="fa fa-cog yellow_color"></i> <span>Settings</span></a></li>
                   -->
               </ul>
            </div>
         </nav>
         <!-- end sidebar -->