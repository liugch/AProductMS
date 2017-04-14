package com.comment.entity;

import java.util.Date;

/*--评论表
go
create table comment(
	comId int primary key identity(1,1),				--评论编号
	comUserId int foreign key references [user](userID) ,--评论人编号
	pid int foreign key references productInfo(pid) ,     --商品编号
	content ntext,										--评论内容
	commentTime datetime,								--评论时间
	isGood varchar(20)									--是差中好评?
	username 用户名
	pName 商品名
)*/
public class Comment {
	private int comId;
	private int comUserId;
	private int pid;
	private String content;
	private Date commentTime;
	private String isGood;
	private String username;
	private String pName;
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getComId() {
		return comId;
	}
	public void setComId(int comId) {
		this.comId = comId;
	}
	public int getComUserId() {
		return comUserId;
	}
	public void setComUserId(int comUserId) {
		this.comUserId = comUserId;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCommentTime() {
		return commentTime;
	}
	public void setCommentTime(Date commentTime) {
		this.commentTime = commentTime;
	}
	public String getIsGood() {
		return isGood;
	}
	public void setIsGood(String isGood) {
		this.isGood = isGood;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public Comment() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Comment [comId=" + comId + ", comUserId=" + comUserId + ", pid=" + pid + ", content=" + content
				+ ", commentTime=" + commentTime + ", isGood=" + isGood + ", username=" + username + ", pName=" + pName
				+ "]";
	}
	public Comment(int comId, int comUserId, int pid, String content, Date commentTime, String isGood, String username,
			String pName) {
		super();
		this.comId = comId;
		this.comUserId = comUserId;
		this.pid = pid;
		this.content = content;
		this.commentTime = commentTime;
		this.isGood = isGood;
		this.username = username;
		this.pName = pName;
	}
	
	
}
