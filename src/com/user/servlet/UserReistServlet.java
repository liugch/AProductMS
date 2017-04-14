package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.dao.UserDao;
import com.user.entity.User;


@WebServlet("/Reist.do")
public class UserReistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String userYzm = request.getParameter("yzm");//获取验证码
		String username=request.getParameter("username");//获取用户名
		String phone=request.getParameter("Phone_Mobile");//获取电话号码
		String name=request.getParameter("name");//获取姓名
		String address=request.getParameter("address");//获取邮寄地址
		String Email=request.getParameter("Email");//获取邮件
		int sex=Integer.parseInt(request.getParameter("sex"));
		String password=request.getParameter("Phone_Password");//获取密码
		//String hid=request.getParameter("hid");
		User u=new User();
		if(name!=null&&!"".equals(name.trim())){
			u.setName(name);
		}
		if(address!=null&&!"".equals(address.trim())){
			u.setPost(address);
		}
		if(Email!=null&&!"".equals(Email.trim())){
			u.setEmail(Email);
		}
		u.setUsername(username);
		u.setPassword(password);
		u.setPhone(phone);
		u.setSex(sex);
		int n=new UserDao().Register(u);
		if(n>0){
			response.sendRedirect("/AProductMS/successRegist.jsp");
		}else{
			request.setAttribute("rigistmsg", "请重新注册");
			request.getRequestDispatcher("/Regist.jsp").forward(request, response);
		}
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
