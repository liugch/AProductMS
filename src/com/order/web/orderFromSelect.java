package com.order.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.dao.orderFormDao;
import com.order.entity.orderForm;

@WebServlet("/Select.do")
public class orderFromSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	   public orderFromSelect() {
	        super();
	     
	    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		orderFormDao of=new orderFormDao();
		List<orderForm> li=of.getAll();
		request.getSession().setAttribute("li", li);
		request.getRequestDispatcher("orderForm.jsp").forward(request, response);

		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
