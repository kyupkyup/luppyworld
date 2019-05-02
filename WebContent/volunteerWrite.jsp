<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
    
    
<!DOCTYPE html>
<html>

<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<meta name = "viewport" content = "width=1000px", initial-scale = "1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
 <link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">

<title>러피월드: &nbsp;봉사 공지</title>

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
		
			<form method = "post" action="volunteerWriteAction.jsp">
				<table class = "table table-striped"style= "text-align : center; border: 1px solid #dddddd">
					
					<thead>
						<tr>
							<th colspan="2" style ="background-color: #eeeeee; text-align: center; "> 봉사 공지하기 </th>
							
						</tr>
						
					</thead>
					
					<tbody>
						<tr>
							<td><input type ="text" class="form-control" placeholder="봉사 제목" name = "volunteerTitle" maxlength ="50" ></input></td>
						</tr>
						
						<tr>
							<td><input type ="text" class="form-control" placeholder="봉사 일자" name = "volunteerDate" maxlength ="50" ></input></td>
						</tr>
						
						<tr>
							<td><input type ="text" class="form-control" placeholder="봉사 장소" name = "volunteerPlace" maxlength ="50" ></input></td>
						</tr>
						
						<tr>
							<td><textarea class="form-control" placeholder="봉사 내용" name = "volunteerContent" maxlength ="20000" style= "height: 350px; "> </textarea></td>
						</tr>
				
						<tr>
							<td><input type ="text" class="form-control" placeholder="식사 내용" name = "foodName" maxlength ="50" ></input></td>
						</tr>
						
						<tr>
							<td><input type ="text" class="form-control" placeholder="식사 가격" name = "foodPrice" maxlength ="50" ></input></td>
						</tr>
						<tr>
							<td>
								<p>마감날짜 입력 : </p>
								<input type="text" id="testDatepicker" name="dueDate"><input type="text" name="dueHour">시<input type="text" name="dueMinute">분
							</td>
						</tr>
						<tr>
							<td><input type ="text" class="form-control" placeholder="설문 URL" name = "surveyURL" maxlength ="500" ></input></td>
						</tr>
						
					</tbody>
					
				</table>
					
					
				<input type ="submit" class="btn btn-primary pull-right" value ="공지 하기">
			</form>
		</div>
	</div>
		
		
	<!-- 로그인 상태에서 글쓰기를 할 경우 - 봉사 공지의 경우 로그인상태가 의미가 없음 -->
		<%
				}
				
			else {
					
			
		%>
<!-- 	<div class = "container">
		<div class = "row">
		
			<form method = "post" action="writeAction.jsp">
				<table class = "table table-striped"style= "text-align : center; border: 1px solid #dddddd">
					
					<thead>
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
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 
	
<script>
$(function() {
    $( "#testDatepicker" ).datepicker({
        showButtonPanel: true, 
        currentText: '오늘 날짜', 
        closeText: '닫기', 
        dateFormat: "yymmdd"
    });
});
</script>
</body>
</html>