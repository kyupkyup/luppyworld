<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import = "bulletin.Bulletin" %>
    <%@ page import = "bulletin.BulletinDAO" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
    
    
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<meta name = "viewport" content = "width=1000px", initial-scale = "1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link href="css/style.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">
<title>러피월드: &nbsp;글 수정</title>

</head>
<body>
	<%
	User user1 = null;
		String userID = null;
		
		
	if(session.getAttribute("user") != null){
		user1 = (User)session.getAttribute("user");
		userID = user1.getUserID();
		
	}
		
		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		int bulletinID = 0;
		if(request.getParameter("bulletinID") != null)
		{
			bulletinID = Integer.parseInt(request.getParameter("bulletinID"));
		}
		
		if(bulletinID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bulletin.jsp'");
			script.println("</script>");
		}
		
		Bulletin bulletin = new BulletinDAO().getBulletin(bulletinID);

	 	if(!userID.equals(bulletin.getUserID())  && !userID.equals("admin") ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bulletin.jsp'");
			script.println("</script>");
			
		}
	%>
<div class="container-all">	
	
<!-- 기본 네비게이션 바 - 아이콘 형태 항상 상위에 고정-->
	        <nav class="navbar navbar-default">
            <!-- 기본 네비게이션 바 - 아이콘 형태 항상 상위에 고정-->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">

                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>

                </button>
                <a class="navbar-brand" href="main.jsp"></a> <!--  브랜드 로고 -->
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <!--	<ul class = "nav navbar-nav">
			
			
			</ul>
			-->



                <%
				if(userID == null){
					
					
				
			%>
                <!-- 로그인이 안 되어있는 경우 -->
                <ul class="nav navbar-nav navbar-right">
<!--                     <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span> </a>

                        <ul class="dropdown-menu">
                            <li class=""><a href="login.jsp">로그인</a></li>
                            <li class=""><a href="join.jsp">회원가입</a></li>
                        </ul>
                    </li> -->
                    <li class="login-button"><a href="login.jsp"></a></li>
                    
                </ul>
                <%
					}
				else if(userID.equals("admin"))
				{
					
			
				
				%>
                <!-- 로그인이 관리자 계정으로 된 경우 -->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span> </a>

                        <ul class="dropdown-menu">
                            <li class=""><a href="adminMember.jsp">회원관리</a></li> <!-- 회원관리 페이지 만들것  -->
                            <li class=""><a href="logoutAction.jsp">로그아웃</a></li>


                        </ul>

                    </li>
                </ul>


                <%
				}
				else {
					
			
				%>
                <!-- 로그인이 되어 있는 경우  -->
                <ul class="nav navbar-nav navbar-right">
<!--                     <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원 정보<span class="caret"></span> </a>

                        <ul class="dropdown-menu">
                            <li class=""><a href="userInfo.jsp">계정 정보</a></li> 회원정보 페이지 만들것 
                            <li class=""><a href="logoutAction.jsp">로그 아웃</a></li>


                        </ul>

                    </li> -->
                    
                    <li class="userInfo-button"><a href="userInfo.jsp"></a></li>
                </ul>

                <%
				
				}
				
				%>


                <ul class="nav navbar-nav navbar-right">

         <!--            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"> 게시판 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="bulletinNotice.jsp">공지사항</a></li>
                            <li><a href="bulletinIntroduction.jsp">가입인사</a></li>
                            <li><a href="bulletin.jsp">자유글</a></li>
                        </ul>
                    </li>  -->
                    <li class="notice-button"><a href="bulletinNotice.jsp"></a></li>
                    <li class="introduction-button"><a href="bulletinIntroduction.jsp"></a></li>
                    <li class="volunteer-button"><a href="volunteerBulletin.jsp"></a></li>
                </ul>

            </div>
        </nav>
	
	<!-- 내용 부분  -->
	<!-- 비로그인 상태에서 게시판을 볼 경우 -->
		<%
				if(userID == null){
					
					
		%>
				
	<!-- 관리자 계정에서 글쓰기 할 경우 -->
		<%
			}
			
			else if(userID.equals("admin")){
					
		%>
		<!-- 관리자 계정 게시판 열람 경우 - 게시판 삭제 권한, 모든 게시판 열람 권한 추가 필요 -->
	<div class = "container">
		<div class = "row">
		
			<form method = "post" action="updateAction.jsp?bulletinID=<%=bulletinID%>" enctype="multipart/form-data">
				<table class = "table table-striped"style= "text-align : center; border: 1px solid #dddddd">
					
					<thead>
						<tr>
							<th colspan="2" style ="background-color: #eeeeee; text-align: center; "> 게시글 수정 </th>
							
						</tr>
						
					</thead>
					
					<tbody>
						<tr>
							<td><input type ="text" class="form-control" placeholder="글 제목" name = "bulletinTitle" maxlength ="50" value="<%=bulletin.getBulletinTitle()%>" ></input></td>
						</tr>
							
						<tr class = "container">
							<td>
								<select class="select-one" data-width="fit" name = "bulletinAvailable" >
									<option value = 2>공지사항</option>
									<option value = 3>가입인사</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name = "bulletinContent" maxlength ="2048" style= "height: 350px;"><%=bulletin.getBulletinContent()%> </textarea></td>
						</tr>
				
					</tbody>
					
					
				</table>
									본인의 잘 나온 사진 : <input type="file" name="file"><br>
				
				<input type ="submit" class="btn btn-primary pull-right" value ="수정">
			</form>
		</div>
	</div>
		
		
	<!-- 로그인 상태에서 글쓰기를 할 경우 -->
		<%
				}
				
			else {
					
			
		%>
	<div class = "container">
		<div class = "row">
		
			<form method = "post" action="updateAction.jsp?bulletinID=<%=bulletinID%>" enctype="multipart/form-data">
				<table class = "table table-striped"style= "text-align : center; border: 1px solid #dddddd">
					
					<thead>
						<tr>
							<th colspan="2" style ="background-color: #eeeeee; text-align: center; "> 게시글 수정 </th>
							
						</tr>
						
					</thead>
					
					<tbody>
						<tr>
							<td><input type ="text" class="form-control" placeholder="글 제목" name = "bulletinTitle" maxlength ="50" value="<%=bulletin.getBulletinTitle()%>" ></input></td>
						</tr>
							
						<tr>
							<td style = "text-align:left;">
								<select class="select-one" data-width="fit" name = "bulletinAvailable" >
									<option value = 3>가입인사</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name = "bulletinContent" maxlength ="2048" style= "height: 350px;"><%=bulletin.getBulletinContent()%> </textarea></td>
						</tr>
				
					</tbody>
					
					
				</table>
									본인의 잘 나온 사진 : <input type="file" name="file"><br>
				
				<input type ="submit" class="btn btn-primary pull-right" value ="수정">
			</form>
		</div>
	</div>
		
		
		
		<%
			
				}
				
		%>
</div>
	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>