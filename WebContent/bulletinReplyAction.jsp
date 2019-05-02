<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "reply.Reply" %>
<%@ page import= "reply.ReplyDAO" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
<%@ page import= "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id ="reply" class	="reply.Reply" scope="page"/>
<jsp:setProperty name ="reply" property="replyContent" />
<jsp:setProperty name ="reply" property="replyDate" />
<jsp:setProperty name ="reply" property="replyAvailable" />




<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">

<title>luppyworld_write_action_page</title>

</head>
<body>
			
	
	<!-- 글쓰기 부분 -->
	<%
	User user1 =null;
		String userID = null;
		String userName = null;

		if(session.getAttribute("user") != null){
			user1 = (User)session.getAttribute("user");
			userID = user1.getUserID();
			userName = user1.getUserName();
		}
		
			int bulletinID = 0;
			
			if(request.getParameter("bulletinID") != null){
		bulletinID = Integer.parseInt(request.getParameter("bulletinID"));			
			}

			if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
			}
			
			else{
		
		if(reply.getReplyContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글 입력이 안 됐습니다.')");
			script.println("history.back()");
			script.println("</script>");
			
			
		}
		
		else{
			
				
				ReplyDAO replyDAO = new ReplyDAO();
				int result = replyDAO.reply(bulletinID, userID, reply.getReplyContent());
				

				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");

				}
				
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
	/* 						script.println("alert('댓글 쓰기에 성공했습니다.')");
	 */						script.println("location.href='bulletinView.jsp?bulletinID="+bulletinID+"'");
					script.println("</script>");
				}
			}
			}
	%>
	
</body>
</html>