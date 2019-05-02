<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import= "user.User" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_main_style.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_style.css">


<meta name="viewport" content="width=device-width" , initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>러피월드: &nbsp;즐거운 봉사는 유기견을 춤추게한다.</title>
</head>
<body>
    <%
    User user =null;
    	String userID = null;
    	
    	
    if(session.getAttribute("user") != null){
    	user = (User)session.getAttribute("user");
    	userID = user.getUserID();
    	
    }
    %>
	<div class="container-all">
		<nav class="navbar navbar-default navbar-color">
            <!-- 기본 네비게이션 바 - 아이콘 형태 항상 상위에 고정-->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed color" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand logo" href="mobile_main.jsp"></a> <!--  브랜드 로고 -->
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                	<ul class = "nav navbar-nav">
						<li><a href="mobile_bulletinNotice.jsp" class="text-color">공지사항</a></li>
						<li><a href="mobile_bulletinIntroduction.jsp" class="text-color">가입인사</a></li>
						<li><a href="mobile_volunteerBulletin.jsp" class="text-color">봉사신청</a></li>
                <%
				if(userID == null){		
			%>
                <!-- 로그인이 안 되어있는 경우 -->

                     	<li><a href="mobile_login.jsp" class="text-color">로그인</a></li>
                <%
					}
				else if(userID.equals("admin"))
				{
				%>
                <!-- 로그인이 관리자 계정으로 된 경우 -->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span> </a>
                        <ul class="dropdown-menu">
                            <li class=""><a href="mobile_adminMember.jsp" class="text-color">회원관리</a></li> 
                            <li class=""><a href="mobile_logoutAction.jsp" class="text-color">로그아웃</a></li>
                        </ul>
                    </li>
                <%
				}
				else {
				%>
                <!-- 로그인이 되어 있는 경우  -->
                    <li><a href="mobile_userInfo.jsp" class="text-color">내 계정</a></li>
                <%
				}
				%>
				</ul>
            </div>
        </nav>
        <br>
	<div class="container-main">
			<a href="http://pf.kakao.com/_PVhIj" ><img src="/css/images/mobile/landing.png"height="auto" width="100%" alt=""></a>

<!-- 			<div class="volunteer-button">
				<a class="volunteer-button-a" href="mobile_volunteerBulletin.jsp"><img src="/css/images/mobile/volunteer_button.png"  height="50%" width="50%" alt=""></a>
			</div>
			<div class="notice-button">
				<a class="notice-button-a" href="mobile_bulletinNotice.jsp"><img src="/css/images/mobile/notice_button.png"  height="50%" width="50%" alt=""></a>
			</div>
			<div class="introduce-button">
				<a class="introduce-button-a" href="mobile_bulletinIntroduction.jsp"><img src="/css/images/mobile/introduction_button.png" height="50%" width="50%" alt=""></a>
			</div>		
			<div class="login-button">
				<a class="introduce-button-a" href="mobile_bulletin.jsp"><img src="/css/images/mobile/bulletin_button.png" height="50%" width="50%" alt=""></a>
			</div> -->
				<a class="notice-button-a" href="mobile_bulletinNotice.jsp"><img src="/css/images/mobile/notice_button.png"  height="50%" width="49%" alt=""></a>
				<a class="introduce-button-a" href="mobile_bulletinIntroduction.jsp"><img src="/css/images/mobile/introduction_button.png" height="50%" width="49%" alt=""></a>
				<a class="volunteer-button-a" href="mobile_volunteerBulletin.jsp"><img src="/css/images/mobile/volunteer_button.png"  height="50%" width="49%" alt=""></a>
				<a class="bulletin-button-a" href="mobile_bulletin.jsp"><img src="/css/images/mobile/bulletin_button.png" height="50%" width="49%" alt=""></a>

	</div>
	
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
	
</body>
</html>