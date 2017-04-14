package com.shopping_cart.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shopping_cart.dao.shopping_cartDao;


@WebServlet("/DeleteCart.action")
public class DeleteCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public DeleteCartServlet() {
        super();       
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid=request.getParameter("pid");
		//System.out.println(cid);
		String[] sids=new String[1];
		sids[0]=pid;
		//System.out.println(cids.toString());
		int n=new shopping_cartDao().delete__shopping_cart(sids);
		response.getWriter().println("É¾³ýÉÌÆ·"+n);
	}

}
