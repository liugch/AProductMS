package com.order.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.dao.orderFormDao;


@WebServlet("/UpdateOrderForm.action")
public class UpdateOrderFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public UpdateOrderFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int oID=Integer.parseInt(request.getParameter("oID"));
		//System.out.println("oid:;;;;;"+oID);
		orderFormDao odao=new orderFormDao();
		int n=odao.updateIsOut(oID);
		response.getWriter().println(n);
	}

}
