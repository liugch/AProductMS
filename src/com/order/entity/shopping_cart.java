package com.order.entity;
/**
 * 	[sid] int foreign key references productInfo(pid),			--商品编号
	sPicture varchar(100),										 --商品图片
	sDesc varchar(600) foreign key references productInfo(pDesc),--商品描述
	price float,												--价格
	amount int,													--数量
	total float,												--合计
	sguiGe varchar(50) foreign key references productInfo(guiGe),--规格
 * 
 * 
 * */
public class shopping_cart {
	private int  sid;
	private String sPicture;
	private String sDesc;
	private double price;
	private int amount;
	private double total;
	private String  sguiGe;
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getsPicture() {
		return sPicture;
	}
	public void setsPicture(String sPicture) {
		this.sPicture = sPicture;
	}
	public String getsDesc() {
		return sDesc;
	}
	public void setsDesc(String sDesc) {
		this.sDesc = sDesc;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public String getSguiGe() {
		return sguiGe;
	}
	public void setSguiGe(String sguiGe) {
		this.sguiGe = sguiGe;
	}
	public shopping_cart(int sid, String sPicture, String sDesc, double price, int amount, double total,
			String sguiGe) {
		super();
		this.sid = sid;
		this.sPicture = sPicture;
		this.sDesc = sDesc;
		this.price = price;
		this.amount = amount;
		this.total = total;
		this.sguiGe = sguiGe;
	}
	public shopping_cart() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "shopping_cart [sid=" + sid + ", sPicture=" + sPicture + ", sDesc=" + sDesc + ", price=" + price
				+ ", amount=" + amount + ", total=" + total + ", sguiGe=" + sguiGe + "]";
	}
	
}
