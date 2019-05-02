<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>

<!DOCTYPE html>
<html>

<script type="text/javascript" src="js/instafeed.min.js"></script> <!-- js 파일 로드 --> 
<script type="text/javascript">

        var userFeed = new Instafeed({
            get:'user',
            userId: 8105780839,
            sortBy: "most-recent",
            limit: 8,
            template:'<div class="insta-box"><a href="{{link}}" target="_blank"><img class="insta-image" src="{{image}}" alt="썸네일"/></a></div>',
            target: "instaPics",
            accessToken: '8105780839.725437d.2e2b25de80de436da1b8367edbf0dce5',
            resolution:"low_resolution"
        });1
        
        userFeed.run();


         
        
</script>



<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=1000px" , initial-scale="1">
    <link href="css/insta_style.css" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/main_style.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">
    <link rel="shortcut icon" href="/pavicon.png">
    <title>러피월드: &nbsp;즐거운 봉사는 유기견을 춤추게한다.</title>

</head>

<body>


    <%
    User user =null;
    	String userID = null;
    	
    	
    if(session.getAttribute("user") != null){
    	user = (User)session.getAttribute("user");
    	userID = user.getUserID();
    	
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

        <!-- 점보트론 : 웹사이트 소개  -->
        
        <div class="container-main">
            
           <!-- <div class="container-banner">
                <div class="banner"></div>

            </div>-->
         
            <img src="css/images/main_banner_1000.500px-02.png" alt="" height="auto" width="100%">
            
            <a class="button-1" href="volunteerBulletin.jsp">
            	<img src="css/images/volunteer_1000.220px-05.png" height="auto" width="100%">
            </a>
            	
            
           
            
            <div class="boxes-container">                 
                <img class="boxes item-1" id="boxes_item1" src="css/images/box1.png" height="auto" width="33%" alt="">
                <img class="boxes item-2" id="boxes_item2" src="css/images/box2.png" height="auto" width="33%" alt="">
                <img class="boxes item-3" id="boxes_item3" src="css/images/box3.png" height="auto" width="33%" alt="">
            </div>
           
            <div class="boxes-explain-container">
                <img class="boxes-explain" id="boxes-explain1" src="css/images/box_exp1.png" height="auto" width="99%" alt="">
                <img class="boxes-explain" id="boxes-explain2" src="css/images/box_exp2.png" height="auto" width="99%" alt="">
                <img class="boxes-explain" id="boxes-explain3" src="css/images/box_exp3.png" height="auto" width="99%" alt="">
            </div> 

                
            <div id="instaPics"></div>
                
            <div class="footer">
            	<div class="information-footer"></div>
            	<div class="SNS">
            		<div class="instagram"></div>
            		<div class="blog"></div>
            		<div class="kakaoTalk"></div>
            	</div>
            </div>
            
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.js"></script>

</body>

<script type="text/javascript">

var boxes_item1= document.getElementById("boxes_item1");
var boxes_item2= document.getElementById("boxes_item2");
var boxes_item3= document.getElementById("boxes_item3");

var boxes_explain_item1= document.getElementById("boxes-explain1");
var boxes_explain_item2= document.getElementById("boxes-explain2");
var boxes_explain_item3= document.getElementById("boxes-explain3");

boxes_explain_item1.style.display='inline-block';
boxes_explain_item2.style.display='none';
boxes_explain_item3.style.display='none';

function boxes_listener(event){
	
	
	switch(event.target.id){
		case "boxes_item1":
			boxes_explain_item1.style.display='inline-block';
			boxes_explain_item2.style.display='none';
			boxes_explain_item3.style.display='none';
			break;
		case "boxes_item2":
			boxes_explain_item1.style.display='none';
			boxes_explain_item2.style.display='inline-block';
			boxes_explain_item3.style.display='none';

			break;
		case "boxes_item3":
			boxes_explain_item1.style.display='none';
			boxes_explain_item2.style.display='none';
			boxes_explain_item3.style.display='inline-block';
			break;
	
				
	}
	
}
boxes_item1.addEventListener('click', boxes_listener);
boxes_item2.addEventListener('click', boxes_listener);
boxes_item3.addEventListener('click', boxes_listener);



	 

</script>

</html>
