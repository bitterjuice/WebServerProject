package news;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReportServlet
 */
@WebServlet("/report")
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReportDAO reportDAO;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportServlet() throws ServletException {
        super();
        reportDAO = new ReportDAO();
    }
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
		String commentId = request.getParameter("commentId");
		String reportReason = request.getParameter("reason");
		String reporterId = request.getParameter("reporterId");
		reportDAO.Report(commentId, reportReason, reporterId);
		
		response.setStatus(HttpServletResponse.SC_OK);
	}
}
