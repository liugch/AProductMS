package com.order.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.order.dao.orderFormDao;
import com.order.entity.orderForm;
import com.util.Pager;


@WebServlet("/AllOrderForm.action")
public class AllOrderFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		orderFormDao odao=new orderFormDao();
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

		int num=0;
		int ispayoff=0;
		
		String no=request.getParameter("bianhao");	
		String off=request.getParameter("ispayoff");
		//System.out.println("num::"+no);
		//System.out.println("off:::"+off);
		if(no!=null && !"".equals(no.trim())){
			num=Integer.parseInt(no.trim());
		}
		if(off!=null&&!"".equals(off.trim())){
			ispayoff=Integer.parseInt(off);
		}

		Pager<orderForm> pager=odao.listEmps(currentPage, pageSize, num,ispayoff);
		List<orderForm> list=pager.getDataList();
		
		String json=new Gson().toJson(list);
		//System.out.println(json);
		int total=odao.count();
		//String l="{\"total\":"+total+",\"rows\":"+json+"}";
		//System.out.println(l);
		response.getWriter().append("{\"total\":"+total+",\"rows\":"+json+"}");
	}

}
