package com.comment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.comment.entity.Comment;
import com.util.DBUitl;
import com.util.Pager;

/*--���۱�
go
create table comment(
	comId int primary key identity(1,1),				--���۱��
	comUserId int foreign key references [user](userID) ,--�����˱��
	pid int foreign key references productInfo(pid) ,     --��Ʒ���
	content ntext,										--��������
	commentTime datetime,								--����ʱ��
	isGood varchar(20)									--�ǲ��к���?
	username �û���										--
	pName ��Ʒ��											--
)*/
public class CommentDao {
	private Connection conn=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	/**
	 * ��ѯ������������ ����
	 * @param name ���۵�����
	 * @param fromdate ���ۿ�ʼʱ��
	 * @param toDate ���۽���ʱ��
	 * @param isGood �Ǻ������ǲ���
	 * @param pName ��Ʒ������
	 * @return
	 */
	public List<Comment> getAllComment(String name,Date fromdate,Date toDate,String isGood,String pName){
		List<Comment> list=new ArrayList<Comment>();
		StringBuffer sb=new StringBuffer();
		sb.append("select comId,comUserId,pid,content,commentTime,isGood ,username from comment inner join [user] on comment.comUserId=[user].userID where 1=1");
		if(fromdate!=null)
			sb.append(" and commentTime>='"+fromdate+"' ");
		if(toDate!=null)
			sb.append(" and commentTime<='"+toDate+"' ");
		if(isGood!=null)
			sb.append(" and isGood='"+isGood+"' ");
		if(name!=null&&!"".equals(name.trim())){
			String sql="select userID from [user] where username='"+name+"' ";
			try {
				conn=DBUitl.getCon();
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				if(rs.next()){
					if(rs.getInt(1)!=0){
						sb.append(" and [user].username='"+name+"' ");
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				DBUitl.closeAll(rs, ps, conn);
			}
		}
		if(pName!=null&&!"".equals(pName.trim())){
			sb.append(" and pid in(select pid from productInfo where pName like '%"+pName+"%')");
		}
		
		String sql2=sb.toString();
		list=DBUitl.executeQuery(sql2, "com.comment.entity.Comment");
		return list;
	}
	/**
	 * ��ȡ����
	 * @param isGood
	 * @param pid
	 * @return
	 */
	public List<Comment> getCommentByIsGood(String isGood,int pid){
		String sql=null;
		if(isGood!=null){
			sql="select c.*,p.pName,u.username from comment c inner join productInfo p on p.pid=c.pid  inner join [user] u on c.comUserId=u.userID where 1=1 and isGood='"+isGood+"' and c.pid="+pid+" order by  c.commentTime desc";
		}else{
			sql="select c.*,p.pName,u.username from comment c inner join productInfo p on p.pid=c.pid  inner join [user] u on c.comUserId=u.userID where 1=1 and c.pid="+pid+" order by  c.commentTime desc ";
		}
		List<Comment> list=DBUitl.executeQuery(sql, "com.comment.entity.Comment");
		 return list;
	}
	/**
	 * ���� ���۵ı��ɾ����Ӧ�� 
	 * @param comId ���۱��
	 * @return ���۵ĸ���
	 */
	public int deleteComment(int comId){
		int n=0;
		String sql="delete comment where comId ="+comId+"";
		String sql2="delete reply where rComId="+comId+"";
		n+=DBUitl.PreparedUpdate(sql2);
		n+=DBUitl.PreparedUpdate(sql);
		return n;
	}
	
	public boolean sendComment(Comment c){
		boolean b=false;
		String sql="insert into comment(comUserId,content,pid,commentTime,isGood) values(?,?,?,GETDATE(),?)	";
		int n=DBUitl.PreparedUpdate(sql, c.getComUserId(),c.getContent(),c.getPid(),c.getIsGood());
		b=n>0;
		return b;
	}
	/**
	 * ��ȡ���۵ĸ���
	 * @return ���۸���
	 */
	public int count(){
		int count=0;
		String sql="select count(*) as totalRows from comment";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("totalRows");
		//System.out.println("count"+count);
		return count;
	}
	/**
	 * ��ȡ��Ʒ��ͬ���۵ĸ���
	 * @return
	 */
	public int pinCount(String isGood,int pid){
		int count=0;
		String sql=null;
		if(isGood!=null){
			 sql="select count(*) as totalRows from comment where isGood='"+isGood+"' and pid="+pid+"";
		}else{
			 sql="select count(*) as totalRows from comment where pid="+pid+"";
		}
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		count=(int) map.get("totalRows");
		//System.out.println("count"+count);
		return count;
	}
	
	
	/**
	 * ���� ����
	 * @param currentPage ��ǰҳ
	 * @param pageSize ҳ���С
	 * @param pName ��Ʒ������
	 * @param isGood �������ǲ���
	 * @param fromTime ��ʲôʱ��
	 * @param toTime ��ʲôʱ��
	 * @return �����б�
	 */
	public Pager<Comment> listEmps(int currentPage, int pageSize,String pName,String isGood,String fromTime,String toTime){
		Pager<Comment> pager=null;
		List<Comment> list=new ArrayList<Comment>();
		StringBuffer sb=new StringBuffer();
		if(currentPage==0){
			currentPage=1;
		}
		if(pageSize<2){
			pageSize=2;
		}
		sb.append("select * from (select row_number() over (order by commentTime desc) as rn,c.*,p.pName,u.username from comment c inner join productInfo p on p.pid=c.pid  inner join [user] u on c.comUserId=u.userID where 1=1");
		int a = (currentPage-1)*pageSize+1;
		int b = currentPage* pageSize;
		if(pName!=null&&!"".equals(pName.trim()))
			sb.append(" and p.pName like'%"+pName+"%'");
		if(isGood!=null&&!"".equals(isGood.trim()))
			sb.append(" and c.isGood='"+isGood+"'");
		if(fromTime!=null)
			sb.append(" and c.commentTime>='"+fromTime+"'");
		if(toTime!=null)
			sb.append(" and c.commentTime<='"+toTime+"'");
		
		sb.append(" ) as b where b.rn between "+a+" and "+b+"");
		String sql=sb.toString();
		//System.out.println(sql);
		try {
			list=DBUitl.executeQuery(sql, "com.comment.entity.Comment");
			//System.out.println(list);
			int totalRecord=count();
			int totalPage = totalRecord / pageSize;
			if(totalRecord % pageSize !=0){
				totalPage++;
			}
			pager=new Pager<Comment>(pageSize, currentPage, totalRecord, totalPage, list);
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
	
	public static void main(String[] args) {
		CommentDao cdao=new CommentDao();
		/*List<Comment> list=cdao.getAllComment("zhangsan", null, null, "��");
		System.out.println(list);*/
		/*int n=cdao.deleteComment(1);
		System.out.println(n);*/
		/*Comment c =new Comment();
		c.setComUserId(1);
		c.setContent("zhenxinbucuo");
		c.setPid(1);
		c.setIsGood("����");
		c.setComUserId(1);
		boolean b=cdao.sendComment(c);
		System.out.println(b);*/
		
	/*	Pager<Comment> list=cdao.listEmps(1, 2, "��", "����", "2015-10-1", new java.sql.Date(new Date().getTime()).toString());
		System.out.println(list.getDataList());*/
		
	}
}
