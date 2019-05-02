<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "user.User" %>
    <%@ page import= "user.UserDAO" %>
    <%@ page import = "java.io.PrintWriter" %>
    <%@ page import = "java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>

	
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_style.css">
<link rel="stylesheet" href="/css/mobile_css/mobile_adminMember_style.css">


<meta name="viewport" content="width=device-width" , initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Nanum+Gothic/Sunflower:300&amp;subset=korean" rel="stylesheet">

    <title>러피월드: &nbsp;즐거운 봉사는 유기견을 춤추게한다.</title>

</head>

<body>
<script type="text/javascript">

//출처 : http://tonks.tistory.com/79 
//에러가 나온다면, 여기에 댓글을 남겨주세요. 


/* sortingNumber() : 숫자인 실수만으로 되어있을 때, 적용될 함수 */ 

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
		User user1 =null;
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

                     	<li><a href="mobile_login.jsp">로그인</a></li>
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
			/* 비로그인 상태에서 게시판을 볼 경우 -*/
				/* if(userID.equals("admin")) */
				if(userID.equals("admin"))
				{
		%>
	<div class = "container-main">
	
		<p class="title">회원 관리</p>
		<div class = "row">

			<table class = "table table-hover" id="userList">
				
				<thead>
<!-- 					<tr>
					
						<th class="userProfilePhoto" rowspan="3">프로필 사진</th>
						<th class="userName">유저 이름<button onclick="sortTD( 1 )">▲</button><button onclick="reverseTD( 1 )">▼</button></th>
						<th class="userPhoneNumber">핸드폰 번호</th>
						<th class="userGender">성별</th>
						<th class="userAddress">주소</th>
						<th class="userGender">나이</th>
						<th class="userRoute">유입경로<button onclick="sortTD( 6 )">▲</button><button onclick="reverseTD( 6 )">▼</button></th>
						<th class="userMemberShip">멤버십 <button onclick="sortTD( 7 )">▲</button><button onclick="reverseTD( 7 )">▼</button></th>
						<th class="userAttend">참석횟수 <button onclick="sortTD( 8 )">▲</button><button onclick="reverseTD( 8 )">▼</button></th>
						
					</tr> -->
					
				</thead>
				
				<tbody>
				<%
					UserDAO userDAO = new UserDAO();
									ArrayList<User> list = userDAO.getListAdmin();
									for(int i = 0; i< list.size(); i++){
										
										String userMemberShip = null;
										if(list.get(i).getUserMemberShip()==0){
											userMemberShip ="준회원";
										}
										else if(list.get(i).getUserMemberShip()==1){
											userMemberShip ="정회원";
										}
										else if(list.get(i).getUserMemberShip()==2){
											userMemberShip ="운영진";
										}
										else if(list.get(i).getUserMemberShip()==3){
											userMemberShip ="모임장";
										}
										else if(list.get(i).getUserMemberShip()==4){
											userMemberShip ="신입회원";
										}
										else if(list.get(i).getUserMemberShip()==5){
											userMemberShip ="가입대기";
										}
										
										
										String firstRoute = null;
										if(list.get(i).getFirstRoute()==1){
											firstRoute ="소모임";
										}
										else if(list.get(i).getFirstRoute()==2){
											firstRoute ="인스타그램";
										}
										else if(list.get(i).getFirstRoute()==3){
											firstRoute ="검색";
										}
										else if(list.get(i).getFirstRoute()==4){
											firstRoute ="봉사현장";
										}
										else if(list.get(i).getFirstRoute()==5){
											firstRoute ="소개";
										}
										else if(list.get(i).getFirstRoute()==6){
											firstRoute ="기타";
										}
				%>
					<tr>
						<td rowspan="3"><img class="userProfilePhoto-1 vertical" onerror="this.src='/css/images/basic_image.png'" src="/upload/profile/<%=list.get(i).getFileRealName()%>"></td>
						<td class="userName-1"><%=list.get(i).getUserName()%></td>
						<td colspan="2"class="userPhoneNumber-1"><%=list.get(i).getUserPhoneNumber()%></td>
						<td colspan="2" class="userGender-1"><%=list.get(i).getUserGender()%></td>
					</tr>
					<tr>
						<td colspan="5"class="userAddress-1"><%=list.get(i).getUserAddress()%></td>
					</tr>
					<tr>
						<td class="userGender-1"><%=list.get(i).getUserAge()%></td>
						<td class="userRoute-1"><%=firstRoute%></td>
						<td class="userMemberShip-1"><%=userMemberShip%></td>
						<td class="userAttend-1"><%=list.get(i).getUserAttend()+"회" %></td>
						<td><a class="btn btn-primary" href="mobile_adminMemberEach.jsp?userID=<%=list.get(i).getUserID()%>">관리</a></td>
					</tr>
		
				<%
					}
				%>
				</tbody>
			</table>
	
		</div>
	
	
	</div>
		
		
		
	<!-- 관리자 계정에서 게시판을 볼 경우 -->
	
		<%
			
			}				
		%>
</div>
	<script src ="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="/js/bootstrap.js"></script>
	
	<script type="text/javascript">
		var myTable = document.getElementById( "userList" ); 
		var replace = replacement( myTable ); 
		function sortTD( index ){    replace.ascending( index );    } 
		function reverseTD( index ){    replace.descending( index );    } 
	</script>
 

</body>


</html>