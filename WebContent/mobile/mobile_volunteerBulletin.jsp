<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import = "volunteer.VolunteerDAO" %>
    <%@ page import = "volunteer.Volunteer" %>
    <%@ page import = "java.util.ArrayList" %>
    <%@ page import= "user.User" %>
    <%@ page import = "java.time.LocalDate"%>
    <%@ page import = "java.time.LocalTime"%>
    <%@ page import = "java.time.Period"%>
    <%@ page import = "java.time.format.DateTimeFormatter"%>
    
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_style.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_volunteerBulletin_style.css">


<meta name="viewport" content="width=device-width" , initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>러피월드: &nbsp;봉사 게시판</title>

<!--  전체 스타일 만드는 부분 -->


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
		<nav class="navbar navbar-default navbar-color">
            <!-- 기본 네비게이션 바 - 아이콘 형태 항상 상위에 고정-->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed color"  data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand logo" href="mobile_main.jsp"></a> <!--  브랜드 로고 -->
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                	<ul class = "nav navbar-nav">
						<li><a href="mobile_bulletinNotice.jsp" class="text-color">공지사항</a></li>
						<li><a href="mobile_bulletinIntroduction.jsp" class="text-color">가입인사</a></li>
						<li><a href="mobile_volunteerBulletin.jsp" class="text-color">봉사신청</a></li>
                <%
				if(userID == null){		
			%>
                <!-- 로그인이 안 되어있는 경우 -->

                     	<li><a href="mobile_login.jsp" class="text-color">로그인</a></li>
                <%
					}
				else if(userID.equals("admin"))
				{
				%>
                <!-- 로그인이 관리자 계정으로 된 경우 -->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span> </a>
                        <ul class="dropdown-menu">
                            <li class=""><a href="mobile_adminMember.jsp" class="text-color">회원관리</a></li> 
                            <li class=""><a href="mobile_logoutAction.jsp" class="text-color">로그아웃</a></li>
                        </ul>
                    </li>
                <%
				}
				else {
				%>
                <!-- 로그인이 되어 있는 경우  -->
                    <li><a href="mobile_userInfo.jsp" class="text-color">내 계정</a></li>
                <%
				}
				%>
				</ul>
            </div>
        </nav>
        <br>
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
						script.println("location.href = 'mobile_login.jsp'");
						script.println("</script>");
				}
		

		
		
			
			else if(userID.equals("admin")){
				
				
			
					
		%>
		<!-- 관리자 계정 게시판 열람 경우 - 게시판 삭제 권한, 모든 게시판 열람 권한 추가 필요 -->
	<div class = "container-main">
		<div class = "row">
			<table class = "table table-hover list">

				
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
						<td colspan='3' class="title-line"><a href="mobile_volunteerBulletinView.jsp?volunteerID=<%=list.get(i).getVolunteerID()%>"> <%=list.get(i).getVolunteerTitle() %></a></td>
					</tr>
					<tr>	
						<td class="date-line"> <%= list.get(i).getVolunteerDate() %></td>
						
						<td class="place-line"><%= list.get(i).getVolunteerPlace() %></td>
					
					<%

					if(periodDay>0){
					
						%>
						<td class="dead-line"><%=periodDay%>일
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
								<td class="dead-line"><%=periodHour%>시간 <%=periodMinute %>분
							<%
						
						}
						else{
							
							if(dueHour-curHour>0){
								%>
									<td class="dead-line"><%=periodHour%>시간
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
										<td class="dead-line"><%=periodMinute%>분</td>
									<%
								}
								
								else if(dueMinute - curMinute<=0){
									%>
									<td class="dead-line">마감</td>
									<% 
								}
							}
						
						
							else if(dueHour-curHour<0){
								%>
									<td class="dead-line">마감</td>
								<%
							
							}
							
						}
					}
					
					else if(periodDay<0){
						%>
						<td class="dead-line">마감</td>
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
			<a href = "mobile_volunteerBulletin.jsp?pageNumber=<%= pageNumber +1 %>" class= "btn btn-success btn-arrow-left">이전 페이지 보기</a>
			
			<%
				}
			%>
			
			<%
				if(pageNumber != 1){
			%>
			<a href = "mobile_volunteerBulletin.jsp?pageNumber=<%= pageNumber-1 %>" class= "btn btn-success btn-arrow-left">다음 페이지 보기</a>
			
			<%
				}
			%>

			
				<a href= "mobile_volunteerWrite.jsp" class="btn btn-primary pull-right">봉사 공지하기</a>
		</div>
	</div>
		
		
	
	<!-- 로그인 상태에서 게시판을 볼 경우 -->
		<%
				}
				
			else {
					
			
		%>
	<div class = "container-main">
		<div class = "row">
			<table class = "table table-hover list">
				

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
						<td colspan='3'><a href="mobile_volunteerBulletinView.jsp?volunteerID=<%=list.get(i).getVolunteerID()%>"> <%=list.get(i).getVolunteerTitle() %></a></td>
					</tr>	
					<tr>	
						<td> <%= list.get(i).getVolunteerDate() %></td>
						<td><%= list.get(i).getVolunteerPlace() %></td>
					
					<%

					if(periodDay>0){
					
						%>
						<td class="dead-line"><%=periodDay%>일
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
								<td class="dead-line"><%=periodHour%>시간 <%=periodMinute %>분
							<%
						
						}
						else{
							
							if(dueHour-curHour>0){
								%>
									<td class="dead-line"><%=periodHour%>시간
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
										<td class="dead-line"><%=periodMinute%>분</td>
									<%
								}
								
								else if(dueMinute - curMinute<=0){
									%>
									<td class="dead-line">마감</td>
									<% 
								}
							}
						
						
							else if(dueHour-curHour<0){
								%>
									<td class="dead-line">마감</td>
								<%
							
							}
							
						}
					}
					
					else if(periodDay<0){
						%>
						<td class="dead-line">마감</td>
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
			<a href = "mobile_volunteerBulletin.jsp?pageNumber=<%= pageNumber +1 %>" class= "btn btn-success btn-arrow-left">이전 페이지 보기</a>
			
			<%
				}
			%>
			
			<%
				if(pageNumber != 1){
			%>
			<a href = "mobile_volunteerBulletin.jsp?pageNumber=<%= pageNumber-1 %>" class= "btn btn-success btn-arrow-left">다음 페이지 보기</a>
			
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
	<script src="/js/bootstrap.js"></script>

</body>
</html>