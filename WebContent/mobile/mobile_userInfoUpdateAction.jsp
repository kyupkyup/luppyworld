<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import= "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id ="user" class	="user.User" scope="page"/>
<jsp:setProperty name ="user" property="userPassword" />
<jsp:setProperty name ="user" property="userName" />
<jsp:setProperty name ="user" property="userEmail" />
<jsp:setProperty name ="user" property="userAddress" />
<jsp:setProperty name ="user" property="userAddressNum" />
<jsp:setProperty name ="user" property="userGender" />
<jsp:setProperty name ="user" property="userJob" />
<jsp:setProperty name ="user" property="userAge" />
<jsp:setProperty name ="user" property="userBirthday" />
<jsp:setProperty name ="user" property="userPhoneNumber" />
<jsp:setProperty name ="user" property="firstRoute" />





<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">

<title>luppyworld_write_action_page</title>

</head>
<body>
	
	<!-- 글쓰기 부분 -->
	<%
		String directory = application.getRealPath("/upload/profile/");
		int maxSize = 1024 * 1024 *5; // 5메가 까지 업로드 가능
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
			
		String userID=null;
		if(multipartRequest.getParameter("userID")!=null){
			userID = multipartRequest.getParameter("userID");
		}
		
		String userPassword = multipartRequest.getParameter("userPassword");
		String userName = multipartRequest.getParameter("userName");
		String userEmail = multipartRequest.getParameter("userEmail");
		String userAddress = multipartRequest.getParameter("userAddress");
		int userAddressNum = Integer.parseInt(multipartRequest.getParameter("userAddressNum"));
		String userGender = multipartRequest.getParameter("userGender");
		String userJob = multipartRequest.getParameter("userJob");
		int userAge = Integer.parseInt(multipartRequest.getParameter("userAge"));
		String userBirthday = multipartRequest.getParameter("userBirthday");
		String userPhoneNumber = multipartRequest.getParameter("userPhoneNumber");
		int firstRoute = Integer.parseInt(multipartRequest.getParameter("firstRoute"));

		

		if(userID == null ||userPassword == null || userName == null || userEmail == null ||userAddress==null
		|| userGender ==null || userBirthday==null || userJob==null || userPhoneNumber==null){
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			script.println("alert('입력이 안 된 부분이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
			else {
			
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.userUpdate(userPassword,userName,userEmail,userAddress,userAddressNum,userGender,userJob,userAge,userBirthday, 
				userPhoneNumber, fileName, fileRealName, firstRoute, userID);
		
			
			if(result == -1 ){
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			script.println("alert('개인정보 수정에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			
			}
			
			else{
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			script.println("alert('개인정보 수정에 성공했습니다.')");
			script.println("location.href = 'mobile_userInfo.jsp'");
			script.println("</script>");
			}


	}
	%>

	
</body>
</html>