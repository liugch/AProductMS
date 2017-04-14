package com.shopping_cart.dao;


import java.util.List;
import com.shopping_cart.entity.shopping_cart;
import com.util.DBUitl;
/*--购物车表
create table shopping_cart( 
	cid int primary key identity(1,1),							--购物车编号 
	userID int foreign key references [user](userID),			--用户编号
	[sid] int foreign key references productInfo(pid),			--商品编号
	sPicture varchar(100),										--商品图片
	sName  varchar(600),										--商品名称
	price float,												--价格
	amount int,													--数量
	total float,												--合计
	sguiGe varchar(50) ,										--规格
)*/
public class shopping_cartDao {	
	String sql="";
	public List<shopping_cart> getAll(int useid){ 
		String sql="select * from shopping_cart where 1=1 and userID="+useid+"";
		List<shopping_cart> list=DBUitl.executeQuery(sql, "com.shopping_cart.entity.shopping_cart");
		return list;
	}
	/**
	 * 添加购物车
	 * @param s
	 * @return
	 */
	public int  insert_shopping_cart(shopping_cart s){
		int  n=0;
		sql="insert shopping_cart values(?,?,?,?,?,?,?,?)";
		
		n=DBUitl.PreparedUpdate(sql, s.getUserID(),s.getSid(),s.getsPicture(),s.getsName(),s.getPrice(),s.getAmount(),s.getTotal(),s.getSguiGe());
		return n;
	}
	/**
	 * 删除商品
	 * @param sid
	 * @return
	 */
	public int delete__shopping_cart(String[] sid){
		int n=0;
		for(int i=0;i<sid.length;i++){
			sql="delete shopping_cart where [sid]="+Integer.parseInt(sid[i])+"";
			n+=DBUitl.PreparedUpdate(sql);
		}
		return n;
	}
	/**
	 * 根据用户编号删除所有的购物车 
	 * @param uid
	 * @return
	 */
	public int deletAll(int uid){
		int n=0;
		String sql="delete shopping_cart where userID="+uid+" ";
		n=DBUitl.PreparedUpdate(sql);
		return n;
	}
	/**
	 * 更改商品数量
	 * @param cid
	 * @param op
	 * @return
	 */
	public int updateAmount(int cid,String op){
		int n=0;
		sql="update shopping_cart set amount=amount"+op+"1 where  cid="+cid+"";
		DBUitl.PreparedUpdate(sql);
		String sql2="select * from shopping_cart where 1=1 and cid="+cid+"";
		List<shopping_cart> list=DBUitl.executeQuery(sql2, "com.shopping_cart.entity.shopping_cart");
		if(list!=null){
			double price= list.get(0).getPrice();
			int amount= list.get(0).getAmount();
			System.out.println("price"+price);
			System.out.println("amount"+amount);
			if(amount==0){
				amount=1;
			}
			float total=(float) (price*amount);			
			String sql3="update shopping_cart set total="+total+" where  cid="+cid+"";
			n=DBUitl.PreparedUpdate(sql3);
		}
		return n;
	}
	public static void main(String[] args) {
		
	}
}
