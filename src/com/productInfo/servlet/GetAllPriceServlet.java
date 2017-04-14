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
import com.productInfo.entity.PictureList;


@WebServlet("/GetAllPrice.action")
public class GetAllPriceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public GetAllPriceServlet() {
        super();
       
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid=request.getParameter("pid");
		//System.out.println("pic:::"+pid);
		List<PictureList> list=new PictureListDao().getAllPic(Integer.parseInt(pid));
		String g=new Gson().toJson(list);
		response.getWriter().println(g);
	}

}
