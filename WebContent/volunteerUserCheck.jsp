<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>

<%@ page import= "registration.Registration" %>
 <%@ page import= "registration.RegistrationDAO" %>


    
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<meta name = "viewport" content = "width=1000px", initial-scale = "1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link href="css/style.css" rel="stylesheet">
<link href="css/volunteer_register_style.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">
<title>bulletin_write</title>

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
			
			int volunteerID = 0;
			if(request.getParameter("volunteerID") != null)
			{
		volunteerID = Integer.parseInt(request.getParameter("volunteerID"));
			}
			String userID1 = null;
			if(request.getParameter("userID") != null)
			{
		userID1 =request.getParameter("userID");
			}
			RegistrationDAO registrationDAO = new RegistrationDAO();
			Registration registration = registrationDAO.getRegistration(userID1, volunteerID);
			
			UserDAO userDAO = new UserDAO();
			User user = userDAO.getUser(userID1);
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
				
	<!-- 관리자계정이 아닐 경우 봉사신청 하도록 -->
		<%
			}
			
			else if(userID.equals("admin")){
					
		%>
		<!-- 관리자 계정 게시판 열람 경우 - 게시판 삭제 권한, 모든 게시판 열람 권한 추가 필요 -->
	<div class = "container">
	
	    <p class="title"><%= user.getUserName() %></p>
	    <p class="content"><%= user.getUserPhoneNumber() %></p> 
	    
            <div class = "row">

                <form>
                 <p style="font-size:15px;"><strong>카풀 하시나요?</strong></p>
                        <!-- 현재 신청하려는 봉사 제목, 내용, 주의사항 보여주기  -->
						<%
							if(registration.getCarfool()==0){
						%>
                           
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "0"  class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-1">네! 차량 지원 할게요.</label>
                                </div>
                                <div class="custom-control custom-radio  disabled">
                                    <input type="radio" name="carfool" value = "1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고는 싶은데 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <div class="custom-control custom-radio  disabled">
                                    <input type="radio" name="carfool" value = "2"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고 싶어요.</label>
                                </div>
                                <div class="custom-control custom-radio  disabled">
                                    <input type="radio" name="carfool" value = "3"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 갈게요.</label>
                                </div> 
                                <div class="custom-control custom-radio  disabled">
                                    <input type="radio" name="carfool" value = "4" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 가고는 싶은데, 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <%
							}
							else if(registration.getCarfool()==1){
                                %>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "0"  class="custom-control-input" >
                                    <label class="custom-control-label" for="jb-radio-1">네! 차량 지원 할게요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "1" class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고는 싶은데 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "2"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고 싶어요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "3"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 갈게요.</label>
                                </div> 
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "4" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 가고는 싶은데, 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <%
							}
							else if(registration.getCarfool()==2){
								
							
                                %>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "0"  class="custom-control-input" >
                                    <label class="custom-control-label" for="jb-radio-1">네! 차량 지원 할게요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "1" class="custom-control-input" >
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고는 싶은데 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "2"  class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고 싶어요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "3"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 갈게요.</label>
                                </div> 
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "4" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 가고는 싶은데, 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <%
							}
							else if(registration.getCarfool()==3){
                                %>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "0"  class="custom-control-input" >
                                    <label class="custom-control-label" for="jb-radio-1">네! 차량 지원 할게요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고는 싶은데 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "2"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고 싶어요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "3"  class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 갈게요.</label>
                                </div> 
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "4" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 가고는 싶은데, 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <%
							}
							else if(registration.getCarfool()==4){
                                %>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "0"  class="custom-control-input" >
                                    <label class="custom-control-label" for="jb-radio-1">네! 차량 지원 할게요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고는 싶은데 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "2"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고 싶어요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfool" value = "3"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 갈게요.</label>
                                </div> 
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "4" class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 가고는 싶은데, 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <%
							}
                                %>
							<br>
                            <!-- 식사내용 발런티어에서 받아와서 보여주기  -->
                            <p style="font-size:15px;"><strong>식사 하시나요?</strong></p>
                            						<%
							if(registration.getEatWhether()==0){
						%>
                           
                                 <div class="custom-control custom-radio">
                                    <input type="radio" name="eatWhether" value="0" class="custom-control-input"  checked>
                                    <label class="custom-control-label" for="jb-radio-1">네.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="eatWhether" value="1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="eatWhether" value="2" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">먹을 수도 있고 안 먹을 수도 있고</label>
                                </div>
                                <%
							}
							else if(registration.getEatWhether()==1){
                                %>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="eatWhether" value="0" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">네.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="eatWhether" value="1" class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-2">아니요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="eatWhether" value="2" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">먹을 수도 있고 안 먹을 수도 있고</label>
                                </div>
                                <%
							}
							else if(registration.getEatWhether()==2){
								
							
                                %>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="eatWhether" value="0" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">네.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="eatWhether" value="1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="eatWhether" value="2" class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-2">먹을 수도 있고 안 먹을 수도 있고</label>
                                </div>
                                <%
							}
                                %>
                            <br>
                            <p style="font-size:15px;"><strong>카풀비</strong></p>
                                
                            <%
                            if(registration.getCarfoolee()==0){
							%>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfoolee" value="0" class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-1">차 안 얻어타요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfoolee" value="1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">편도만 타요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfoolee" value="2" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">왕복으로 다 타요.</label>
                                </div>
                                <%
							}
							else if(registration.getCarfoolee()==1){
                                %>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfoolee" value="0" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">차 안 얻어타요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfoolee" value="1" class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-2">편도만 타요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfoolee" value="2" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">왕복으로 다 타요.</label>
                                </div>
                                <%
							}
							else if(registration.getCarfoolee()==2){
								
							
                                %>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfoolee" value="0" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">차 안 얻어타요.</label>
                                </div>
                                <div class="custom-control custom-radio disabled">
                                    <input type="radio" name="carfoolee" value="1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">편도만 타요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfoolee" value="2" class="custom-control-input" checked>
                                    <label class="custom-control-label" for="jb-radio-2">왕복으로 다 타요.</label>
                                </div>
                                <%
							}
                                %>
                            
							<br>
                  
                </form>
            </div>
	</div>
		
		
	<!-- -->
		<%
				}
				
			else {
		%>
<!-- 	<div class = "container">
		<div class = "row">
		
			<form method = "post" action="writeAction.jsp">
				<table class = "table table-striped"style= "text-align : center; border: 1px solid #dddddd">
					
					<thead>gymz84a9BHFQ1!
					
						<tr>
							<th colspan="2" style ="background-color: #eeeeee; text-align: center; "> 게시판 글 쓰기 양식 </th>
							
						</tr>
						
					</thead>
					
					<tbody>
						<tr>
							<td><input type ="text" class="form-control" placeholder="글 제목" name = "bulletinTitle" maxlength ="50" ></input></td>
						</tr>
						
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name = "bulletinContent" maxlength ="2048" style= "height: 350px; "> </textarea></td>
						</tr>
				
					</tbody>
					
					
				</table>
				
				<input type ="submit" class="btn btn-primary pull-right" value ="글쓰기">
			</form>
		</div>
	</div>
		
		 -->
		
		<%
			
				}
				
		%>
</div>
	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>