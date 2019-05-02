<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<meta name = "viewport" content = "width=1000px", initial-scale = "1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link href="css/style.css" rel="stylesheet">
<link href="css/login_style.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">

<title>러피월드: &nbsp;로그인</title>

</head>
<body>
<div class="container-all">
	<nav class = "navbar navbar-default">	<!-- 기본 네비게이션 바 - 아이콘 형태 항상 상위에 고정-->
		<div class ="navbar-header">
			<button type="button" class = "navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded = "false">
				
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
				
				</button>
				<a class = "navbar-brand" href = "main.jsp"></a>  <!--  브랜드 로고 -->
		</div>
		<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
		<!--	<ul class = "nav navbar-nav">
			
			
			</ul>
			-->
			<ul class = "nav navbar-nav navbar-right">
			
			
				<li class="notice-button"><a href="bulletinNotice.jsp"></a></li>
                <li class="introduction-button"><a href="bulletinIntroduction.jsp"></a></li>
                <li class="volunteer-button"><a href="volunteerBulletin.jsp"></a></li>
				<li class="login-button"><a href = "login.jsp"></a></li>
			</ul>
			
		</div>
	</nav>
	
	<div class = "container-login">  <!--  로그인 아이디 패스워드 입력 창 -->
		<div class = "col-lg-4"></div>
		<div class = "col-lg-4"></div>
		<div class = "jumbotron" style= "padding-top: 20px">
			<form method = "post" action="loginAction.jsp">
				<h3 style = "text-align: center;">로그인</h3>
					<div class="form-group userID">
						<input type = "text" class = "form-control" placeholder = "아이디" name = "userID" maxlength = "20">
					</div>
						
						
					<div class="form-group userPassword">
						<input type = "password" class = "form-control" placeholder = "비밀번호" name = "userPassword" maxlength = "20">
						
					</div>
					
						<input type = "submit" class ="btn btn-primary form-control" value = "로그인">
						<a class="btn btn-primary" href="join.jsp">회원가입</a>
				
			</form>
		</div>
		
		
	</div>
</div>	

	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>