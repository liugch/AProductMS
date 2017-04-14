package com.productInfo.entity;
/*--图片列表
go
create table pictureList(
	picid int primary key identity(1,1),--图片编号
	pid int foreign key references productInfo(pid),--商品编号
	picOne varchar(100),					--第一张图片
	picTwo varchar(100),					--第二张图片
	picThree varchar(100)					--第三张图片
)*/
public class PictureList {
	private int picid;
	private int pid;
	private String picOne;
	private String picTwo;
	private String picThree;
	public int getPicid() {
		return picid;
	}
	public void setPicid(int picid) {
		this.picid = picid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getPicOne() {
		return picOne;
	}
	public void setPicOne(String picOne) {
		this.picOne = picOne;
	}
	public String getPicTwo() {
		return picTwo;
	}
	public void setPicTwo(String picTwo) {
		this.picTwo = picTwo;
	}
	public String getPicThree() {
		return picThree;
	}
	public void setPicThree(String picThree) {
		this.picThree = picThree;
	}
	public PictureList(int picid, int pid, String picOne, String picTwo, String picThree) {
		super();
		this.picid = picid;
		this.pid = pid;
		this.picOne = picOne;
		this.picTwo = picTwo;
		this.picThree = picThree;
	}
	public PictureList() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "PictureList [picid=" + picid + ", pid=" + pid + ", picOne=" + picOne + ", picTwo=" + picTwo
				+ ", picThree=" + picThree + "]";
	}
	
}
