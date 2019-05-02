<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import = "volunteer.Volunteer" %>
    <%@ page import = "volunteer.VolunteerDAO" %>
<%@ page import= "user.User" %>
<%@ page import= "user.UserDAO" %>
    <%@ page import = "registration.Registration" %>
    <%@ page import = "registration.RegistrationDAO" %>
    <%@ page import = "java.util.ArrayList" %>
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
<link href="css/volunteer_view.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Sunflower:300&amp;subset=korean" rel="stylesheet">

<title>러피월드: &nbsp;봉사</title>

</head>
<body>
<script type="text/javascript">


function sortingNumber( a , b ){  

     if ( typeof a == "number" && typeof b == "number" ) return a - b; 

     // 천단위 쉼표와 공백문자만 삭제하기.  
     var a = ( a + "" ).replace( /[,\s\xA0]+/g , "" ); 
     var b = ( b + "" ).replace( /[,\s\xA0]+/g , "" ); 

     var numA = parseFloat( a ) + ""; 
     var numB = parseFloat( b ) + ""; 

     if ( numA == "NaN" || numB == "NaN" || a != numA || b != numB ) return false; 

     return parseFloat( a ) - parseFloat( b ); 
} 


/* changeForSorting() : 문자열 바꾸기. */ 

function changeForSorting( first , second ){  

     // 문자열의 복사본 만들기. 
     var a = first.toString().replace( /[\s\xA0]+/g , " " ); 
     var b = second.toString().replace( /[\s\xA0]+/g , " " ); 

     var change = { first : a, second : b }; 

     if ( a.search( /\d/ ) < 0 || b.search( /\d/ ) < 0 || a.length == 0 || b.length == 0 ) return change; 

     var regExp = /(\d),(\d)/g; // 천단위 쉼표를 찾기 위한 정규식. 

     a = a.replace( regExp , "$1" + "$2" ); 
     b = b.replace( regExp , "$1" + "$2" ); 

     var unit = 0; 
     var aNb = a + " " + b; 
     var numbers = aNb.match( /\d+/g ); // 문자열에 들어있는 숫자 찾기 

     for ( var x = 0; x < numbers.length; x++ ){ 

             var length = numbers[ x ].length; 
             if ( unit < length ) unit = length; 
     } 

     var addZero = function( string ){ // 숫자들의 단위 맞추기 

             var match = string.match( /^0+/ ); 

             if ( string.length == unit ) return ( match == null ) ? string : match + string; 

             var zero = "0"; 

             for ( var x = string.length; x < unit; x++ ) string = zero + string; 

             return ( match == null ) ? string : match + string; 
     }; 

     change.first = a.replace( /\d+/g, addZero ); 
     change.second = b.replace( /\d+/g, addZero ); 

     return change; 
} 


/* byLocale() */ 

function byLocale(){ 

     var compare = function( a , b ){ 

             var sorting = sortingNumber( a , b ); 

             if ( typeof sorting == "number" ) return sorting; 

             var change = changeForSorting( a , b ); 

             var a = change.first; 
             var b = change.second; 

             return a.localeCompare( b ); 
     }; 

     var ascendingOrder = function( a , b ){  return compare( a , b );  }; 
     var descendingOrder = function( a , b ){  return compare( b , a );  }; 

     return { ascending : ascendingOrder, descending : descendingOrder }; 
} 


/* replacement() */ 

