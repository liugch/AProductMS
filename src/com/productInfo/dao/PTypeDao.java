package com.productInfo.dao;

import java.util.List;
import java.util.Map;

import com.productInfo.entity.PType;
import com.util.DBUitl;

/*--商品类型表
go
create table pType(
	pTypeId int primary key identity(1,1),	--商品种类
	pTypeName varchar(200)					--商品种类名称
)*/
public class PTypeDao {
	/**
	 * 获取所有的类型
	 * @return
	 */
	public List<PType> getAllPType(){
		String sql="select pTypeId,pTypeName from pType where 1=1";
		 List<PType> list=DBUitl.executeQuery(sql, "com.productInfo.entity.PType");
		 return list;
	}
	/**
	 * 如果没有这个类型才可以增加这个类型
	 *增加类型
	 * @param pTypeName 类型的名称
	 * @return 
	 */	
	public String addPType(String pTypeName){
		String str="添加商品类型失败!";
		int n=0;
		int count=0;
		String sql1="select COUNT(*) as nn from pType where pTypeName='"+pTypeName+"'";
		String sql2="insert into pType(pTypeName) values(?)";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql1);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("nn");
		System.out.println("count::"+count);
		if(count<=0){
			n=DBUitl.PreparedUpdate(sql2, pTypeName);
			System.out.println("N::"+n);
			if(n>0){
				str="成功添加商品类型!";
			}
		}
		if(count>0){
			str="已经有了该类型!";
		}
		return str;
	}
	
	/**
	 * 根据 编号删除类型
	 * @param pTypeIds 类型编号的字符串数组
	 * @return 删除 的个数
	 */
	public int deletePType(String[] pTypeIds){
		int n=0;
		String sql1=null;
		String sql2=null;
		for(int i=0;i<pTypeIds.length;i++){
			int ptid=Integer.parseInt(pTypeIds[i]);
			//删除对应类型的商品
			sql1="delete productInfo where pTypeInfoId="+ptid+"";
			//删除类型
			sql2="delete pType where pTypeId ="+ptid+"";
			DBUitl.PreparedUpdate(sql1);
			n+=DBUitl.PreparedUpdate(sql2);
		}
		return n;
	}
	
	public String getTypeName(int tid){
		String pName=null;
		String sql="select pTypeName from pType where pTypeId="+tid+"";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		pName=(String) map.get("pTypeName");
		return pName;
	}
	
	
	
	public static void main(String[] args) {
		PTypeDao  pdao=new PTypeDao();
		String p=pdao.getTypeName(1);
		System.out.println(p);
		/*List<PType> list=pdao.getAllPType();
		System.out.println(list);*/
		/*String pTypeName="5678967890";
		int n=pdao.addPType(pTypeName);
		System.out.println(n);*/
		/*String[] pTypeIds={"12"};
		int n=pdao.deletePType(pTypeIds);
		System.out.println(n);*/
		
	}
}
