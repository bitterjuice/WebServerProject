<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.regex.Pattern" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userTel1"/>
<jsp:setProperty name="user" property="userTel2"/>
<jsp:setProperty name="user" property="userTel3"/>
<jsp:setProperty name="user" property="userEmail"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%! 
		public static boolean invalidNumber(String str){
			return Pattern.matches("[0-9]{1,11}",str);
		} 
	%>
	<%
		String userID = null;
	
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
	
		
		if(request.getParameter("userName") != null){
			user.setUserName(request.getParameter("userName"));
		}
		if(request.getParameter("userTel1") != null){
			user.setUserTel1(request.getParameter("userTel1"));
		}
		if(request.getParameter("userTel2") != null){
			user.setUserTel2(request.getParameter("userTel2"));
		}
		if(request.getParameter("userTel3") != null){
			user.setUserTel3(request.getParameter("userTel3"));
		}
		if(request.getParameter("userEmail") != null){
			user.setUserEmail(request.getParameter("userEmail"));
		}
		
		if(!userID.equals(user.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else{
			if(user.getUserPassword()==null || user.getUserName()==null || user.getUserTel1()==null || user.getUserTel2()==null || user.getUserTel3()==null|| user.getUserEmail()==null || 
					user.getUserPassword().equals("") || user.getUserName().equals("") || user.getUserTel1().equals("") || user.getUserTel2().equals("") || user.getUserTel3().equals("")|| user.getUserEmail().equals("") ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 부분이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				UserDAO userDAO = new UserDAO();
				int result = userDAO.update(user);
				
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정 완료했습니다.')");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
				
			}
				
		}
		
		
		
		
	%>

</body>
</html>