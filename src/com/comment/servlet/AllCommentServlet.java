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

import com.util.Pager;


@WebServlet("/AllComment.action")
public class AllCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public AllCommentServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CommentDao cdao=new CommentDao();
		int currentPage=1;
		int pageSize=3;
		String pageNum = request.getParameter("page");
		String size=request.getParameter("rows");
		if(pageNum != null){
			currentPage = Integer.parseInt(pageNum);
			//System.out.println("pageNum:"+pageNum);
		}
		if(size!=null){
			pageSize=Integer.parseInt(size);
			//System.out.println("size:"+size);
		}

		String pName=null;
		String isGood=null;
		String  fromTime=null;
		String toTime=null;
		
		String name=request.getParameter("pName");
		String Good=request.getParameter("isGood");
		String from=request.getParameter("fromTime");
		String to=request.getParameter("toTime");
	
		if(name!=null&&!"".equals(name.trim())){
			pName=name;
		//	System.out.println(name);
		}
		if(Good!=null&&!"".equals(Good.trim())&&Good!="ÔÝÎÞÆÀ¼Û"){
			isGood=Good;
			//System.out.println(Good);
		}
		if(from!=null&&!"".equals(from.trim())){
			fromTime=from;
			//System.out.println("from:"+from);
		}
		if(to!=null&&!"".equals(to.trim())){
			toTime=to;
			//System.out.println("to:"+to);
		}
		Pager<Comment> pager=cdao.listEmps(currentPage, pageSize, pName, isGood, fromTime, toTime);
		List<Comment> list=pager.getDataList();
		
		String json=new Gson().toJson(list);
		//System.out.println(json);
		int total=cdao.count();
		//String l="{\"total\":"+total+",\"rows\":"+json+"}";
		//System.out.println(l);
		response.getWriter().append("{\"total\":"+total+",\"rows\":"+json+"}");
	}

}
