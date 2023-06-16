<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.ReportDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="news.Report" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.List" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- <jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
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
		ReportDAO reportDAO = new ReportDAO();
		List<Report> reportList = reportDAO.getReportList();
		
	%>
	<div class="jumbotron">
		<div class = "container">
			<h2>신고내역 조회(관리자)</h2>
		</div>
	</div>
	<form>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>신고_ID</th>
					<th>댓글_ID</th>
					<th>사유</th>
					<th>신고자_ID</th>
				</tr>
			</thead>
			<tbody>
				<% for(Report report:reportList){ %>
				<tr>
					<td><%=report.getReport_id() %></td>
					<td><%=report.getComment_id() %></td>
					<td><%=report.getReason() %></td>
					<td><%=report.getReporter_id() %></td>
				</tr>
				
				<% } %>
			
			</tbody>		
		
		</table>

	
	
	</form>
	


</body>
</html>