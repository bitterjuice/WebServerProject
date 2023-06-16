<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴스 토론 게시판</title>
</head>
<body>
<%
	String[] removeId = request.getParameterValues("checkId");

	for(String id:removeId){
		UserDAO userDAO = new UserDAO();
		userDAO.remove(id, null);
	}
	response.sendRedirect("userList.jsp");
	
%>
</body>
</html>