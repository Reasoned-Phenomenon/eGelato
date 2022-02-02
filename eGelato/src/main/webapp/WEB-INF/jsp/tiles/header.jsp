<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- topbar -->
 <div class="topbar">
    <nav class="navbar navbar-expand-lg navbar-light">
       <div class="full">
          <button type="button" id="sidebarCollapse" class="sidebar_toggle"><i class="fa fa-bars"></i></button>
          <div class="logo_section">
             <a href="${path}"><img class="img-responsive" src="${path}/resources/images/logo/imsiLogo.png" alt="#" /></a>
          </div>
          <div class="right_topbar">
             <div class="icon_info">
                <ul class="user_profile_dd">
                   <li>
                      <a class="dropdown-toggle" data-toggle="dropdown"><img class="img-responsive rounded-circle" src="${path}/resources/images/layout_img/user_img.jpg" alt="#" /><span class="name_user">John David</span></a>
                      <div class="dropdown-menu">
                         <a class="dropdown-item" href="${path }/uat/uia/actionLogout.do"><span>Log Out</span> <i class="fa fa-sign-out"></i></a>
                      </div>
                   </li>
                </ul>
             </div>
          </div>
       </div>
    </nav>
 </div>
 <!-- end topbar -->
 
 