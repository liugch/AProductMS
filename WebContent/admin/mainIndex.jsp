<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理主界面</title>
<!--UI的核心UI文件CSS-->
<link rel="stylesheet" type="text/css" href="/AProductMS/easyui/themes/default/easyui.css"/>
<!--引入UI 的图标-->
<link rel="stylesheet" type="text/css" href="/AProductMS/easyui/themes/icon.css"/>
<!-- 自己的样式 -->
<link rel="stylesheet" type="text/css" href="/AProductMS/css/mainIndex.css"/>
</head>
<body id="layout" class="easyui-layout">
	
	
	<c:if test="${sessionScope.adminName ne null}" >
		<div id="head" data-options="
			region:'north',
			border : true,
			collapsible : false,
			split:true,
			noheader:true,
			" style="height:100px;width:100%;background-color:#FAFCFF;">
			<div id="top">
				<h1 style="font-size:16px;">欢迎使用!</h1>
				<p><a href="/AProductMS/admin/adminLogin.jsp">您好!${adminName}</a>&nbsp;|&nbsp;<a href="/AProductMS/OutAdminLogin.action">退出</a></p>
			</div>
		</div>
		<!--菜单部分  -->
		<div iconCls='icon-world' data-options="region:'west',title:'  系统菜单',collapsible : true,split:true,align:'center'," style="width:250px;">
				<div id="caidan"></div>
		</div>
		
		<div data-options="region:'center',collapsible : false,split:true,">
			<div id="tabs">
				<div title="起始页" iconCls="icon-house" style="padding:0 10px;display:block;">
					<p style="font-size:60px;color:#E0ECFF;text-align:center;margin:150px auto;font-family: 华文彩云;">欢迎来到后台管理系统！<p>
				</div>
			</div>
		</div>	
		<div data-options="region:'south',collapsible :false,split:true,noheader:true," style="height:70px;">
			<p style="text-align:center;color:#72C0F7;">Copyright© 鲜尚鲜网上超市 2016-2015，All Rights Reserved</p>
		</div>	
	</c:if>
	<c:if test="${sessionScope.adminName eq null}">
		<c:redirect url="/admin/adminLogin.jsp"/>
	</c:if>
	
	<!--核心标签库-->
	<script src="/AProductMS/js/jquery-3.0.0.js" type="text/javascript" charset="utf-8"></script>
	<!--引入UI 核心库 -->
	<script src="/AProductMS/easyui/jquery.easyui.min.js" type="text/javascript" charset="utf-8"></script>
	<!--引用中文提示-->
	<script src="/AProductMS/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
	<!--引入自己开发adminJS-->
	 <script src="/AProductMS/js/admin/mainIndex.js" type="text/javascript" charset="utf-8"></script> 

</body>
</html>