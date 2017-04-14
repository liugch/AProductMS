package com.comment.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.dao.CommentDao;


@WebServlet("/AllCommentCount.action")
public class AllCommentCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public AllCommentCountServlet() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid=request.getParameter("pid");	
		int count=new CommentDao().pinCount(null, Integer.parseInt(pid));
		response.getWriter().println(count);
	}

}
