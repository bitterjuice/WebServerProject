package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {
	private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public ReportDAO() {
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
    
    public void Report(String commentId, String reportReason, String reporterId) {
    	String query = "insert into REPORTS(COMMENT_ID, REASON, REPORTER_ID) values (?,?,?)";
    	
    	try {
    		pstmt = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
    		pstmt.setString(1, commentId);
    		pstmt.setString(2, reportReason);
    		pstmt.setString(3, reporterId);
    		
    		pstmt.executeUpdate();
    		
    		ResultSet generatedKeys = pstmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int reportID = generatedKeys.getInt(1);
                System.out.println("Report with ID " + reportID + " inserted successfully.");
            }
    	} catch(Exception e) { e.printStackTrace(); }
    }
    
    
    public List<Report> getReportList(){
		List<Report> reportList = new ArrayList<Report>();
		String SQL = "select * from reports order by report_ID";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Report report = new Report();
				report.setReport_id(rs.getInt("report_id"));
				report.setComment_id(rs.getInt("comment_id"));
				report.setReason(rs.getString("reason"));
				report.setReporter_id(rs.getString("reporter_id"));

				reportList.add(report);
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return reportList;
	}
    
    
    
    
    
    
    
    
    
    
    
    
    
}
