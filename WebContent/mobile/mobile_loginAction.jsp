<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "user.UserDAO" %>
<%@ page import= "user.User" %>

<%@ page import= "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id ="user" class="user.User" scope="page"/>
<jsp:setProperty name ="user" property="userID" />
<jsp:setProperty name ="user" property="userPassword" />

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">

<title>luppyworld_login_page</title>

</head>
<body>
	
	<%
	User user1 = null;
			String userID = null;
			
			
				if(session.getAttribute("user") != null){
			user1 = (User)session.getAttribute("user");
			userID = user1.getUserID();
			
				}
				/* 		String userID = null;
				if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
			
			
				} */
				
				if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href = 'mobile_main.jsp'");
			script.println("</script>");
				}
				
				UserDAO userDAO = new UserDAO();
				User user_all = new User();
				user_all = userDAO.getUser(user.getUserID());
				int result = userDAO.login(user.getUserID(), user.getUserPassword());
			
				if(result ==1 ){/* 로그인 성공  */
			
			session.setAttribute("user", user_all);

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'mobile_main.jsp'");
			script.println("</script>");
				}
				
				else if(result == 0 ){/* 비밀번호가 틀릴경우 */
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
				}
				
				else if(result == -1 ){/* 아이디가 존재하지 않을 경우 */
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");
				}
				
				else if(result == -2 ){  /* 데이터베이스 오류  */
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
				}
		%>
	
</body>
</html>