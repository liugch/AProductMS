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
		int price=Integer.parseInt(request.getParameter("totalPrice"));//��ȡ��Ʒ�ܽ����
		
		 int danjia=Integer.parseInt( request.getParameter("danjia"));//��ȡ����
		// System.out.println("���ۣ�"+danjia);
		 String name=request.getParameter("ming");//��Ʒ����
		 String guige=request.getParameter("gg");//���
		 
		 request.getSession().setAttribute("names", name);
		 request.getSession().setAttribute("guige", guige);
		 
		// System.out.println(name);
		 //System.out.println(guige);
		 
		  int amount=Integer.parseInt( request.getParameter("amount"));//��ȡ��Ʒ����
		  request.getSession().setAttribute("amount", amount);
		 int  pID=Integer.parseInt(request.getParameter("check"));//��ȡ��Ʒid]
		 System.out.println("pID:"+pID);
		 System.out.println("price:"+price);
		 System.out.println("amount:"+amount);
		 
			//��ȡ��¼ʱ�绰����
		String phone=(String) request.getSession().getAttribute("userName");//MianLogin�ﱣ���phone
		int uid=new  UserDao().getUseId(phone);//���ݵ绰���û����		
		Random rand= new Random();
		int non = rand.nextInt(10000)%(10000-1000+1) + 1000;
		Date subtime=new Date(System.currentTimeMillis());
		
		//��������
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
		System.out.println("��������:"+n);
		System.out.println(of);
		
		
		//����geiOId�����õ��������
		List<orderForm> oid=new orderFormDao().getOId();    
			int oLID=0;
		for(orderForm a:oid){
			oLID=a.getoID();
		}
		
		
		//����������Ϣ�б�
		orderList ol=new orderList();
		ol.setoLID(oLID);
		ol.setpID(pID);
		ol.setAmount(amount);
		System.out.println(oLID);
		System.out.println(pID);
		System.out.println(amount);
		boolean l=new orderListDao().insertOrderList(ol);
		System.out.println("����������Ϣ�б�"+l);
		
		//���ݵ绰�����ѯ�û�id  ������UserDAO
		
		request.getSession().setAttribute("danjia",danjia);
		request.getSession().setAttribute("price", price);
		
		request.getSession().setAttribute("oLID", oLID);//���涩�����
		System.out.println("ת��ǰ�Ķ������"+oLID);
		request.getRequestDispatcher("money.jsp").forward(request, response);
	}

}
