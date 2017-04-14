package com.shopping_cart.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shopping_cart.dao.shopping_cartDao;

@WebServlet("/DeletXunZ.action")
public class DeletXunZSerlvelt extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public DeletXunZSerlvelt() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] ids=request.getParameterValues("check");
		int len=ids.length;
	
		int n=new shopping_cartDao().delete__shopping_cart(ids);
		//System.out.println(n);
		response.getWriter().println(len);
	}

}
