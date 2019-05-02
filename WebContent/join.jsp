<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<meta name = "viewport" content = "width=1000px", initial-scale = "1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link href="css/join_style.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
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
/* 	document.form.admCd.value = admCd;
	document.form.rnMgtSn.value = rnMgtSn;
	document.form.bdMgtSn.value = bdMgtSn;
	document.form.detBdNmList.value = detBdNmList;
	/** 2017년 2월 추가제공 **/
/* 	document.form.bdNm.value = bdNm;
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
	document.form.lnbrSlno.value = lnbrSlno; */
 	/** 2017년 3월 추가제공 **/
	/* document.form.emdNo.value = emdNo;  */
	
		
}
</script>

<title>러피월드: &nbsp;회원가입</title>

</head>
<body>
<div class="container-all">
	<nav class = "navbar navbar-default">	<!-- 기본 네비게이션 바 - 아이콘 형태 항상 상위에 고정-->
		<div class ="navbar-header">
			<button type="button" class = "navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded = "false">
				
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
				
				</button>
				<a class = "navbar-brand" href = "main.jsp"></a>  <!--  브랜드 로고 -->
		</div>
		<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
		<!--	<ul class = "nav navbar-nav">
			
			
			</ul>
			-->
			<ul class = "nav navbar-nav navbar-right">
			
			
				<li class="notice-button"><a href="bulletinNotice.jsp"></a></li>
                <li class="introduction-button"><a href="bulletinIntroduction.jsp"></a></li>
                <li class="volunteer-button"><a href="volunteerBulletin.jsp"></a></li>
				<li class="login-button"><a href = "login.jsp"></a></li>
			</ul>
			
		</div>
	</nav>
	
	<div class = "container-join">  <!--  회원가입 정보 입력 창 -->
		<div class = "col-lg-4"></div>
		<div class = "col-lg-4"></div>
		<div class = "jumbotron" style= "padding-top: 20px">
			<form method = "post" action="joinAction.jsp" id = "form" name = "form" enctype="multipart/form-data">
				<h3 style = "text-align: center;">회원 가입</h3>
					<div class="form-group userID">
						<input type = "text" class = "form-control" placeholder = "아이디" name = "userID" maxlength = "20"value="">
					</div>
											
					<div class="form-group userPassword">
						<input type = "password" class = "form-control" placeholder = "비밀번호" name = "userPassword" maxlength = "20"value = "">	
					</div>
								
					<div class="form-group userName">
						<input type = "text" class = "form-control" placeholder = "이름" name = "userName" maxlength = "10"value = "">		
					</div>
						
					<div class="form-group userEmail">			
						<input type = "text" class = "form-control" placeholder = "이메일" name = "userEmail" maxlength = "100"value = "">
					</div>
					
					<div class="address-holder">
						<input  type="button" onClick="goPopup();" value="주소찾기" class="btn btn-primary form-control address-button">
								<div id="list"></div>
								<div id="callBackDiv">
								
						<table>
							<tr><td><input type="text" id="userAddressNum"  value = "" name="userAddressNum" placeholder="우편번호" class="form-control address-num-holder"/></td></tr>
							<tr><td><input type="text" id="userAddress" value=""  name="userAddress" placeholder="주소"  class="form-control address-full-holder"/></td></tr>
							
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
						<input type = "text" class = "form-control" placeholder = "직업" name = "userJob" maxlength = "20"value = "">
					</div>
					<div class="form-group userAge">			
						<input type = "text" class = "form-control" placeholder = "나이" name = "userAge" maxlength = "20"value = "">
					</div>
					<div class="form-group userBirthday">			
						<input type = "text" class = "form-control" placeholder = "생년월일(ex.93.03.25)" name = "userBirthday" maxlength = "20"value = "">
					</div>
					<div class="form-group  userPhoneNumber">			
						<input type = "text" class = "form-control" placeholder = "핸드폰 번호" name = "userPhoneNumber" maxlength = "20"value = "">
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
					<div class = "form-group userProfilePhoto">프로필 사진 : <input type="file" name="file"></div>
					
					<div class="form-group button">
						<input type = "submit" class ="btn btn-primary form-control" value = "회원가입">
					</div>
					
			</form>
		</div>
		
		
	</div>
</div>	

	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>