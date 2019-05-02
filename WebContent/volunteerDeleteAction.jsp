<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "volunteer.Volunteer" %>
<%@ page import= "volunteer.VolunteerDAO" %>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>

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
	User user1 = null;
		String userID = null;
		
		
	if(session.getAttribute("user") != null){
		user1 = (User)session.getAttribute("user");
		userID = user1.getUserID();
		
	}
			
			int volunteerID = 0;
			if(request.getParameter("volunteerID") != null)
			{
		volunteerID = Integer.parseInt(request.getParameter("volunteerID"));
			}
			
			Volunteer volunteer = new VolunteerDAO().getVolunteer(volunteerID);
			
			
			if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
			}

			
			else if(!userID.equals("admin")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'volunteerBulletin.jsp'");
		script.println("</script>");
			}
			
			else{
		
		
		if(volunteerID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'volunteerBulletin.jsp'");
			script.println("</script>");
		}
		
		else{
				VolunteerDAO volunteerDAO = new VolunteerDAO();
				int result = volunteerDAO.delete(volunteerID);
		
		
				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
		
				}
				
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제에 성공했습니다.')");
					script.println("location.href = 'volunteerBulletin.jsp'");
					script.println("</script>");
				}
				
			
			
		}
			}
	%>

	
</body>
</html>