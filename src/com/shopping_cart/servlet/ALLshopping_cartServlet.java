package com.shopping_cart.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.shopping_cart.dao.shopping_cartDao;
import com.shopping_cart.entity.shopping_cart;
import com.user.dao.UserDao;


@WebServlet("/ALLshopping.do")
public class ALLshopping_cartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String phone=request.getParameter("userName");
		//System.out.println(phone);
		int useid=new UserDao().getUseId(phone);
		List<shopping_cart> li=new shopping_cartDao().getAll(useid);
		String  g=new Gson().toJson(li);
		//System.out.println(g);
		response.getWriter().println(g);
	}

}
