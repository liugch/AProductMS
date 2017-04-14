package com.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.order.entity.shopping_cart;
/**
 * 	[sid] int foreign key references productInfo(pid),			--��Ʒ���
	sPicture varchar(100),										 --��ƷͼƬ
	sDesc varchar(600) foreign key references productInfo(pDesc),--��Ʒ����
	price float,												--�۸�
	amount int,													--����
	total float,												--�ϼ�
	sguiGe varchar(50) foreign key references productInfo(guiGe),--���
 * 
 * 
 * */
public class shopping_cart_SelectDao {
	Connection conn=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	shopping_cart sc=null;
	String sql="";
	//��ѯ���ﳵ������Ʒ
	public List<shopping_cart> getAll(){
		List<shopping_cart> li=new ArrayList<shopping_cart>();
		sql="select [sid],sPicture,sDesc,price,amount,total,sguiGe from shopping_cart";
		try {
			conn=DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				sc=new shopping_cart();
				sc.setSid(rs.getInt("sid"));
				sc.setsPicture(rs.getString("sPicture"));
				sc.setsDesc(rs.getString("sDesc"));
				sc.setPrice(rs.getDouble("price"));
				sc.setAmount(rs.getInt("amount"));
				sc.setTotal(rs.getDouble("total"));
				sc.setSguiGe(rs.getString("sguiGe"));
				li.add(sc);
			}
		} catch (Exception e) {
			e.getMessage();
		}finally{
			DBUitl.closeAll(rs, ps, conn);
		}
		return li;
	}
	//���ﳵ�����Ʒ
	public boolean insert_shopping_cart(shopping_cart s){
		boolean bl=false;
		sql="insert shopping_cart([sid],sPicture,sDesc,price,amount,total,sguiGe) values(?,?,?,?,?,?,?)";
		try {
			conn=DBUitl.getCon();
			ps=conn.prepareStatement(sql);
				ps.setInt(1, s.getSid());
				ps.setString(2, s.getsPicture());
				ps.setString(3, s.getsDesc());
				ps.setDouble(4, s.getPrice());
				ps.setInt(5, s.getAmount());
				ps.setDouble(6, s.getTotal());
				ps.setString(7, s.getSguiGe());
				int n=ps.executeUpdate();
				bl=n>0;
		} catch (Exception e) {
			e.getMessage();
		}finally{
			DBUitl.closeAll(null, ps, conn);
		}
		
		return bl;
	}
	//���ﳵɾ����Ʒ
	public boolean delete__shopping_cart(int[] sid){
		//boolean bl=false;
		int n=0;
		try {
			conn=DBUitl.getCon();
			//conn.setAutoCommit(false);
			for(int i=0;i<sid.length;i++){
				sql="delete from shopping_cart where [sid]=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, sid[i]);
				n+=ps.executeUpdate();
				//ps.addBatch();
			}
			//ps.executeBatch();
			//conn.commit();
			//bl=true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUitl.closeAll(null, ps, conn);
		}
		return n>0;
	}
	public static void main(String[] args) {
	/*	//���ò�ѯ����
		List<shopping_cart> li=new shopping_cart_SelectDao().getAll();
		for(shopping_cart a:li){
			System.out.println(a.getAmount());
			System.out.println(a.getPrice());
			System.out.println(a.getsPicture());
			System.out.println(a.getsDesc());
			System.out.println(a.getSguiGe());
			System.out.println(a.getTotal());
			System.out.println(a.getSid());

		}*/
/*		//���ò��뷽��
		boolean bl=new shopping_cart_SelectDao().insert_shopping_cart(new shopping_cart(3,"/NetworkShopping_Mall/image/1/9288692499652694_500.jpg","���򼴻�",158,2,316,"��"));
		System.out.println(bl);*/
		
		//��������ɾ������
		int[] a={2,3};
		boolean bl=new shopping_cart_SelectDao().delete__shopping_cart(a);
		System.out.println(bl);
	}
}
