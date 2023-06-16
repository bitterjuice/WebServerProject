package news;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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

@WebServlet("/debate")
public class DebateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NewsDAO newsDAO;
    private discussionDAO discussionDAO;
    private CommentDAO commentDAO;
    private String title;

    @Override
    public void init() throws ServletException {
        super.init();
        newsDAO = new NewsDAO();
        discussionDAO = new discussionDAO();
        commentDAO = new CommentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String newsIdParam = request.getParameter("newsId");
        int newsId = Integer.parseInt(newsIdParam);
        
        String newsTitle = newsDAO.getNewsTitle(newsId);
        request.setAttribute("newsTitle", newsTitle);
        title = newsTitle;
        String discussionTopic = discussionDAO.getDiscussionTopic(newsId);
        
        if (discussionTopic == null) {
        	discussionTopic = discussionDAO.createEmptyDiscussionTopic(newsId);
        }
        
        request.setAttribute("discussionTopic", discussionTopic);
        int discussionId = discussionDAO.getDiscussionId(newsId);
        
        
        List<Comment> commentList = commentDAO.getCommentsByDiscussionId(discussionId);
        List<Comment> topLevelComments = new ArrayList<>();
        Map<Integer, List<Comment>> childCommentsMap = new HashMap<>();

        // PARENT_COMMENT_ID가 0인 댓글과 아닌 댓글 분리
        for (Comment comment : commentList) {
            if (comment.getParentCommentId() == 0) {
                topLevelComments.add(comment);
            } else {
                int parentCommentId = comment.getParentCommentId();
                List<Comment> childComments = childCommentsMap.getOrDefault(parentCommentId, new ArrayList<>());
                childComments.add(comment);
                childCommentsMap.put(parentCommentId, childComments);
            }
        }

        request.setAttribute("topLevelComments", topLevelComments);
        request.setAttribute("childCommentsMap", childCommentsMap);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/news/debate.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String newsTitle = title;
        System.out.println("제목:"+newsTitle);
        
        int newsId = newsDAO.getNewsId(newsTitle);
        System.out.println("뉴스아이디"+newsId);
        
        String commentContent = request.getParameter("commentContent");
        String userId = request.getParameter("userId");
        
        int discussionId = discussionDAO.getDiscussionId(newsId);
        System.out.println("토론아이디"+discussionId);
        
        Comment comment = new Comment();
        comment.setDiscussionId(discussionId);
        comment.setParentCommentId(0); // 0은 최상위 댓글임을 의미합니다.
        comment.setContent(commentContent);
        comment.setUserId(userId);
        commentDAO.insertComment(comment);

        // 댓글 추가 후 다시 doGet을 호출하여 댓글 목록을 업데이트합니다.
        response.sendRedirect(request.getContextPath() + "/debate?newsId=" + newsId);
    }




}
