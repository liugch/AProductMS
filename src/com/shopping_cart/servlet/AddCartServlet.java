package com.shopping_cart.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.productInfo.dao.ProductInfoDao;
import com.productInfo.entity.ProductInfo;
import com.shopping_cart.dao.shopping_cartDao;
import com.shopping_cart.entity.shopping_cart;
import com.user.dao.UserDao;


@WebServlet("/AddCart.action")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AddCartServlet() {
        super();      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid=request.getParameter("pid");
		//System.out.println("pid:"+pid);
		shopping_cartDao sdao=new shopping_cartDao();
		int n=0;
		List<ProductInfo> list=new ProductInfoDao().getProductByPid(Integer.parseInt(pid));
		if(list!=null){
			ProductInfo p=list.get(0);
			shopping_cart s=new shopping_cart();
			s.setPrice(p.getpPrice());
			s.setSguiGe(p.getGuiGe());
			s.setSid(p.getPid());
			s.setsName(p.getpName());
			s.setsPicture(p.getpPicture());
			s.setAmount(1);
			s.setTotal(p.getpPrice());
			if(request.getSession().getAttribute("userName")!=null){
				String uids=(String) request.getSession().getAttribute("userName");
				int uid=new UserDao().getUseId(uids);
				s.setUserID(uid);
				n=sdao.insert_shopping_cart(s);
				//System.out.println(n);
				if(n>0){
					response.getWriter().println("成功添加到购物车!");
				}else{
					response.getWriter().println("添加到购物车失败!");
				}
			}else{
				response.getWriter().println("你还没有登录");
			}
			
		}
		
	}

}
