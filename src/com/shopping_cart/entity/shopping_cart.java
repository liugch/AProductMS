package com.shopping_cart.entity;
/*--购物车表
create table shopping_cart( 
	cid int primary key identity(1,1),							--购物车编号 
	userID int foreign key references [user](userID),			--用户编号
	[sid] int foreign key references productInfo(pid),			--商品编号
	sPicture varchar(100),										--商品图片
	sName  varchar(600),										--商品名称
	price float,												--价格
	amount int,													--数量
	total float,												--合计
	sguiGe varchar(50) ,										--规格
)
*/
public class shopping_cart {
	private int cid;
	private int userID;
	private int sid;
	private String sPicture;
	private String sName;
	private double price;
	private  int amount;
	private double  total;
	private	String sguiGe ;
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
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
	public String getsName() {
		return sName;
	}
	public void setsName(String sName) {
		this.sName = sName;
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
	public shopping_cart(int cid, int userID, int sid, String sPicture, String sName, double price, int amount,
			double total, String sguiGe) {
		super();
		this.cid = cid;
		this.userID = userID;
		this.sid = sid;
		this.sPicture = sPicture;
		this.sName = sName;
		this.price = price;
		this.amount = amount;
		this.total = total;
		this.sguiGe = sguiGe;
	}
	public shopping_cart() {
		super();
		
	}
	@Override
	public String toString() {
		return "shopping_cart [cid=" + cid + ", userID=" + userID + ", sid=" + sid + ", sPicture=" + sPicture
				+ ", sName=" + sName + ", price=" + price + ", amount=" + amount + ", total=" + total + ", sguiGe="
				+ sguiGe + "]";
	}
	
}