function replacement( parent ){  
     var tagName = parent.tagName.toLowerCase(); 
     if ( tagName == "table" ) parent = parent.tBodies[ 0 ]; 
     tagName = parent.tagName.toLowerCase(); 
     if ( tagName == "tbody" ) var children = parent.rows; 
     else var children = parent.getElementsByTagName( "li" ); 

     var replace = { 
             order : byLocale(), 
             index : false, 
             array : function(){ 
                     var array = [ ]; 
                     for ( var x = 0; x < children.length; x++ ) array[ x ] = children[ x ]; 
                     return array; 
             }(), 
             checkIndex : function( index ){ 
                     if ( index ) this.index = parseInt( index, 10 ); 
                     var tagName = parent.tagName.toLowerCase(); 
                     if ( tagName == "tbody" && ! index ) this.index = 0; 
             }, 
             getText : function( child ){ 
                     if ( this.index ) child = child.cells[ this.index ]; 
                     return getTextByClone( child ); 
             }, 
             setChildren : function(){ 
                     var array = this.array; 
                     while ( parent.hasChildNodes() ) parent.removeChild( parent.firstChild ); 
                     for ( var x = 0; x < array.length; x++ ) parent.appendChild( array[ x ] ); 
             }, 
             ascending : function( index ){ // 오름차순 
                     this.checkIndex( index ); 
                     var _self = this; 
                     var order = this.order; 
                     var ascending = function( a, b ){ 
                             var a = _self.getText( a ); 
                             var b = _self.getText( b ); 
                             return order.ascending( a, b ); 
                     }; 
                     this.array.sort( ascending ); 
                     this.setChildren(); 
             }, 
             descending : function( index ){ // 내림차순
                     this.checkIndex( index ); 
                     var _self = this; 
                     var order = this.order; 
                     var descending = function( a, b ){ 
                             var a = _self.getText( a ); 
                             var b = _self.getText( b ); 
                             return order.descending( a, b ); 
                     }; 
                     this.array.sort( descending ); 
                     this.setChildren(); 
             } 
     }; 
     return replace; 
} 

function getTextByClone( tag ){  
     var clone = tag.cloneNode( true ); // 태그의 복사본 만들기. 
     var br = clone.getElementsByTagName( "br" ); 
     while ( br[0] ){ 
             var blank = document.createTextNode( " " ); 
             clone.insertBefore( blank , br[0] ); 
             clone.removeChild( br[0] ); 
     } 
     var isBlock = function( tag ){ 
             var display = ""; 
             if ( window.getComputedStyle ) display = window.getComputedStyle ( tag, "" )[ "display" ]; 
             else display = tag.currentStyle[ "display" ]; 
             return ( display == "block" ) ? true : false; 
     }; 
     var children = clone.getElementsByTagName( "*" ); 
     for ( var x = 0; x < children.length; x++){ 
             var child = children[ x ]; 
             if ( ! ("value" in child) && isBlock(child) ) child.innerHTML = child.innerHTML + " "; 
     } 
     var textContent = ( "textContent" in clone ) ? clone.textContent : clone.innerText; 
     return textContent; 
} 


