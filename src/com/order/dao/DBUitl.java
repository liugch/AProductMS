package com.order.dao;
import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 * <h2>�Զ���һ�����ݿ�����Ĺ�����</h2>
 * ���Ի�ȡ����getCon();<br>
 * ���Թر��������ݿ�������ԴcloseAll();<br>
 * ����ִ�зǲ�ѯsql���.<br>
 * @author mach
 *com.microsoft.sqlserverjdbc.SQLServerDriver
 *jdbc:salsercer://localhost:1433;database=
 */
public class DBUitl {
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
	 * 
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
	 * ִ����,ɾ,��(insert, delete, update)SQL���
	 * 
	 * @param sql �ǲ�ѯsql���
	 * @return ������Ӱ�����
	 */
	public static int update(String sql) {
		int row = 0;
		Connection conn = getCon();
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			row = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeAll(null, stmt, conn);
		}
		return row;
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * ��ȡ��������
	 * @param sql
	 * @param tt
	 * @return
	 */
	public static <T> List<T> getListAll(String sql,T tt){
		List<T> li = new ArrayList<T>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			Class<?> clazz = Class.forName(tt.getClass().getName());
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int column = rsmd.getColumnCount();
			while(rs.next()){
				T t = (T)clazz.newInstance();
				for(int i=1;i<=column;i++){
					Field f = t.getClass().getDeclaredField(rsmd.getColumnName(i));
					f.setAccessible(true);
					f.set(t, rs.getObject(i));
				}
				li.add(t);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			closeAll(rs, ps, con);
		}
		return li;
	}
	
	
	/**
	 * �������������Ƿ�ɹ�!
	 * @param args
	 * @throws SQLException
	 */
	public static void main(String[] args) throws SQLException {
		Connection conn = getCon();
		System.out.println(conn);//��ʾ��ConnectionID:1  ��ʾ���ӳɹ�!
		conn.close();			
	}
}
