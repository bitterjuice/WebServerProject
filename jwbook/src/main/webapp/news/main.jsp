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
	*{padding: 0; margin: 0}
	li{list-style:none}
	a{text-decoration:none;}
	h2 {
		text-align: center;
	}
	.category {
		width: 100%;
		margin: auto;
	}
	.category > li {
		width: 20%; /*카테고리 갯수 x width 값이 100이 되게*/
		float: left;
		text-align: center;
		line-height: 50px;
		height: 50px;
		background: #495057;
		
	}
	.category a {
		color: white;
		font-size: 20px;
		font-weight: bold;
	}
	
	.newsList {
        list-style-type: none;
        padding: 0;
        margin: 0;
        text-align: center;
    }

    .newsList li {
        margin-bottom: 10px;
        border-bottom: 1px solid #ccc;
        padding-bottom: 10px;
    }

    .newsList li:last-child {
        border-bottom: none;
    }
	.newsList a {
        color: #333;
        text-decoration: none;
        font-weight: bold;
        font-size: 18px;
        font-family: 'Arial', sans-serif;
        display: block;
        padding: 5px;
    }

    .newsList a:hover {
        text-decoration: underline;
        background-color: #f1f1f1;
    }
	
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
	<br><br>
	<ul class = "category">
		<li><a href = "/jwbook/news/main?action=general">General</a></li>
		<li><a href = "/jwbook/news/main?action=entertainment">엔터테인먼트</a></li>
		<li><a href = "/jwbook/news/main?action=technology">기술</a></li>
		<li><a href = "/jwbook/news/main?action=sports">스포츠</a></li>
		<li><a href = "/jwbook/news/main?action=science">과학</a></li>
	</ul>
	<hr><hr>
	<ul class="newsList">
    <% 
    String category = request.getParameter("action");
    NewsDAO newsdao = new NewsDAO();
    List<News> newsList = newsdao.getRecentNewsByCategory(category,10);
    for (News news : newsList) { 
    %>
    <li>
        <a href="<%=news.getUrl()%>"><%=news.getTitle()%></a>
        <% if(userID != null) { %>
        	<a href="/jwbook/debate?newsId=<%=news.getId()%>">토론하러 가기</a>	
        <% } else { %>
        	<a href="./login.jsp" 
        	onclick = "javascript:alert('토론은 로그인 후 이용 가능 합니다.')">토론하러 가기</a>
        <% } %>
    </li>
    <% } %>
	</ul>
</body>
</html>