<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userEmail"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
		UserDAO userDAO = new UserDAO();
		String result = userDAO.findPw(user);
		if(result == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('해당하는 정보로 비밀번호를 찾지 못했습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호는 "+result+" 입니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		if(user.getUserID()==null ||user.getUserEmail()==null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('다시 입력해주세요.')");
					script.println("history.back()");
					script.println("</script>");
		}

		
		
	%>

</body>
</html>