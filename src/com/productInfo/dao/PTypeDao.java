package com.productInfo.dao;

import java.util.List;
import java.util.Map;

import com.productInfo.entity.PType;
import com.util.DBUitl;

/*--��Ʒ���ͱ�
go
create table pType(
	pTypeId int primary key identity(1,1),	--��Ʒ����
	pTypeName varchar(200)					--��Ʒ��������
)*/
public class PTypeDao {
	/**
	 * ��ȡ���е�����
	 * @return
	 */
	public List<PType> getAllPType(){
		String sql="select pTypeId,pTypeName from pType where 1=1";
		 List<PType> list=DBUitl.executeQuery(sql, "com.productInfo.entity.PType");
		 return list;
	}
	/**
	 * ���û��������Ͳſ��������������
	 *��������
	 * @param pTypeName ���͵�����
	 * @return 
	 */	
	public String addPType(String pTypeName){
		String str="�����Ʒ����ʧ��!";
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
				str="�ɹ������Ʒ����!";
			}
		}
		if(count>0){
			str="�Ѿ����˸�����!";
		}
		return str;
	}
	
	/**
	 * ���� ���ɾ������
	 * @param pTypeIds ���ͱ�ŵ��ַ�������
	 * @return ɾ�� �ĸ���
	 */
	public int deletePType(String[] pTypeIds){
		int n=0;
		String sql1=null;
		String sql2=null;
		for(int i=0;i<pTypeIds.length;i++){
			int ptid=Integer.parseInt(pTypeIds[i]);
			//ɾ����Ӧ���͵���Ʒ
			sql1="delete productInfo where pTypeInfoId="+ptid+"";
			//ɾ������
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
