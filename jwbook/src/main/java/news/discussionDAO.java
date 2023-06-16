package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class discussionDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Statement stmt;
	
	public discussionDAO() {
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
	public String getDiscussionTopic(int newsId) {
	    String content = null;
	    try (PreparedStatement statement = conn.prepareStatement("SELECT content FROM DISCUSSIONS WHERE news_id = ?")) {
	        statement.setInt(1, newsId);
	        ResultSet resultSet = statement.executeQuery();
	        if (resultSet.next()) {
	            content = resultSet.getString("content");
	        } else {
	        	return content;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return content;
	}

	public int  getDiscussionId(int newsId) {
	    int content = 0;
	    try (PreparedStatement statement = conn.prepareStatement("SELECT discussion_id FROM DISCUSSIONS WHERE news_id = ?")) {
	        statement.setInt(1, newsId);
	        ResultSet resultSet = statement.executeQuery();
	        if (resultSet.next()) {
	            content = resultSet.getInt("discussion_id");
	        } else {
	        	return content;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return content;
	}
	
	public String createEmptyDiscussionTopic(int newsId) {
	    String emptyTopic = "No Topic";
	    try (PreparedStatement statement = conn.prepareStatement("SELECT content FROM DISCUSSIONS WHERE news_id = ?")) {
	        statement.setInt(1, newsId);
	        ResultSet resultSet = statement.executeQuery();
	        if (resultSet.next()) {
	            // 이미 토론 주제가 생성되어 있다면 반환
	            return resultSet.getString("content");
	        } else {
	            // 토론 주제가 없을 경우, 새로 생성
	            try (PreparedStatement insertStatement = conn.prepareStatement("INSERT INTO DISCUSSIONS (news_id, content) VALUES (?, ?)")) {
	                insertStatement.setInt(1, newsId);
	                insertStatement.setString(2, emptyTopic);
	                insertStatement.executeUpdate();
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return emptyTopic;
	}
	public void createDiscussion(int newsId,String commentContent) {
		
		try (PreparedStatement statement = conn.prepareStatement("SELECT content FROM DISCUSSIONS WHERE news_id = ?")) {
	        statement.setInt(1, newsId);
	        ResultSet resultSet = statement.executeQuery();
	        if (resultSet.next()) {
	            // 이미 토론 주제가 생성되어 있다면 수정
	            try (PreparedStatement updateStatement = conn.prepareStatement("UPDATE DISCUSSIONS SET content = ? WHERE news_id = ?")) {
	                updateStatement.setString(1,commentContent);
	                updateStatement.setInt(2, newsId);
	                updateStatement.executeUpdate();
	            }
	        } else {
	            // 토론 주제가 없을 경우, 새로 생성
	            try (PreparedStatement insertStatement = conn.prepareStatement("INSERT INTO DISCUSSIONS (news_id, content) VALUES (?, ?)")) {
	                insertStatement.setInt(1, newsId);
	                insertStatement.setString(2, commentContent);
	                insertStatement.executeUpdate();
	            }
	        }
	    }
		catch (SQLException e) {
	        e.printStackTrace();
	    }
		
	}
	public int getnewsId(int discussionid) {
		int content = 0;
	    try (PreparedStatement statement = conn.prepareStatement("SELECT news_id FROM DISCUSSIONS WHERE discussion_id = ?")) {
	        statement.setInt(1, discussionid);
	        ResultSet resultSet = statement.executeQuery();
	        if (resultSet.next()) {
	            content = resultSet.getInt("news_id");
	        } else {
	        	return content;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return content;
	}


}
