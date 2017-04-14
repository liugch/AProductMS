<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	
</style>
</head>
<body>
	<form id="addproduct" method="post" action="" >
		<div>
			<p>商品名称:&nbsp;&nbsp;<input type="text" name="pName" id="pName"></p>
			商品种类:&nbsp;&nbsp;<select name="typeNames" id="types">
					</select>
			<p>商品描述:&nbsp;&nbsp;<textarea style="vertical-align:top;" name="pDesc" rows="10" cols="35"  id="pDesc"></textarea>
			<p>商品价格:&nbsp;&nbsp;<input type="text" name="pPrice" id="pPrice"></p>
			<p>商品数量:&nbsp;&nbsp;<input type="text" name="amount" value="1" id="amount"></p>
			<p>商品规格:&nbsp;&nbsp;<input type="text" name="guiGe"  id="guiGe"></p>			
			添加三张图片:<div id="mmm">	
			<!--图片区域  -->
				<div> 
			        <input type="file" name="fileImg1" id="fileImg1" style="opacity: 0;width:56px;border:1px solid red; height:60px;" onchange="uploadimg('img1','fileImg1','hidden1')" accept="image/jpeg,image/png,image/gif"><br />  
			        <input type="hidden" name="hidden1" id="hidden1" value="" />			       
	   			 </div>
	   			  <div> 
			        <input type="file" name="fileImg2" id="fileImg2" style="opacity: 0;width:56px;border:1px solid red;height:60px;" onchange="uploadimg('img2','fileImg2','hidden2')" accept="image/jpeg,image/png,image/gif"><br />  
			        <input type="hidden" name="hidden2" id="hidden2" value="" />			        
	   			 </div>
	   			  <div> 
			        <input type="file" name="fileImg3" id="fileImg3" style="opacity: 0;width:56px;border:1px solid red;height:60px;" onchange="uploadimg('img3','fileImg3','hidden3')" accept="image/jpeg,image/png,image/gif"><br />  
			        <input type="hidden" name="hidden3" id="hidden3" value="" />			        
	   			 </div>
			</div>
			<div style="clear: both;">
				<img class="load0" name="img1" id="img1" src=""/>
				<img class="load0" name="img2" id="img2" src=""/>
				<img class="load0" name="img3" id="img3" src=""/>
   			</div>
			<p><input type="button" id="sub" value="添加" style="width:50px;padding:0px 4px 18px 4px;">&nbsp;&nbsp;&nbsp;<input type="reset" id ="reset"style="width:50px;padding:0px 4px 18px 4px;" value="取消"></p>
		</div>
	</form>
	<script src="/AProductMS/easyui/jquery.validate.js" type="text/javascript" charset="utf-8"></script>
	<script src="/AProductMS/easyui/ajaxfileupload.js" type="text/javascript" charset="utf-8"></script>
	<script src="/AProductMS/js/admin/addproduct.js" type="text/javascript" charset="utf-8"></script>
	<script>
	/**
	 * 加载图片
	 */
	function uploadimg(imgid,fileid,hiddenid) {
    	//imgid指<img />标签id,fileid表示<input type='file' />文件上传标签的id,hiddenid指隐藏域标签id
	    $("#"+imgid).attr("src","/AProductMS/images/admin/loading.gif").removeClass("load0");//加载loading图片
	    $.ajaxFileUpload ({            
            url: '/AProductMS/AddPictures.action',
            secureuri: false,
            fileElementId: fileid, 
            dataType:'json',   	           
            success: function (data, status) {
            	console.log(data);
				//加载返回的图片路径
            	$("#"+imgid).attr("src",data.picUrl).css("width","200px").css("height","200px");	            	
            	$("#"+hiddenid).val(data.picUrl);//给对应的隐藏域赋值，以便提交时给后台
            },
	    }
	)};
	</script>
</body>

</html>