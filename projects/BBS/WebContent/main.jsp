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
		//메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
			if(session.getAttribute("userID") != null){
				userID = (String)session.getAttribute("userID");
			}
	%>
	<!-- 네비게이션 영역 -->
	<nav class="navbar navbar-default">
		<!-- 헤더 영역(홈페이지 로고 등을 담당) -->
		<div class = "navbar-header">
			<button type = "button" class = "navbar-toggle collapsed"
				data-toggle = "copplapse" data-target = "#bs-example-navbar-collapse-1"
				aria-expanded = "false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타남 -->
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
			</button>
			<!--  상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동 -->
			<a class = "navbar-brand" href = "main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 이름 영역 -->
		<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				//로그인 하지 않았을 때 보여지는 화면
				if(userID==null){
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기 <span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href = "login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a>
					</ul>
				</li>
			</ul>
			<%
				//로그인이 되어 있는 상태에서 보여주는 화면
				}else{
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>