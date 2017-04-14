package com.productInfo.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.dao.AdminDao;
import com.productInfo.dao.PTypeDao;

@WebServlet("/AddPType.action")
public class AddPTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public AddPTypeServlet() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String typeName=request.getParameter("typeName");
		//typeName=new String(new String(typeName).getBytes("iso-8859-1"),"UTF-8");
		//System.out.println("typeName::;"+typeName);
		PTypeDao tdao=new PTypeDao();
		String data=tdao.addPType(typeName);
		//System.out.println(data);
		response.getWriter().println(data);
	}

}
