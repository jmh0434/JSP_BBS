<%@page import="java.io.PrintWriter"%>
<%@page import="likey.LikeyDAO"%>
<%@page import="bbs.BbsDAO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%!
public static String getClientIP(HttpServletRequest request) {
    String ip = request.getHeader("X-FORWARDED-FOR"); 
    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("Proxy-Client-IP");
    }

    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("WL-Proxy-Client-IP");
    }

    if (ip == null || ip.length() == 0) {
        ip = request.getRemoteAddr() ;
    }
    return ip;
}

%>
	<%
		//현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		//로그인을 한 사람만 글을 쓸 수 있도록 한다
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		
		request.setCharacterEncoding("UTF-8");
		String bbsID = null;
		if(request.getParameter("bbsID") != null) {
			bbsID = (String) request.getParameter("bbsID");
		}
		BbsDAO bbsDAO = new BbsDAO();
		LikeyDAO likeyDAO = new LikeyDAO();
		// userID와 userWriteTtilte을 PK, NN 설정이기때매 중복이 불가
		
		int result = likeyDAO.like(userID, bbsID, getClientIP(request));
		// 정상적으로 1번 데이터가 들어가면 1이 출력되고

		if (result == 1) {
			result = bbsDAO.like(bbsID);

			if (result == 1) { // 1인경우 디비에서 해당 게시물 추천 완료
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('추천이 완료되었습니다.');");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
				script.close();
				return;
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
				return;
			}
		} else { // 이미 PK, NN으로 설정되어 중복되면 1 반환이 되지 않음
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 추천을 누른 글입니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
			}
	%>