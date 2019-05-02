<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "user.User" %>

    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import = "bulletin.BulletinDAO" %>
    <%@ page import = "bulletin.Bulletin" %>
    <%@ page import = "java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_style.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_bulletin_style.css">


<meta name="viewport" content="width=device-width" , initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua/Sunflower:300&amp;subset=korean" rel="stylesheet">
    <title>러피월드: &nbsp;즐거운 봉사는 유기견을 춤추게한다.</title>

</head>
<body>
	<%
		User user1 =null;
		String userID = null;
		
		if(session.getAttribute("user") != null){
			user1 = (User)session.getAttribute("user");
			userID = user1.getUserID();
			
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

		<%
		
			int pageNumber = 1;
			if(request.getParameter("pageNumber") != null){
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}
		/* 비로그인 상태에서 게시판을 볼 경우 -*/
				if(userID == null){
					
		%>
	<div class = "container-main">
			<div class="btn-group" role="group" aria-label="...">
			  <a type="button" class="btn btn-default " href="mobile_bulletinNotice.jsp">공지사항</a>
			  <a type="button" class="btn btn-default " href="mobile_bulletinIntroduction.jsp">가입인사</a>
			  <a type="button" class="btn btn-default active" href="mobile_bulletin.jsp">자유게시판</a>
			</div>
			<br>
		<div class = "row">

			<table class = "table table-hover list">

				
				<tbody>
				<%
					BulletinDAO bulletinDAO = new BulletinDAO();
					ArrayList<Bulletin> list = bulletinDAO.getList(pageNumber);
					for(int i = 0; i< list.size(); i++){
					
				%>
					<tr>
						<td colspan='2'><a  class="title-line" href="mobile_bulletinView.jsp?bulletinID=<%=list.get(i).getBulletinID()%>"><%=list.get(i).getBulletinTitle() %></a></td>
					</tr>
					<tr>	
						<td class="name-line"><%= list.get(i).getUserName() %></td>
						<td class="date-line"><%= list.get(i).getBulletinDate().substring(0,11) + list.get(i).getBulletinDate().substring(11, 13)+ "시" + list.get(i).getBulletinDate().substring(14, 16) + "분" %></td>
					</tr>
				</tbody>
				<%
					}
				%>
			</table>
			
				
			<%
				if(bulletinDAO.nextPage(pageNumber + 1,1)){
				
			%>
			<a href = "mobile_bulletin.jsp?pageNumber=<%= pageNumber +1 %>" class= "btn btn-success btn-arrow-left pull-left">이전</a>
			
			<%
				}
			%>
			<%
				
				if(pageNumber != 1){
			%>
			<a href = "mobile_bulletin.jsp?pageNumber=<%= pageNumber -1 %>" class= "btn btn-success btn-arrow-left pull-left">다음</a>
			
			<%
				}
			%>
		
			<a href= "mobile_write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	
	
	</div>
		
		
		
	<!-- 관리자 계정에서 게시판을 볼 경우 -->
		<%
		}
			
			else if(userID.equals("admin")){
					
		%>
		<!-- 관리자 계정 게시판 열람 경우 - 게시판 삭제 권한, 모든 게시판 열람 권한 추가 필요 -->
	<div class = "container-main">
		<div class="btn-group" role="group" aria-label="...">
		  <a type="button" class="btn btn-default " href="mobile_bulletinNotice.jsp">공지사항</a>
		  <a type="button" class="btn btn-default " href="mobile_bulletinIntroduction.jsp">가입인사</a>
		  <a type="button" class="btn btn-default active" href="mobile_bulletin.jsp">봉사 후기</a>
		</div>
		<br>
		<div class = "row">

			<table class ="table table-hover list">
				
				<tbody>
				<%
					BulletinDAO bulletinDAO = new BulletinDAO();
					ArrayList<Bulletin> list = bulletinDAO.getList(pageNumber);
					for(int i = 0; i< list.size(); i++){
					
				%>
				
					<tr>
						<td colspan='2'><a  class="title-line" href="mobile_bulletinView.jsp?bulletinID=<%=list.get(i).getBulletinID()%>"><%=list.get(i).getBulletinTitle() %></a></td>
					</tr>
					<tr>	
						<td class="name-line"><%= list.get(i).getUserName() %></td>
						<td class="date-line"><%= list.get(i).getBulletinDate().substring(0,11) + list.get(i).getBulletinDate().substring(11, 13)+ "시" + list.get(i).getBulletinDate().substring(14, 16) + "분" %></td>
					</tr>
				</tbody>
				
				<%
				
					}
				%>
				
			</table>
					
			<%
				if(bulletinDAO.nextPage(pageNumber + 1,1)){
				
			%>
			<a href = "mobile_bulletin.jsp?pageNumber=<%=pageNumber +1%>" class= "btn btn-success btn-arrow-left pull-left">이전</a>
			
			<%
				}
			%>
			
			<%
				if(pageNumber != 1){
					
			%>
			<a href = "mobile_bulletin.jsp?pageNumber=<%=pageNumber -1%>" class= "btn btn-success btn-arrow-left pull-left">다음</a>
			
			<%
				}
			%>
	
			
			
			<a href= "mobile_write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	
	
	</div>
		
		
	<!-- 로그인 상태에서 게시판을 볼 경우 -->
		<%
				}
				
			else {
					
			
		%>
	<div class = "container-main">
			<div class="btn-group" role="group" aria-label="...">
			  <a type="button" class="btn btn-default " href="mobile_bulletinNotice.jsp">공지사항</a>
			  <a type="button" class="btn btn-default " href="mobile_bulletinIntroduction.jsp">가입인사</a>
			  <a type="button" class="btn btn-default active" href="mobile_bulletin.jsp">봉사 후기</a>
			</div>
			<br>
			<div class = "row">

			<table class ="table table-hover list">

				<tbody>
				<%
					BulletinDAO bulletinDAO = new BulletinDAO();
					ArrayList<Bulletin> list = bulletinDAO.getList(pageNumber);
					for(int i = 0; i< list.size(); i++){
					
				%>
				
					<tr>
						<td colspan='2'><a  class="title-line" href="mobile_bulletinView.jsp?bulletinID=<%=list.get(i).getBulletinID()%>"><%=list.get(i).getBulletinTitle() %></a></td>
					</tr>
					<tr>	
						<td class="name-line"><%= list.get(i).getUserName() %></td>
						<td class="date-line"><%= list.get(i).getBulletinDate().substring(0,11) + list.get(i).getBulletinDate().substring(11, 13)+ "시" + list.get(i).getBulletinDate().substring(14, 16) + "분" %></td>
					</tr>
				</tbody>
				
				<%
				
					}
				%>
				
			</table>
					
			<%
				if(bulletinDAO.nextPage(pageNumber + 1, 1)){
				
			%>
			<a href = "mobile_bulletin.jsp?pageNumber=<%= pageNumber +1 %>" class= "btn btn-success btn-arrow-left pull-left">이전</a>
			
			<%
				}
			%>
			<%
				if(pageNumber != 1){
					
			%>
			<a href = "mobile_bulletin.jsp?pageNumber=<%= pageNumber -1 %>" class= "btn btn-success btn-arrow-left pull-left">다음</a>
			
			<%
				}
			%>
	
			
			
			<a href= "mobile_write.jsp" class="btn btn-primary pull-right">글쓰기</a>
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