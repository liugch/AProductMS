package com.productInfo.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.productInfo.dao.PictureListDao;
import com.productInfo.dao.ProductInfoDao;


@WebServlet("/DeleteProduct.action")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public DeleteProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String proId=request.getParameter("proId");
		String[] ids=proId.split(",");
		int n=new PictureListDao().deletePicture(ids);
		if(n>0){
			int b=new ProductInfoDao().removeProduct(ids);
			response.getWriter().println(b);
		}	
	}

}
