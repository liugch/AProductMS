package com.productInfo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.productInfo.entity.ProductInfo;
import com.util.*;

/*--��Ʒ��Ϣ��
go
create table productInfo(
	pid int primary key identity(1,1),					--��Ʒ���
	pName varchar(200),									 --��Ʒ����
	pTypeInfoId int foreign key references pType(pTypeId),--��Ʒ����
	pDesc varchar(600),									 --��Ʒ����
	pPrice float,										--��Ʒ�۸�
	amount int,											--��Ʒ����
	guiGe varchar(50),									--��Ʒ���
	pUptime datetime,									--��Ʒ�ϼ�ʱ��
	pPicture varchar(100)								--��ƷͼƬ
)*/
/*create table pType(
	pTypeId int primary key identity(1,1),	--��Ʒ����
	pTypeName varchar(200)					--��Ʒ��������
)*/
public class ProductInfoDao {
	private Connection conn=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	/**
	 * ��������ȡ��Ʒ���б�
	 * @param pName ��Ʒ�� ģ����ѯ
	 * @param pTypeInfoId ��Ʒ���ͱ��
	 * @param fromPrice ��Ʒ�۸������
	 * @param toPrice  ��Ʒ�۸�����
	 * @return List<ProductInfo>
	 */
	public List<ProductInfo> getProduct(String pName,int pTypeInfoId,float fromPrice,float toPrice,int paixu){
		StringBuffer sb=new StringBuffer();
		sb.append("select pid,pName,pTypeInfoId,pDesc,pPrice,amount,guiGe,pUptime,pPicture,pTypeName from productInfo inner join pType on productInfo.pTypeInfoId=pType.pTypeId where amount>0 ");
		if(pName!=null&&!"".equals(pName.trim())){
			sb.append(" and pName like '%"+pName+"%' ");
		}
		if(pTypeInfoId!=0){
			sb.append(" and pTypeInfoId="+pTypeInfoId+" ");
		}
		if(fromPrice!=0){
			sb.append(" and pPrice>="+fromPrice+" ");
		}
		if(toPrice!=0){
			sb.append(" and pPrice<="+toPrice+" ");
		}
		if(paixu==1){
			sb.append(" order by pPrice desc");
		}else{
			sb.append(" order by pUptime desc");
		}
		String sql=sb.toString();
		List<ProductInfo> list=DBUitl.executeQuery(sql, "com.productInfo.entity.ProductInfo");
		return list;
	}
	/**
	 * ������Ʒ��Ż�ȡ��Ʒ
	 * @param pid
	 * @return
	 */
	public List<ProductInfo> getProductByPid(int pid){
		String sql="select pid,pName,pTypeInfoId,pDesc,pPrice,amount,guiGe,pUptime,pPicture,pTypeName from productInfo inner join pType on productInfo.pTypeInfoId=pType.pTypeId where pid="+pid+"";
		List<ProductInfo> list=DBUitl.executeQuery(sql, "com.productInfo.entity.ProductInfo");
		return list;
	}
	
	
	/**
	 * ������Ʒ�����ɾ����Ʒ
	 * @param pids һ����Ʒ��ŵ�����
	 * @return ����ɾ��������
	 */
	public int removeProduct(String[] pids){
		int n=0;
		for(int i=0;i<pids.length;i++){
			int pid=Integer.parseInt(pids[i]);
			String sql="delete productInfo where pid="+pid+"";
			n+=DBUitl.PreparedUpdate(sql);
		}
		return n;
	}
	/**
	 * �޸���Ʒ 
	 * @param p һ����Ʒ����
	 * @return
	 */
	public String updatProduct(ProductInfo p){
		String n="";
		StringBuffer sb=new StringBuffer();
		sb.append("update productInfo ");
		if(p.getpName()!=null&&!"".equals(p.getpName().trim()))
			sb.append("set pName='"+p.getpName()+"'");
		/*if(p.getpTypeName()!=null&&!"".equals(p.getpTypeName().trim())){
			String sql="select COUNT(*) from pType  where pTypeName='"+p.getpTypeName()+"'";
			try {
				conn=DBUitl.getCon();
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				if(rs.next()){
					if(rs.getInt(1)<1)
						return n="�޸���Ʒʧ��!�����Ͳ�����!";
					else{
						//System.out.println(rs.getInt(1));
						
						String sql3="select pTypeId from pType where pTypeName='"+p.getpTypeName()+"'";
						ps=conn.prepareStatement(sql3);
						rs=ps.executeQuery();
						if(rs.next()){
							//System.out.println(p.getpTypeName());
							int id=rs.getInt(1);
							sb.append(", pTypeInfoId="+id+"");
						}
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DBUitl.closeAll(rs, ps, conn);
			}
		}
		if(p.getpDesc()!=null&&!"".equals(p.getpDesc().trim()))
			sb.append(", pDesc='"+p.getpDesc()+"'");
		if(p.getpPicture()!=null&&!"".equals(p.getpPicture().trim()))
			sb.append(", pPicture='"+p.getpPicture()+"'");
		*/
		if(p.getpPrice()!=0)
			sb.append(", pPrice="+p.getpPrice()+"");
		if(p.getAmount()!=0){
			sb.append(", amount="+p.getAmount()+"");
		}
		sb.append(" where pid="+p.getPid()+"");
		String sql2=sb.toString();
		//System.out.println(sql2);
		int b=DBUitl.PreparedUpdate(sql2);
		if(b>0)
			n="�޸���Ʒ�ɹ�!";
		return n;
	}
	/**
	 * ��ȡ���е���Ʒ
	 * @return
	 */
	public int count(){
		int count=0;
		String sql="select count(*) as totalRows from productInfo";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("totalRows");
		//System.out.println("count"+count);
		return count;
	}
	/**
	  * @param pName ��Ʒ�� ģ����ѯ
	 * @param pTypeName ��Ʒ��������
	 * @param fromPrice ��Ʒ�۸������
	 * @param toPrice  ��Ʒ�۸�����
	 * @param currentPage ��ǰҳ��
	 * @param pageSize ҳ���С
	 * @return
	 */
	public Pager<ProductInfo> listEmps(int currentPage, int pageSize,String pName,String pTypeName,float fromPrice,float toPrice){
		Pager<ProductInfo> pager=null;
		List<ProductInfo> list=new ArrayList<ProductInfo>();
		StringBuffer sb=new StringBuffer();
		if(currentPage==0){
			currentPage=1;
		}
		if(pageSize<2){
			pageSize=2;
		}
		int a = (currentPage-1)*pageSize+1;
		int b = currentPage* pageSize;
		sb.append("select * from (select row_number() over (order by pUptime desc) as rn, * from productInfo p inner join pType t on p.pTypeInfoId=t.pTypeId where amount>0 ");
		if(pName!=null&&!"".equals(pName.trim())){
			sb.append(" and pName like '%"+pName+"%' ");
		}
		if(pTypeName!=null&&!"".equals(pTypeName.trim())){
			sb.append(" and pTypeName='"+pTypeName+"' ");
		}
		if(fromPrice!=0){
			sb.append(" and pPrice>="+fromPrice+" ");
		}
		if(toPrice!=0){
			sb.append(" and pPrice<="+toPrice+" ");
		}
		sb.append(" ) b where b.rn between "+a+" and "+b+"");
		String sql=sb.toString();
		//System.out.println(sql);
		try {
			list=DBUitl.executeQuery(sql, "com.productInfo.entity.ProductInfo");
			//System.out.println(list);
			int totalRecord=count();
			int totalPage = totalRecord / pageSize;
			if(totalRecord % pageSize !=0){
				totalPage++;
			}
			pager=new Pager<ProductInfo>(pageSize, currentPage, totalRecord, totalPage, list);
			//System.out.println(pager);
		}
	
		catch (Exception ex) {
			System.out.println("�������󣬴�����:" + ex.getMessage());
			return null;
		}finally {
			DBUitl.closeAll(rs, ps, conn);
		}
		return pager;	
	}
	/**
	 * ������Ʒ
	 * @param p
	 * @return
	 */
	public int insertProduct(ProductInfo p){
		int n=0;
		String sql="insert into productInfo(pName,pTypeInfoId,pDesc,pPrice,amount,guiGe,pUptime,pPicture) values(?,?,?,?,?,?,GETDATE(),?)";
		n=DBUitl.PreparedUpdate(sql, p.getpName(),p.getpTypeInfoId(),p.getpDesc(),p.getpPrice(),p.getAmount(),p.getGuiGe(),p.getpPicture());
		return n;
	}
	
