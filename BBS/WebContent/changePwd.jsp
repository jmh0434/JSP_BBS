<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equv="Content-Type" content = "text/html"; charset="UTF-8">
<meta name = "viewport" content = "width-device-width", initial-scale = "1">
<%-- 내부 css 파일 참조--%>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<%-- user/User.java에서 ID --%>


<title>JSP 게시판 웹 사이트</title>
</head>
<body>
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
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			
			<%-- 드랍다운 메뉴 --%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toogle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						
						<ul class="dropdown-menu">
							<li class="active"><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
				</li>
			</ul>
		</div>
	</nav>
	<%
		String userID = request.getParameter("userID");
	%>
	
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">	
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="changePwd_Action.jsp?userID=<%= userID %>" onsubmit="return input_check_func()">	<%-- 비밀번호 숨길 떄 ***-> post --%>
					<h3 style="text-align: center;">비밀번호 변경 화면</h3>
					<div style="text-align: center; padding-bottom: 10px;">개인정보를 입력해주세요.</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" id="userPassword" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호 확인" id="userPassword_check" name="userPassword_check" maxlength="20">
					</div>					
					<input type="submit" class="btn btn-primary form-control" value="비밀번호 변경">
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script>
    function input_check_func() {
        var change_pw = document.getElementById('userPassword').value;
        var change_pw_check = document.getElementById('userPassword_check').value;
        
        if(change_pw == null || change_pw_check == null ||
           change_pw == ""   || change_pw_check == "") {
            alert("비밀번호에서 공백은 허용하지 않습니다.");
            return false;
        } 

        else if ( change_pw != change_pw_check ) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            return false;
        } else {
            return true;
        }
    }    
    </script>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
	<%-- 외부 js와 내부 js 파일 참조--%>
</body>
</html>