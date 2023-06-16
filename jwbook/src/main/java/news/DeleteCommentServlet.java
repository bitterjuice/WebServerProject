package news;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteComment")
public class DeleteCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CommentDAO commentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        commentDAO = new CommentDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        int commentId = Integer.parseInt(request.getParameter("commentId"));
        String userId = request.getParameter("userId");
        
        
        if(userId.equals("admin") || commentDAO.checkCommentUser(commentId, userId)) {
        	commentDAO.deleteComment(commentId);
        	// 응답 상태 코드를 200(OK)로 설정하여 클라이언트에게 삭제가 성공했음을 알립니다.
        	response.setStatus(HttpServletResponse.SC_OK);
        } else {
        	//삭제 요청을 한 user와 comment를 작성한 유저가 다를경우
        	response.setStatus(210);
        }
    }
}
