<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import="java.io.PrintWriter" %>
<%@	page import="bbs.BbsDAO" %>
<%@	page import="bbs.Bbs" %>
<%@	page import="likey.LikeyDTO" %>
<%@	page import="likey.LikeyDAO" %>

<%@	page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content_Type" content ="text/html; charset="UTF-8">
<meta name = "viewport" content = "width=device-width", initial-scale = "1">
<!--  루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<title>JSP 게시판 웹사이트</title>
<style type = "text/css">
	a, a:hober{
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<% 
		//메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
			if(session.getAttribute("userID") != null){
				userID = (String)session.getAttribute("userID");
			}
		int pageNumber = 1;//기본은 1페이지를 할당
		// 만약 파라미터로 넘어온 오브젝트 타입'pageNumber'가 존재한다면
		// 'int'타입으로 캐스팅을 해주고 그 값을 'pageNumber' 변수에 저장한다
		if(request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
	
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class = "container">
		<div class = "row">
			<table class = "table table-striped" style = "text-align : center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style = "background-color: #eeeeee; text-align : center;">번호</th>
						<th style = "background-color: #eeeeee; text-align : center;">제목</th>
						<th style = "background-color: #eeeeee; text-align : center;">작성자</th>
						<th style = "background-color: #eeeeee; text-align : center;">작성일</th>
						<th style = "background-color: #eeeeee; text-align : center;">추천</th>
						<th style = "background-color: #eeeeee; text-align : center;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<!--  테스트 코드 -->
						
					</tr>
				</tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO(); // 인스턴스 생성 
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<!--  게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 -->
						<td><a href = "view.jsp?bbsID=<%= list.get(i).getBbsID() %>">
							<%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13)+"시" 
							+ list.get(i).getBbsDate().substring(14,16) + "분" %></td>
						<td><%= list.get(i).getLikeCount() %></td>
						<td><%= list.get(i).getReadCount() %></td>
					</tr>
					<% 
						}
					%>
			</table>
			
			<!-- 페이징 처리 영역 -->
			<%
				if(pageNumber != 1){
			%>
				<a href = "bbs.jsp?pageNumber=<%=pageNumber -1 %>"
					class = "btn btn-success btn-arraw-Left">이전</a>
			<%
				}if(bbsDAO.nextPage(pageNumber + 1)){
			%>
				<a href = "bbs.jsp?pageNumber=<%=pageNumber +1 %>"
					class = "btn btn-success btn-arraw-Left">다음</a>
			<%		
				}
			%>		
			<!--  글쓰기 버튼 생성 -->
			<a href = "write.jsp" class = "btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>