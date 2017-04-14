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
		//String userYzm = request.getParameter("yzm");//��ȡ��֤��
		String username=request.getParameter("username");//��ȡ�û���
		String phone=request.getParameter("Phone_Mobile");//��ȡ�绰����
		String name=request.getParameter("name");//��ȡ����
		String address=request.getParameter("address");//��ȡ�ʼĵ�ַ
		String Email=request.getParameter("Email");//��ȡ�ʼ�
		int sex=Integer.parseInt(request.getParameter("sex"));
		String password=request.getParameter("Phone_Password");//��ȡ����
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
			request.setAttribute("rigistmsg", "������ע��");
			request.getRequestDispatcher("/Regist.jsp").forward(request, response);
		}
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
