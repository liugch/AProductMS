package com.comment.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.dao.CommentDao;


@WebServlet("/isGoodCommentCount.action")
public class isGoodCommentCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public isGoodCommentCountServlet() {
        super();       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid=request.getParameter("pid");
		String isGood=request.getParameter("isgood");
		int n=new CommentDao().pinCount(isGood, Integer.parseInt(pid));
		response.getWriter().println(n);
	}

}
