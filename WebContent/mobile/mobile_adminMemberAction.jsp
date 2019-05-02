<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
<%@ page import= "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id ="user" class="user.User" scope="page"/>
<jsp:setProperty name ="user" property="userMemberShip" />
<jsp:setProperty name ="user" property="userAttend" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<title>Insert title here</title>


</head>
<body>
<%
	String userID = null;
		
		if(request.getParameter("userID") != null)
		{
	userID = request.getParameter("userID");
		}
		
	
		UserDAO userDAO = new UserDAO();
		
		int result = userDAO.userAdmin(userID, user.getUserMemberShip(), user.getUserAttend());

		if(result == -1 ){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('확정에 실패했습니다.')");
	script.println("history.back()");
	script.println("</script>");
	
	
		}
		
		
		else{
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('확정에 성공했습니다.')");
	script.println("location.href='mobile_adminMemberEach.jsp?userID="+userID+"'");
	 		script.println("</script>");
		
	
		}
%>


</body>
</html>