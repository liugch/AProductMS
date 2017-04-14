package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.dao.UserDao;

@WebServlet("/createpwd.action")
public class FindCreatePwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd=request.getParameter("Password");
		//String pwdcfm=request.getParameter("PasswordConfirm");
		String phone= (String) request.getSession().getAttribute("phone_mobile");
		System.out.println(phone);
		System.out.println(pwd);
			boolean bl=new UserDao().updateUser(pwd, phone);
				System.out.println("bl:"+bl);
				if(bl){
					request.getRequestDispatcher("CreatePwdSuccess.jsp").forward(request, response);
				}else{	
					response.getWriter().append("<script>");
					response.getWriter().append("	alert('’“ªÿ√‹¬Î ß∞‹!');");
					response.getWriter().append("	location.href='CreatePwd.jsp';");
					response.getWriter().append("</script>");
				}
			
			
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
