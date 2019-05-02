<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.User" %>
    <%@ page import = "user.UserDAO" %>
    <%@ page import = "java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_style.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_userInfo_style.css">


<meta name="viewport" content="width=device-width" , initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>러피월드: &nbsp;개인정보 관리</title>

</head>
<body>
<%
User user1 = null;
String userID = null;


if(session.getAttribute("user") != null){
user1 = (User)session.getAttribute("user");
userID = user1.getUserID();

}
	
	String userMemberShip = null;
	User user = new UserDAO().getUser(userID);
	if(user.getUserMemberShip()==0){
		userMemberShip ="준회원";
	}
	else if(user.getUserMemberShip()==1){
		userMemberShip ="정회원";
	}
	else if(user.getUserMemberShip()==2){
		userMemberShip ="운영진";
	}
	else if(user.getUserMemberShip()==3){
		userMemberShip ="모임장";
	}
	else if(user.getUserMemberShip()==4){
		userMemberShip ="신입회원";
	}
	else if(user.getUserMemberShip()==5){
		userMemberShip ="가입대기";
	}
	
	String firstRoute = null;
	if(user.getFirstRoute()==1){
		firstRoute ="소모임";
	}
	else if(user.getFirstRoute()==2){
		firstRoute ="인스타그램";
	}
	else if(user.getFirstRoute()==3){
		firstRoute ="검색";
	}
	else if(user.getFirstRoute()==4){
		firstRoute ="봉사현장";
	}
	else if(user.getFirstRoute()==5){
		firstRoute ="소개";
	}
	else if(user.getFirstRoute()==6){
		firstRoute ="기타";
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
	<div class = "container-main"> 

		<div class="userInfo-title"><p class="title">계정 정보</p></div>
		<div class="userInfo"><p class="info-title">아이디</p><p class="info"><%=user.getUserID()%></p></div>
		<div class="userInfo"><p class="info-title">이름</p><p class="info"><%=user.getUserName()%></p></div>
		<div class="userInfo"><p class="info-title">이메일</p><p class="info"><%=user.getUserEmail()%></p></div>
		<div class="userInfo"><p class="info-title">주소</p><p class="info"><%=user.getUserAddress()%></p></div>
		<div class="userInfo"><p class="info-title">직업</p><p class="info"><%=user.getUserJob()%></p></div>
		<div class="userInfo"><p class="info-title">나이</p><p class="info"><%=user.getUserAge()%></p></div>
		<div class="userInfo"><p class="info-title">생일</p><p class="info"><%=user.getUserBirthday()%></p></div>
		<div class="userInfo"><p class="info-title">회원상태</p><p class="info"><%=userMemberShip%></p></div>
		<div class="userInfo"><p class="info-title">핸드폰 번호</p><p class="info"><%=user.getUserPhoneNumber()%></p></div>
		<div class="userInfo"><p class="info-title">봉사 참여 횟수</p><p class="info"><%=user.getUserAttend()%> 회</p></div>
		<div class="userInfo"><p class="info-title">유입 경로</p><p class="info"><%=firstRoute%></p></div>
		
		<a class="btn btn-primary pull-right userInfo_btn" href="mobile_userInfoUpdate.jsp">개인정보 수정</a>
		<a class="btn btn-primary pull-right userInfo_btn" href="mobile_logoutAction.jsp">로그아웃</a>
	</div>
	

	
</div>

	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="/js/bootstrap.js"></script>

</body>
</html>