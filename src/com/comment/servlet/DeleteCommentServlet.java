package com.comment.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.dao.CommentDao;


@WebServlet("/DeleteComment.action")
public class DeleteCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public DeleteCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String commentId=request.getParameter("commentId");
		System.out.println(commentId);
		int n=new CommentDao().deleteComment(Integer.parseInt(commentId));
		response.getWriter().println(n);
	}

}
