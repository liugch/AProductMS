package com.yzm.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class YZServlet
 */
@WebServlet("/yz.do")
public class YZServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userYzm = request.getParameter("yzm");
		String sysYzm = (String) request.getSession().getAttribute("sysYzm");
		if (userYzm.equalsIgnoreCase(sysYzm)) {
			response.getWriter().append("通过验证!");
		} else {
			response.getWriter().append("<script>");
			response.getWriter().append("	alert('验证码出错！请重输!');");
			response.getWriter().append("	location.href='Regist.html';");
			response.getWriter().append("</script>");
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
