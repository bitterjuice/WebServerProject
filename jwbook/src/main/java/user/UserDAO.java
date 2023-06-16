package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Statement stmt;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:h2:tcp://localhost/~/test";
			String dbID = "sa";
			String dbPassword = "1234";
			Class.forName("org.h2.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM `USER` WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else
					return 0; //비밀번호 불일치
					
			}
			return -1; //아이디 없음
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO `USER`(userid,userpassword,username,usertel1,usertel2,usertel3,useremail) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserTel1());
			pstmt.setString(5, user.getUserTel2());
			pstmt.setString(6, user.getUserTel3());
			pstmt.setString(7, user.getUserEmail());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	
	public User getUser(String userID) {
		String SQL = "SELECT * FROM `USER` WHERE USERID='"+userID+"'";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			User user = new User();
			
			if(rs.next()) {
				user.setUserID(rs.getString("userId"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserName(rs.getString("userName"));
				user.setUserTel1(rs.getString("userTel1"));
				user.setUserTel2(rs.getString("userTel2"));
				user.setUserTel3(rs.getString("userTel3"));
				user.setUserEmail(rs.getString("userEmail"));
				return user;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("return: -1");
		return null;
	}
	
	public int update(User user) {
		String SQL = "UPDATE `USER` SET userID='" + user.getUserID() + "'"+", userPassword = '"+ user.getUserPassword()+"'"+", userName = '"+user.getUserName()+"'"+", userTel1 = '"+user.getUserTel1()+"'"+", userTel2 = '"+user.getUserTel2()+"'"+", userTel3 = '"+user.getUserTel3()+"'"+", userEmail = '"+user.getUserEmail()+"' WHERE userID='"+ user.getUserID() +"'";
		
		try {
			stmt = conn.createStatement();
			return stmt.executeUpdate(SQL);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	
	
	}
	
	public List<User> getUserList(){
		List<User> userList = new ArrayList<User>();
		String SQL = "select * from `user` order by userID";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString("userId"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserName(rs.getString("userName"));
				user.setUserTel1(rs.getString("userTel1"));
				user.setUserTel2(rs.getString("userTel2"));
				user.setUserTel3(rs.getString("userTel3"));
				user.setUserEmail(rs.getString("userEmail"));
				userList.add(user);
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return userList;
	}
	
	
	public int remove(String userId, String userPassword) {
		int rows = 0;
		try {
			String SQL = "";
			if(userPassword==null) {
				SQL = "delete from `user` where userId=?";
			}else {
				SQL = "delete from `user` where userId=? and userPassword=?";
			}
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userId);
			if(userPassword!=null) {
				pstmt.setString(2, userPassword);
			}
			rows = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return rows;
	}
	
	public String findId(User user) {
		String SQL = "select userid from `user` where username=? and useremail=?";
		String userId = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getUserEmail());
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				userId = rs.getString("userId");
			}
			else {
				userId = null;
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return userId;
	}
	
	public String findPw(User user) {
		String SQL = "select userpassword from `user` where userid=? and useremail=?";
		String userPassword = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserEmail());
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				userPassword = rs.getString("userPassword");
			}
			else {
				userPassword = null;
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return userPassword;
	}
	
	
	
	
	
	
	
	
}
