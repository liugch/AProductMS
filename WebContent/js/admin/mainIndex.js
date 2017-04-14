$(function(){
	
	//菜单部分
	$('#caidan').tree({
		data :[
		   	{
				"id" : 1,
				"text" : "商品管理",
				"iconCls":"icon-zhu",
				"children" : [
						{
							"id":'1',
							"text" : "销售报表",
							"iconCls":"icon-list",
							"url":"/AProductMS/admin/typeChart.jsp",
						},
						{
						"id":'2',
						"text" : "查看商品",
						"iconCls":"icon-list",
						"url":"/AProductMS/admin/allProduct.jsp",
					},
					{
						"id":3,
						"text" : "添加商品",
						"iconCls":"icon-list",
						"url":"/AProductMS/admin/addProduct.jsp",
					}
				]
			},
			{
				"id":3,
				"text":"类型管理",
				"iconCls":"icon-zhu",
				"children":[
					{
						"id":1,
						"text" : "商品类型",
						"iconCls":"icon-list",
						"url":"/AProductMS/admin/allPType.jsp",
					}
				]
			
			},
			{
				"id" : 3,
				"text" : "订单管理",
				"iconCls":"icon-zhu",
				"children" : [
					{
						"id":1,
						"text" : "查看订单",
						"iconCls":"icon-list",
						"url":"allOrderForm.jsp",
			/*			"state" : "closed"*/
					}
				]
			},
			{
				"id" : 4,
				"text" : "评论管理",
				"iconCls":"icon-zhu",
				"children" : [
					{
						"id":1,
						"text" : "查看评论",
						"iconCls":"icon-list",
						"url":"/AProductMS/admin/allComment.jsp",
					}
				]
			},
			{
				"id" : 5,
				"text" : "用户管理",
				"iconCls":"icon-zhu",
				"children" : [
					{
						"id":1,
						"text" : "查看用户信息",
						"iconCls":"icon-list",
						"url":"/AProductMS/admin/allUser.jsp",
					}
				]
			}
		],
		animate:true,
		lines : true,
		onClick : function (node) {
			console.log(node);
			if (node.url) {
				if ($('#tabs').tabs('exists', node.text)) {
					$('#tabs').tabs('select', node.text);
				} else {
					$('#tabs').tabs('add', {
						index:node.id,
						title : node.text,
						//iconCls : node.iconCls,
						closable : true,
						href : node.url,
					});
				}
			}
		}
	});
	//选项卡
	$('#tabs').tabs({
		fit : true,
		border : false,
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*alert($(".p1").length);
	for(var i=0;i<$(".p1").length;i++){
		$(".p1")[i].hide();
	}*/
	/*for(var i=0;i<$(".p1").length;i++){
		$(".pro")[i].on("click",function(){
			if($(".p1")[i].is(":hidden")){
				$(".p1")[i].slideDown("slow");
			}else{
				$(".p1")[i].slideUp("slow");
			}
		})
	}*/
	/*$(".p1").hide();
	
	$(".pro").on("click",function(){
		if($(".p1").is(":hidden")){
			$(".p1").slideDown("slow");
		}else{
			$(".p1").slideUp("slow");
		}
	})*/
	/*$(".p1").each(function(i){
		if($(".p1")[i].is(":hidden")){
			$(".p1")[i].slideDown("slow");
		}else{
			$(".p1")[i].slideUp("slow");
		}
	});*/
	
	
});