<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import= "registration.Registration" %>
<%@ page import= "registration.RegistrationDAO" %>
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
<title>Insert title here</title>


</head>
<body>
<%
	String primaryUserID = null;
		int volunteerID=0;
		int paid=0;
		String userID = null;
		if(request.getParameter("primaryUserID") != null)
		{
	primaryUserID = request.getParameter("primaryUserID");
		}
		
		if(request.getParameter("userID") != null)
		{
	userID = request.getParameter("userID");
		}
		
		if(request.getParameter("volunteerID") != null)
		{
	volunteerID = Integer.parseInt(request.getParameter("volunteerID"));
		}
		
		if(request.getParameter("paid") != null)
		{
	paid = Integer.parseInt(request.getParameter("paid"));
		}
		
		RegistrationDAO registrationDAO = new RegistrationDAO();
		UserDAO userDAO = new UserDAO();
		
		if(paid==0){
	
		int result = registrationDAO.paid(primaryUserID);
		int resultAttend = userDAO.userAttend(userID);
		
		if(result == -1 ){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('확정에 실패했습니다.')");
	script.println("history.back()");
	script.println("</script>");
		}
		
		else if(resultAttend == -1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('출석 추가에 실패했습니다.')");
	script.println("history.back()");
	script.println("</script>");
	
		}
		
		else{
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href='volunteerBulletinView.jsp?volunteerID="+volunteerID+"'");
	 		script.println("</script>");
		
	
		}
		}
		
		else if(paid==1){
		
		int cancelResult = registrationDAO.cancelPaid(primaryUserID);
		int cancelResultAttend = userDAO.cancelUserAttend(userID);
		
		if(cancelResult == -1 ){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('취소에 실패했습니다.')");
	script.println("history.back()");
	script.println("</script>");
	
	
		}
		
		else if(cancelResultAttend == -1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('출석 취소에 실패했습니다.')");
	script.println("history.back()");
	script.println("</script>");
	
		}
		
		else{
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href='volunteerBulletinView.jsp?volunteerID="+volunteerID+"'");
	 		script.println("</script>");
		
	
		}
		}
%>


</body>
</html>