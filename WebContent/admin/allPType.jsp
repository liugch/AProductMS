<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

	<div id="tb1" style="padding:5px;">
		<div style="margin-left:10px;">
			<!--  iconCls="icon-add"
			 iconCls="icon-edit" 
			 iconCls="icon-remove"
			  iconCls="icon-redo"
			 iconCls="icon-save"-->
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="obj.addss();">添加</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="obj.deletes();">删除</a>
			<a href="#" class="easyui-linkbutton"  plain="true" style="display:none;" id="save3"  iconCls="icon-save" onclick="obj.saves();">保存</a>
			<a href="#" class="easyui-linkbutton" plain="true" style="display:none;" iconCls="icon-redo" id="redo3" onclick="obj.redos();">取消编辑</a>	
		</div>
	</div>
	<!-- 商品类型部分 -->
	<table id="PType"></table>
	<script src="/AProductMS/js/admin/allPType.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>