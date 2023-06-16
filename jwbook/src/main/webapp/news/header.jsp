<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="news.News" %>
<%@ page import="news.NewsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴스 토론 게시판</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
<style>
	nav{
	position: fixed;
	top:0;
	left:0;
	right:0;
	height:50px;}
	
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="/jwbook/news/main.jsp">뉴스 토론 게시판</a>
			<%
				String userID = null;
				if(session.getAttribute("userID")!=null){
					userID = (String) session.getAttribute("userID");
				}
			%>
	
			<%
				if(userID == null){
			%>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="./login.jsp">로그인</a></li>
					<li class="nav-item"><a class="nav-link"
						href="./join.jsp">회원가입</a></li>
				</ul>
			</div>
			
			<%
				}else if(userID != null && userID.equals("admin")){
			
			%>
			
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<span>관리자 페이지 입니다.</span>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="./logoutAction.jsp">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link"
						href="./userList.jsp">회원조회</a></li>
					<li class="nav-item"><a class="nav-link"
						href="./reportList.jsp">신고내역조회</a></li>
					<li class="nav-item"><a class="nav-link"
						href="./topic.jsp">토픽생성</a></li>
				</ul>
			</div>
			
			<%		
				}else{
			%>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="./logoutAction.jsp">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link"
						href="./update.jsp">정보수정</a></li>
				</ul>
			</div>
			<%		
				}
			%>

		</div>
	</nav>
	
</body>
</html>