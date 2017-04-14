package com.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.order.entity.orderList;

/**
 * 	oListID int primary key identity(1,1),				--订单列表编号
	oLID int foreign key references orderForm(oId) ,	--订单编号
	pID int foreign key references productInfo(pid),	--商品编号
	amount int			
 * */
public class orderListDao {
	Connection conn=null;
	ResultSet rs= null;
	PreparedStatement ps=null;
	String sql="";
	public List<orderList> getAll(){
		List<orderList> li=new ArrayList<orderList>();
		orderList of=null;
		sql="select oListID,oLID,pID,amount from orderList";
		try {
			conn=DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				of=new orderList();
				of.setoListID(rs.getInt("oListID"));
				of.setoLID(rs.getInt("oLID"));
				of.setpID(rs.getInt("pID"));
				of.setAmount(rs.getInt("amount"));
				
				li.add(of);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUitl.closeAll(rs, ps, conn);
		}
		return li;
	}
	/**
	 * 创建订单详细列表
	 * @param o
	 * @return
	 */
	public boolean insertOrderList(orderList o){
		boolean bl=false;
			sql="insert orderList(oLID,pID,amount) values(?,?,?)";
			try{
				conn=DBUitl.getCon();
				ps=conn.prepareStatement(sql);
				ps.setInt(1, o.getoLID());
				ps.setInt(2, o.getpID());
				ps.setInt(3, o.getAmount());
				int n=ps.executeUpdate();
				bl=n>0;
			}catch (Exception e){
				e.getMessage();
			}finally{
				DBUitl.closeAll(null, ps, conn);
			}
			
			return bl;
	}
	public static void main(String[] args) {
		
		orderListDao ol=new orderListDao();
		List<orderList> li=ol.getAll();
		for(orderList a:li){
			System.out.println(a.getoListID());
			System.out.println(a.getoLID());
			System.out.println(a.getpID());
			System.out.println(a.getAmount());
		}
		
	}
}
