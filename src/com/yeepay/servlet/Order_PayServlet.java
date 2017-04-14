package com.yeepay.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.dao.orderFormDao;
import com.order.dao.orderListDao;
import com.order.entity.orderForm;
import com.order.entity.orderList;
import com.user.dao.UserDao;

@WebServlet("/odpay.action")
public class Order_PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int price=Integer.parseInt(request.getParameter("totalPrice"));//获取商品总金额金额
		
		 int danjia=Integer.parseInt( request.getParameter("danjia"));//获取单价
		// System.out.println("单价："+danjia);
		 String name=request.getParameter("ming");//商品名称
		 String guige=request.getParameter("gg");//规格
		 
		 request.getSession().setAttribute("names", name);
		 request.getSession().setAttribute("guige", guige);
		 
		// System.out.println(name);
		 //System.out.println(guige);
		 
		  int amount=Integer.parseInt( request.getParameter("amount"));//获取商品数量
		  request.getSession().setAttribute("amount", amount);
		 int  pID=Integer.parseInt(request.getParameter("check"));//获取商品id]
		 System.out.println("pID:"+pID);
		 System.out.println("price:"+price);
		 System.out.println("amount:"+amount);
		 
			//获取登录时电话号码
		String phone=(String) request.getSession().getAttribute("userName");//MianLogin里保存的phone
		int uid=new  UserDao().getUseId(phone);//根据电话找用户编号		
		Random rand= new Random();
		int non = rand.nextInt(10000)%(10000-1000+1) + 1000;
		Date subtime=new Date(System.currentTimeMillis());
		
		//创建订单
		orderForm of =new orderForm();
		of.setoNo(non);
		of.setUserID(uid);
		of.setSubmitTime(subtime);
		of.setTotalPrice(price);
		of.setAmount(amount);
		of.setOutTime(subtime);
		of.setRemark("");
		of.setIPAddress("");
		boolean n=new orderFormDao().insertOrderForm2(of);
		System.out.println("创建订单:"+n);
		System.out.println(of);
		
		
		//调用geiOId方法得到订单编号
		List<orderForm> oid=new orderFormDao().getOId();    
			int oLID=0;
		for(orderForm a:oid){
			oLID=a.getoID();
		}
		
		
		//创建订单信息列表
		orderList ol=new orderList();
		ol.setoLID(oLID);
		ol.setpID(pID);
		ol.setAmount(amount);
		System.out.println(oLID);
		System.out.println(pID);
		System.out.println(amount);
		boolean l=new orderListDao().insertOrderList(ol);
		System.out.println("创建订单信息列表"+l);
		
		//根据电话号码查询用户id  方法在UserDAO
		
		request.getSession().setAttribute("danjia",danjia);
		request.getSession().setAttribute("price", price);
		
		request.getSession().setAttribute("oLID", oLID);//保存订单编号
		System.out.println("转发前的订单编号"+oLID);
		request.getRequestDispatcher("money.jsp").forward(request, response);
	}

}
