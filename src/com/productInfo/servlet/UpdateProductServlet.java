package com.productInfo.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.productInfo.dao.ProductInfoDao;
import com.productInfo.entity.ProductInfo;

@WebServlet("/UpdateProduct.action")
public class UpdateProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public UpdateProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取字段的值
		String pid=request.getParameter("pid");
		String pName=request.getParameter("pName");
		String pPrice=request.getParameter("pPrice");
		String amount=request.getParameter("amount");
		ProductInfo p=new ProductInfo();
		p.setPid(Integer.parseInt(pid));
		if(pName!=null&&!"".equals(pName.trim())){
			p.setpName(pName);
		}
		if(pPrice!=null&&!"".equals(pPrice.trim())){
			p.setpPrice(Float.parseFloat(pPrice));
		}
		if(amount!=null&&!"".equals(amount.trim())){
			p.setAmount(Integer.parseInt(amount));
		}
	//	System.out.println("upadate============"+pName+pPrice+amount);
		String data=new ProductInfoDao().updatProduct(p);
		response.getWriter().println(data);
	}

}
