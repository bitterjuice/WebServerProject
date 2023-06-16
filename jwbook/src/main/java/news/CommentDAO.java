package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    private Connection conn;
    private PreparedStatement pstmt;

    public CommentDAO() {
        try {
            String dbURL = "jdbc:h2:tcp://localhost/~/test";
            String dbID = "sa";
            String dbPassword = "1234";
            Class.forName("org.h2.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertComment(Comment comment) {
        String sql = "INSERT INTO Comments (discussion_id, parent_comment_id, content, user_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
        	System.out.println("토론id"+comment.getDiscussionId());
        	System.out.println("부모id"+comment.getParentCommentId());
        	System.out.println("내용"+comment.getContent());
        	statement.setInt(1, comment.getDiscussionId());
        	
        	if (comment.getParentCommentId() == 0) {
        		String id = null;
        		statement.setString(2, id);
        	}else {
        		statement.setInt(2, comment.getParentCommentId());
        	}
        
            
            statement.setString(3, comment.getContent());
            statement.setString(4, comment.getUserId());
            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                int commentId = generatedKeys.getInt(1);
                comment.setId(commentId);
                System.out.println("Comment with ID " + commentId + " inserted successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Comment> getCommentsByDiscussionId(int discussionId) {
        List<Comment> commentList = new ArrayList<>();

        String sql = "SELECT * FROM comments WHERE discussion_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, discussionId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();
                comment.setId(rs.getInt("comment_id"));
                comment.setDiscussionId(rs.getInt("discussion_id"));
                comment.setParentCommentId(rs.getInt("parent_comment_id"));
                comment.setContent(rs.getString("content"));
                comment.setLikes(rs.getInt("likes"));
                comment.setDislikes(rs.getInt("dislikes"));
                comment.setUserId(rs.getString("user_id"));
                commentList.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(commentList.toString());
        return commentList;
    }
    
    public void deleteComment(int commentId) {
        try {
            String query = "DELETE FROM Comments WHERE comment_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, commentId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void incrementLikeCount(String commentId) {
        try {
            String query = "UPDATE comments SET likes = likes + 1 WHERE comment_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, commentId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getLikeCount(String commentId) {
        int likeCount = 0;
        try {
            String query = "SELECT likes FROM comments WHERE comment_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, commentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                likeCount = rs.getInt("likes");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return likeCount;
    }

	public void incrementDisLikeCount(String commentId) {
		try {
            String query = "UPDATE comments SET dislikes = dislikes + 1 WHERE comment_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, commentId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
		
	}

	public int getDisLikeCount(String commentId) {
		int dislikeCount = 0;
        try {
            String query = "SELECT dislikes FROM comments WHERE comment_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, commentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                dislikeCount = rs.getInt("dislikes");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dislikeCount;
	}

	public void addReply(Comment comment) {
		String sql = "INSERT INTO Comments (discussion_id, parent_comment_id, content, user_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
        	
        	statement.setInt(1, comment.getDiscussionId());
        	
        	if (comment.getParentCommentId() == 0) {
        		String id = null;
        		statement.setString(2, id);
        	}else {
        		statement.setInt(2, comment.getParentCommentId());
        	}
        
            statement.setString(3, comment.getContent());
            statement.setString(4, comment.getUserId());
            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                int commentId = generatedKeys.getInt(1);
                comment.setId(commentId);
                System.out.println("Comment with ID " + commentId + " inserted successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public List<Comment> getCommentsBycommentId(int commentId) {
		 List<Comment> commentList = new ArrayList<>();

	        String sql = "SELECT * FROM comments WHERE comment_id = ?";
	        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            pstmt.setInt(1, commentId);
	            ResultSet rs = pstmt.executeQuery();

	            while (rs.next()) {
	                Comment comment = new Comment();
	                comment.setId(rs.getInt("comment_id"));
	                comment.setDiscussionId(rs.getInt("discussion_id"));
	                comment.setParentCommentId(rs.getInt("parent_comment_id"));
	                comment.setContent(rs.getString("content"));
	                comment.setLikes(rs.getInt("likes"));
	                comment.setDislikes(rs.getInt("dislikes"));
	                comment.setUserId(rs.getString("user_id"));
	                commentList.add(comment);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        System.out.println(commentList.toString());
	        return commentList;
	}

	public int getDiscussionId(int parseInt) {
		int a=0;
		String sql = "SELECT discussion_id FROM comments WHERE comment_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, parseInt);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                a = rs.getInt("discussion_id");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return a;
	}

	public int getparentCommentId(int discussionId) {
		int a=0;
		String sql = "SELECT parent_comment_id FROM comments WHERE discussion_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, discussionId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                a = rs.getInt("parent_comment_id");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return a;
	}

	public List<Comment> getCommentsByparentcommentId(int parentcommentId) {
		 List<Comment> commentList = new ArrayList<>();

	        String sql = "SELECT * FROM comments WHERE parent_comment_id = ?";
	        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            pstmt.setInt(1, parentcommentId);
	            ResultSet rs = pstmt.executeQuery();

	            while (rs.next()) {
	                Comment comment = new Comment();
	                comment.setId(rs.getInt("comment_id"));
	                comment.setDiscussionId(rs.getInt("discussion_id"));
	                comment.setParentCommentId(rs.getInt("parent_comment_id"));
	                comment.setContent(rs.getString("content"));
	                comment.setLikes(rs.getInt("likes"));
	                comment.setDislikes(rs.getInt("dislikes"));
	                comment.setUserId(rs.getString("user_id"));
	                commentList.add(comment);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        System.out.println(commentList.toString());
	        return commentList;
	}

	public boolean checkCommentUser(int commentId, String userId) {
		List<Comment> commentList = getCommentsBycommentId(commentId);
		if(commentList.get(0).getUserId().equals(userId) )
			return true;
		else
			return false;
	}

}
