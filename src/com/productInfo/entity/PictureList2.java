package com.productInfo.entity;
/**
 * 		picid2 int primary key identity(1,1),--图片编号
	pid2 int foreign key references productInfo(pid),--商品编号
	picFour varchar(100),					--第四张图片
	picFive varchar(100),					--第五张图片
	picSix varchar(100)	,				--第六张图片
	priSeven varchar(100),							--第七张图片
	priEighT varchar(100),							--第八张图片
		
 * 
 * */
public class PictureList2 {
	private int picid2;
	private int pid2;
	private String picFour;
	private String picFive;
	private String picSix;
	private String priSeven;
	private String priEighT;
	public int getPicid2() {
		return picid2;
	}
	public void setPicid2(int picid2) {
		this.picid2 = picid2;
	}
	public int getPid2() {
		return pid2;
	}
	public void setPid2(int pid2) {
		this.pid2 = pid2;
	}
	public String getPicFour() {
		return picFour;
	}
	public void setPicFour(String picFour) {
		this.picFour = picFour;
	}
	public String getPicFive() {
		return picFive;
	}
	public void setPicFive(String picFive) {
		this.picFive = picFive;
	}
	public String getPicSix() {
		return picSix;
	}
	public void setPicSix(String picSix) {
		this.picSix = picSix;
	}
	public String getPriSeven() {
		return priSeven;
	}
	public void setPriSeven(String priSeven) {
		this.priSeven = priSeven;
	}
	public String getPriEighT() {
		return priEighT;
	}
	public void setPriEighT(String priEighT) {
		this.priEighT = priEighT;
	}
	public PictureList2(int picid2, int pid2, String picFour, String picFive, String picSix, String priSeven,
			String priEighT) {
		super();
		this.picid2 = picid2;
		this.pid2 = pid2;
		this.picFour = picFour;
		this.picFive = picFive;
		this.picSix = picSix;
		this.priSeven = priSeven;
		this.priEighT = priEighT;
	}
	public PictureList2() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "pictureList2 [picid2=" + picid2 + ", pid2=" + pid2 + ", picFour=" + picFour + ", picFive=" + picFive
				+ ", picSix=" + picSix + ", priSeven=" + priSeven + ", priEighT=" + priEighT + "]";
	}
	
}
