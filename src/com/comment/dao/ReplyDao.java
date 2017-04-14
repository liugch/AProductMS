package com.comment.dao;

import java.util.ArrayList;
import java.util.List;

import com.comment.entity.Reply;
import com.util.DBUitl;

/*--回复表
go
create table reply(
	rId int primary key identity(1,1),					--回复编号
	rUserId int ,										--回复人编号
	rComId int foreign key references comment (comId) , --评论编号
	pid int foreign key references productInfo(pid),	--回复商品的编号
	rContent ntext,										--回复内容
	replyTime datetime									--回复时间时间									--回复内容
)*/
public class ReplyDao {
	
	/**
	 * 查询   对应商品   对应评论的回复信息
	 * @param pid 商品的编号
	 * @param rComId 评论的编号 
	 * @return 回复的信息
	 */
	public List<Reply> getAllReply(int pid,int rComId){
		List<Reply> list=new ArrayList<Reply>();
		String sql="select rId,rUserId,rComId,pid,rContent,replyTime from reply where pid="+pid+" and rComId="+rComId+"";
		list=DBUitl.executeQuery(sql,"com.comment.entity.Reply");
		return list;
	}
	/**
	 * 回复
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
