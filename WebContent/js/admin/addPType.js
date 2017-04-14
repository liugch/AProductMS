$(function(){
	//验证类型
	$("#addPType").validate({
		success : 'color',
		success : function (label) {
			label.addClass('color').text('ok');
		},
		rules:{
			typeName:{
				required:true,
			}
		},
		messages:{
			typeName:{
				required:'类型名不能为空!',
			}
		}
	});
	//单击登录
	$('#btn1 #a').click(function () {
		/*if($("#typeName").val()==''){
			$.messager.alert('美丽的提示','没有类型是插不进去的哦!','info', function () {
				//alert('确认后的回调！');
				$("#typeName").focus();
			});	
		}else{*/
			$.ajax({			
				url:'/AProductMS/AddPType.action',
				data:{
					typeName:$("#typeName").val(),
				},
				beforeSend:function(){
					$.messager.progress({
						text : '努力添加中...',
					});		
				},
				success:function(data){								
					if(data){
						$.messager.show({
							title : '提示',
							msg :  data,
						});
						$.messager.progress('close');
					}				
				},
			});		
		/*}*/
		
	});
	$('#btn1 #b').click(function () {
		//获取被选择的选项卡
		//console.log($('#tabs').tabs('getSelected'));
		//获取选中的选项卡的下标
		var index=$('#tabs').tabs('getTabIndex',$('#tabs').tabs('getSelected'));
		//console.log(index);
		//关闭选中的的选项卡
		$('#tabs').tabs('close', index);
	});
});

