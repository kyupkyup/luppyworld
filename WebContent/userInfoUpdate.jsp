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
<link href="css/join_style.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">
<script language="javascript">

function goPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
}


function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.form.userAddress.value = roadFullAddr;
	document.form.userAddressNum.value = zipNo;
	document.form.admCd.value = admCd;
	document.form.rnMgtSn.value = rnMgtSn;
	document.form.bdMgtSn.value = bdMgtSn;
	document.form.detBdNmList.value = detBdNmList;
	/** 2017년 2월 추가제공 **/
	document.form.bdNm.value = bdNm;
	document.form.bdKdcd.value = bdKdcd;
	document.form.siNm.value = siNm;
	document.form.sggNm.value = sggNm;
	document.form.emdNm.value = emdNm;
	document.form.liNm.value = liNm;
	document.form.rn.value = rn;
	document.form.udrtYn.value = udrtYn;
	document.form.buldMnnm.value = buldMnnm;
	document.form.buldSlno.value = buldSlno;
	document.form.mtYn.value = mtYn;
	document.form.lnbrMnnm.value = lnbrMnnm;
	document.form.lnbrSlno.value = lnbrSlno;
	/** 2017년 3월 추가제공 **/
	document.form.emdNo.value = emdNo;
	
		
}
</script>
<title>러피월드: &nbsp;개인정보 수정</title>

</head>


<body>
	<%
	User user = null;
		String userID = null;
		
		
	if(session.getAttribute("user") != null){
		user = (User)session.getAttribute("user");
		userID = user.getUserID();
		
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
			
			else {
					
		%>
		<!-- 관리자 계정 게시판 열람 경우 - 게시판 삭제 권한, 모든 게시판 열람 권한 추가 필요 -->
	<div class = "container-join">  <!--  회원가입 정보 입력 창 -->
		<div class = "col-lg-4"></div>
		<div class = "col-lg-4"></div>
		<div class = "jumbotron" style= "padding-top: 20px">
			<form method = "post" action="userInfoUpdateAction.jsp?userID=<%=user.getUserID()%>" id = "form" name = "form" enctype="multipart/form-data">
				<h3 style = "text-align: center;">개인정보 수정</h3>
					<div class="form-group userID">
						<p class="info"><%=user.getUserID()%></p>
					</div>
											
					<div class="form-group userPassword">
						<input type = "password" class = "form-control" placeholder = "비밀번호" name = "userPassword" maxlength = "20">	
					</div>
								
					<div class="form-group userName">
						<input type = "text" class = "form-control" value = "<%=user.getUserName() %>" name = "userName" maxlength = "10">		
						</div>
						
					<div class="form-group userEmail">			
						<input type = "text" class = "form-control" value = "<%=user.getUserEmail() %>" name = "userEmail" maxlength = "100">
					</div>
					
					<div class="address-holder">
						<input type="button" onClick="goPopup();" value="주소찾기" class="btn btn-primary form-control address-button">
								<div id="list"></div>
								<div id="callBackDiv">
								
						<table>
							<tr><td><input type="text" id="userAddressNum"  value = "<%=user.getUserAddressNum() %>" name="userAddressNum"  class="form-control address-num-holder"/></td></tr>
							<tr><td><input type="text" id="userAddress"   name="userAddress" value="<%=user.getUserAddress() %>"  class="form-control address-full-holder"/></td></tr>
							
						</table>
						</div>
					</div>
					
					<div class="switch-gender"> 
					    <div class="switch">
					      <input type="radio" class="switch-input" name="userGender" value="male" id="week" checked>
					      <label for="week" class="switch-label switch-label-off">Male</label>
					      <input type="radio" class="switch-input" name="userGender" value="female" id="month">
					      <label for="month" class="switch-label switch-label-on">Female</label>
					      <span class="switch-selection"></span>
					    </div>
					</div>		
					
					<div class="form-group userJob">			
						<input type = "text" class = "form-control" value = "<%=user.getUserJob() %>" name = "userJob" maxlength = "20">
					</div>
					<div class="form-group userAge">			
						<input type = "text" class = "form-control"  value = "<%=user.getUserAge() %>" name = "userAge" maxlength = "20">
					</div>
					<div class="form-group userBirthday">			
						<input type = "text" class = "form-control"  value = "<%=user.getUserBirthday() %>" name = "userBirthday" maxlength = "20">
					</div>
					
					<div class="form-group  firstRoute"><p style="text-align:left;width:100px;font-size:15px;display:block; ">가입경로: </p>						
								<select class="select-one" name = "firstRoute" data-width="fit" style="width:200px; float:left;">	
									<option value = 1>소모임</option>
									<option value = 2>인스타그램</option>
									<option value = 3>검색</option>
									<option value = 4>봉사현장</option>
									<option value = 5>소개</option>
									<option value = 6>기타</option>
								</select>
					</div>
					<br>
					<div class="form-group  userPhoneNumber">			
						<input type = "text" class = "form-control"  value = "<%=user.getUserPhoneNumber() %>" name = "userPhoneNumber" maxlength = "20">
					</div>
					
					<div class = "form-group userProfilePhoto">프로필 사진 : <input type="file" name="file" value="<%=user.getFileRealName()%>"></div>
			
					
					<div class="form-group button">
						<input type = "submit" class ="btn btn-primary form-control" value = "수정">
					</div>
					
			</form>
		</div>
		
		
	</div>
</div>	
		
		
	<!-- 로그인 상태에서 글쓰기를 할 경우 -->
		<%
				}
				
			
					
			
		%>
		
		
		
	
</div>
	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

				
</body>
</html>