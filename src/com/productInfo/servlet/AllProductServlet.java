package com.productInfo.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.productInfo.dao.ProductInfoDao;
import com.productInfo.entity.ProductInfo;
import com.util.Pager;

@WebServlet("/AllProduct.action")
public class AllProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AllProductServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductInfoDao pdao=new ProductInfoDao();
		int currentPage=1;
		int pageSize=3;
		String pageNum = request.getParameter("page");
		String size=request.getParameter("rows");
		
		if(pageNum != null){
			currentPage = Integer.parseInt(pageNum);
			//System.out.println("pageNum:"+pageNum);
		}
		if(size!=null){
			pageSize=Integer.parseInt(size);
			//System.out.println("size:"+size);
		}

		String pName=null;
		String pTypeName=null;
		float  fromPrice=0;
		float toPrice=0;
		
		String name=request.getParameter("pName");
		String typeName=request.getParameter("typeName");
		String fPrice=request.getParameter("fPrice");
		String tPrice=request.getParameter("tPrice");
	
	
	
		//System.out.println("name:"+name);
		if(name!=null&&!"".equals(name.trim())){
			pName=name;
			System.out.println(name);
		}
		if(typeName!=null&&!"".equals(typeName.trim())){
			pTypeName=typeName;
			System.out.println(typeName);
		}
		if(fPrice!=null&&!"".equals(fPrice.trim())){
			fromPrice=Float.parseFloat(fPrice);
			System.out.println(fPrice);
		}
		if(tPrice!=null&&!"".equals(tPrice.trim())){
			toPrice=Float.parseFloat(tPrice);
			System.out.println(tPrice);
		}
		Pager<ProductInfo> pager=pdao.listEmps(currentPage, pageSize, pName, pTypeName, fromPrice, toPrice);
		List<ProductInfo> list=pager.getDataList();
		
		String json=new Gson().toJson(list);
		//System.out.println(json);
		int total=pdao.count();
		//String l="{\"total\":"+total+",\"rows\":"+json+"}";
		//System.out.println(l);
		response.getWriter().append("{\"total\":"+total+",\"rows\":"+json+"}");
	}

}
