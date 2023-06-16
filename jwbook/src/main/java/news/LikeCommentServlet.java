package news;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/likeComment")
public class LikeCommentServlet extends HttpServlet {
    private CommentDAO commentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        commentDAO = new CommentDAO(); // CommentDAO 객체 초기화
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commentId = request.getParameter("commentId"); // 요청 파라미터에서 commentId 가져오기

        // commentId를 사용하여 데이터베이스에서 해당 댓글의 좋아요 수를 증가시킴
        commentDAO.incrementLikeCount(commentId);

        // 업데이트된 좋아요 수 가져오기
        int updatedLikeCount = commentDAO.getLikeCount(commentId);

        String responseData = "{\"likes\": " + updatedLikeCount + "}";
        
        response.getWriter().write(responseData);
    }
}
