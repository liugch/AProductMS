$(function(){
	//背景部分
	/*$('body').ripples({
		resolution: 512,
		dropRadius: 20, //px
		perturbance: 0.04,
	});
	$("#adminLogin").on("click",function(){
		$('body').ripples('destroy');
	});*/
	//登录界面
	$('#adminLogin').dialog({
		title : '管理员登录',
		width : 500,
		height : 280,
		modal : true,
		closable:false,
		border:false,
		iconCls:"icon-login",
		buttons : '#btn',
	});
	
	//管理员帐号验证
	$('#adminName').validatebox({
		required : true,
		missingMessage : '请输入管理员帐号',
		invalidMessage : '管理员帐号不得为空',
	});
	
	//管理员密码验证
	$('#adminPassword').validatebox({
		required : true,
		//validType : 'length[6,30]',
		missingMessage : '请输入管理员密码',
		invalidMessage : '管理员密码不得为空',
	});
	
	//加载时判断验证
	if (!$('#adminName').validatebox('isValid')) {
		$('#adminName').focus();
	} else if (!$('#adminPassword').validatebox('isValid')) {
		$('#adminPassword').focus();
	}
	
	
	//单击登录
	$('#btn a').click(function () {
		if (!$('#adminName').validatebox('isValid')) {
			$('#adminName').focus();
		} else if (!$('#adminPassword').validatebox('isValid')) {
			$('#adminPassword').focus();
		} else {
			$.ajax({
				url:'/AProductMS/adminLogin.action',
				data:{
					adminName:$("#adminName").val(),
					adminPassword:$("#adminPassword").val()
				},
				beforeSend:function(){
					$.messager.progress({
						text : '正在登录中...',
					});
				},
				success:function(data,status,xhr){
					//alert(data);
					//str.replace(/^\s+|\s+$/g," ");去除前后的空格
					if(data==1){
						location.href = '/AProductMS/admin/mainIndex.jsp';
					}else{
						$("#adminMsg").text("管理员账号或者密码有误!重新输入!").css('color','red');
						$('#adminPassword').select();
						$.messager.progress("close");
					}
				},
			});
		}
	});
});

