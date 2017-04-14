package com.productInfo.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.productInfo.dao.PictureListDao;
import com.productInfo.entity.PictureList2;


@WebServlet("/GetAllpriceServlet2.action")
public class GetAllpriceServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid=request.getParameter("pid");
		List<PictureList2> list2=new PictureListDao().getAllPic2(Integer.parseInt(pid));
		String g2=new Gson().toJson(list2);
		response.getWriter().println(g2);
	}

}
