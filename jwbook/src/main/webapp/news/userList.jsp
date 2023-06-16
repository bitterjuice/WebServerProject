<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.List" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- <jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userTel1"/>
<jsp:setProperty name="user" property="userTel2"/>
<jsp:setProperty name="user" property="userTel3"/>
<jsp:setProperty name="user" property="userEmail"/> --%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴스 토론 게시판</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
<%@ include file = "header.jsp" %>
<style>
	body{padding-top: 50px;}
	
	table {
	  border: 1px #a39485 solid;
	  font-size: .9em;
	  box-shadow: 0 2px 5px rgba(0,0,0,.25);
	  width: 100%;
	  border-collapse: collapse;
	  border-radius: 5px;
	  overflow: hidden;
	}

	th {
	width: 20%;
	text-align: left;
	}
	  
	thead {
	  font-weight: bold;
	  color: #fff;
	  background: #73685d;
	}
	  
	 td, th {
	  padding: 1em .5em;
	  vertical-align: middle;
	}
	  
	 td {
	  border-bottom: 1px solid rgba(0,0,0,.1);
	  background: #fff;
	}
	
	a {
	  color: #73685d;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
		$(document).ready(function(){
			$("#allCheck").change(function(){
				if(this.checked){
					$(".check").prop("checked",true);
				}else{
					$(".check").prop("checked",false);
				}
			});
			
			$("#checkForm").submit(function(){
				if($(".check").filter(":checked").size()==0){
					alert("선택된 회원이 없습니다.");
					return false;
				}
			});
		});
	
</script>

</head>
<body>

	<%
		
	
	
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null || !userID.equals("admin")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자 권한이 필요합니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		List<User> userList = userDAO.getUserList();
		
	%>
	<div class="jumbotron">
		<div class = "container">
			<h2>유저정보 조회(관리자)</h2>
		</div>
	</div>
	<form action="userRemove.jsp" method="post" id="checkForm">
		<table class="table table-striped">
			<thead>
				<tr>
					<th><input type="checkbox" id="allCheck"></th>
					<th>아이디</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody>
				<% for(User user:userList){ %>
				<tr>
					<td>
					<% if(user.getUserID().equals("admin")){ %>
					삭제불가
					<%}else{ %>
					<input type="checkbox" name="checkId" value="<%=user.getUserID()%>" class="check">
					<%} %>
					</td>
					<td><%=user.getUserID() %></td>
					<td><%=user.getUserName() %></td>
					<td><%=user.getUserTel1() %>-<%=user.getUserTel2() %>-<%=user.getUserTel3()%></td>
					<td><%=user.getUserEmail() %></td>
				</tr>
				
				<% } %>
			
			</tbody>		
		
		</table>
		<p><button type="submit">회원삭제</button></p>
		<div id="message" style="color: red;"></div>
	
	
	</form>
	
	
	

</body>
</html>