package com.comment.dao;

import java.util.ArrayList;
import java.util.List;

import com.comment.entity.Reply;
import com.util.DBUitl;

/*--�ظ���
go
create table reply(
	rId int primary key identity(1,1),					--�ظ����
	rUserId int ,										--�ظ��˱��
	rComId int foreign key references comment (comId) , --���۱��
	pid int foreign key references productInfo(pid),	--�ظ���Ʒ�ı��
	rContent ntext,										--�ظ�����
	replyTime datetime									--�ظ�ʱ��ʱ��									--�ظ�����
)*/
public class ReplyDao {
	
	/**
	 * ��ѯ   ��Ӧ��Ʒ   ��Ӧ���۵Ļظ���Ϣ
	 * @param pid ��Ʒ�ı��
	 * @param rComId ���۵ı�� 
	 * @return �ظ�����Ϣ
	 */
	public List<Reply> getAllReply(int pid,int rComId){
		List<Reply> list=new ArrayList<Reply>();
		String sql="select rId,rUserId,rComId,pid,rContent,replyTime from reply where pid="+pid+" and rComId="+rComId+"";
		list=DBUitl.executeQuery(sql,"com.comment.entity.Reply");
		return list;
	}
	/**
	 * �ظ�
	 * @param r
	 * @return
	 */
	public int sendReply(Reply r){
		int n=0;
		String sql="insert into reply(rUserId,rComId,pid,rContent,replyTime) values(?,?,?,?,GETDATE())";
		n=DBUitl.PreparedUpdate(sql, r.getrUserId(),r.getrComId(),r.getPid(),r.getrContent());
		return n;
	}
}
