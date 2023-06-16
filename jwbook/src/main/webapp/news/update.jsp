<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- <jsp:useBean id="user" class="user.User" scope="page"/> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
<title>뉴스 토론 게시판</title>
<%@ include file = "header.jsp" %>
<style>
	body{padding-top: 100px;}
</style>
</head>
<body>
<div class="jumbotron">
	<div class = "container">
		<h1>정보수정</h1>
	</div>
</div>

<%
	userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	else if(session.getAttribute("userID")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	
	User user = new UserDAO().getUser(userID);
	if(!userID.equals(user.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
%>


<div class="container">
	<form action = "updateAction.jsp" method="post">
		<div class="form-group row">
			<label class="col-sm-2">아이디</label>
			<div class="col-sm-3">
				<input type="text" name="userID" class="form-group" placeholder="ID" value="<%=user.getUserID()%>" readonly>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">비밀번호</label>
			<div class="col-sm-3">
				<input type="password" name="userPassword" class="form-group" placeholder="Password" value="<%=user.getUserPassword()%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">이름</label>
			<div class="col-sm-3">
				<input type="text" name="userName" class="form-group" placeholder="Name" value="<%=user.getUserName()%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">전화번호</label>
			<div class="col-sm-3">
				<input type="text" name="userTel1" class="form-group" size="3" maxlength="3" value="<%=user.getUserTel1()%>">
				<input type="text" name="userTel2" class="form-group" size="4" maxlength="4" value="<%=user.getUserTel2()%>">
				<input type="text" name="userTel3" class="form-group" size="4" maxlength="4" value="<%=user.getUserTel3()%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">이메일</label>
			<div class="col-sm-3">
				<input type="email" name="userEmail" class="form-group" placeholder="Email" value="<%=user.getUserEmail()%>">
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="submit" class="btn btn-primary" value="수정완료">
			</div>
		</div>
	</form>
</div>
</body>
</html>