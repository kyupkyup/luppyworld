<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
<%@ page import= "volunteer.Volunteer" %>
<%@ page import= "volunteer.VolunteerDAO" %>
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
	User user1 = null;
		String userID = null;
		
	if(session.getAttribute("user") != null){
		user1 = (User)session.getAttribute("user");
		userID = user1.getUserID();
		
	}
			
			if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
			}
			
			int volunteerID = 0;

			if(request.getParameter("volunteerID") != null)
			{
		volunteerID = Integer.parseInt(request.getParameter("volunteerID"));
			}
			

		if(volunteerID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else{
			
			if(volunteer.getVolunteerTitle() == null || volunteer.getVolunteerPlace() == null || volunteer.getVolunteerContent() == null
					|| volunteer.getVolunteerDate() == null || volunteer.getFoodName() == null ||volunteer.getFoodPrice() == 0)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
				
				
			}
			
			else{
				
		
				VolunteerDAO volunteerDAO = new VolunteerDAO();
				int result = volunteerDAO.updateVolunteer(volunteerID, volunteer.getVolunteerTitle(), volunteer.getVolunteerContent() ,volunteer.getVolunteerPlace(),
						volunteer.getVolunteerDate(),volunteer.getFoodName(), volunteer.getFoodPrice(), userID, volunteer.getDueDate(), volunteer.getDueHour(), 
						volunteer.getDueMinute(), volunteer.getSurveyURL());
		
		
				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
		
				}
				
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					/* script.println("alert('수정에 성공했습니다.')"); */
					script.println("location.href = 'volunteerBulletin.jsp'");
					script.println("</script>");
				}
				
			}
			
		}
	%>

	
</body>
</html>