package com.shopping_cart.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shopping_cart.dao.shopping_cartDao;


@WebServlet("/DeleteAll.action")
public class DeleteAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public DeleteAllServlet() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uid=request.getParameter("uid");
		//System.out.println("Uid:"+uid);
		int n=new shopping_cartDao().deletAll(Integer.parseInt(uid));
		response.getWriter().println(n);
	}

}
