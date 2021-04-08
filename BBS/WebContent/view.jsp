<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import="java.io.PrintWriter" %>
<%@	page import="bbs.BbsDAO" %>
<%@	page import="bbs.Bbs" %>
<%@	page import="likey.LikeyDAO" %>
<%@	page import="likey.LikeyDAO" %>
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
		//메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
			if(session.getAttribute("userID") != null){
				userID = (String)session.getAttribute("userID");
			}
		// bbsID를 초기화 시키고
		// 'bbsID라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
		int bbsID = 0;
		if(request.getParameter("bbsID")!=null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		// 만약 넘어온 데이터가 없다면
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='bbs.jsp'");
			script.println("</script");
		}
		//유효한 글이라면 구체적인 정보를 'bbs'라는 인스턴스에 담는다
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.read(bbsID);
	
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
	
	<!-- 게시판 글보기 양식 영역 시작 -->
	<div class = "container">
		<div class = "row">
				<table class = "table table-striped" style = "text-align : center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan = "2" style = "background-color: #eeeeee; text-align : center;">게시판 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;")
									.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan ="2"><%= bbs.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan = "2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "시" 
							+ bbs.getBbsDate().substring(14,16) + "분" %></td>
						</tr>
						<tr>
							<td>조회수</td>
							<td colspan = "2"><%=bbs.getReadCount()%></td>
						</tr>
						<tr>
							<td>추천</td>
							<td colspan = "2"><%=bbs.getLikeCount()%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan = "2" style = "heigh: 200px; text-align: Left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;")
									.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>					
					</tbody>
				</table>
				<a href = "bbs.jsp" class = "btn btn-primary">목록</a>
				<a onclick="return confirm('추천하시겠습니까?'')" href = "likeAction.jsp?bbsID=<%= bbsID %>" class = "btn btn-primary">추천</a>
				
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<%
				if(userID != null && userID.equals(bbs.getUserID())){
			%>
					<a href = "update.jsp?bbsID=<%= bbsID %>" class = "btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "deleteAction.jsp?bbsID=<%= bbsID %>" class = "btn btn-primary">삭제</a>
			<% 
				}
			%>		
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>