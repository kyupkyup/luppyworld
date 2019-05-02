<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>luppyWorld</title>
</head>
<body>
		<script>
			if(screen.width<600){
				location.href="/mobile/mobile_main.jsp";
			}
		
			else{
				location.href = "main.jsp";    // 메인 페이지로 고정해놓는다.

			}
				</script>
</body>
</html>