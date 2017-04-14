<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 自己的样式 -->
<title>page</title>
</head>
<body>
	<!-- 按钮部分 -->
	
	<div id="tb" style="padding:5px;">
		<div style="margin-bottom:5px;">
			<!--  iconCls="icon-add"
			 iconCls="icon-edit" 
			 iconCls="icon-remove"
			 iconCls="icon-redo"
			 iconCls="icon-save"
			  -->
			<a href="#" class="easyui-linkbutton" onclick="obj.add();" iconCls="icon-add" plain="true">添加</a>
			<a href="#" class="easyui-linkbutton"  plain="true" iconCls="icon-remove" onclick="obj.remove();">删除</a>	
			<a href="#" class="easyui-linkbutton" plain="true"  iconCls="icon-edit"  onclick="obj.edit();">修改</a>
			<a href="#" class="easyui-linkbutton"  plain="true" style="display:none;" iconCls="icon-save" id="save" onclick="obj.save();">保存</a>
			<a href="#" class="easyui-linkbutton" plain="true" style="display:none;"  iconCls="icon-redo"  id="redo" onclick="obj.redo();">取消编辑</a>		
		</div>
		<div style="padding:0 0 0 7px;color:#333;">
			商品名：<input type="text" class="textbox" name="proName" style="width:110px">
			商品类型：	<select class="textbox" id="types" name="typeNames" style="width:110px">
					</select>
			商品价格：<input type="text" class="textbox" name="fPrice" style="width:100px">
			--- <input type="text" class="textbox" name="tPrice" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="obj.search();">查询</a>
		</div>
	</div>
	<!-- 分页部分 -->
	<table id="product"></table>
	
	 <script src="/AProductMS/js/admin/allproduct.js" type="text/javascript" charset="utf-8"></script> 
</body>
</html>