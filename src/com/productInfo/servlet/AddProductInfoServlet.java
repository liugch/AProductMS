package com.productInfo.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.productInfo.dao.PictureListDao;
import com.productInfo.dao.ProductInfoDao;
import com.productInfo.entity.PictureList;
import com.productInfo.entity.ProductInfo;

@WebServlet("/AddProductInfo.action")
public class AddProductInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AddProductInfoServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pName=request.getParameter("pName");
		String types=request.getParameter("types");
		String pDesc=request.getParameter("pDesc");
		String pPrice=request.getParameter("pPrice");
		String amount=request.getParameter("amount");
		String  guiGe=request.getParameter("guiGe");
		String picOne=request.getParameter("hidden1");
		String picTwo=request.getParameter("hidden2");
		String picThree=request.getParameter("hidden3");
		System.out.println(pName+","+types+","+pDesc+","+pPrice+","+amount+","+guiGe+","+picOne+","+picTwo+","+","+picThree);
		ProductInfo p=new ProductInfo();
		
		if(pName!=null&&!"".equals(pName.trim()))
			p.setpName(pName);
		if(types!=null&&!"".equals(types.trim()))
			p.setpTypeInfoId(Integer.parseInt(types));
		if(pDesc!=null&&!"".equals(pDesc.trim()))
			p.setpDesc(pDesc);
		if(pPrice!=null&&!"".equals(pPrice.trim()))
			p.setpPrice(Float.parseFloat(pPrice));
		if(amount!=null&&!"".equals(amount.trim()))
			p.setAmount(Integer.parseInt(amount));
		if(guiGe!=null&&!"".equals(guiGe.trim()))
			p.setGuiGe(guiGe);
		if(picOne!=null&&!"".equals(picOne.trim())){
			p.setpPicture(picOne);
			int rs=new ProductInfoDao().insertProduct(p);
			PictureList plist=new PictureList();
			//查询插入后商品的编号
			int pid=new ProductInfoDao().findPid(pName, picOne);	
			System.out.println("pid:"+pid);
			if(pid!=0){
				plist.setPid(pid);
			}
			plist.setPicOne(picOne);
			
			if(picTwo!=null&&!"".equals(picTwo.trim()))
				plist.setPicTwo(picTwo);
			if(pPrice!=null&&!"".equals(pPrice.trim()))
				plist.setPicThree(picThree);
			rs+=new PictureListDao().insertPic(plist);
			if(rs==2){
				response.getWriter().println("一个商品添加成功!");
			}else{
				response.getWriter().println("商品插入失败");
			}
		}
			
		
	}

}
