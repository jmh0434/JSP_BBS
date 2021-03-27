<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content_Type" content ="text/html; charset="UTF-8">
<meta name = "viewport" content = "width=device-width", initial-scale = "1">
<!--  루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;	// 로그인을 안 한 사람이라면 null 값
		if (session.getAttribute("userID") != null)	// 로그인을 한 사람이라면 값 유지
		{
			userID = (String) session.getAttribute("userID");
		}
	%>

	<%-- 네비게이션 링크 --%>
	<nav class="navbar navbar-default">
	<%-- 내부 css 파일 참조--%> 
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<%-- 메뉴바 줄 3개 --%>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		
		<%-- 메뉴 링크 --%>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>	<%-- active = 지금 접속한 페이지 --%>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			
			<%
				if(userID == null)	// 로그인 X
				{
			%>
			<%-- 드랍다운 메뉴 --%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toogle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
							
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>	
			<%
				} else				// 로그인 O
				{
			%>
			<%-- 드랍다운 메뉴 --%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toogle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
							
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
	<!-- 로그인 양식 -->
	<div class = "container"> <!-- 하나의 영역 생성 -->
		<div class="col-lg-4"></div> <!-- 영역의 크기 -->
		<div class="col-lg-4">
			<!-- 점보트론은 특정컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align: center;">로그인 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
					</form>
				</div>
			</div>
		</div>
		<div class="col-lg-4"></div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>