	public int findPid(String pName,String pic){
		int pid=0;
		String sql="select pid from productInfo where pName='"+pName+"' and pPicture='"+pic+"'";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		pid=(int) map.get("pid");
		return pid;
	}
	
	public static void main(String[] args) {
		ProductInfoDao pdao=new ProductInfoDao();
		
		
		/*List<ProductInfo> list=pdao.getProduct(null, 0, 0, 0);
		for(ProductInfo p:list){
			System.out.println(p);
		}*/
		/*
		String[] pids={"2","3"};
		int n=pdao.removeProduct(pids);
		System.out.println(n);*/
		/*ProductInfo p=new ProductInfo();
		p.setPid(1);
		p.setpTypeInfoId(2);
		p.setpName("xingd");
		p.setpDesc("xindmiaosu");
		p.setpTypeName("����ˮ��");
		p.setpPicture("xin.jpg");
		String rs=pdao.updatProduct(p);
		System.out.println(rs);*/
		
		//int n=pdao.count();
		//System.out.println(n);
		/*Pager<ProductInfo> pp =pdao.listEmps(1, 2, "2", "����ˮ��", 1, 100);
		System.out.println(pp);*/
		
		/*ProductInfo p=new ProductInfo();
		p.setpName("ddddd");
		p.setpTypeInfoId(1);
		p.setpDesc("hendadadada");
		p.setpPrice(45);
		p.setAmount(33);
		p.setGuiGe("90kg");
		p.setpPicture("jj.jpg");
		int n=pdao.insertProduct(p);
		System.out.println(n);*/
		
	}
}
