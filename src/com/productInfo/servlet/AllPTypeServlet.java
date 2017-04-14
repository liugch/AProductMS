package com.productInfo.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.productInfo.dao.PTypeDao;
import com.productInfo.entity.PType;

@WebServlet("/AllPType.action")
public class AllPTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AllPTypeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<PType> list=new PTypeDao().getAllPType();
		Gson g=new Gson();
		String list2=g.toJson(list);
		//System.out.println(list2);
		response.getWriter().println(list2);
	}

}
