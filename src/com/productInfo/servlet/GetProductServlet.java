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
 * 搜索框里根据商品名查找商品
 */
@WebServlet("/get.do")
public class GetProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pName=request.getParameter("pName");
		//System.out.println(pName);
		//String name="虾仁";
		ProductInfoDao pd=new ProductInfoDao(); 
		List<ProductInfo> li=pd.getProduct(pName, 0, 0, 0,0);
		request.getSession().setAttribute("li", li);
		request.getRequestDispatcher("Search.jsp").forward(request, response);
	}

}
