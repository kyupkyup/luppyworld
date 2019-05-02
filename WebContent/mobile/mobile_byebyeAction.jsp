<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
<%@ page import= "java.io.PrintWriter" %>


<%
	request.setCharacterEncoding("UTF-8");
%>



<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">

<title>luppyworld_write_action_page</title>

</head>
<body>
	
	<!-- 글쓰기 부분 권한 제어 추가로 만들것 -->
	<%
	User user1 =null;
		String userID = null;
		

		if(session.getAttribute("user") != null){
			user1 = (User)session.getAttribute("user");
		}
		
			

		if(request.getParameter("userID") != null)
		{
			userID = request.getParameter("userID");
		}
		
		if(user1.getUserID() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요)");
			script.println("location.href = 'mobile_login.jsp'");
			script.println("</script>");
		}
		
	UserDAO userDAO = new UserDAO();
		int result = userDAO.deleteUser(userID);
		

		if(result == -1 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴시키기에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");

		}
		
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('바이바이~')");
			script.println("location.href = 'mobile_adminMember.jsp'");
			script.println("</script>");
		}
	%>

	
</body>
</html>