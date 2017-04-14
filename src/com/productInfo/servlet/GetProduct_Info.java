package com.productInfo.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.productInfo.dao.ProductInfoDao;
import com.productInfo.entity.ProductInfo;

/**
 *根据商品编号查找商品详情
 */
@WebServlet("/GetProduct_Info.action")
public class GetProduct_Info extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		int pid=Integer.parseInt(request.getParameter("pid"));
		List<ProductInfo> li=new ProductInfoDao().getProductByPid(pid);
		request.getSession().setAttribute("li", li);
		//System.out.println(pid);
		request.getRequestDispatcher("product1.jsp").forward(request, response);
	}

}
