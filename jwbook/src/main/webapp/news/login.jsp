<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴스 토론 게시판</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
<%@ include file = "header.jsp" %>
<style>
	body{padding-top: 50px;}
</style>
</head>
<body>
	<div class="jumbotron">
		<div class = "container">
			<h1>로그인</h1>
		</div>
	</div>	
	<div class = "container" align = "center">
		<div class="col-md-4 col-me-offset-4">
			<h3 class="form-signin-heading">로그인</h3>
			<form class="form-signin" action="loginAction.jsp" method="post">
				<div class = "form-group">
					<label class="sr-only">User Name</label>
					<input name = "userID" class="form-control" placeholder="ID" required autofocus>
				</div>
				<div class = "form-group">
					<label class="sr-only">Password</label>
					<input type = "password" name = "userPassword" class="form-control" placeholder="password" required>
				</div>
				<button class="btn btn-lg btn-success btn-block" type="submit">로그인</button>
				<br>
				<div class="links">
            		<a href="findId.jsp">아이디 찾기</a> | <a href="findPw.jsp">비밀번호 찾기</a> | <a href="join.jsp">회원가입</a>
            	</div>
			</form>
		</div>
	</div>
</body>
</html>