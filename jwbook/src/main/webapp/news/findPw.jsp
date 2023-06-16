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
	<div class = "jumbotron">
		<div class = "container">
			<h2>비밀번호 찾기</h2>
		</div>
	</div>
	<form action="findPw_Action.jsp" method = "POST">
		
		<div class = "container" align = "center">
			<div class="col-md-4 col-me-offset-4">
				<h3 class="form-signin-heading">비밀번호 찾기</h3>
					<div class = "form-group">
						<label class="sr-only">아이디</label>
						<input type="text"  name="userID" placeholder="아이디" required autofocus>
					</div>
					<div class = "form-group">
						<label class="sr-only">이메일</label>
						<input type = "email"  name="userEmail" placeholder="이메일" required>
					</div>
					<button class="btn btn-lg btn-success btn-block" type="submit">찾기</button>
					
			</div>
		</div>
			
		
 </form>
</body>
</html>