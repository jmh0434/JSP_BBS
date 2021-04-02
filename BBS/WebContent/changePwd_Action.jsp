<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>  
<%@ page import="java.io.PrintWriter" %>   
<%-- 외부 내부 페이지 import 하기--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- user/User.java에서 ID,Email --%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userPassword" />



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
		
		String whoWantChangePwd_ID = request.getParameter("userID");
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.changePwd(user.getUserPassword(), whoWantChangePwd_ID);
		if (result == 1) 		 // ID와 Email이 맞는 데이터 존재!
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('성공')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else	// 아이디 찾기 성공
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호 바꾸기를 실패하였습니다." +user.getUserPassword()+ "')");
			script.println("history.back()");		// 이전 페이지로 사용자 돌려보내기
			script.println("</script>");
		}

		
	%>
</body>
</html>



