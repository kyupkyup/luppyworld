<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import= "user.User" %>
<%@ page import= "volunteer.Volunteer" %>
    <%@ page import= "volunteer.VolunteerDAO" %>


    
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_style.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_register_style.css">


<meta name="viewport" content="width=device-width" , initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">
<title>러피월드: &nbsp;봉사신청</title>

</head>
<body>
	<%
	User user1 = null;
		String userID = null;
		int userMemberShip = -1;
		
	if(session.getAttribute("user") != null){
		user1 = (User)session.getAttribute("user");
		userID = user1.getUserID();
		userMemberShip = user1.getUserMemberShip();
	}
		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'mobile_login.jsp'");
			script.println("</script>");
		}
		
		if(userMemberShip == 5){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('현재 가입대기 중이니 가입인사를 작성하고 등업을 기다리세요.')");
			script.println("location.href = 'mobile_main.jsp'");
			script.println("</script>");
		}
		
		int volunteerID = 0;
		if(request.getParameter("volunteerID") != null)
		{
			volunteerID = Integer.parseInt(request.getParameter("volunteerID"));
		}
		
		VolunteerDAO volunteerDAO = new VolunteerDAO();
		Volunteer volunteer = volunteerDAO.getVolunteer(volunteerID);
	%>
	<div class="container-all">
		<nav class="navbar navbar-default navbar-color">
            <!-- 기본 네비게이션 바 - 아이콘 형태 항상 상위에 고정-->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed color" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
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
	<!-- 비로그인 상태에서 게시판을 볼 경우 -->
		<%
			if(userID == null){
					
					
		%>
				
	<!-- 관리자계정이 아닐 경우 봉사신청 하도록 -->
		<%
			}
			
			else if(!userID.equals("admin")){
					
		%>
		<!-- 관리자 계정 게시판 열람 경우 - 게시판 삭제 권한, 모든 게시판 열람 권한 추가 필요 -->
	<div class = "container-main">
	
	    <p class="title"><%= volunteer.getVolunteerTitle() %></p>
	    <p class="content"><pre><%= volunteer.getVolunteerContent() %></pre></p>
	    
            <div class = "row">

                <form method = "post" action="mobile_volunteerRegisterAction.jsp?volunteerID=<%=volunteerID%>">

            <!--             현재 신청하려는 봉사 제목, 내용, 주의사항 보여주기 
                            <p style="font-size:15px;"><strong>뭐 하실래요?</strong></p>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="workPlace" value = "0"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">견사팀</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="workPlace" value = "1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">구역팀</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="workPlace" value = "2" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">벽돌팀</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="workPlace" value = "3" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">지원팀</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="workPlace" value = "4" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">기타</label>
                                </div>
                                

							<br>
							
							
                            <p><strong>조금 겁나는 덩치의 강아지가 있다면?</strong></p>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="scary" value = "0"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">소형견</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="scary" value = "1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">중형견</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="scary" value = "2"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">대형견</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="scary" value = "3"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">겁나지 않아요.</label>
                                </div>

							<br>
														
                            <p><strong>같이 카풀 하실래요?</strong></p>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name=carfool value = "0"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">네! 차량지원할게요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀 타고는 싶은데, 차량이 부족하다면 지원할게요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "2"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">네! 카풀타고 싶어요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "3"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로갈게요!</label>
                                </div>       
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfool" value = "4"  class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요. 따로 가고는 싶은데, 차량이 부족하다면 지원할게요.</label>
                                </div>

							<br>
							
                            식사내용 발런티어에서 받아와서 보여주기 
                            <p><strong>식사 하시나요?</strong></p>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="eatWhether" value="0" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">네.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="eatWhether" value="1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">아니요.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="eatWhether" value="2" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-3">먹을 수도 있고 안 먹을 수도 있고</label>
                                </div> 
							<br>
                                <p><strong>카풀비</strong></p>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfoolee" value="0" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-1">차량 지원자 혹은 따로 오시는 분.</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfoolee" value="1" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">편도만 타요. :1000원</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" name="carfoolee" value="2" class="custom-control-input">
                                    <label class="custom-control-label" for="jb-radio-2">왕복으로 다 타요.:2000원</label>
                                </div> -->
                                
                                <div>
                                	<input type = "text" class = "form-control carfool_region" placeholder = "카풀 지역(구랑 동만 ex.중구 동인동)" name = "region" maxlength = "20">
                                </div>
x
  								 <div>
  									<input type = "text" class = "form-control one_say" placeholder = "한 마디 다짐" name = "oneSay" maxlength = "30">
                                
                                </div>
                    <input type ="submit" class="btn btn-primary pull-right" value ="봉사 신청하기" onClick="window.open('<%=volunteer.getSurveyURL()%>')">
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
	<script src="/js/bootstrap.js"></script>

</body>
</html>