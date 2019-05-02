<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"  %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%@ page import= "bulletin.Bulletin" %>
<%@ page import= "bulletin.BulletinDAO" %>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>


<%
	request.setCharacterEncoding("UTF-8");
%>
 <jsp:useBean id ="bulletin" class="bulletin.Bulletin" scope="page"/>
<jsp:setProperty name ="bulletin" property="bulletinTitle" />
<jsp:setProperty name ="bulletin" property="bulletinContent" />
<jsp:setProperty name ="bulletin" property="bulletinAvailable" />




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
		int userMemberShip = 0;
		//파일처리 부분
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024 * 1024 *5; // 5메가 까지 업로드 가능
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("file");
		
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		
		if(session.getAttribute("user") != null){
			user1 = (User)session.getAttribute("user");
			userID = user1.getUserID();
			userName = user1.getUserName();
			userMemberShip=user1.getUserMemberShip();
		}
		
		
		
		UserDAO userDAO = new UserDAO();
		
		
		String bulletinAvailable1 = multipartRequest.getParameter("bulletinAvailable");
		int bulletinAvailable = Integer.parseInt(bulletinAvailable1);
		
			if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
			}
			
			
			
			else{
		
		if(multipartRequest.getParameter("bulletinTitle").equals("") ||multipartRequest.getParameter("bulletinContent").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
			
			
		}
		if(fileName==null || fileRealName ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('사진을 넣어주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else{
			
			if(bulletinAvailable == 1){
				
				BulletinDAO bulletinDAO = new BulletinDAO();
				int result = bulletinDAO.write(multipartRequest.getParameter("bulletinTitle"), userID, multipartRequest.getParameter("bulletinContent") , userName, fileName, fileRealName);
				

				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");

				}
				
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'mobile_bulletin.jsp'");
					script.println("</script>");
				}
				
			}
			
			else if(bulletinAvailable == 2){
				
				BulletinDAO bulletinDAO = new BulletinDAO();
				int result = bulletinDAO.writeNotice(multipartRequest.getParameter("bulletinTitle"), userID, multipartRequest.getParameter("bulletinContent") , userName, fileName, fileRealName);
				

				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");

				}
				
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'mobile_bulletinNotice.jsp'");
					script.println("</script>");
				}
				
			}
			else if(bulletinAvailable == 3){
				
				BulletinDAO bulletinDAO = new BulletinDAO();
				int result = bulletinDAO.writeIntroduction(multipartRequest.getParameter("bulletinTitle"), userID, multipartRequest.getParameter("bulletinContent") , userName, fileName, fileRealName);
				

				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");

				}
				
				else{
					PrintWriter script = response.getWriter();

				if(userMemberShip==5){
				int result1 = userDAO.introduceChangeState(userID);
				if(result1==-1){	
					script.println("<script>");
					script.println("alert('등업에 실패했습니다. 관리자에게 문의하세요.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					script.println("<script>");
					script.println("alert('신입회원으로 등업되었습니다.')");
					script.println("</script>");
				}
				}
				script.println("<script>");
				script.println("alert('글쓰기에 성공했습니다.')"); 
				script.println("location.href = 'mobile_bulletinIntroduction.jsp'");
				script.println("</script>");
				
				
				
			}

		
			
		}
		}
			}
	%>

	
</body>
</html>