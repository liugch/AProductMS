package com.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.user.entity.User;
import com.util.DBUitl;
import com.util.Pager;
/*--用户表
go
create table [user](
	userID int primary key identity(1,1),--用户编号
	username varchar(100),		--用户名
	[password] varchar(100),	--密码
	name varchar(100),			--姓名
	sex int,					--性别
	phone varchar(100),			--电话
	post varchar(200),			--邮寄地址
	email varchar(200),			--邮箱
)*/
public class UserDao {
	/**
	 * 获取所有用户的信息
	 * @return
	 */
	public List<User> getAll(){
		String sql="select userID,username,[password],name,sex,phone,post,email from [user] where 1=1";
		List<User> list=DBUitl.executeQuery(sql, "com.user.entity.User");
		return list;
	}
	/**
	 * 更新 用户的密码
	 * @param oldPwd
	 * @param phone
	 * @return
	 */
	public boolean updateUser(String oldPwd,String phone){
		String sql="update [user] set [password]=? where phone='"+phone+"'";
		int n=DBUitl.PreparedUpdate(sql,oldPwd );
		return n>0;
	}
	
	/**
	 * 获取用户的个数
	 * @return
	 */
	public int count(){
		int count=0;
		String sql="select count(*) as totalRows from [user]";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("totalRows");
		return count;
	}
	/**
	 *  分页获取用户
	 * @param currentPage
	 * @param pageSize
	 * @param pName
	 * @param pTypeName
	 * @param fromPrice
	 * @param toPrice
	 * @return
	 */
	public Pager<User> listEmps(int currentPage, int pageSize){
		Pager<User> pager=null;
		List<User> list=new ArrayList<User>();
		StringBuffer sb=new StringBuffer();
		if(currentPage==0){
			currentPage=1;
		}
		if(pageSize<2){
			pageSize=2;
		}
		int a = (currentPage-1)*pageSize+1;
		int b = currentPage* pageSize;
		sb.append("select * from (select row_number() over (order by userID desc) as rn, * from [user]) as b where b.rn between "+a+" and "+b+"");
	
		String sql=sb.toString();
		//System.out.println(sql);
		try {
			list=DBUitl.executeQuery(sql, "com.user.entity.User");
			//System.out.println(list);
			int totalRecord=count();
			int totalPage = totalRecord / pageSize;
			if(totalRecord % pageSize !=0){
				totalPage++;
			}
			pager=new Pager<User>(pageSize, currentPage, totalRecord, totalPage, list);
			//System.out.println(pager);
		}
	
		catch (Exception ex) {
			System.out.println("发生错误，错误是:" + ex.getMessage());
			return null;
		}
		return pager;	
	}
	/**
	 * 登陆是否成功
	 * @param phone
	 * @param password
	 * @return
	 */
	public int login(String phone,String password){
		int count=0;
		String sql="select count(*) totalRows from [user] where phone='"+phone+"' and [password]='"+password+"'";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("totalRows");
		return count;
	}
	/**
	 * 判断用户是否已经存在
	 * @param phone
	 * @return
	 */
	public int isCunZ(String phone){
		int n=0;
		String sql="select COUNT(*) as c from [user] where phone='"+phone+"' ";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		n=(int) map.get("c");
		return n;
	}
	
	/**
	 * 获取用户的Id
	 * @param phone
	 * @return
	 */
	public int getUseId(String phone){
		int uid=0;
		String sql="select userID,username,[password],name,sex,phone,post,email from [user] where phone='"+phone+"'";
		List<User> 	list=DBUitl.executeQuery(sql, "com.user.entity.User");
		if(list!=null){
			uid=list.get(0).getUserID();
		}
		return uid;
	}
	/**
	 * 注册用户
	 * @param u
	 * @return
	 */
	public int Register(User u){
		int n=0;
		String sql="insert [user](username,[password],name,sex,phone,post,email) values(?,?,?,?,?,?,?)";
		n=DBUitl.PreparedUpdate(sql, u.getName(),u.getPassword(),u.getName(),u.getSex(),u.getPhone(),u.getPost(),u.getEmail());
		return n;
	}
	
	public static void main(String[] args) {
		UserDao udao=new UserDao();
		/*List<User> list=udao.getAll();
		System.out.println(list);*/
	}
	
	
}
