package com.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.*;
public class AdminDao {
	private Connection conn=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	public boolean isAdmin(String adminName,String adminPassword){
		boolean b=false;
		String sql="select count(*) from admins where adminName=? and adminPassword=?";
		adminName=new MD5().getMD5ofStr(adminName);
		adminPassword=new MD5().getMD5ofStr(adminPassword);
		try {
			conn=DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			ps.setString(1, adminName);
			ps.setString(2,adminPassword);
			rs=ps.executeQuery();
			if(rs.next()){
				b=rs.getInt(1)>0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return b;
	}
	public static void main(String[] args) {
		boolean b=new AdminDao().isAdmin("admin", "admin");
		System.out.println(b);
	}

}
