package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.ArrayList;

public class NewsDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Statement stmt;
	
	public NewsDAO() {
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
	public boolean isNewsTitleExists(String title,String category) {
        String sql = "SELECT COUNT(*) FROM news WHERE title = ? AND category = ?";
        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, title);
            statement.setString(2, category);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

	public void insertNews(String title, String url, String category) {
	    if (isNewsTitleExists(title,category)) {
	        System.out.println("제목이 '" + title + "'인 뉴스가 이미 존재합니다. 삽입을 건너뜁니다.");
	        return;
	    }

	    String sql = "INSERT INTO NEWS (title, link, category) VALUES (?, ?, ?)";
	    try (PreparedStatement statement = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
	        statement.setString(1, title);
	        statement.setString(2, url);
	        statement.setString(3, category);
	        statement.executeUpdate();

	        // 생성된 news_id 가져오기
	        ResultSet generatedKeys = statement.getGeneratedKeys();
	        if (generatedKeys.next()) {
	            int newsId = generatedKeys.getInt(1);
	            System.out.println("news_id가 " + newsId + "인 뉴스가 삽입되었습니다.");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	public List<News> getRecentNewsByCategory(String category, int limit) {
	    List<News> newsList = new ArrayList<>();

	    String sql = "SELECT * FROM news WHERE category = ? ORDER BY news_id DESC LIMIT ?";
	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, category);
	        pstmt.setInt(2, limit);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            News news = new News();
	            news.setId(rs.getInt("news_id"));
	            news.setTitle(rs.getString("title"));
	            news.setUrl(rs.getString("link"));
	            newsList.add(news);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return newsList;
	}

    
    public String getNewsTitle(int newsId) {
        String newsTitle = null;
        try (
             PreparedStatement statement = conn.prepareStatement("SELECT title FROM news WHERE news_id = ?")) {
            statement.setInt(1, newsId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                newsTitle = resultSet.getString("title");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsTitle;
    }
    public int getNewsId(String title) {
        int id = 0;
        try (
             PreparedStatement statement = conn.prepareStatement("SELECT news_id FROM news WHERE title = ?")) {
            statement.setString(1, title);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                id = resultSet.getInt("news_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }
    public List<News> getAllNews(){
    	 List<News> newsList = new ArrayList<>();

 	    String sql = "SELECT * FROM news";
 	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
 	        ResultSet rs = pstmt.executeQuery();

 	        while (rs.next()) {
 	            News news = new News();
 	            news.setId(rs.getInt("news_id"));
 	            news.setTitle(rs.getString("title"));
 	            newsList.add(news);
 	        }
 	    } catch (SQLException e) {
 	        e.printStackTrace();
 	    }

 	    return newsList;
    }
}