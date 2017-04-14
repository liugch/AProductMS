package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/finphone.do")
public class FindPwd_phone_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String phone=request.getParameter("UserName");
			String userYzm = request.getParameter("yzm");
			String sysYzm = (String) request.getSession().getAttribute("sysYzm");
			//System.out.println("userYzm:"+userYzm);
			//System.out.println("sysYzm:"+sysYzm);
			if (userYzm.equalsIgnoreCase(sysYzm)) {
				request.getSession().setAttribute("Findphone", phone);
				request.getRequestDispatcher("FindPwdType.jsp").forward(request, response);
			} else {
				response.getWriter().append("<script>");
				response.getWriter().append("	alert('验证码出错！请重输!');");
				response.getWriter().append("	location.href='FindPwd.jsp';");
				response.getWriter().append("</script>");
			}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
