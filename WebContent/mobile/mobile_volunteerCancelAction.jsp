<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import= "registration.Registration" %>
<%@ page import= "registration.RegistrationDAO" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
<%@ page import= "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<title>Insert title here</title>


</head>
<body>
<% 
		String primaryUserID = null;
		int volunteerID = 0;
		if(request.getParameter("primaryUserID") != null)
		{
			primaryUserID = request.getParameter("primaryUserID");
		}
		
		if(request.getParameter("volunteerID") != null)
		{
			volunteerID = Integer.parseInt(request.getParameter("volunteerID"));
		}
		
		
		
		RegistrationDAO registrationDAO = new RegistrationDAO();
		int result = registrationDAO.deleteRegister(primaryUserID);		
	
		if(result == -1 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('취소에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
	
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('취소되었습니다.')");
			script.println("location.href='mobile_volunteerBulletinView.jsp?volunteerID="+volunteerID+"'");
	 		script.println("</script>");
				
			
		}
		
		

		
		
		

		

		
		
%>


</body>
</html>