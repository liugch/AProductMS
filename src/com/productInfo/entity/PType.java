package com.productInfo.entity;
/*--商品类型表
go
create table pType(
	pTypeId int primary key identity(1,1),	--商品种类
	pTypeName varchar(200)					--商品种类名称
)*/
public class PType {
	private int pTypeId;
	private String pTypeName;
	public int getpTypeId() {
		return pTypeId;
	}
	public void setpTypeId(int pTypeId) {
		this.pTypeId = pTypeId;
	}
	public String getpTypeName() {
		return pTypeName;
	}
	public void setpTypeName(String pTypeName) {
		this.pTypeName = pTypeName;
	}
	public PType(int pTypeId, String pTypeName) {
		super();
		this.pTypeId = pTypeId;
		this.pTypeName = pTypeName;
	}
	public PType() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "PType [pTypeId=" + pTypeId + ", pTypeName=" + pTypeName + "]";
	}
	
}
