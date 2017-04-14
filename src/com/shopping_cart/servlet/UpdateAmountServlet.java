package com.shopping_cart.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shopping_cart.dao.shopping_cartDao;


@WebServlet("/UpdateAmount.action")
public class UpdateAmountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public UpdateAmountServlet() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cid=request.getParameter("cid");	
		String op=request.getParameter("op");
		System.out.println(cid);	
		int n=new shopping_cartDao().updateAmount(Integer.parseInt(cid), op);
		
		response.getWriter().println("…Ã∆∑±‡∫≈"+n);
		
	}

}
