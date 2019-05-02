<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import = "bulletin.Bulletin" %>
    <%@ page import = "bulletin.BulletinDAO" %>
    <%@ page import = "user.User" %>
    <%@ page import = "user.UserDAO" %>
    <%@ page import = "reply.Reply" %>
    <%@ page import = "reply.ReplyDAO" %>
    <%@ page import = "java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>



<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_style.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_bulletin_view_style.css">


<meta name="viewport" content="width=device-width" , initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">


<title>러피월드:&nbsp;자유글</title>

</head>
<body>
	<%
	User user1 =null;
			String userID = null;
			
			if(session.getAttribute("user") != null){
		user1 = (User)session.getAttribute("user");
		userID = user1.getUserID();
		
			}
			
		int bulletinID = 0;
		if(request.getParameter("bulletinID") != null)
		{
			bulletinID = Integer.parseInt(request.getParameter("bulletinID"));
		}
		
		if(bulletinID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'mobile_bulletin.jsp'");
			script.println("</script>");
		}
		
		if(session.getAttribute("user") == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'mobile_login.jsp'");
			script.println("</script>");
		}
		
		Bulletin bulletin = new BulletinDAO().getBulletin(bulletinID);
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
				
	<!-- 관리자 계정에서 게시판을 볼 경우 -->
		<%
			/* }
			
			else if(userID.equals("admin")){ */
		%>
		<!-- 관리자 계정 게시판 열람 경우 -  -->
			<%-- 		<div class = "container">
		<div class = "row">
			<table class = "table table-striped"style= "text-align : center; border: 1px solid #dddddd">
				
				<thead>
					<tr>
						<th style ="background-color: #eeeeee; text-align: center; "> 번호 </th>
						<th style ="background-color: #eeeeee; text-align: center; "> 제목 </th>
						<th style ="background-color: #eeeeee; text-align: center; "> 작성자 </th>
						<th style ="background-color: #eeeeee; text-align: center; "> 작성일 </th>
						
					</tr>
					
				</thead>
				
				<tbody>
					<tr>
						<td>1</td>
						<td>안녕하세요.</td>
						<td>관리자</td>
						<td>2018-12-07</td>
					</tr>
			
				</tbody>
				
				
			</table>
			<a href= "writeAction.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	
	
	</div>
		 --%>
		
	<!-- 로그인 상태/ 관리자 계정에서 게시판을 볼 경우 -->
		<%
			}
				
			else {
		%>
	<div class = container-main>
		<div class = "row">
		
				<table class = "table table-bordered view">
					
	
					
					<tbody>
					
						<tr> <!-- 고칠 부분  -->
							<td  colspan='2' class="bulletin-view-title"><%=bulletin.getBulletinTitle()%></td>
						</tr>
						
						<tr>
							<td class="bulletin-view-user"><%=bulletin.getUserName()%></td>
							<td class="bulletin-view-date"><%=bulletin.getBulletinDate().substring(0,11) + bulletin.getBulletinDate().substring(11, 13)+ "시" + bulletin.getBulletinDate().substring(14, 16) + "분"%></td>
						</tr>
		
						<tr>
							<td  colspan='2' ><div style="word-break:break-all; word-wrap:break-word;white-space:pre-wrap;" class="bulletin-view-content"><%=bulletin.getBulletinContent()%></div></td>
						</tr>
				
						<tr>
							<td colspan='2'><img src="/upload/<%=bulletin.getFileRealName()%>" onerror="this.src='/css/images/logo.png'" alt="images/logo.png" class="bulletin-view-image"></td>
							
						</tr>
					</tbody>
					
					
				</table>
				
				<form method = "post" action="mobile_bulletinReplyAction.jsp?bulletinID=<%=bulletinID%>">
					<table class="reply-cover">
							<tbody>
								<tr>
									<td><textarea class ="form-control reply-content" id="replyContent" placeholder = "댓글 남기기" name ="replyContent"></textarea></td>
									<td><input type = "submit" class ="btn btn-primary reply-button" value ="댓글 달기"></td>
								</tr> 
							</tbody>
					</table>
				</form>
				
				<table class = "table table-bordered replied-cover">

					
					<%
											UserDAO userDAO = new UserDAO();									
																	ReplyDAO replyDAO = new ReplyDAO();
																	ArrayList<Reply> list1 = replyDAO.getList(bulletinID);

																	for(int i = 0; i< list1.size(); i++){
										%>
					<tbody>
						<tr>
							<td class="replied-name" style="border:0;"><%=userDAO.getUserName1(list1.get(i).getUserID())%></td>
							<td class="replied-date" style="border:0;"><%=list1.get(i).getReplyDate()%>
						</tr>
						
						<tr>
							<td colspan='2' class="replied-content"  style=" word-break:break-all; word-wrap:break-word;white-space:pre-wrap;"><%=list1.get(i).getReplyContent()%></td>
						</tr>
						<% 
						}
						%>
					</tbody>
				</table>
				
				<a href = "mobile_bulletin.jsp" class = "btn btn-primary">목록으로</a>
				
				<%
					if(userID != null && (userID.equals(bulletin.getUserID()) || userID.equals("admin"))){
				%>
					<a href = "mobile_update.jsp?bulletinID=<%=bulletinID%>" class = "btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "mobile_deleteAction.jsp?bulletinID=<%=bulletinID%>" class = "btn btn-primary">삭제</a>
					
				
				<%
					}
				%>
		</div>
	</div>
		
		
		<%
			
				}
				
		%>
		
</div>			

	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="/js/bootstrap.js"></script>
	<script type="text/javascript">
	
/* 	document.addEventListener('keydown', function(event) {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	}, true); */
	
	</script>
</body>
</html>