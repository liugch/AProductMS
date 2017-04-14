package com.user.entity;
/*--用户表
go
create table [user](
	userID int primary key identity(1,1),--用户编号
	username varchar(100),		--用户名
	[password] varchar(100),	--密码
	name varchar(100),			--姓名
	sex int,					--性别
	phone varchar(100),			--电话
	post varchar(200),			--邮寄地址
	email varchar(200),			--邮箱
)*/
public class User {
	private int userID;
	private String username;
	private String password;
	private String name;
	private int sex;
	private String phone;
	private String post;
	private String email;
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public User(int userID, String username, String password, String name, int sex, String phone, String post,
			String email) {
		super();
		this.userID = userID;
		this.username = username;
		this.password = password;
		this.name = name;
		this.sex = sex;
		this.phone = phone;
		this.post = post;
		this.email = email;
	}
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "User [userID=" + userID + ", username=" + username + ", password=" + password + ", name=" + name
				+ ", sex=" + sex + ", phone=" + phone + ", post=" + post + ", email=" + email + "]";
	}
	
}
