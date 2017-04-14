package com.user.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.user.dao.UserDao;
import com.user.entity.User;
import com.util.Pager;

@WebServlet("/AllUser.action")
public class AllUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AllUserServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDao udao=new UserDao();
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

		Pager<User> pager=udao.listEmps(currentPage, pageSize);
		List<User> list=pager.getDataList();
		
		String json=new Gson().toJson(list);
		//System.out.println(json);
		int total=udao.count();
		//String l="{\"total\":"+total+",\"rows\":"+json+"}";
		//System.out.println(l);
		response.getWriter().append("{\"total\":"+total+",\"rows\":"+json+"}");
	}

}
