<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员登录</title>
<!--UI的核心UI文件CSS-->
<link rel="stylesheet" type="text/css" href="/AProductMS/easyui/themes/default/easyui.css"/>
<!--引入UI 的图标-->
<link rel="stylesheet" type="text/css" href="/AProductMS/easyui/themes/icon.css"/>
<!-- 自己的样式 -->
<link rel="stylesheet" type="text/css" href="/AProductMS/css/adminLogin.css"/>
</head>
<body>
	<div id="adminLogin">
		<!-- <h4>管理员登录</h4> -->
		<p id="adminMsg"></P>
		<p>管理员帐号：<input type="text" id="adminName" class="textbox"></p>
		<p>管理员密码：<input type="password" id="adminPassword" class="textbox"></p>
		<div id="btn">
			<a href="#" class="easyui-linkbutton">登录</a>
		</div>
	</div>

	 <!--核心标签库-->
	<script src="/AProductMS/js/jquery-3.0.0.min.js" type="text/javascript" charset="utf-8"></script>
	<!--背景-->
	<!-- <script src="/AProductMS/js/admin/jquery.ripples.js" type="text/javascript" charset="utf-8"></script> -->
	<!-- 引入UI 核心库 -->
	<script src="/AProductMS/easyui/jquery.easyui.min.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引用中文提示 -->
	<script src="/AProductMS/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入自己开发adminJS -->
	<script src="/AProductMS/js/admin/adminLogin.js" type="text/javascript" charset="utf-8"></script> 
</body>
</html>