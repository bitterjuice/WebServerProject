<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
<title>뉴스 토론 게시판</title>
<%@ include file = "header.jsp" %>
<style>
	body{padding-top: 50px;}
</style>
</head>
<body>
<div class="jumbotron">
	<div class = "container">
		<h1>회원가입</h1>
	</div>
</div>
<div class="container">
	<form action = "joinAction.jsp" method="post">
		<div class="form-group row">
			<label class="col-sm-2">아이디</label>
			<div class="col-sm-3">
				<input type="text" name="userID" class="form-group" maxlength="10" placeholder="ID" required>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">비밀번호</label>
			<div class="col-sm-3">
				<input type="password" name="userPassword" class="form-group" placeholder="Password" required>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">이름</label>
			<div class="col-sm-3">
				<input type="text" name="userName" class="form-group" placeholder="Name" required>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">전화번호</label>
			<div class="col-sm-3">
				<input type="text" name="userTel1" class="form-group" size="3" maxlength="3">
				<input type="text" name="userTel2" class="form-group" size="4" maxlength="4">
				<input type="text" name="userTel3" class="form-group" size="4" maxlength="4">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">이메일</label>
			<div class="col-sm-3">
				<input type="email" name="userEmail" class="form-group" placeholder="Email" required>
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="submit" class="btn btn-primary" value="등록">
			</div>
		</div>
	</form>
</div>
</body>
</html>