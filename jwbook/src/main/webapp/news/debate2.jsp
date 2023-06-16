<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>뉴스 토론 게시판</title>
    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }

        body {
            text-align: center;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        h1 {
            margin: 20px 0;
            font-size: 24px;
            color: #333;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .commentList {
            margin-top: 20px;
            text-align: left;
            list-style: none;
            padding: 0;
        }
        
        .commentList li {
            margin-bottom: 10px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
            font-size: 16px;
            color: #555;
            position: relative;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .commentList li .actions {
            display: flex;
            align-items: center;
        }

        .commentList li .actions button {
            margin-left: 10px;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
        }

        #commentForm {
            display: none;
        }

        .commentFormWrapper {
            margin-top: 20px;
            text-align: left;
        }

        .commentFormWrapper button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 5px;
        }

        .commentFormWrapper textarea {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            font-size: 14px;
            resize: vertical;
        }
        
        .deleteButton {
            background-color: #333;
            color: #fff;
            padding: 0;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            border-radius: 50%;
            cursor: pointer;
        }
        
        .deleteButton:hover {
            background-color: #f22;
        }
        .answerButton{
        background-image: url("${pageContext.request.contextPath}/news/answer.png");
            background-repeat: no-repeat;
            background-position: center;
           	background-size:24px 24px;
            width: 24px;
            height: 24px;
            display: inline-block;
            cursor: pointer;
        }
        .likeButton {
        	
            background-image: url("${pageContext.request.contextPath}/news/good.png");
            background-repeat: no-repeat;
            background-position: center;
           	background-size:24px 24px;
            width: 24px;
            height: 24px;
            display: inline-block;
            cursor: pointer;
        }
        
        .dislikeButton {
        	
            background-image: url("${pageContext.request.contextPath}/news/bad.png");
            background-repeat: no-repeat;
            background-position: center;
            background-size:24px 24px;
            width: 24px;
            height: 24px;
            display: inline-block;
            cursor: pointer;
        }
        
        .reportButton {
        	
            background-image: url("${pageContext.request.contextPath}/news/siran.png");
            background-repeat: no-repeat;
            background-position: center;
            background-size:24px 24px;
            width: 24px;
            height: 24px;
            display: inline-block;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>${requestScope.newsTitle}</h1>

        <div class="commentFormWrapper">
            <button id="showCommentFormBtn">토론 참여</button>

            <form id="commentForm" action="${pageContext.request.contextPath}/debate" method="POST">
                <input type="hidden" name="newsTitle" value="${requestScope.newsTitle}">
                <textarea name="commentContent" placeholder="댓글 작성" rows="5" required></textarea><br>
                <button type="submit" id="submitCommentBtn">댓글 작성</button>
            </form>
        </div>

        <ul class="commentList" id="commentList">
            <c:forEach items="${requestScope.commentList}" var="comment">
                <li>
                    ${comment.content}
                    <span class="actions">
                    	<button class="answerButton"></button>
                        <button class="likeButton"></button>
                        <button class="dislikeButton"></button>
                        <button class="reportButton"></button>
                        <button class="deleteButton"><svg>...</svg>x</button>
                    </span>
                </li>
            </c:forEach>
        </ul>
    </div>

    <script>
        var showCommentFormBtn = document.getElementById('showCommentFormBtn');
        var commentForm = document.getElementById('commentForm');

        showCommentFormBtn.addEventListener('click', function() {
            showCommentFormBtn.style.display = 'none';
            commentForm.style.display = 'block';
        });

        var deleteButtons = document.getElementsByClassName('deleteButton');
        Array.from(deleteButtons).forEach(function(button) {
            button.addEventListener('click', function(event) {
                var listItem = event.target.parentNode.parentNode;
                listItem.parentNode.removeChild(listItem);
            });
        });
    </script>
</body>
</html>
