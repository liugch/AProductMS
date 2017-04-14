package com.util;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.*;



/**
 * <h2>自定义一个数据库操作的工具类</h2>
 * 可以获取连接getCon();<br>
 * 可以关闭所有数据库连接资源closeAll();<br>
 * 可以执行非查询sql语句.<br>
 * @author mach
 *
 */
public class DBUitl{
	// 驱动
	private static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	// 连接字符串,"jdbc:sqlserver"协议，"localhost"数据库连接地址,"1433"数据服务端口号,"nf"要连接的数据库名
	private static String url = "jdbc:sqlserver://localhost:1433;databaseName=pdb";
	// sql登录账号
	private static String uid = "sa";
	// sql登录密码
	private static String pwd = "123456";
	/** 
	 * 静态代码块来加载驱动,自动运行，并只执行一次
	 * */
	static {
		try {
			Class.forName(driver);// 加载驱动
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 获取数据库的连接对象
	 * @return 返回数据库连接对象
	 */
	public static Connection getCon() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(url, uid, pwd);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	/**
	 * 关闭并释放数据库连接的相关资源
	 * @param rs 结果集，只有查询时才有结果集，没有结果集可关闭，可以传参数null
	 * @param stmt 语句对象
	 * @param conn　连接对象
	 */
	public static void closeAll(ResultSet rs, Statement stmt, Connection conn){
		try {
			if(rs!=null)
				rs.close();
			if(stmt!=null)
				stmt.close();
			if(conn!=null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static int count(String sql,Object...args){
		Connection conn=DBUitl.getCon();
		PreparedStatement ps=null;
		ResultSet rs=null;
		int n=0;
		try {
			DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			for(int i=0;i<args.length;i++){
				ps.setObject(i+1, args[i]);
			}
			rs=ps.executeQuery();
			if(rs.next()){
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUitl.closeAll(null, ps, conn);
		}
		return n;
	}
	/**
	 * 执行增,删,改(insert, delete, update)SQL语句
	 * @param sql 非查询sql语句
	 * @return 返回受影响的行
	 */
	public static int PreparedUpdate(String sql,Object...args){
		Connection conn=DBUitl.getCon();
		PreparedStatement ps=null;
		try {
			DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			for(int i=0;i<args.length;i++){
				ps.setObject(i+1, args[i]);
			}
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUitl.closeAll(null, ps, conn);
		}
		return 0;
	}
	/**
	 * 通过反射来获取一个数据库里面的集合
	 */
	public static <T> List<T> preparedQuery(Class<T> objclass,String sql,Object...args){
		Connection conn=DBUitl.getCon();
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<T> list=new ArrayList<T>();
		try {
			ps=conn.prepareStatement(sql);
			//<给每个???设置值>
			for(int i=0;i<args.length;i++){
				ps.setObject(i+1, args[i]);
			}
			rs=ps.executeQuery();//返回一个结果集
			while(rs.next()){
				//反射来实例化一个对象
				T object=(T)objclass.newInstance();
				//获取的是结果集的各种信息
				ResultSetMetaData rsmd=rs.getMetaData();
				//获取结果集中的列数
				int n=rsmd.getColumnCount();
				for(int i=1;i<=n;i++){
					String name=rsmd.getColumnName(i);//获取每个结果集的列名
					Field field=objclass.getDeclaredField(name);//通过 列名 获取 属性
					field.setAccessible(true);//设置属性的访问的权限 ,私有的都可以访问
					
					field.set(object,rs.getObject(i));//给各个属性设值
				}
				list.add(object);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUitl.closeAll(rs, ps, conn);
		}
		return list;
	}
	public static <T> List<T> executeQuery(String sql,String ip,Object...objects){
		List<T> list=new ArrayList<T>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			conn=DBUitl.getCon();
			ps=conn.prepareStatement(sql);
			for(int i=0;i<objects.length;i++){
				ps.setObject(i+1, objects[i]);
			}
			rs=ps.executeQuery();
			@SuppressWarnings("unchecked")
			Class<T> c=(Class<T>)Class.forName(ip);
			while(rs.next()){
				T obj=c.newInstance();
				ResultSetMetaData rsm=rs.getMetaData();
				int n=rsm.getColumnCount();
				Method[] mtd=c.getDeclaredMethods();
				for (Method method : mtd) {
					String names=method.getName();
					if(names.startsWith("set")){
						for(int i=1;i<=n;i++){
							String name1=names.substring(3);
							String name2=rsm.getColumnName(i);
							if(name1.equalsIgnoreCase(name2)){
								String type=rsm.getColumnTypeName(i);
								if(type.contains("char")){
									method.invoke(obj, rs.getString(i));
								}else if(type.contains("money")){
									method.invoke(obj, rs.getDouble(i));
								}else if(type.equals("date")){
									method.invoke(obj, rs.getDate(i));
								}else if(type.equals("datetime")){
									method.invoke(obj,rs.getDate(i));
								}else if(type.equals("float")){
									method.invoke(obj, rs.getFloat(i));
								}else if(type.contains("decimal")){
									method.invoke(obj, rs.getFloat(i));
								}else if(type.contains("text")){
									method.invoke(obj, rs.getString(i));
								}else{
									method.invoke(obj, rs.getInt(i));
								}
							}
						}
					}
					
				}
				list.add(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUitl.closeAll(rs, ps, conn);
		}	
		return list;
	}
	/**
	 * 测试数据连接是否成功!
	 * @param args
	 * @throws SQLException
	 */
	public static List<Map<String,Object>> getResultSet(String sql,Object...param){
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		Connection connection=null;
		PreparedStatement pstmt=null;
		ResultSet resultSet=null;
		try {
			connection=DBUitl.getCon();
			pstmt=connection.prepareStatement(sql);
			if(param.length>0&&param!=null){
				for(int i=0;i<param.length;i++){
					pstmt.setObject(i+1, param[i]);
				}
			}
			resultSet=pstmt.executeQuery();
			ResultSetMetaData rsmd=resultSet.getMetaData();
			int cols=rsmd.getColumnCount();
			while(resultSet.next()){
				Map<String,Object> map=new HashMap<String,Object>();
				for(int j=0;j<cols;j++){
					String colName=rsmd.getColumnName(j+1);
					Object colValue=resultSet.getObject(colName);
					if(colValue==null){
						colValue="";
					}
					map.put(colName, colValue);
				}
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DBUitl.closeAll(resultSet, pstmt, connection);
		}
		return list;
	}
	public static void main(String[] args) throws SQLException {
		Connection conn = getCon();
		System.out.println(conn);//显示：ConnectionID:1  表示连接成功!
		conn.close();			
	}
}
