<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import= "user.User" %>
    
    
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_style.css">


<meta name="viewport" content="width=device-width" , initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">

<title>러피월드: &nbsp;글 작성</title>

</head>
<body>
	<%
	User user1 = null;
		String userID = null;
		
		
	if(session.getAttribute("user") != null){
		user1 = (User)session.getAttribute("user");
		userID = user1.getUserID();
		
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'mobile_login.jsp'");
		script.println("</script>");
	
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
	<!-- 내용 부분  -->
	<!-- 비로그인 상태에서 게시판을 볼 경우 -->
		<%
				if(userID == null){
					
					
		%>
				
	<!-- 관리자 계정에서 글쓰기 할 경우 -->
		<%
			}
			
			else if(userID.equals("admin")){
					
		%>
		<!-- 관리자 계정 게시판 열람 경우 - 게시판 삭제 권한, 모든 게시판 열람 권한 추가 필요 -->
	<div class = "container-main">
		<div class = "row">
		
			<form method = "post" action="mobile_writeAction.jsp"  enctype="multipart/form-data">
				<table class = "table table-striped">
					
					<thead>
						<tr>
							<th colspan="2"> 게시판 글 쓰기 양식 </th>
							
						</tr>
						
					</thead>
					
					<tbody>
						
					
						<tr>
							<td><input type ="text" class="form-control" placeholder="글 제목" name = "bulletinTitle" maxlength ="50" ></input></td>
						</tr>
					
						<tr>
							<td>
								<select class="select-one radio-container" name = "bulletinAvailable" data-width="fit">
									<option value = 1>자유 글</option>
									<option value = 2>공지사항</option>
									<option value = 3>가입인사</option>
								</select>
							</td>
							
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name = "bulletinContent" maxlength ="20000" style= "height: 350px;"> </textarea></td>
						</tr>
				
					</tbody>
					
					
				</table>
								
					본인의 잘 나온 사진 : <input type="file" name="file"><br>
				<input type ="submit" class="btn btn-primary pull-right" value ="글쓰기">
			</form>
		</div>
	</div>
		
		
		
	<!-- 로그인 상태에서 글쓰기를 할 경우 -->
		<%
				}
				
			else {
					
			
		%>
	<div class = "container-main">
		<div class = "row">
		
			<form method = "post" action="mobile_writeAction.jsp" enctype="multipart/form-data">
				<table class = "table table-striped">
					
					<thead>
						<tr>
							<th> 게시판 글 쓰기 양식 </th>
							
						</tr>
						
					</thead>
					
					<tbody>
						<tr>
							<td><input type ="text" class="form-control" placeholder="글 제목" name = "bulletinTitle" maxlength ="50" ></input></td>
						</tr>
						
						<tr>
							<td>
								<select class="select-one" name = "bulletinAvailable" data-width="fit">
									<option value = 1>자유 글</option>
									<option value = 3>가입인사</option>
								</select>
							</td>
							
						</tr>
						
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name = "bulletinContent" maxlength ="20000" style= "height: 350px;"> </textarea></td>
						</tr>
				
					</tbody>
					
					
				</table>
				
					사진 첨부 : <input type="file" name="file"><br>
				<input type ="submit" class="btn btn-primary pull-right" value ="글쓰기">
			</form>
		</div>
	</div>
		
		
		
		<%
			
				}
				
		%>
</div>
	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="/js/bootstrap.js"></script>

</body>
</html>