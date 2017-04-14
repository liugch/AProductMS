<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

	<div id="tb4" style="padding:5px;">
	
		<div style="padding:0 0 0 7px;color:#333;">		
			订单的编号：<input type="text" class="textbox" name="nono" value="" style="width:110px">
			是否付款  ：	<select class="textbox"  name="ispayoff" style="width:100px">
						<option value="0">未付款</option>
						<option value="1">已付款</option>
					</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="obj.search();">查询</a>
		</div>
	</div>
	<!-- 分页部分 -->
	<table id="orderForm"></table>
	
	 <script src="/AProductMS/js/admin/allOrderForm.js" type="text/javascript" charset="utf-8"></script> 
</body>
</html>