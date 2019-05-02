<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import = "volunteer.VolunteerDAO" %>
    <%@ page import = "volunteer.Volunteer" %>
    <%@ page import = "java.util.ArrayList" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
    <%@ page import = "java.time.LocalDate"%>
    <%@ page import = "java.time.LocalTime"%>
    <%@ page import = "java.time.Period"%>
    <%@ page import = "java.time.format.DateTimeFormatter"%>
    
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<meta name = "viewport" content = "width=1000px", initial-scale = "1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link href="css/style.css" rel="stylesheet">
<link href="css/list_style.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">
<title>러피월드: &nbsp;봉사 게시판</title>

<!--  전체 스타일 만드는 부분 -->
<style type = "text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none;
	}
</style>

</head>
<body>
	<%
	User user1 = null;
		String userID = null;
		
		
	if(session.getAttribute("user") != null){
		user1 = (User)session.getAttribute("user");
		userID = user1.getUserID();
		

	}
	%>
<div class="container-all">
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

		<%

			int pageNumber = 1;
			if(request.getParameter("pageNumber") != null){
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
				
		
			}
		/* 비로그인 상태에서 게시판을 볼 경우 -*/
				if(userID == null){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('로그인을 하세요.')");
						script.println("location.href = 'login.jsp'");
						script.println("</script>");
				}
		

		
		
			
			else if(userID.equals("admin")){
				
				
			
					
		%>
		<!-- 관리자 계정 게시판 열람 경우 - 게시판 삭제 권한, 모든 게시판 열람 권한 추가 필요 -->
	<div class = "container">
		<div class = "row">
			<table class = "table table-hover">
				
				<thead>
					<tr class="table-head">
						<th style ="text-align: center; "> 제목 </th>
						<th style ="text-align: center; "> 봉사 날짜 </th>
						<th style ="text-align: center; "> 봉사 장소 </th>
						<th style ="text-align: center; "> 마감 시간 </th>
						
					</tr>
					
				</thead>
				
				<tbody>
				<%
					VolunteerDAO volunteerDAO = new VolunteerDAO();
					ArrayList<Volunteer> list = volunteerDAO.getList(pageNumber);
					for(int i = 0; i< list.size(); i++){
						
						Volunteer volunteer = list.get(i);
						String dueDate = volunteer.getDueDate();
						int dueHour = Integer.parseInt(volunteer.getDueHour());
						int dueMinute = Integer.parseInt(volunteer.getDueMinute());
						LocalDate targetDate = LocalDate.parse(dueDate, DateTimeFormatter.BASIC_ISO_DATE);
						LocalDate curDate = LocalDate.now();
						LocalTime curTime = LocalTime.now();
						int curHour = curTime.getHour();
						int curMinute = curTime.getMinute();
						
						Period period = curDate.until(targetDate);
						int periodDay = period.getDays();
						int periodHour = 0;
						int periodMinute = 0;
						
						if(dueHour-curHour>=0){
							periodHour = dueHour-curHour;
						}
						else if(dueHour-curHour<0){
							periodHour = dueHour-curHour + 24;
							periodDay = periodDay - 1;
						}
						
						if(dueMinute - curMinute>=0){
							periodMinute = dueMinute - curMinute;
						}
						else if(dueMinute - curMinute<0){
							periodMinute = dueMinute - curMinute + 60;
							periodHour = periodHour - 1;
						}
					
					
					
				%>
				
					<tr class="table-body">
						<td><a href="volunteerBulletinView.jsp?volunteerID=<%=list.get(i).getVolunteerID()%>"> <%=list.get(i).getVolunteerTitle() %></a></td>
						<td> <%= list.get(i).getVolunteerDate() %></td>
						<td><%= list.get(i).getVolunteerPlace() %></td>
					
					<%

					if(periodDay>0){
					
						%>
						<td><%=periodDay%>일
						<%
						if(true){
							
							%>
								<%=periodHour%>시간
							<%
							if(true){
								%>
									<%=periodMinute%>분</td>
							<%
							}
						}
							
						
						
					}else if(periodDay==0){
					
						if(curDate.isBefore(targetDate)){
							%>
								<td><%=periodHour%>시간 <%=periodMinute %>분
							<%
						
						}
						else{
							
							if(dueHour-curHour>0){
								%>
									<td><%=periodHour%>시간
								<%
								if(true){
									%>
										<%=periodMinute%>분</td>
									<%
								}
							}
							else if(dueHour-curHour==0){
								
								if(dueMinute-curMinute>0){
									%>
										<td><%=periodMinute%>분</td>
									<%
								}
								
								else if(dueMinute - curMinute<=0){
									%>
									<td>마감</td>
									<% 
								}
							}
						
						
							else if(dueHour-curHour<0){
								%>
									<td>마감</td>
								<%
							
							}
							
						}
					}
					
					else if(periodDay<0){
						%>
						<td>마감</td>
						<% 
					}
					%>
					
					
	
						
					</tr>
					<%
					}
					%>
				</tbody>
			
			</table>
			
						
			<%
				if(volunteerDAO.nextPage(pageNumber + 1)){
				
			%>
			<a href = "volunteerBulletin.jsp?pageNumber=<%= pageNumber +1 %>" class= "btn btn-success btn-arrow-left">이전 페이지 보기</a>
			
			<%
				}
			%>
			
			<%
				if(pageNumber != 1){
			%>
			<a href = "volunteerBulletin.jsp?pageNumber=<%= pageNumber-1 %>" class= "btn btn-success btn-arrow-left">다음 페이지 보기</a>
			
			<%
				}
			%>

			
				<a href= "volunteerWrite.jsp" class="btn btn-primary pull-right">봉사 공지하기</a>
		</div>
	</div>
		
		
	
	<!-- 로그인 상태에서 게시판을 볼 경우 -->
		<%
				}
				
			else {
					
			
		%>
	<div class = "container">
		<div class = "row">
			<table class = "table table-hover">
				
				<thead>
					<tr class="table-head">
						<th style ="text-align: center; "> 제목 </th>
						<th style ="text-align: center; "> 봉사 날짜 </th>
						<th style ="text-align: center; "> 봉사 장소 </th>
						<th style ="text-align: center; "> 마감 시간 </th>
						
						
					</tr>
					
				</thead>
				
				<tbody>
				<%
					VolunteerDAO volunteerDAO = new VolunteerDAO();
					ArrayList<Volunteer> list = volunteerDAO.getList(pageNumber);
					for(int i = 0; i< list.size(); i++){
						Volunteer volunteer = list.get(i);
						String dueDate = volunteer.getDueDate();
						int dueHour = Integer.parseInt(volunteer.getDueHour());
						int dueMinute = Integer.parseInt(volunteer.getDueMinute());
						LocalDate targetDate = LocalDate.parse(dueDate, DateTimeFormatter.BASIC_ISO_DATE);
						LocalDate curDate = LocalDate.now();
						LocalTime curTime = LocalTime.now();
						int curHour = curTime.getHour();
						int curMinute = curTime.getMinute();
						
						Period period = curDate.until(targetDate);
						int periodDay = period.getDays();
						int periodHour = 0;
						int periodMinute = 0;
						
						if(dueHour-curHour>=0){
							periodHour = dueHour-curHour;
						}
						else if(dueHour-curHour<0){
							periodHour = dueHour-curHour + 24;
							periodDay = periodDay - 1;
						}
						
						if(dueMinute - curMinute>=0){
							periodMinute = dueMinute - curMinute;
						}
						else if(dueMinute - curMinute<0){
							periodMinute = dueMinute - curMinute + 60;
							periodHour = periodHour - 1;
						}
				%>
				
					<tr class="table-body">
						<td><a href="volunteerBulletinView.jsp?volunteerID=<%=list.get(i).getVolunteerID()%>"> <%=list.get(i).getVolunteerTitle() %></a></td>
						<td> <%= list.get(i).getVolunteerDate() %></td>
						<td><%= list.get(i).getVolunteerPlace() %></td>
					
					<%

					if(periodDay>0){
					
						%>
						<td><%=periodDay%>일
						<%
						if(true){
							
							%>
								<%=periodHour%>시간
							<%
							if(true){
								%>
									<%=periodMinute%>분</td>
							<%
							}
						}
							
						
						
					}else if(periodDay==0){
					
						if(curDate.isBefore(targetDate)){
							%>
								<td><%=periodHour%>시간 <%=periodMinute %>분
							<%
						
						}
						else{
							
							if(dueHour-curHour>0){
								%>
									<td><%=periodHour%>시간
								<%
								if(true){
									%>
										<%=periodMinute%>분</td>
									<%
								}
							}
							else if(dueHour-curHour==0){
								
								if(dueMinute-curMinute>0){
									%>
										<td><%=periodMinute%>분</td>
									<%
								}
								
								else if(dueMinute - curMinute<=0){
									%>
									<td>마감</td>
									<% 
								}
							}
						
						
							else if(dueHour-curHour<0){
								%>
									<td>마감</td>
								<%
							
							}
							
						}
					}
					
					else if(periodDay<0){
						%>
						<td>마감</td>
						<% 
					}
					%>
					
					
	
						
					</tr>
					<%
					}
					%>
				</tbody>
				
			</table>
			
						<%
				if(volunteerDAO.nextPage(pageNumber + 1)){
				
			%>
			<a href = "volunteerBulletin.jsp?pageNumber=<%= pageNumber +1 %>" class= "btn btn-success btn-arrow-left">이전 페이지 보기</a>
			
			<%
				}
			%>
			
			<%
				if(pageNumber != 1){
			%>
			<a href = "volunteerBulletin.jsp?pageNumber=<%= pageNumber-1 %>" class= "btn btn-success btn-arrow-left">다음 페이지 보기</a>
			
			<%
				}
			%>
			

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