</script>

	<%
	User user1 = null;
			String userID = null;
			
			
		if(session.getAttribute("user") != null){
			user1 = (User)session.getAttribute("user");
			userID = user1.getUserID();
			
		}
		int volunteerID = 0;
		if(request.getParameter("volunteerID") != null)
		{
			volunteerID = Integer.parseInt(request.getParameter("volunteerID"));
		}
		
		if(volunteerID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'volunteer.jsp'");
			script.println("</script>");
		}
		
		Volunteer volunteer = new VolunteerDAO().getVolunteer(volunteerID);
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
	<!-- 비로그인 상태에서 게시판을 볼 경우 -->
		<%
			if(userID == null){
		%>
				
	<!-- 관리자 계정에서 게시판을 볼 경우 -->
		<%
			}
			
			else if(!userID.equals("admin")){
		%>
		<!-- 일반 계정 게시판 열람 경우 -  -->
		
	<div class = "container">
		<div class = "row">
		
				<table class = "table table-striped box"style= "text-align : center; border:1px solid #dddddd;  table-layout:fixed;  word-break:break-all;">
					
					<thead>
						<tr>
							<th colspan="3" style ="background-color: #eeeeee; text-align: center;" class="title"> 봉사 보기 </th>
							
						</tr>
						
					</thead>
					
					<tbody>
						<tr>
							<th colspan="3" style = "backgound-color: #eeeeee; text-align: center;"></th>
						</tr>
						
						<tr> <!-- 고칠 부분  -->
							<td class="volunteer-title" style = "width: 100px;">봉사 명</td>
							<td class="volunteer-title-1" colspan="2"><%=volunteer.getVolunteerTitle()%></td>
						</tr>
						
						<tr>
							<td class="volunteer-date" style = "width: 100px;">봉사 일자</td>
							<td class="volunteer-date-1" colspan="2"><%=volunteer.getVolunteerDate()%></td>
						</tr>
						
						<tr>
							<td class="volunteer-place" style = "width: 100px;">봉사 장소</td>
							<td class="volunteer-place-1" colspan="2"><%=volunteer.getVolunteerPlace()%></td>
						</tr>
						<tr>
							<td class="volunteer-write-date"style = "width: 100px;">작성 일자</td>
							<td class="volunteer-write-date-1"colspan="2"><%=volunteer.getVolunteerAnnounceDate().substring(0,11) + volunteer.getVolunteerAnnounceDate().substring(11, 13)+ "시" + volunteer.getVolunteerAnnounceDate().substring(14, 16) + "분"%></td>
						</tr>
						
						<tr>
							<td class="volunteer-content"style = "width: 100px;">내용</td>
							<td class="volunteer-content-1" colspan="2"><div style="min-height: 200px; text-align: Left; word-break:break-all; word-wrap:break-word;white-space:pre-wrap;"><%=volunteer.getVolunteerContent()%></div></td>
						</tr>
						
						<tr>
							<td class="volunteer-food" style ="width: 100px;">식사</td>
							<td class="volunteer-food-1" colspan="2" style="text-align: Left;"><%=volunteer.getFoodName()%> 에서 <%=volunteer.getFoodPrice()%>원에 맛있는 점심을~ </td>
						</tr>
					</tbody>
					
					
				</table>
													
				<!-- 봉사 등록 한 사람 리스트 보여주는 부분  -->
				<table class = "table table-striped box"style= "text-align : center; border: 1px solid #dddddd">
				
					<thead>
						<tr>
							<th class="volunteer-userProfilePhoto" style="text-color:#00ff0000; background-color: #eeeeee;  text-align: center;">사진</th>
							<th class="volunteer-userName"style ="background-color: #eeeeee; text-align: center; "> 이름 </th>
							<th class="volunteer-userMemberShip"style ="background-color: #eeeeee; text-align: center; "> 멤버십</th>
							<th class="volunteer-attend"style ="background-color: #eeeeee; text-align: center; "> 참석 횟수</th>
							<th class="volunteer-foodWhether"style ="background-color: #eeeeee; text-align: center; "> 한 마디</th>
							<th class="volunteer-cancel" style ="background-color: #eeeeee; text-align: center; "> 참석 취소</th>
							
						</tr>
						
					</thead>
					
					<tbody>
					<%
					UserDAO userDAO = new UserDAO();						
												RegistrationDAO registrationDAO = new RegistrationDAO();
												ArrayList<Registration> list1 = registrationDAO.getList(volunteerID);
											
												
												for(int i = 0; i< list1.size(); i++){
													User user = new UserDAO().getUser(list1.get(i).getUserID());
													Registration registration = new RegistrationDAO().getRegistration(list1.get(i).getUserID(), volunteerID);
													String primaryUserID = registration.getPrimaryUserID();

													String userMemberShip = null;
													if(user.getUserMemberShip()==0){
														userMemberShip ="준회원";
													}
													else if(user.getUserMemberShip()==1){
														userMemberShip ="정회원";
													}
													else if(user.getUserMemberShip()==2){
														userMemberShip ="운영진";
													}
													else if(user.getUserMemberShip()==3){
														userMemberShip ="모임장";
													}
													else if(user.getUserMemberShip()==4){
														userMemberShip ="신입회원";
													}
													
								/* 							String userMeal = null;
													if(registration.getEatWhether()==0 ){
														userMeal ="취식";
													}
													else if(registration.getEatWhether()==1){
														userMeal ="미취식";
													}
													else if(registration.getEatWhether()==2){
														userMeal ="잘 모름";
													}
													
													
													String userCarfool = null;						
													if(registration.getCarfool()==0 ||registration.getCarfool()== 4 || registration.getCarfool()==1){
														userCarfool ="카풀 지원";
													}
													else if(registration.getCarfool()==2){
														userCarfool ="카풀 피지원";
													}
													else if(registration.getCarfool()==3){
														userCarfool ="따로 감";
													}  */
					%>
					
						<tr>
							<td><img src="/upload/profile/<%=user.getFileRealName()%>" onerror="this.src='/css/images/basic_image.png'" class="userProfilePhoto"></td>
							<td class="volunteer-userName-1"><%=userDAO.getUserName1(list1.get(i).getUserID())%></td>
							<td class="volunteer-userMemberShip-1"><%=userMemberShip%></td>
							<td class="volunteer-foodWhether-1"><%=user.getUserAttend()%>회</td>
							<%
								if(registration.getOneSay()==null){
							%>
								<td class="volunteer-onesay-1"></td>
								<%
									}else{
								%>
								<td class="volunteer-onesay-1"><%=registration.getOneSay()%></td>
							<%
								}
							%>
																			<%
																				if(userID.equals(user.getUserID()))
																																										{
																			%>
							<td><a class="btn btn-primary" href="volunteerCancelAction.jsp?primaryUserID=<%=primaryUserID%>&volunteerID=<%=volunteerID%>">참석 취소</a></td>
							
					 		<%
												 			}
												 												 								else
												 												 								{
												 		%>
							<td></td>
							<%
								}
							%>
							
 						</tr>
						
						<%
													}
												%>
					</tbody>
				</table>
				
				
				<a href = "volunteerBulletin.jsp" class = "btn btn-primary">목록으로</a>
				
				
				<%
													if(periodDay>0){
												%>
						<a href = "volunteerRegister.jsp?volunteerID=<%=volunteerID%>" class = "btn btn-primary">봉사 신청</a> 
						<p><%=periodDay%>일
						<%
 							if(true){
 						%>
								<%=periodHour%>시간
							<%
									if(true){
								%>
									<%=periodMinute%>분 남았습니다.</p>
							<%
								}
																}
																	
																
																
															}else if(periodDay==0){
															
																if(curDate.isBefore(targetDate)){
							%>
								<a href = "volunteerRegister.jsp?volunteerID=<%=volunteerID%>" class = "btn btn-primary">봉사 신청</a> 
								<p><%=periodHour%>시간 <%=periodMinute%>분 남았습니다.</p>
							<%
								}
																else{
																	
																	if(dueHour-curHour>0){
							%>
									<a href = "volunteerRegister.jsp?volunteerID=<%=volunteerID%>" class = "btn btn-primary">봉사 신청</a> 
									<p><%=periodHour%>시간
								<%
 										if(true){
 									%>
										<%=periodMinute%>분 남았습니다.</p>
									<%
										}
																					}
																					else if(dueHour-curHour==0){
																						
																						if(dueMinute-curMinute>0){
									%>
										<a href = "volunteerRegister.jsp?volunteerID=<%=volunteerID%>" class = "btn btn-primary">봉사 신청</a>
										<p><%=periodMinute%>분 남았습니다.</p>
									<%
										}
																						
																						else if(dueMinute - curMinute<=0){
									%>
									<a class="btn btn-disabled">봉사 마감</a>
									<%
										}
																					}
																				
																				
																					else if(dueHour-curHour<0){
									%>
									<a class="btn btn-disabled">봉사 마감</a>
								<%
									}
																			
																		}
																	}
																	
																	else if(periodDay<0){
								%>
						<a class="btn btn-disabled">봉사 마감</a>
						<%
							}
						%>
		</div>
	</div>
		
	<!-- 관리자 계정에서 게시판을 볼 경우 -->
		<%
			}
				
			else if(userID.equals("admin")){
		%>
	<div class = "container">
		<div class = "row">
		
				<table class = "table table-striped box"style= "text-align : center;  table-layout:fixed; border:1px solid #dddddd;  word-break:break-all;">
					
										<thead>
						<tr>
							<th colspan="3" style ="background-color: #eeeeee; text-align: center;" class="title"> 봉사 보기 </th>
							
						</tr>
						
					</thead>
					
					<tbody>
						<tr>
							<th colspan="3" style = "backgound-color: #eeeeee; text-align: center;"></th>
						</tr>
						
						<tr> <!-- 고칠 부분  -->
							<td class="volunteer-title" style = "width: 100px;">봉사 명</td>
							<td class="volunteer-title-1" colspan="2"><%=volunteer.getVolunteerTitle()%></td>
						</tr>
						
						<tr>
							<td class="volunteer-date" style = "width: 100px;">봉사 일자</td>
							<td class="volunteer-date-1" colspan="2"><%=volunteer.getVolunteerDate()%></td>
						</tr>
						
						<tr>
							<td class="volunteer-place" style = "width: 100px;">봉사 장소</td>
							<td class="volunteer-place-1" colspan="2"><%=volunteer.getVolunteerPlace()%></td>
						</tr>
						<tr>
							<td class="volunteer-write-date"style = "width: 100px;">작성 일자</td>
							<td class="volunteer-write-date-1"colspan="2"><%=volunteer.getVolunteerAnnounceDate().substring(0,11) + volunteer.getVolunteerAnnounceDate().substring(11, 13)+ "시" + volunteer.getVolunteerAnnounceDate().substring(14, 16) + "분"%></td>
						</tr>
						
						<tr>
							<td class="volunteer-content"style = "width: 100px;">내용</td>
							<td class="volunteer-content-1" colspan="2"><div style="min-height: 200px; text-align: Left; word-break:break-all; word-wrap:break-word;white-space:pre-wrap;"><%=volunteer.getVolunteerContent()%></div></td>
						</tr>
						
						<tr>
							<td class="volunteer-food" style ="width: 100px;">식사</td>
							<td class="volunteer-food-1" colspan="2" style="text-align: Left;"><%=volunteer.getFoodName()%> 에서 <%=volunteer.getFoodPrice()%>원에 맛있는 점심을~ </td>
						</tr>
					</tbody>
					
					
				</table>
				<!-- 봉사 등록 한 사람 리스트 보여주는 부분  -->
				<table  id="register-user" class = "table table-striped box"style= "text-align : center; border: 1px solid #dddddd">
				
					<thead>
						<tr>
							<th class="volunteer-userName"style ="background-color: #eeeeee; text-align: center; "> 이름 </th>
							<th class="volunteer-region"style ="background-color: #eeeeee; text-align: center; "> 지역<br><button onclick="sortTD( 1 )">▲</button><button onclick="reverseTD( 1 )">▼</button></th>
							<th class="volunteer-userMemberShip"style ="background-color: #eeeeee; text-align: center; "> 멤버십<br><button onclick="sortTD( 2 )">▲</button><button onclick="reverseTD( 2 )">▼</button></th>
							<th class="volunteer-userCafool"style ="background-color: #eeeeee; text-align: center; "> 노동장소<br><button onclick="sortTD( 3 )">▲</button><button onclick="reverseTD( 3 )">▼</button></th>
							<th class="volunteer-userCafool"style ="background-color: #eeeeee; text-align: center; "> 무서움<br><button onclick="sortTD( 4 )">▲</button><button onclick="reverseTD( 4 )">▼</button></th>
							<th class="volunteer-userCafool"style ="background-color: #eeeeee; text-align: center; "> 카풀<br><button onclick="sortTD( 5 )">▲</button><button onclick="reverseTD( 5 )">▼</button></th>
							<th class="volunteer-foodWhether"style ="background-color: #eeeeee; text-align: center; "> 식사 여부<br><button onclick="sortTD( 6 )">▲</button><button onclick="reverseTD( 6 )">▼</button></th>
							<th class="volunteer-userCafool"style ="background-color: #eeeeee; text-align: center; "> 카풀비<br><button onclick="sortTD( 7 )">▲</button><button onclick="reverseTD( 7 )">▼</button></th>
							<th class="volunteer-attend"style ="background-color: #eeeeee; text-align: center; "> 참석 횟수<br><button onclick="sortTD( 8 )">▲</button><button onclick="reverseTD( 8 )">▼</button></th>
							<th class="volunteer-cancel" style ="background-color: #eeeeee; text-align: center; "> 참석 취소</th>
							
						</tr>
						
					</thead>
					
					<tbody>
					<%
					UserDAO userDAO = new UserDAO();						
												RegistrationDAO registrationDAO = new RegistrationDAO();
												ArrayList<Registration> list1 = registrationDAO.getList(volunteerID);


												
												for(int i = 0; i< list1.size(); i++){
													
													String primaryUserID = null;
													User user = new UserDAO().getUser(list1.get(i).getUserID());
													Registration registration = new RegistrationDAO().getRegistration(list1.get(i).getUserID(), volunteerID);
													
													primaryUserID = registration.getPrimaryUserID();
													
													String userMemberShip = null;
													
													
													if(user.getUserMemberShip()==0){
														userMemberShip ="준회원";
													}
													else if(user.getUserMemberShip()==1){
														userMemberShip ="정회원";
													}
													else if(user.getUserMemberShip()==2){
														userMemberShip ="운영진";
													}
													else if(user.getUserMemberShip()==3){
														userMemberShip ="모임장";
													}
													else if(user.getUserMemberShip()==4){
														userMemberShip ="신입회원";
													}
													
											/*		String userMeal = null;
													if(registration.getEatWhether()==0 ){
														userMeal ="취식";
													}
													else if(registration.getEatWhether()==1){
														userMeal ="미취식";
													}
													else if(registration.getEatWhether()==2){
														userMeal ="잘 모름";
													}
													
													
													String userCarfool = null;						
													if(registration.getCarfool()==0 ||registration.getCarfool()== 4 || registration.getCarfool()==1){
														userCarfool ="카풀 지원";
													}
													else if(registration.getCarfool()==2){
														userCarfool ="카풀 피지원";
													}
													else if(registration.getCarfool()==3){
														userCarfool ="따로 감";
													} 
													*/
					%>
					
						<tr>
							<td class="volunteer-userName-1"><a href="volunteerUserCheck.jsp?userID=<%=user.getUserID()%>&volunteerID=<%=volunteerID%>"><%=userDAO.getUserName1(list1.get(i).getUserID())%></a></td>
							<td class="volunteer-userMemberShip-1"><%=registration.getRegion()%></td>
							<td class="volunteer-userMemberShip-1"><%=userMemberShip%></td>							
							<td class="volunteer-foodWhether-1"><%=registration.getWorkPlace()+"번"%></td>
							<td class="volunteer-userCafool-1"><%=registration.getScary()+"번"%></td>
							<td class="volunteer-foodWhether-1"><%=registration.getCarfool()+"번"%></td>
							<td class="volunteer-foodWhether-1"><%=registration.getEatWhether()+"번"%></td>
							<td class="volunteer-foodWhether-1"><%=registration.getCarfoolee()+"번"%></td>
							<td class="volunteer-attend-1"><%=userDAO.getUserAttend1(list1.get(i).getUserID())%> 회</td>
				
							
							<%
								if(registration.getPaid()==0)
								{
							%>
							<td><a class="btn btn-primary" href="payCheck.jsp?primaryUserID=<%=primaryUserID%>&volunteerID=<%=volunteerID%>&userID=<%=user.getUserID()%>&paid=<%=registration.getPaid()%>">참석 확정</a></td>
							
					 		<%
								}
								else if(registration.getPaid()==1)
								{
							%>
							<td><a class="btn btn-gray" href="payCheck.jsp?primaryUserID=<%=primaryUserID%>&volunteerID=<%=volunteerID%>&userID=<%=user.getUserID()%>&paid=<%=registration.getPaid()%>">참석 취소</a></td>
							<%
								}
							%>
								
							 
 						</tr>
						
						<%
								}
						%>
					</tbody>
				</table>
				
				<a href = "volunteerBulletin.jsp" class = "btn btn-primary">목록으로</a>
				
				<%
					if(userID != null && (userID.equals(volunteer.getUserID()) || userID.equals("admin"))){
				%>
					<a href = "volunteerUpdate.jsp?volunteerID=<%=volunteerID%>" class = "btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "volunteerDeleteAction.jsp?volunteerID=<%=volunteerID%>" class = "btn btn-primary">삭제</a>
					
				
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
	<script type = "text/javascript">
	function attendPlus(userID){
		UserDAO userDAO = new UserDAO();
		userDAO.userAttend(userID);
	}
	</script>
	<script type="text/javascript">
	var myTable = document.getElementById( "register-user" ); 
	var replace = replacement( myTable ); 
	function sortTD( index ){    replace.ascending( index );    } 
	function reverseTD( index ){    replace.descending( index );    } 
	</script>
</body>
</html>