package com.productInfo.servlet;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.productInfo.dao.ProductInfoDao;
import com.productInfo.entity.ProductInfo;
@WebServlet("/AllType.action")
public class AllTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AllTypeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int  pType=Integer.parseInt(request.getParameter("pType"));
		int  pricetype=Integer.parseInt(request.getParameter("pricetype"));
		String  pName=request.getParameter("pName");
		//System.out.println(pName);
		String name=null;
		int type=0;
		int paixu=0;
		if(pType!=0){
			type=pType;
		}
		if(pricetype==1){
			paixu=pricetype;
		}
		if(pName!=null&&!"".equals(pName.trim())){
			name=pName;
		}
		ProductInfoDao pdao=new ProductInfoDao();
		List<ProductInfo> list1=pdao.getProduct(name, type, 0, 0,paixu);
		String g=new Gson().toJson(list1);
		response.getWriter().println(g);
		//	System.out.println(g);
		
	}

}
