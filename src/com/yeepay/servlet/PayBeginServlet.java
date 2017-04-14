package com.yeepay.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.dao.orderFormDao;
import com.shopping_cart.dao.shopping_cartDao;
import com.user.dao.UserDao;
import com.yeepay.util.YeePayUtil;

@WebServlet("/paybegin.action")
public class PayBeginServlet extends HttpServlet {  
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response); 
		}  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	        
		        int oid=(int) request.getSession().getAttribute("oLID");//获取订单编号
		        String phone=(String) request.getSession().getAttribute("userName");
		       
		        String IPAddress=null;
		        String remark=null;
		        String IPAddress1=request.getParameter("IPAddress");
		        String remark1=request.getParameter("remark");
		        if(IPAddress1!=null&&!"".equals(IPAddress)){
		        	IPAddress=IPAddress1;
		        }
		        if(remark1!=null&&!"".equals(remark1)){
		        	remark=remark1;
		        }
		        // 	System.out.println("更改发货状态时的订单编号："+oid);
		        int n=new orderFormDao().updateIsPayoff(oid, remark, IPAddress);
		        if(n>0){
		        	 int uid=new UserDao().getUseId(phone);
		        	 //删除购物车里面的商品
		        	 int nn=new shopping_cartDao().deletAll(uid);
		        	 
		        	response.getWriter().println("https://one.teegon.com/buy/createorder?id=f9b949d125d3d476cb78fb02c9a0a9a7");
		        }else{
		        	response.getWriter().println("结算失败!");
		        }
		       // System.out.println("更改发货状态"+n);
		        // 重定向方式向易宝发送请求:
		      
		}

}