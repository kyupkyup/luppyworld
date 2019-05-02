<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "user.User" %>
<%@ page import= "bulletin.Bulletin" %>
<%@ page import= "bulletin.BulletinDAO" %>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id ="bulletin" class	="bulletin.Bulletin" scope="page"/>
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

		if(session.getAttribute("user") != null){
			user1 = (User)session.getAttribute("user");
			userID = user1.getUserID();
			userName = user1.getUserName();
		}
		
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024 * 1024 *5; // 5메가 까지 업로드 가능
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("file");
		
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		String bulletinAvailable1 = multipartRequest.getParameter("bulletinAvailable");
		int bulletinAvailable = Integer.parseInt(bulletinAvailable1);
		
			if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요)");
		script.println("location.href = 'mobile_login.jsp'");
		script.println("</script>");
			}
			int bulletinID = 0;
			
			if(multipartRequest.getParameter("bulletinID") != null)
			{
		bulletinID = Integer.parseInt(multipartRequest.getParameter("bulletinID"));
			}
			
			
			
		if(bulletinID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'mobile_bulletin.jsp'");
			script.println("</script>");
		}
		
		else{
			
			if(multipartRequest.getParameter("bulletinTitle") == null || multipartRequest.getParameter("bulletinContent")== null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
				
				
			}
			
			else{
				if(bulletinAvailable == 1){
		
				BulletinDAO bulletinDAO = new BulletinDAO();
				int result = bulletinDAO.update(bulletinID, multipartRequest.getParameter("bulletinTitle"), multipartRequest.getParameter("bulletinContent"), bulletinAvailable, fileName, fileRealName);
		
		
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
					script.println("alert('수정에 성공했습니다.')");
					script.println("location.href = 'mobile_bulletin.jsp'");
					script.println("</script>");
				}
				
			}
				
				else if(bulletinAvailable == 2){
					BulletinDAO bulletinDAO = new BulletinDAO();
					int result = bulletinDAO.update(bulletinID, multipartRequest.getParameter("bulletinTitle"), multipartRequest.getParameter("bulletinContent"), bulletinAvailable, fileName, fileRealName);
			
			
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
						script.println("alert('수정에 성공했습니다.')");
						script.println("location.href = 'mobile_bulletin.jsp'");
						script.println("</script>");
					}
					
					
				}
				
				else if(bulletinAvailable == 3){
					BulletinDAO bulletinDAO = new BulletinDAO();
					int result = bulletinDAO.update(bulletinID, multipartRequest.getParameter("bulletinTitle"), multipartRequest.getParameter("bulletinContent"), bulletinAvailable, fileName, fileRealName);
			
			
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
	/* 							script.println("alert('수정에 성공했습니다.')");
	 */							script.println("location.href = 'mobile_bulletin.jsp'");
						script.println("</script>");
					}
					
					
				}
		}
			}
	%>

	
</body>
</html>