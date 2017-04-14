package com.order.dao;


import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Date;
import com.order.entity.orderForm;
import com.util.DBUitl;
import com.util.Pager;
/**
 * 	oId int primary key  identity(1,1),		--订单编号
	oNo varchar(100),			--订单序号
	userID int(100),		--用户编号
	submitTime datetime ,		--提交订单时间
	outTime datetime,			--发货时间
	totalPrice float,			--总金额
	remark varchar(200),		--买家备注
	IPAddress varchar(200),		--买家地址
	isPayoff int,				--买家是否付款
	isOut int					--是否发货	
 * */
public class orderFormDao {
	Connection conn=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	String sql="";
	//查找订单信息表
 	public List<orderForm> getAll(){
 		List<orderForm> li=new ArrayList<orderForm>();
 		orderForm of=null;
 		sql="select [user].name a,[user].username b,[user].phone c,oId,oNo,orderForm.userID,submitTime,outTime,totalPrice,remark,IPAddress,isPayoff,isOut from orderForm join [user] on [user].userID=orderForm.userID";
 				try {
					conn=DBUitl.getCon();
					ps=conn.prepareStatement(sql);
					rs=ps.executeQuery();
					while(rs.next()){
						of=new orderForm();
						of.setoID(rs.getInt("oid"));
						of.setoNo(rs.getInt("oNo"));
						of.setUserID(rs.getInt("userID"));
						of.setSubmitTime(rs.getDate("submitTime"));
						of.setOutTime(rs.getDate("outTime"));
						of.setName(rs.getString("a"));
						of.setUsername(rs.getString("b"));
						of.setPhone(rs.getString("c"));
						of.setTotalPrice(rs.getDouble("totalPrice"));
						of.setRemark(rs.getString("remark"));
						of.setIPAddress(rs.getString("IPAddress"));
						of.setIsPayoff(rs.getInt("isPayoff"));
						of.setIsOut(rs.getInt("isOut"));
						li.add(of);
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					DBUitl.closeAll(rs, ps, conn);
				}
 		return li; 		
 	}
 	//创建订单
 	public int insertOrderForm(orderForm o){
		int n=0;
		sql="insert orderForm(oNo,userID,submitTime,outTime,totalPrice,remark,IPAddress,isPayoff,isOut) values('"+o.getoNo()+"',"+o.getUserID()+",getdate(),null,"+o.getTotalPrice()+",null,null,0,0)";
		n=com.util.DBUitl.PreparedUpdate(sql);	
 		return n;
 	}
 	public boolean insertOrderForm2(orderForm o){
		boolean bl=false;
		
		sql="insert orderForm(oNo,userID,submitTime,outTime,totalPrice,remark,IPAddress,isPayoff,isOut) values(?,?,?,?,?,?,?,?,?)";
			try {
				conn=DBUitl.getCon();
				ps=conn.prepareStatement(sql);
				ps.setInt(1, o.getoNo());
				ps.setInt(2, o.getUserID());
				ps.setDate(3, new java.sql.Date(o.getSubmitTime().getTime()));
				ps.setDate(4,new java.sql.Date( o.getOutTime().getTime()));
				ps.setDouble(5, o.getTotalPrice());
				ps.setString(6, o.getRemark());
				ps.setString(7, o.getIPAddress());
				ps.setInt(8,o.getIsPayoff());
				ps.setInt(9, o.getIsOut());
				int n=ps.executeUpdate();
				bl=n>0;
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				DBUitl.closeAll(null, ps, conn);
			}
 		return bl;
 		
 	}
 	//根据订单查找用户名
 	public List<orderForm> getName(){
 		List<orderForm> lname=new ArrayList<orderForm>();
 			
 		sql="select name,username from [user] a join orderForm on orderForm.userID=a.userID";
 		try { 			
			conn=DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();	
			while(rs.next()){		
				orderForm of=new orderForm();
				of.setName(rs.getString("name"));
				of.setUsername(rs.getString("username"));
				lname.add(of);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUitl.closeAll(rs, ps, conn);
		}
		return lname;
 	
 		
 	}
 	//根据姓名，订单序号，是否发货 查找订单
 	public List<orderForm> getDingDan(String name,int oNo,int isOut,int ispayoff){
 		List<orderForm> liDD=new ArrayList<orderForm>(); 			
 			sql="select oNo,[user].name, [user].username ,[user].phone,submitTime,outTime,totalPrice,remark,IPAddress,isOut,isPayoff  from  orderForm  join [user]	on [user].userID=orderForm.userID ";
 			if(name!=null){
 				sql+="and [user].name = '"+name+"'";
 			}
 			if(oNo!=0){
 				sql+="and oNo='"+oNo+"'";
 			}
 			if(isOut!=0||isOut==0){
 				sql+="and isOut='"+isOut+"'";
 			}
 			if(ispayoff!=0){
 				sql+="and ispayoff='"+ispayoff+"'";
 			}
 			try {
				conn=DBUitl.getCon();
				System.out.println(sql);
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				while(rs.next()){
					orderForm of=new orderForm();
					of.setoNo(rs.getInt("oNo"));
					of.setName(rs.getString("name"));
					of.setUsername(rs.getString("username"));
					of.setSubmitTime(rs.getDate("submitTime"));
					of.setOutTime(rs.getDate("outTime"));
					of.setPhone(rs.getString("phone"));
					of.setTotalPrice(rs.getDouble("totalPrice"));
					of.setRemark(rs.getString("remark"));
					of.setIPAddress(rs.getString("IPAddress"));
					of.setIsPayoff(rs.getInt("isPayoff"));
					of.setIsOut(rs.getInt("isOut"));
					liDD.add(of);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				DBUitl.closeAll(rs, ps, conn);
			}
		return liDD;
 		
 	}
 	//查找最后一次创建的数据里的订单编号
	public List<orderForm> getOId(){
		orderForm of=new orderForm();
		List<orderForm> li=new ArrayList<orderForm>();
			sql="select top 1 oId from orderForm  order by oId desc";
		try {
			conn=DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			if(rs.next()){
				of.setoID(rs.getInt("oId"));
				li.add(of);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return li;
	}

 	//根据订单序号批量删除订单
	public boolean DelectForm(int[] oid){
		int n=0;
		try {
		for(int i=0;i<oid.length;i++){
			sql="delete from orderList where oLID=? ";
			sql +="delete from orderForm where oId=? ";
			conn=DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			ps.setInt(1, oid[i]);
			ps.setInt(2, oid[i]);
			 n+=ps.executeUpdate();			
		}	
			
		} catch (Exception e) {
			e.getMessage();
		}finally{
			DBUitl.closeAll(null, ps, conn);
		}
		return n>0;
	}
	/**
	 * 获取所有订单数量
	 * @return
	 */
	public int count(){
		int count=0;
		String sql="select count(*) as totalRows from orderForm";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("totalRows");
		//System.out.println("count"+count);
		return count;
	}
	/**
	 * 订单部分
	 * @param currentPage
	 * @param pageSize
	 * @param oNo 订单编号
	 * @param isOut 是否已经发货
	 * @param ispayoff 是否已经付款
	 * @return
	 */
	public Pager<orderForm> listEmps(int currentPage, int pageSize,int oNo,int ispayoff){
		Pager<orderForm> pager=null;
		List<orderForm> list=new ArrayList<orderForm>();
		StringBuffer sb=new StringBuffer();
		sb.append("select * from (select row_number() over (order by oId desc) as rn,  oform.* ,olist.amount,pinfo.pPrice,pinfo.pName,u.username,(olist.amount*pinfo.pPrice) as totalMoney from orderForm oform inner join orderList olist on  oform.oId=olist.oLID inner join [user] u on u.userID=oform.userID inner join productInfo pinfo on pinfo.pid=olist.pID where oform.isOut=0");
		if(currentPage==0){
			currentPage=1;
		}
		if(pageSize<2){
			pageSize=2;
		}
		if(oNo!=0){
			sb.append(" and  oform.oNo="+oNo+" ");
		}
		if(ispayoff!=-1){
			sb.append(" and  oform.ispayoff="+ispayoff+" ");
		}
		int a = (currentPage-1)*pageSize+1;
		int b = currentPage* pageSize;
		
		sb.append(") b where b.rn between "+a+" and "+b+"");
		String sql=sb.toString();
		//System.out.println(sql);
		try {
			list=DBUitl.executeQuery(sql, "com.order.entity.orderForm");
			//System.out.println(list);
			int totalRecord=count();
			int totalPage = totalRecord / pageSize;
			if(totalRecord % pageSize !=0){
				totalPage++;
			}
			pager=new Pager<orderForm>(pageSize, currentPage, totalRecord, totalPage, list);
			//System.out.println(pager);
		}
	
		catch (Exception ex) {
			System.out.println("发生错误，错误是:" + ex.getMessage());
			return null;
		}finally {
			DBUitl.closeAll(rs, ps, conn);
		}
		return pager;	
	}
	
	/**
	 * 更新是否已经发货
	 * @param oID
	 * @return
	 */
	public int updateIsOut(int oID){
		int n=0;
		String sql="update orderForm set isOut=1 where isPayoff=1 and oId="+oID+"";
		n=DBUitl.PreparedUpdate(sql);
		return n;
	}
	
	  /**
	   * 更新是否已经付款
	   * @param oID 
	   * @param remark 卖家备注
	   * @param IPAddress 卖家收货地址
	   * @return
	   */
	public int updateIsPayoff(int oID,String remark,String IPAddress){
		int n=0;
		StringBuffer sbf=new StringBuffer();
		sbf.append("update orderForm set isPayoff=1");
		if(IPAddress!=null&&!"".equals(IPAddress)){
			sbf.append(" ,IPAddress='"+IPAddress+"'");
        }
        if(remark!=null&&!"".equals(remark)){
        	sbf.append(" ,remark='"+remark+"'");
        }
		
		sbf.append(" where oId="+oID+"");
		String sql=sbf.toString();
		//String sql="update orderForm set isPayoff=1,remark='"+remark+"',IPAddress='"+IPAddress+"' where oId="+oID+"";
		n=DBUitl.PreparedUpdate(sql);
		return n;
	}
	/**
	 * 看该客户是否已经购买
	 * @param uid
	 * @return
	 */
	public int isGouMai(int uid){
		int count=0;
		String sql="select COUNT(*) as totalRows from orderForm where userID="+uid+" and isPayoff=1 and isOut=1";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("totalRows");
		return count;
	}
	

	/**
	 * 对应商品类型的进货商品总数量
	 * @param type 类型的名称
	 * @return
	 */
	public int sumByPtype(String type){
		int count=1;
		String sql="select SUM(amount) as b from productInfo p inner join pType t on p.pTypeInfoId=t.pTypeId where t.pTypeName='"+type+"'";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("b");
		return count;
	}
	
	/**
	 * 对应类型 不同年月份的 商品销售总数量
	 * @param type
	 * @param year
	 * @param month
	 * @param outTime
	 * @return
	 */
	public int sumByOut(String type,int year,int month,String outTime){
		int count=0;
		StringBuffer sb=new StringBuffer();
		sb.append("	select SUM(o.amount) as b from orderList o inner join productInfo p on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId inner join orderForm f on f.oId=o.oListID where 1=1");
		if(type!=null&&!"".equals(type))
			sb.append(" and t.pTypeName='"+type+"'");
		if(year!=0)
			sb.append(" and DATEPART(YYYY,f.outTime)="+year+"");
		if(month!=0)
			sb.append(" and MONTH(f.outTime)="+month+"");
		if(outTime!=null&&!"".equals(outTime))
			sb.append(" and f.outTime='"+outTime+"'");
		sb.append("and f.isPayoff=1 and f.isOut=1 group by t.pTypeId");
		String sql=sb.toString();
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("b");
		return count;
	}
	
	
	
 	public static void main(String[] args) {
 		System.out.println("对应商品类型的进货商品总数量:"+new orderFormDao().sumByPtype("进口水果"));
 		System.out.println("对应类型 不同年月份的 商品销售总数量:"+new orderFormDao().sumByOut("进口水果", 2016, 1, "2016-1-7"));
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		//Date dt=new Date(System.currentTimeMillis());
 		//SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 		/*orderForm of=new orderForm();
 		orderFormDao odao=new orderFormDao();
 		Pager<orderForm> page=odao.listEmps(1, 2, 0, 0, 0);
 		System.out.println(page.getDataList());*/
 		
 		
 		
 		
 	
 		/*of.setoNo("3");
 		of.setUserID(1);
 		of.setSubmitTime(dt);*/
 		//System.out.println(dt);
 		/*of.setOutTime(dt);
 		of.setTotalPrice(500);
 		of.setRemark("请及时发货");
 		of.setIPAddress("中国珠海");
 		of.setIsOut(0);
 		of.setIsPayoff(1);
 		orderFormDao ofd=new orderFormDao();
 			//boolean bl=ofd.insertOrderForm("3",1,dt,dt,500,"请及时发货","中国珠海",0,0);
 		List<orderForm> li=ofd.getAll();
 		for(orderForm a:li){			
 			
 			
 			System.out.println(a.getoNo());
 			System.out.println(a.getUserID());
 			System.out.println(a.getUserID());
 			System.out.println(a.getSubmitTime());
 			System.out.println(a.getOutTime());
 			System.out.println(a.getRemark());
 			System.out.println(a.getIPAddress());
 			System.out.println(a.getTotalPrice());
 			System.out.println(a.getIsOut());
 			System.out.println(a.getIsPayoff());
 		}*/
 			//测试根据给查找订单
 			/*orderFormDao ofd=new orderFormDao();
 				List<orderForm> lidd=ofd.getDingDan("赵六",0,0,0);
 				for(orderForm a:lidd){			
 		 			 		 			
 		 			System.out.println(a.getoNo());
 		 			System.out.println(a.getName());
 		 			System.out.println(a.getSubmitTime());
 		 			System.out.println(a.getOutTime());
 		 			System.out.println(a.getRemark());
 		 			System.out.println(a.getIPAddress());
 		 			System.out.println(a.getTotalPrice());
 		 			System.out.println(a.getIsOut());
 		 			System.out.println(a.getIsPayoff());
 				}*/
 		//查询所以订单
 	
 	/*	List<orderForm> l=new orderFormDao().getDingDan("张三", 3, 0, 0);
 		System.out.println(l);
	for(orderForm a:l){
	 			System.out.println(a.getName());
	 			System.out.println(a.getUsername());
	 			System.out.println(a.getIsOut());
	 			System.out.println(a.getIPAddress());
	 		}*/
 	
 		//调用批量删除订单方法
 		/*int[] a={8,9};
 		 boolean bl=new orderFormDao().DelectForm(a);
 		 System.out.println(bl);*/
 		//调用订单编号姓名是否发货查询订单方法
 		/*List<orderForm> li=new orderFormDao().getDingDan("李四", 0, 1, 1);
 		System.out.println(li.size());*/
 		/*for(orderForm a:li){
 				System.out.println(a.getoNo());
	 			System.out.println(a.getName());
	 			System.out.println(a.getSubmitTime());
	 			System.out.println(a.getOutTime());
	 			System.out.println(a.getRemark());
	 			System.out.println(a.getIPAddress());
	 			System.out.println(a.getTotalPrice());
	 			System.out.println(a.getIsOut());
	 			System.out.println(a.getIsPayoff());
 		}*/
 		
 		
	}






}






