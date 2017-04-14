package com.productInfo.entity;

import java.io.Serializable;
import java.util.Date;
/*--��Ʒ��Ϣ��
go
create table productInfo(
	pid int primary key identity(1,1),					--��Ʒ���
	pName varchar(200),									 --��Ʒ����
	pTypeInfoId int foreign key references pType(pTypeId),--��Ʒ����
	pDesc varchar(600),									 --��Ʒ����
	pPrice float,										--��Ʒ�۸�
	amount int,											--��Ʒ����
	guiGe varchar(50),									--��Ʒ���
	pUptime datetime,									--��Ʒ�ϼ�ʱ��
	pPicture varchar(100)								--��ƷͼƬ
)*/
/*create table pType(
		pTypeId int primary key identity(1,1),	--��Ʒ����
		pTypeName varchar(200)					--��Ʒ��������
)*/
public class ProductInfo implements Serializable {
	
	private static final long serialVersionUID = -9111330812762023440L;
	private int pid ;
	private String pName;
	private int pTypeInfoId;
	private String pDesc;
	private float pPrice;
	private int amount;
	private String guiGe;
	private Date pUptime;
	private String pPicture;
	private String pTypeName;
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getpTypeInfoId() {
		return pTypeInfoId;
	}
	public void setpTypeInfoId(int pTypeInfoId) {
		this.pTypeInfoId = pTypeInfoId;
	}
	public String getpDesc() {
		return pDesc;
	}
	public void setpDesc(String pDesc) {
		this.pDesc = pDesc;
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
	public String getGuiGe() {
		return guiGe;
	}
	public void setGuiGe(String guiGe) {
		this.guiGe = guiGe;
	}
	public Date getpUptime() {
		return pUptime;
	}
	public void setpUptime(Date pUptime) {
		this.pUptime = pUptime;
	}
	public String getpPicture() {
		return pPicture;
	}
	public void setpPicture(String pPicture) {
		this.pPicture = pPicture;
	}


	public String getpTypeName() {
		return pTypeName;
	}
	public void setpTypeName(String pTypeName) {
		this.pTypeName = pTypeName;
	}
	public ProductInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProductInfo(int pid, String pName, int pTypeInfoId, String pDesc, float pPrice, int amount, String guiGe,
			Date pUptime, String pPicture, String pTypeName) {
		super();
		this.pid = pid;
		this.pName = pName;
		this.pTypeInfoId = pTypeInfoId;
		this.pDesc = pDesc;
		this.pPrice = pPrice;
		this.amount = amount;
		this.guiGe = guiGe;
		this.pUptime = pUptime;
		this.pPicture = pPicture;
		this.pTypeName = pTypeName;
	}
	@Override
	public String toString() {
		return "ProductInfo [pid=" + pid + ", pName=" + pName + ", pTypeInfoId=" + pTypeInfoId + ", pDesc=" + pDesc
				+ ", pPrice=" + pPrice + ", amount=" + amount + ", guiGe=" + guiGe + ", pUptime=" + pUptime
				+ ", pPicture=" + pPicture + ", pTypeName=" + pTypeName + "]";
	}
	
	
}
