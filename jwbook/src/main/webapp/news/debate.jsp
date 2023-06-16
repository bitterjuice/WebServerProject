<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>뉴스 토론 게시판</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
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
		h3 {
            margin: 20px 0;
            font-size: 24px;
            color: #333;
        }
        .container2 {
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
        .replyList {
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

        .commentForm {
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
        
         .replyForm {
            display: none;
        }
        
        .submitCommentBtn {
	    padding: 10px 20px;
	    font-size: 16px;
	    cursor: pointer;
	    background-color: #333;
	    color: #fff;
	    border: none;
	    border-radius: 5px;
		}
        

        .replyFormWrapper {
            margin-top: 20px;
            text-align: left;
        }

        .replyFormWrapper textarea {
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
        
       .answerButton {
	    background-image: url("${pageContext.request.contextPath}/news/answer.png"); /* Change the image URL to the desired image */
	    background-repeat: no-repeat;
	    background-position: center;
	    background-size: 24px 24px;
	    width: 24px;
	    height: 24px;
	    display: inline-block;
	    cursor: pointer;
	    color: transparent;
	     border-radius: 20%; /* Add this line to apply rounded corners */
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
            color: transparent;
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
            color: transparent;
        }
        
        .likeButton:hover,
		.dislikeButton:hover {
    	background-image: none; /* 배경 이미지 제거 */
    	background-color: transparent; /* 배경 색상 투명하게 설정 */
    	color: black; /* 글자 색상 투명하게 설정 */
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
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="/jwbook/news/main.jsp">뉴스 토론 게시판</a>	
			<%
				if(userID == null){
			%>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="/jwbook/news/login.jsp">로그인</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/jwbook/news/join.jsp">회원가입</a></li>
				</ul>
			</div>
			
			<%
				}else if(userID != null && userID.equals("admin")){
			
			%>
			
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<span>관리자 페이지 입니다.</span>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="/jwbook/news/logoutAction.jsp">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/jwbook/news/userList.jsp">회원조회</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/jwbook/news/reportList.jsp">신고내역조회</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/jwbook/news/topic.jsp">토픽생성</a></li>
				</ul>
			</div>
			
			<%		
				}else{
			%>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="/jwbook/news/logoutAction.jsp">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/jwbook/news/update.jsp">정보수정</a></li>
				</ul>
			</div>
			<%		
				}
			%>

		</div>
	</nav>
	<br><br><br>
	
    <div class="container2">
        <h1>${newsTitle}</h1>
        
        <h3>
	        <div class="admintalk">
	        	오늘의 토론주제 : ${discussionTopic}
	        </div>
        </h3>
        

    	<div class="commentFormWrapper">
    		<button class="showCommentFormBtn">토론 참여</button>

   			 <form class="commentForm" action="${pageContext.request.contextPath}/debate" method="POST">
        			<input type="hidden" name="newsTitle" value="${newsTitle}">
        			<input type="hidden" name="userId" value = "<%=userID%>">
        			<textarea name="commentContent" placeholder="댓글 작성" rows="5" required></textarea><br>
       				<button type="submit" class="submitCommentBtn">댓글 작성</button>
   			 </form>
		</div>
	<br>
	<hr>
	<ul class="commentList" id="commentList">
	  <c:forEach items="${topLevelComments}" var="comment">
	    <li>
	      ${comment.content}
	      <span class="actions">
	        <button class="likeButton" data-comment-id="${comment.id}" data-like="${comment.likes}" onClick="window.location.reload()">${comment.likes}</button>
	        <button class="dislikeButton" data-comment-id="${comment.id}" data-dislike="${comment.dislikes}" onClick="window.location.reload()">${comment.dislikes}</button>
	        <button class="reportButton" data-comment-id="${comment.id}"></button>
	        <button class="deleteButton" data-comment-id="${comment.id}" onClick="window.location.reload()"><svg>...</svg>x</button>
	      </span>
	      
	      <div class="replyFormWrapper">
		        <button class="answerButton" data-comment-id="${comment.id}" data-discussion-id="${comment.discussionId}"></button>
		        <form class="replyForm" action="${pageContext.request.contextPath}/addReply" method="POST" style="display: none;">
			          <input type="hidden" name="commentId" value="${comment.id}">
			          <input type="hidden" name="userId" value = "<%=userID%>">
			          <textarea name="replyContent" placeholder="대댓글 작성" rows="5" required></textarea>
			          <button type="submit" class="submitCommentBtn" onClick="window.location.reload()">대댓글 작성</button>
			          <hr>
					     <ul class="replyList">
					        <c:forEach items="${childCommentsMap[comment.id]}" var="reply">
						          <li>
						            대댓글 : ${reply.content}
						            <span class="actions">
						              <button class="likeButton" data-comment-id="${reply.id}" data-like="${reply.likes}" onClick="window.location.reload()">${reply.likes}</button>
						              <button class="dislikeButton" data-comment-id="${reply.id}" data-dislike="${reply.dislikes}" onClick="window.location.reload()">${reply.dislikes}</button>
						              <button class="reportButton" data-comment-id="${reply.id}" onClick=""></button>
						              <button class="deleteButton" data-comment-id="${reply.id}" onClick="window.location.reload()"><svg>...</svg>x</button>
						            </span>
						          </li>
					        </c:forEach>
				      	</ul>
		      		 <hr>
		        </form>
	      </div>
	  </li>    
	  </c:forEach>
</ul>
    <script>
    
	    var showCommentFormBtns = document.getElementsByClassName('showCommentFormBtn');
	    var commentForms = document.getElementsByClassName('commentForm');
	
	    for (var i = 0; i < showCommentFormBtns.length; i++) {
	        showCommentFormBtns[i].addEventListener('click', function() {
	            var commentForm = this.nextElementSibling;
	            if (commentForm.style.display == 'none') {
	                commentForm.style.display = 'block';
	            } else {
	                commentForm.style.display = 'none';
	            }
	        });
	    }
	   


	    
	    var answerButtons = document.getElementsByClassName('answerButton');
	    var replyForms = document.getElementsByClassName('replyFormWrapper');

	    for (var i = 0; i < answerButtons.length; i++) {
	      answerButtons[i].addEventListener('click', function() {
	        var replyForm = this.nextElementSibling;

	        if (replyForm.style.display == 'none') {
	          replyForm.style.display = 'block';
	        } else {
	          replyForm.style.display = 'none';
	        }
	      });
	    } 
	    
        function deleteComment(commentId) {
            // AJAX를 사용하여 서버에 댓글 삭제 요청을 보냅니다.
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '${pageContext.request.contextPath}/deleteComment', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    // 서버로부터 응답이 오면 댓글을 삭제합니다.
                    var listItem = document.querySelector('li[data-comment-id="' + commentId + '"]');
                    if (listItem) {
                        listItem.remove();
                    }
                }else if(xhr.status === 210){
                	alert("타인의 댓글을 삭제할 수 없습니다.")
                }
            };
            xhr.send('commentId=' + encodeURIComponent(commentId) + '&userId=' + encodeURIComponent("<%=userID%>"));
        }

        // 삭제 버튼에 클릭 이벤트 리스너를 추가합니다.
        var deleteButtons = document.getElementsByClassName('deleteButton');
        for (var i = 0; i < deleteButtons.length; i++) {
            deleteButtons[i].addEventListener('click', function() {
                var commentId = this.getAttribute('data-comment-id');
                deleteComment(commentId);
            });
        }
        
        function likeComment(commentId) {
            // AJAX를 사용하여 서버에 좋아요 요청을 보냅니다.
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '${pageContext.request.contextPath}/likeComment', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    // 서버로부터 응답이 오면 좋아요 수를 업데이트합니다.
                    var likeButton = document.querySelector('button[data-comment-id="' + commentId + '"]');
                    var likeCount = parseInt(likeButton.getAttribute('data-like'));
                    likeCount++; // 좋아요 수 증가
                    likeButton.textContent = likeCount; // 버튼 내용 업데이트
                }
            };
            xhr.send('commentId=' + encodeURIComponent(commentId));
        }

        // 좋아요 버튼에 클릭 이벤트 리스너를 추가합니다.
        var likeButtons = document.getElementsByClassName('likeButton');
        for (var i = 0; i < likeButtons.length; i++) {
            likeButtons[i].addEventListener('click', function() {
                var commentId = this.getAttribute('data-comment-id');
                likeComment(commentId);
            });
        }
        
        function dislikeComment(commentId) {
            // AJAX를 사용하여 서버에 좋아요 요청을 보냅니다.
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '${pageContext.request.contextPath}/dislikeComment', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    // 서버로부터 응답이 오면 좋아요 수를 업데이트합니다.
                    var dislikeButton = document.querySelector('button[data-comment-id="' + commentId + '"]');
                    var dislikeCount = parseInt(dislikeButton.getAttribute('data-dislike'));
                    dislikeCount++; // 좋아요 수 증가
                    dislikeButton.textContent = dislikeCount; // 버튼 내용 업데이트
                }
            };
            xhr.send('commentId=' + encodeURIComponent(commentId));
        }

        // 좋아요 버튼에 클릭 이벤트 리스너를 추가합니다.
        var dislikeButtons = document.getElementsByClassName('dislikeButton');
        for (var i = 0; i < dislikeButtons.length; i++) {
            dislikeButtons[i].addEventListener('click', function() {
                var commentId = this.getAttribute('data-comment-id');
                dislikeComment(commentId);
            });
        }
        
      	//신고 팝업창
        function reportPopup(commentId) {
      		var reason = prompt("신고 사유를 입력해주세요. (예시 : 욕설, 광고 등)", "");
      		if(reason != null) {
      			var xhr = new XMLHttpRequest();
                xhr.open('POST', '${pageContext.request.contextPath}/report', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onreadystatechange = function() {
                	if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                		alert("신고가 완료되었습니다.")
                	}
                };
                xhr.send('commentId=' + encodeURIComponent(commentId) + '&reason=' + encodeURIComponent(reason) +
                		'&reporterId=' + encodeURIComponent("<%=userID%>"));
      		}
      	}
        
        //신고 버튼에 클릭 이벤트 리스너 추가
        var reportButtons = document.getElementsByClassName('reportButton');
        for (var i = 0; i < reportButtons.length; i++) {
        	reportButtons[i].addEventListener('click', function() {
                var commentId = this.getAttribute('data-comment-id');
                reportPopup(commentId);
            });
        }
    </script>
</body>
</html>
