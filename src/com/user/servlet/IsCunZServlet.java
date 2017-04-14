package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.synth.SynthSeparatorUI;

import com.user.dao.UserDao;

@WebServlet("/IsCunZ.action")
public class IsCunZServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public IsCunZServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String phone=request.getParameter("phone");
		System.out.println(phone);
		if(phone!=null){
			int n=new UserDao().isCunZ(phone);
			response.getWriter().println(n);
		}
	}

}
