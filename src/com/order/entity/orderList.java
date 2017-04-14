package com.order.entity;
/**
 * 	oListID int primary key identity(1,1),				--订单列表编号
	oLID int foreign key references orderForm(oId) ,	--订单编号
	pID int foreign key references productInfo(pid),	--商品编号
	amount int			
 * 	
 * */
public class orderList {
	private int oListID;
	private int oLID;
	private int pID;
	private int amount;
	public int getoListID() {
		return oListID;
	}
	public void setoListID(int oListID) {
		this.oListID = oListID;
	}
	public int getoLID() {
		return oLID;
	}
	public void setoLID(int oLID) {
		this.oLID = oLID;
	}
	public int getpID() {
		return pID;
	}
	public void setpID(int pID) {
		this.pID = pID;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public orderList(int oListID, int oLID, int pID, int amount) {
		super();
		this.oListID = oListID;
		this.oLID = oLID;
		this.pID = pID;
		this.amount = amount;
	}
	public orderList() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "orderListDao [oListID=" + oListID + ", oLID=" + oLID + ", pID=" + pID + ", amount=" + amount + "]";
	}
	
}
