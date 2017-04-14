$(function(){
	/*$("#sub").on("click",function(){
		//ajax上传
		$.ajax({
			// method="post" action="/AProductMS/AddProductInfo.action" enctype="multipart/form-data"
		   	//processData: false,
		   	//contentType: false,
		   	contentType:"multipart/form-data",
		   	data:{
		   	 	pName:$('input[name="pName"]').val(),
				types:$('select[name="types"]').val(),
				pDesc:$('textarea[name="pDesc"]').val(),
				pPrice:$('input[name="pPrice"]').val(),
				amount:$('input[name="amount"]').val(),
				guiGe:$('input[name="guiGe"]').val(),
				file1:$('input[name="file1"]').val(),
				file2:$('input[name="file2"]').val(),
				file3:$('input[name="file3"]').val()
		   	},
		    success: function (data) {
		    	alert(data);
		    }
		});
		return false;
	});*/
	/*$.ajax({
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
	});*/
	
	//追加类型
	$.ajax({
		type:"post",
		url:"/AProductMS/AllPType.action",
		async:true,
		success:function(data,status,xhr){
			var arr=$.parseJSON(data);
			var html;
			$.each(arr, function(i,v) {
					html+="<option value='"+v.pTypeId+"'>"+v.pTypeName+"</option>";
			});
			$("#types").append(html);
		}
	});
	
	
	//输入验证
	$("#addproduct").validate({
		success : 'abc',
		success : function (label) {
			label.addClass('abc').text('ok');
		},
		rules:{
			pName:{
				required:true,
			},
			pPrice:{
				required:true,
			},
			guiGe:{
				required:true,
			},
			pPicture:{
				required:true,
			},
			amount:{
				required:true,
				minlength:1,
			}
		},
		messages:{
			pName:{
				required:'商品名不能为空!',
			},
			pPrice:{
				required:'商品价格不能为空!',
			},
			guiGe:{
				requried:'规格',
			},
			pPicture:{
				requried:'图片地址不能为空!',
			},
			amount:{
				requried:'商品数量不能为空!',
				minlength:jQuery.format('账号不能小于{0}'),
			}
		}
	});
});



//图片预览
function setImagePreview(doc,preview,localImag) {
	var docObj = document.getElementById(doc);
	//var upload = document.getElementById("upload");
	var imgObjPreview = document.getElementById(preview);
	if(docObj.files && docObj.files[0]) {
		//upload.style.display = 'block';
		//火狐下，直接设img属性 
		imgObjPreview.style.display = 'block';
		imgObjPreview.style.width = '130px';
		imgObjPreview.style.height = '120px';
		//imgObjPreview.src = docObj.files[0].getAsDataURL(); 
		//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式 
		imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
		
	} else {
		//IE下，使用滤镜 
		docObj.select();
		var imgSrc = document.selection.createRange().text;
		
		var localImagId = document.getElementById(localImag);
		//必须设置初始大小 
		localImagId.style.width = "130px";
		localImagId.style.height = "120px";
		//图片异常的捕捉，防止用户修改后缀来伪造图片 
		try {
			localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
			localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
		} catch(e) {
			alert("您上传的图片格式不正确，请重新选择!");
			return false;
		}
		imgObjPreview.style.display = 'none';
		document.selection.empty();
	}
	return true;
}