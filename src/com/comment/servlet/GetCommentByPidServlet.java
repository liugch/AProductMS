package com.comment.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.dao.CommentDao;
import com.comment.entity.Comment;
import com.google.gson.Gson;


@WebServlet("/GetCommentByPid.action")
public class GetCommentByPidServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public GetCommentByPidServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid=request.getParameter("pid");
		//System.out.println("pid:"+pid);
		String isGood=request.getParameter("isgood");
		if(isGood.equals("a")){
			isGood=null;
		}
		//System.out.println("isGood::"+isGood);
		List<Comment> list=new CommentDao().getCommentByIsGood(isGood, Integer.parseInt(pid));
		String n=new Gson().toJson(list);
		//System.out.println(n);
		response.getWriter().println(n);	
	}

}
