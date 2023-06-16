package user;

public class User {
	private String userID;
	private String userPassword;
	private String userName;
	private String userTel1;
	private String userTel2;
	private String userTel3;
	private String userEmail;
	
//	public User(String userID, String userPassword, String userName, String userTel1, String userTel2, String userTel3, String userEmail) {
//		this.userID = userID;
//		this.userPassword = userPassword;
//		this.userName = userName;
//		this.userTel1 = userTel1;
//		this.userTel2 = userTel2;
//		this.userTel3 = userTel3;
//		this.userEmail = userEmail;
//		
//				
//	}
	
	
	
	public User() {
		// TODO Auto-generated constructor stub
	}



	public String getUserID() {
		return userID;
	}
	public String getUserTel1() {
		return userTel1;
	}
	public void setUserTel1(String userTel1) {
		this.userTel1 = userTel1;
	}
	public String getUserTel2() {
		return userTel2;
	}
	public void setUserTel2(String userTel2) {
		this.userTel2 = userTel2;
	}
	public String getUserTel3() {
		return userTel3;
	}
	public void setUserTel3(String userTel3) {
		this.userTel3 = userTel3;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
}
