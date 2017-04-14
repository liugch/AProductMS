$(function(){
	
	//商品
	obj = {
		editRow : undefined,
		//查找商品
		search:function () {
			$('#orderForm').datagrid('load', {				
				ispayoff: $.trim($('select[name="ispayoff"]').val()),
				bianhao : $.trim($('input[name="nono"]').val())
			});
		},
		fahuo:function(oID){
			//console.log(oID);
			if (oID > 0) {
				$.ajax({
					type : 'POST',
					url : '/AProductMS/UpdateOrderForm.action',
					data : {
						oID : oID,
					},
					beforeSend : function () {
						$('#orderForm').datagrid('loading');
					},
					success : function (data) {
						if (data>0) {
							$('#orderForm').datagrid('load');
							$('#orderForm').datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg :'等待快递小哥来收件!......',
							});
						}
					},
				});
			}
		}
	
	};
	
	$("#orderForm").datagrid({
		url:'/AProductMS/AllOrderForm.action',
		width:'auto',
		height:'auto',
		title:'订单列表',
		rownumbers:true,//行号
		striped : true,//斑马线
		fitColumns:true,//自适应
		iconCls : 'icon-search',
		border:false,
		columns:[[
			{
				field : 'oID',
				title : '编号',
				width : 100,
				checkbox : true,
				align:'center',
			},
		   {
			 field:'oNo',
			 title:'订单的序号',
			 width:100,
			 align:'center',
		   },
		   {
			 field:'username',
			 title:'用户名',
			 width:100,
			 align:'center',
		   },  
		   {
			 field:'pPrice',
			 title:'商品单价/元',
			 width:100,
			 align:'center',
			 formatter : function (value,row,index) {
				 return value+"元";
			  },
		   },  
		   {
			 field:'amount',
			 title:'商品数量/个',
			 width:100,
			 align:'center',
			} , 
		   {
			 field:'totalMoney',
			 title:'商品总价格',
			 width:100,
			 align:'center',
			 formatter : function (value,row,index) {
				 return value+"元";
			  },
		   } ,
		   {
			   field:'status',
			   title:'状态',
			   width:100,
			   align:'center',
			   formatter : function (value,row,index) {
				 //  console.log(row);
				   var t=row.isPayoff;
				   if(t==0){
					   return "未付款"
				   }else{
					   return "已付款";
				   }
			   },
			}, 
		   {
			  field:'caozuo',
			  title:'操作',
			  width:100,
			  align:'center',		  
			  formatter : function (value,row,index) {
				  return  '<a href="#" onclick="obj.fahuo('+row.oID+');" >发货</a>'; 
				 // oID: 5, oNo: 32345333, userID: 6, submitTime: "六月 27, 1905", outTime: "六月 27, 19				 
			  },
		   }   
		]],
		
		toolbar : '#tb4',
		pagination:true,
		pageList : [3, 6, 9],
		pageSize:3,
		pageNumber:1,
		
		
	});
	
});

