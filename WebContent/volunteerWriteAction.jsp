<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "volunteer.VolunteerDAO" %>
    <%@ page import = "volunteer.Volunteer" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>

    
    
<%@ page import= "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id ="volunteer" class	="volunteer.Volunteer" scope="page"/>
<jsp:setProperty name ="volunteer" property="volunteerTitle" />
<jsp:setProperty name ="volunteer" property="volunteerDate" />
<jsp:setProperty name ="volunteer" property="volunteerPlace" />
<jsp:setProperty name ="volunteer" property="volunteerContent" />
<jsp:setProperty name ="volunteer" property="foodName" />
<jsp:setProperty name ="volunteer" property="foodPrice" />
<jsp:setProperty name ="volunteer" property="dueDate" />
<jsp:setProperty name ="volunteer" property="dueHour" />
<jsp:setProperty name ="volunteer" property="dueMinute" />
<jsp:setProperty name ="volunteer" property="surveyURL" />





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
		
		String dueDate = volunteer.getDueDate();
		String dueHour = volunteer.getDueHour();
		String dueMinute = volunteer.getDueMinute();

		
			if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
			}
			
			else{
		
		if(volunteer.getVolunteerTitle() == null || volunteer.getVolunteerContent() == null || volunteer.getVolunteerPlace() == null
				 || volunteer.getVolunteerDate() == null || volunteer.getFoodName()==null || volunteer.getFoodPrice()==0 
				 ||volunteer.getSurveyURL()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
			
			
		}
		
		else{
			

			VolunteerDAO volunteerDAO = new VolunteerDAO();
			int result = volunteerDAO.volunteerWrite(volunteer.getVolunteerTitle(), volunteer.getVolunteerContent(), volunteer.getVolunteerPlace(), volunteer.getVolunteerDate(), volunteer.getVolunteerAvailable(), volunteer.getFoodName(), volunteer.getFoodPrice(), userID, 
					volunteer.getDueDate(), volunteer.getDueHour(), volunteer.getDueMinute(), volunteer.getSurveyURL());


			if(result == -1 ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('공지에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");

			}
			
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('공지에 성공했습니다.')");
				script.println("location.href = 'volunteerBulletin.jsp'");
				script.println("</script>");
			}
			
		}
		
			}
	%>

	
</body>
</html>