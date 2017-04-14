$(function(){
	$("#user").datagrid({
		url:'/AProductMS/AllUser.action',
		width:'auto',
		height:'auto',
		title:'商品列表',
		rownumbers:true,//行号
		striped : true,//斑马线
		fitColumns:true,//自适应
		iconCls : 'icon-search',
		border:false,
		/*--用户表
		go
		create table [user](
			userID int primary key identity(1,1),--用户编号
			username varchar(100),		--
			[password] varchar(100),	--密码
			name varchar(100),			--
			sex int,					--
			phone varchar(100),			--
			post varchar(200),			--邮寄地址
			email varchar(200),			--
		)*/
		columns:[[
			{
				field : 'userID',
				title : '编号',
				width : 100,
				align:'center',
				checkbox : true,
			},
		   {
			 field:'username',
			 title:'用户名',
			 align:'center',
			 width:100,
		   },
		   {
			 field:'name',
			 title:'姓名',
			 align:'center',
			 width:100,
			
		   },  
		   {
			 field:'sex',
			 title:'性别',
			 width:100,
			 align:'center',
			 formatter : function (value,row,index) {
				console.log(row);
				if(row.sex==1){
					return '男';
				}else{
					return '女';
				} 
			 },
		   },  
		   {
			 field:'phone',
			 title:'电话号码',
			 width:100,
			 align:'center',
		   } , 
		   {
			 field:'email',
			 title:'邮箱',
			 width:100,
			 align:'center',
			}
		]],
		pagination:true,
		pageList : [3, 6, 9],
		pageSize:3,
		pageNumber:1,
		
	});
	
});

