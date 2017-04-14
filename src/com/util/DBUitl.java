package com.util;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.*;



/**
 * <h2>�Զ���һ�����ݿ�����Ĺ�����</h2>
 * ���Ի�ȡ����getCon();<br>
 * ���Թر��������ݿ�������ԴcloseAll();<br>
 * ����ִ�зǲ�ѯsql���.<br>
 * @author mach
 *
 */
public class DBUitl{
	// ����
	private static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	// �����ַ���,"jdbc:sqlserver"Э�飬"localhost"���ݿ����ӵ�ַ,"1433"���ݷ���˿ں�,"nf"Ҫ���ӵ����ݿ���
	private static String url = "jdbc:sqlserver://localhost:1433;databaseName=pdb";
	// sql��¼�˺�
	private static String uid = "sa";
	// sql��¼����
	private static String pwd = "123456";
	/** 
	 * ��̬���������������,�Զ����У���ִֻ��һ��
	 * */
	static {
		try {
			Class.forName(driver);// ��������
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * ��ȡ���ݿ�����Ӷ���
	 * @return �������ݿ����Ӷ���
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
	 * �رղ��ͷ����ݿ����ӵ������Դ
	 * @param rs �������ֻ�в�ѯʱ���н������û�н�����ɹرգ����Դ�����null
	 * @param stmt ������
	 * @param conn�����Ӷ���
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
	 * ִ����,ɾ,��(insert, delete, update)SQL���
	 * @param sql �ǲ�ѯsql���
	 * @return ������Ӱ�����
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
	 * ͨ����������ȡһ�����ݿ�����ļ���
	 */
	public static <T> List<T> preparedQuery(Class<T> objclass,String sql,Object...args){
		Connection conn=DBUitl.getCon();
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<T> list=new ArrayList<T>();
		try {
			ps=conn.prepareStatement(sql);
			//<��ÿ��???����ֵ>
			for(int i=0;i<args.length;i++){
				ps.setObject(i+1, args[i]);
			}
			rs=ps.executeQuery();//����һ�������
			while(rs.next()){
				//������ʵ����һ������
				T object=(T)objclass.newInstance();
				//��ȡ���ǽ�����ĸ�����Ϣ
				ResultSetMetaData rsmd=rs.getMetaData();
				//��ȡ������е�����
				int n=rsmd.getColumnCount();
				for(int i=1;i<=n;i++){
					String name=rsmd.getColumnName(i);//��ȡÿ�������������
					Field field=objclass.getDeclaredField(name);//ͨ�� ���� ��ȡ ����
					field.setAccessible(true);//�������Եķ��ʵ�Ȩ�� ,˽�еĶ����Է���
					
					field.set(object,rs.getObject(i));//������������ֵ
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
	 * �������������Ƿ�ɹ�!
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
		System.out.println(conn);//��ʾ��ConnectionID:1  ��ʾ���ӳɹ�!
		conn.close();			
	}
}
