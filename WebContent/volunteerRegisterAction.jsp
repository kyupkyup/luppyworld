<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "registration.Registration" %>
<%@ page import= "registration.RegistrationDAO" %>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>

<%@ page import= "volunteer.VolunteerDAO" %>
<%@ page import= "volunteer.Volunteer" %>


<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id ="registration" class	="registration.Registration" scope="page"/>
<%-- <jsp:setProperty name ="registration" property="workPlace" />
<jsp:setProperty name ="registration" property="scary" />
<jsp:setProperty name ="registration" property="carfool" />
<jsp:setProperty name ="registration" property="eatWhether" />
<jsp:setProperty name ="registration" property="carfoolee" /> --%>
<jsp:setProperty name ="registration" property="region" />
<jsp:setProperty name ="registration" property="oneSay" />




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
		
		int volunteerID = 0;

		if(request.getParameter("volunteerID")!=null){
			volunteerID = Integer.parseInt(request.getParameter("volunteerID"));
			
		}

		int payment = 0;
		VolunteerDAO volunteerDAO = new VolunteerDAO();
		UserDAO userDAO = new UserDAO();
		/* 		int foodPrice = volunteerDAO.getVolunteer(volunteerID).getFoodPrice();
		
		if(userDAO.getUser(userID).getUserMemberShip()==0 || userDAO.getUser(userID).getUserMemberShip()==4){
			payment += 5000;
		}
		
		if(registration.getCarfoolee()==1){
			payment += 1000;
		}
		else if(registration.getCarfoolee()==2){
			payment += 2000;
		}
		
		if(registration.getEatWhether()==0){
			payment += foodPrice;
		} */
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		
		}
		
		else{
			
		/* 			if(registration.getCarfoolee() == -1 || registration.getEatWhether() == -1 || registration.getCarfoolee() == -1 ||registration.getWorkPlace()==-1|| 
			registration.getScary()==-1 || registration.getRegion()==null || registration.getOneSay()==null) */
			if( registration.getRegion()==null || registration.getOneSay()==null)
			
			{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		
			}
			
			else{
		RegistrationDAO registrationDAO = new RegistrationDAO();
		int result = registrationDAO.register(volunteerID, userID, registration.getRegion(), registration.getCarfool(), 
				registration.getEatWhether(), registration.getCarfoolee(), registration.getWorkPlace(), registration.getScary(),
				registration.getPaid(), registration.getOneSay());

		
		

		if(result == -1 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 봉사신청을 하셨습니다.')");
			script.println("history.back()");
			script.println("</script>");

		}
		
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
		/* 					script.println("alert('입금하실 금액은"+payment+"원 입니다. 계좌를 확인해주세요.')"); */
			script.println("location.href = 'volunteerBulletin.jsp'");
			script.println("</script>");
		}
		
			}
			
		}
	%>

	
</body>
</html>