<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content_Type" content ="text/html; charset="UTF-8">
<meta name = "viewport" content = "width=device-width", initial-scale = "1">
<!--  루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel = "stylesheet" href = "css/bootstrap.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		alert('로그아웃 되었습니다');
		location.href="main.jsp";
	</script>
</body>
</html>