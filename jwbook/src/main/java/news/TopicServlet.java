package news;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TopicServlet
 */
@WebServlet("/topic")
public class TopicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NewsDAO newsDAO;
    private discussionDAO discussionDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        newsDAO = new NewsDAO();
        discussionDAO = new discussionDAO();
    }
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopicServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 토픽 작성 처리
        int newsId = Integer.parseInt(request.getParameter("newsid"));
        String commentContent = request.getParameter("commentContent");

        // 토픽 생성
        discussionDAO.createDiscussion(newsId, commentContent);

        // 토픽 작성 후에 원래 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/news/main.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
