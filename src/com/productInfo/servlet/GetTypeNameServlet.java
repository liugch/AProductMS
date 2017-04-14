package com.productInfo.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.productInfo.dao.PTypeDao;


@WebServlet("/GetTypeName.action")
public class GetTypeNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tid=request.getParameter("tid");
		if(tid!=null&&!"".equals(tid.trim())){
			String pName=new PTypeDao().getTypeName(Integer.parseInt(tid));
			response.getWriter().println(pName);
		}
	}

}
