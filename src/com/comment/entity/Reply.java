package com.comment.entity;

import java.util.Date;

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
public class Reply {
	private int rId;
	private int rUserId;
	private int rComId;
	private int pid;
	private String rContent;
	private Date replyTime;
	@Override
	public String toString() {
		return "Reply [rId=" + rId + ", rUserId=" + rUserId + ", rComId=" + rComId + ", pid=" + pid + ", rContent="
				+ rContent + ", replyTime=" + replyTime + "]";
	}
	public Reply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Reply(int rId, int rUserId, int rComId, int pid, String rContent, Date replyTime) {
		super();
		this.rId = rId;
		this.rUserId = rUserId;
		this.rComId = rComId;
		this.pid = pid;
		this.rContent = rContent;
		this.replyTime = replyTime;
	}
	public int getrId() {
		return rId;
	}
	public void setrId(int rId) {
		this.rId = rId;
	}
	public int getrUserId() {
		return rUserId;
	}
	public void setrUserId(int rUserId) {
		this.rUserId = rUserId;
	}
	public int getrComId() {
		return rComId;
	}
	public void setrComId(int rComId) {
		this.rComId = rComId;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public Date getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}
	
	
}
