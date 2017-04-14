<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<!-- 按钮部分 -->
	
	<div id="tb2" style="padding:5px;">
		<!-- <div style="margin:5px;">
			 iconCls="icon-add"
			 iconCls="icon-edit" 
			 iconCls="icon-remove
			<a href="#" class="easyui-linkbutton"  plain="true" iconCls="icon-remove" onclick="obj.remove();">删除</a>	
		</div> -->
		<div style="padding:0 0 0 7px;color:#333;">
			商品名：<input type="text" class="textbox" name="pName" style="width:110px">
			评价级：<select class="textbox" name="isGood" style="width:80px">
					<option value="暂无评价">暂无评价</option>
					<option value="好评">好评</option>
					<option value="中评">中评</option>
					<option value="差评">差评</option>
				</select>
			评论时间：<input  type="text" name="fromTime" class="easyui-datebox"  style="width:100px">
			--- <input  type="text" name="toTime" class="easyui-datebox"  style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="obj.search();">查询</a>
		</div>
	</div>
	<!-- 分页显示 -->
	<table id="comment"></table>
	
	<!-- 回复部分 -->
	<div id="reply" style="display:none;">
			<textarea id="cont" rows="8" cols="66"></textarea>
			<div id="btn3">
				<a href="#" id="hui" class="easyui-linkbutton" >回复</a>
				<a href="#" id="buhui" class="easyui-linkbutton" onclick="obj.open()">取消</a>
			</div>
	</div>
	 <script src="/AProductMS/js/admin/allComment.js" type="text/javascript" charset="utf-8"></script> 
</body>
</html>