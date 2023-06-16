package news;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddReplyServlet
 */
@WebServlet("/addReply")
public class AddReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommentDAO commentDAO;
	private discussionDAO discussiondao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddReplyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    @Override
    public void init() throws ServletException {
        super.init();
        commentDAO = new CommentDAO(); // CommentDAO 객체 초기화
        discussiondao = new discussionDAO();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");
         response.setCharacterEncoding("UTF-8");
         
		 String commentId = request.getParameter("commentId");
		 System.out.println(commentId);
		 int discussionid = commentDAO.getDiscussionId(Integer.parseInt(commentId));
		 System.out.println(discussionid);
		 String commentContent = request.getParameter("replyContent");
		 System.out.println(commentContent);
		 String userId = request.getParameter("userId");
		 
		 Comment comment = new Comment();
		 comment.setDiscussionId(discussionid);
	     comment.setParentCommentId(Integer.parseInt(commentId)); 
	     comment.setContent(commentContent);
	     comment.setUserId(userId);
	    
	     commentDAO.addReply(comment);
		
	     int newsId = discussiondao.getnewsId(discussionid);
	     
	     response.sendRedirect(request.getContextPath() + "/debate?newsId=" + newsId);
		
	}

}
