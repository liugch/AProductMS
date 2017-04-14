<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>登录</title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script type="text/javascript" src="js/jquery.validate.js" ></script>
		<link rel="stylesheet" type="text/css" href="css/login.css"/>
		<link rel="stylesheet" href="css/themes.css" />
		<link rel="stylesheet" href="css/public.css" />
		<link rel="shortcut icon" href="img/tu.png">
	</head>
	<script>
	    $(function () {
	        $('#Pwd').keydown(function (e) {
            if (e.keyCode == 13) {
                document.getElementById("btnLogin").click(); //调用登录按钮的登录事件
            }
	    });
	</script>
	<body>
	<div id="w">
		<div class="header clearfix">
		    <div class="wrap">
		        <div class="logo">
		            <a href="index.jsp" target="_blank"></a>
		            <span class="h-tit">登录</span>
		        </div>
		    </div>
		</div>
			<form action="/AProductMS/Mian.do" method="post" id="frm">
				<div class="login">
					<div class="wrap">
						<div class="fl">
							<a href="#">
								<img width="666px" height="418px" src="img/login.jpg"/>
							</a>
						</div>
						<div class="fr">
							<p class="right"></p>
							<div class="login-main">
								<p>
									<strong>欢迎登录</strong>
									<span class="r1">
										还没有账号？
										<a class="green" href="/AProductMS/Regist.jsp">立即注册</a>
									</span>
								</p>
								 <div id="msg-wrap" class="msg-wrap">
								 	<div class="msg-error">
									 	
									</div>
								</div>
								<p>
									<span class="phone-icon"></span>
									<input type="text" name="phone" id="UserName" class="input input-phone" placeholder="账号/已验证手机" value="" />
								</p>
								<p>
									<span class="key-icon"></span>
									<input type="password" name="Pwd" id="Pwd" class="input input-key" placeholder="密码" />
								</p>
								<p>
									<label>
										<input type="checkbox" name="UserNameRemeber" id="UserNameRemeber" data-val-requeired="The 自动登录 field is required." data-val="true" value="true" />
										<input name="UserNameRemeber" type="hidden" value="false" />
										自动登录
									</label>
									<span  class="r2"></span>
									<a href="/AProductMS/FindPwd.jsp" class="forget">忘记登录密码？</a>
								</p>
								<p>
									<input type="submit" id="btnLogin" class="btn-green-l" value="登 &nbsp; 录"></input>
								</p>
								<p>第三方登录</p>
								<div>
									<a href="#"><img src="img/san.png"/></a>
								</div>
							</div>
						</div>
					</div>
			</form>
			<c:if test="${msg1 !=null }">
				<script type="text/javascript">
					$(".msg-error").text("${msg1}").css("color","red");
					$("input[name='UserName']").focus();
				</script>
			</c:if> 
		</div>
		<!------- 页尾开始 ------->
	        <div class="footer">
	            <div class="wrap">
	                <dl class="col1">
	                    <dt>新手指南</dt>
	                    <dd>
	                        <p><a href="#">账户注册</a></p>
	                        <p><a href="#">购物流程</a></p>
	                        <p><a href="#">订购方式</a></p>
	                        <p><a href="#">悠币说明</a></p>
	                        <p><a href="#">会员等级</a></p>
	                    </dd>
	                </dl>
	                <dl class="col2">
	                    <dt>付款方式</dt>
	                    <dd>
	                        <p><a href="#">支付方式</a>/<a href="#">发票说明</a></p>
	                        <p><a href="#">充值说明</a>/<a href="#">储值卡说明</a></p>
	                        <p><a href="#">优惠代码/礼品卡说明</a></p>
	                        <p><a href="#">卡券购买章程</a></p>
	                    </dd>
	                </dl>
	                <dl class="col3">
	                    <dt>配送方式</dt>
	                    <dd>
	                        <p><a href="#">配送运费</a></p>
	                        <p><a href="#">配送范围</a></p>
	                        <p><a href="#">配送时间</a></p>
	                    </dd>
	                </dl>
	                <dl class="col4">
	                    <dt>售后服务</dt>
	                    <dd>
	                        <p><a href="#">退换货政策</a></p>
	                        <p><a href="#">退换货流程</a></p>
	                        <p><a href="#">常见问题</a></p>
	                        <p><a href="#">投诉与建议</a></p>
	                    </dd>
	                </dl>
	                <dl class="col5">
	                    <dt>关于我们</dt>
	                    <dd>
	                        <p><a href="#">公司介绍</a></p>
	                        <p><a href="#">联系我们</a></p>
	                        <p><a href="#">业务合作</a></p>
	                        <p><a href="#">诚信举报</a></p>
	                        <p><a href="#">人才招聘</a></p>
	                        
	                        
	                    </dd>
	                </dl>
	                <div class="service"><span>客服热线 400-000-7788</span><span>周一至周日 9:00-21:00</span></div>
	                <div class="copyright">
	                    <p>所有图片均受著作权保护，未经许可任何单位与个人不得使用、复制、转载、摘编，违者必究法律责任。</p>
	                    <p>沪ICP备09008015号 Copyright © 2005-2016 <a href="#">上海易果电子商务有限公司</a>版权所有</p>
	                    <p class="authentication">
	                        <a href="#" target="_blank"><img src="img/footer_copy.gif" width="47px" height="47px"></a>
	                        <a href="#">
	                            <img src="img/picp_bg.png"  border="0">
	                            <!--<span>310100102001</span>-->
	                        </a>
	                    </p>
	                </div>
	            </div>
	        </div>
	        <!------- 页尾结束 ------->
    </div>
	</body>
	<script>
	    $(function(){
			/* $("input[name='UserName']").bind("focus",function(){
				$(".msg-error").text("");
			});
			$("input[name='Pwd']").bind("focus",function(){
				$(".msg-error").text("");
			});  */
			$("#frm").bind("submit",function(){
				if($("input[name='UserName']").val()==""&&$("input[name='Pwd']").val()==""){
					$(".msg-error").text("用户名不能为空！");
					$("input[name='UserName']").focus();
					return false;
				}
				if($("input[name='UserName']").val()!="" && $("input[name='Pwd']").val()==""||$("input[name='Pwd']").val().length<6){
					$(".msg-error").text("密码不合法！");
					$("input[name='Pwd']").focus();
					return false;
				}
			});
		});
	</script>
</html>
