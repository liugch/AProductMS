$(function(){
	
	//评价
	obj = {
		editRow : undefined,
		//查找评价
		search : function () {
			$('#comment').datagrid('load', {
				pName : $.trim($('input[name="pName"]').val()),
				isGood: $.trim($('select[name="isGood"]').val()),
				fromTime : $.trim($('input[name="fromTime"]').val()),
				toTime : $.trim($('input[name="toTime"]').val()),
			});
		},
		//删除评价
		out : function (commentId) {
			//获取已经选中的行
			//var rows = $('#comment').datagrid('getSelections');
			alert(commentId);
			if (commentId > 0) {
				$.messager.confirm('确定操作', '您正在要删除所选的记录吗？', function (flag) {
					if (flag) {
						$.ajax({
							type : 'POST',
							url : '/AProductMS/DeleteComment.action',
							data : {
								commentId : commentId,
							},
							beforeSend : function () {
								$('#comment').datagrid('loading');
							},
							success : function (data) {
								if (data) {
									$('#comment').datagrid('load');
									$('#comment').datagrid('unselectAll');
									$.messager.show({
										title : '提示',
										msg :'评论被删除成功！',
									});
								}
							},
						});
					}
				});
			} else {
				$.messager.alert('提示', '请选择要删除的记录！', 'info');
			}
		},
		huifu:function(comId,pid){
			var comId=comId;
			var pid=pid;
			$('#reply').show();
			//console.log(comId+"......"+pid);
			$('#reply').dialog({
				title : '你可以在这里回复',
				width : 500,
				height : 280,
				modal : true,
				buttons : '#btn3',
			});
			$("#hui").click(function(){
				$.ajax({
					type : 'POST',
					url : '/AProductMS/SendReply.action',
					data : {
						comId:comId,
						pid:pid,
						conmment:$("#cont").val()
					},
					beforeSend : function () {
						$('#comment').datagrid('loading');
					},
					success : function (data) {
						if (data) {
							$('#reply').dialog("close");
							$('#comment').datagrid('load');
							$('#comment').datagrid('unselectAll');
							$.messager.show({
								title : '提示',
								msg :'回复成功!',
							});
						}
					},
				});
			})
		},
		open:function(){
			$('#reply').dialog("close");
		}
	};
	$("#comment").datagrid({
		url:'/AProductMS/AllComment.action',
		width:'auto',
		height:'auto',
		title:'评论列表',
		rownumbers:true,//行号
		striped : true,//斑马线
		fitColumns:true,//自适应
		iconCls : 'icon-search',
		border:false,
		columns:[[
			{
				field : 'comId',
				title : '编号',
				width : 100,
				align:'center',
				checkbox : true,
			},
		   {
			 field:'username',
			 title:'用户名',
			 width:100,
			 align:'center',
		   },
		   {
			 field:'pName',
			 title:'商品名称',
			 align:'center',
			 width:100,
		   },
		   {
			 field:'content',
			 title:'评论内容',
			 align:'center',
			 width:100,
		   },  
		   {
			 field:'isGood',
			 title:'评论级',
			 width:100,
			 align:'center',
		   },  
		   {
			 field:'commentTime',
			 title:'评论时间',
			 width:100,
			 align:'center',
		   } ,
		   {
			 field:'caozuo',
			 title:'操作',
			 width:100,
			 align:'center',
			 formatter:function(value,row,index){ 
				console.log(row);
			   var d = '<a href="#"  onclick="obj.out('+row.comId+');">删除</a>'; 
			  var e = ' | <a href="#" onclick="obj.huifu('+row.comId+','+row.pid+')">回复</a> '; 
			   return d+e; 
			 } 
		   }
		]],
		
		toolbar : '#tb2',
		pagination:true,
		pageList : [3, 6, 9],
		pageSize:3,
		pageNumber:1,
		
	});
	$("#huifu").linkbutton();
	
});

