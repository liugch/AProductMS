package com.order.entity;

import java.util.Date;

/**
	 * 	oId int primary key  identity(1,1),		--订单编号
		oNo varchar(100),			--订单序号
		userID int(100),		--用户编号
		submitTime datetime ,		--提交订单时间
		outTime datetime,			--发货时间
		totalPrice float,			--总金额
		remark varchar(200),		--买家备注
		IPAddress varchar(200),		--买家地址
		isPayoff int,				--买家是否付款
		isOut int					--是否发货	
		
 * */
public class orderForm {
	private int oID;//订单编号
	private int oNo;//订单序号
	private int userID;//用户编号
	private Date submitTime;//提交订单时间
	private Date outTime;//发货时间
	private double totalPrice;//总金额
	private String remark;//买家备注
	private String IPAddress;//买家地址
	private int isPayoff;//买家是否付款
	private int isOut;//是否发货	
	private String phone;//电话号码
	private String name;//姓名
	private String username;//用户名
	private float pPrice;//商品单价
	private int  amount;// 商品的数量
	private float totalMoney;//商品总价格
	private String pName;//商品名称
	public int getoID() {
		return oID;
	}
	public void setoID(int oID) {
		this.oID = oID;
	}
	public int getoNo() {
		return oNo;
	}
	public void setoNo(int oNo) {
		this.oNo = oNo;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public Date getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(Date submitTime) {
		this.submitTime = submitTime;
	}
	public Date getOutTime() {
		return outTime;
	}
	public void setOutTime(Date outTime) {
		this.outTime = outTime;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getIPAddress() {
		return IPAddress;
	}
	public void setIPAddress(String iPAddress) {
		IPAddress = iPAddress;
	}
	public int getIsPayoff() {
		return isPayoff;
	}
	public void setIsPayoff(int isPayoff) {
		this.isPayoff = isPayoff;
	}
	public int getIsOut() {
		return isOut;
	}
	public void setIsOut(int isOut) {
		this.isOut = isOut;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public float getpPrice() {
		return pPrice;
	}
	public void setpPrice(float pPrice) {
		this.pPrice = pPrice;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public float getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(float totalMoney) {
		this.totalMoney = totalMoney;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public orderForm(int oID, int oNo, int userID, Date submitTime, Date outTime, double totalPrice, String remark,
			String iPAddress, int isPayoff, int isOut, String phone, String name, String username, float pPrice,
			int amount, float totalMoney, String pName) {
		super();
		this.oID = oID;
		this.oNo = oNo;
		this.userID = userID;
		this.submitTime = submitTime;
		this.outTime = outTime;
		this.totalPrice = totalPrice;
		this.remark = remark;
		IPAddress = iPAddress;
		this.isPayoff = isPayoff;
		this.isOut = isOut;
		this.phone = phone;
		this.name = name;
		this.username = username;
		this.pPrice = pPrice;
		this.amount = amount;
		this.totalMoney = totalMoney;
		this.pName = pName;
	}
	public orderForm() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "orderForm [oID=" + oID + ", oNo=" + oNo + ", userID=" + userID + ", submitTime=" + submitTime
				+ ", outTime=" + outTime + ", totalPrice=" + totalPrice + ", remark=" + remark + ", IPAddress="
				+ IPAddress + ", isPayoff=" + isPayoff + ", isOut=" + isOut + ", phone=" + phone + ", name=" + name
				+ ", username=" + username + ", pPrice=" + pPrice + ", amount=" + amount + ", totalMoney=" + totalMoney
				+ ", pName=" + pName + "]";
	}
	
	
}
	
