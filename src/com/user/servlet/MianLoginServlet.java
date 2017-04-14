package com.user.servlet;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.user.dao.UserDao;

@WebServlet("/Mian.do")
public class MianLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public MianLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	//	PrintWriter out = response.getWriter();
		//String html="";
		String phone=request.getParameter("phone");
		String Pwd=request.getParameter("Pwd");
		String UserNameRemeber=request.getParameter("UserNameRemeber");
	//	System.out.println("UserNameRemeber:"+UserNameRemeber);
		
		UserDao udao=new UserDao();
		int bl= udao.login(phone.trim(), Pwd.trim());
		System.out.println(bl);
		if(bl>0){
			/*Cookie cookie1=new Cookie("uid",phone);
			Cookie cookie2=new Cookie("upwd",Pwd);
			if(UserNameRemeber.equals("true")){
				cookie1.setMaxAge(7*24*60*60);
				cookie2.setMaxAge(7*24*60*60);
			}
			response.addCookie(cookie1);
			response.addCookie(cookie2);*/
			request.getSession().setAttribute("userName", phone);
			response.sendRedirect("/AProductMS/index.jsp");
		}else{
			request.setAttribute("msg1", "’À∫≈≤ª¥Ê‘⁄!");
			request.getRequestDispatcher("/Login.jsp").forward(request,response);;
			
		}
	
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
