<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
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
		
		public int checkPassword(String pwd, String id){
			  
			  // 비밀번호 포맷 확인(영문, 특수문자, 숫자 포함 8자 이상)
			  Pattern passPattern1 = Pattern.compile("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*\\W).{8,20}$");
			  Matcher passMatcher1 = passPattern1.matcher(pwd);
			  
			  if(!passMatcher1.find()){
			    return 1;
			  }
			  
			  // 반복된 문자 확인
			  Pattern passPattern2 = Pattern.compile("(\\w)\\1\\1\\1");
			  Matcher passMatcher2 = passPattern2.matcher(pwd);
			  
			  if(passMatcher2.find()){
			    return 2;
			  }
			  
			  // 아이디 포함 확인
			  if(pwd.contains(id)){
			    return 3;
			  }
			  
			  // 특수문자 확인
			  Pattern passPattern3 = Pattern.compile("\\W");
			  Pattern passPattern4 = Pattern.compile("[!@#$%^*+=-]");
			  
			  for(int i = 0; i < pwd.length(); i++){
			    String s = String.valueOf(pwd.charAt(i));
			    Matcher passMatcher3 = passPattern3.matcher(s);
			    
			    if(passMatcher3.find()){
			      Matcher passMatcher4 = passPattern4.matcher(s);
			      if(!passMatcher4.find()){
			        return 4;
			      }
			    }   
			  }
			  
			  //연속된 문자 확인
			  int ascSeqCharCnt = 0; // 오름차순 연속 문자 카운트
			  int descSeqCharCnt = 0; // 내림차순 연속 문자 카운트
			  
			  char char_0;
			  char char_1;
			  char char_2;
			  
			  int diff_0_1;
			  int diff_1_2;
			  
			  for(int i = 0; i < pwd.length()-2; i++){
			    char_0 = pwd.charAt(i);
			    char_1 = pwd.charAt(i+1);
			    char_2 = pwd.charAt(i+2);
			    
			    diff_0_1 = char_0 - char_1;
			    diff_1_2 = char_1 - char_2;
			    
			    if(diff_0_1 == 1 && diff_1_2 == 1){
			      ascSeqCharCnt += 1;
			    }
			    
			    if(diff_0_1 == -1 && diff_1_2 == -1){
			      descSeqCharCnt -= 1;
			    }
			  }
			  
			  if(ascSeqCharCnt > 1 || descSeqCharCnt > 1){
			    return 5;
			  }
			  
			  return 0;
			}
	
	
	
	%>
	<%
		String userID = null;
		int pwdResult = checkPassword(user.getUserPassword(),user.getUserID());
		
		
		

		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
		if(user.getUserID()==null || user.getUserPassword()==null || user.getUserName()==null ||
		user.getUserTel1()==null || user.getUserTel2()==null || user.getUserTel3()==null
		|| user.getUserEmail()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('다시 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else if(pwdResult == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호는 영문과 특수문자 숫자를 포함하며 8자 이상이어야 합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(pwdResult == 2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호에 동일한 문자를 과도하게 연속해서 사용할 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(pwdResult == 3){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호에 ID를 포함할 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(pwdResult == 4){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호에 특수문자는 !@#$^*+=-만 사용 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(pwdResult == 5){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호에 연속된 문자열을 사용할 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		
		else if(!(invalidNumber(user.getUserTel1()) &&
				invalidNumber(user.getUserTel2()) &&
				invalidNumber(user.getUserTel3()))){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('전화번호를 숫자로 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디 입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
		
		
		
	%>

</body>
</html>