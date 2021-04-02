<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>  
<%@ page import="java.io.PrintWriter" %>   
<%-- 외부 내부 페이지 import 하기--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- user/User.java에서 ID,Email --%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userEmail" />


<!DOCTYPE html>
<html>
<head>
<meta http-equv="Content-Type" content = "text/html"; charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null)
		{
			userID = (String) session.getAttribute("userID");
		}
	
		if(userID != null)	// 이미 로그인이 되어있는 유저는 아이디를 또 찾게 X
		{
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 되어있습니다.')");
				script.println("location.href = 'main.jsp'");	
				script.println("</script>");
			}
		}
		
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.findPwd(user.getUserID(), user.getUserEmail());
		if (result == 1) 		 // ID와 Email이 맞는 데이터 존재!
		{
			String who_ID = user.getUserID();
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호는 암호화되어있어 변경만 가능합니다.')");
			script.println("location.href = 'changePwd.jsp?userID="+ user.getUserID() + "'");
			script.println("</script>");
		}
		else	// 아이디 찾기 성공
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이름이나 이메일이 틀립니다.')");
			script.println("history.back()");		// 이전 페이지로 사용자 돌려보내기
			script.println("</script>");
		}

		
	%>
</body>
</html>



