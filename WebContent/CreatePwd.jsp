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
		<title>找回密码</title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script type="text/javascript" src="js/jquery-ui-1.12.0.custom/jquery-ui.min.js" ></script>
		<script type="text/javascript" src="js/jquery.js" ></script>
		<script type="text/javascript" src="js/FormValidate.js" ></script>
		<script type="text/javascript" src="js/tab.js" ></script>
		<link rel="stylesheet" href="css/public.css" />
		<link rel="stylesheet" href="css/themes.css" />
		<link rel="stylesheet" href="css/ForgetPw.css" />
	</head>
	<body id="body">
		<div id="w">
			<div class="header clearfix">
			    <div class="wrap">
			        <div class="logo">
			            <a href="index.jsp" target="_blank"></a>
			            <a href="#body" target="_blank" class="l2 goTop"></a>
			            <span class="h-tit">找回密码</span>
			        </div>
			    </div>
			</div>
			<form action="/AProductMS/createpwd.action" id="frm" method="post">    
				<div class="forget-pwd">
			        <div class="wrap clearfix">
			            <img class="f-step f-step3" src="img/3.png">
			            <p>
			                <span class="field-name">设置新密码</span>
			                <input class="input input-key" id="Password" name="Password" placeholder="6-20位字母、符号或数字" type="password" />
			                <span></span>
			            </p>
			            <p>
			                <span class="field-name">重复密码</span>
			                <input class="input input-key" id="PasswordConfirm" name="PasswordConfirm" placeholder="再次输入密码" type="password" />
			                <span></span>
			            </p>
			            <div class="center">
			            	<a href="javascript:sub()" class="btn-green btn-green-l" id="btnSubmit">确 &#160; 认</a>
			            </div>
			            <script>
			            	function sub(){
			            		$("#frm").submit();
			            	}
			            </script>
			        </div>
    			</div>
    		</form>

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
		<script type="text/javascript">

		    function PasswordValited() {
		        var password = $.trim($("#Password").val());
		        if (password == '') {
		            ShowTip($("#Password"), "error", "请输入密码");
		            return false;
		        }
		        if (password.length < 6) {
		            ShowTip($("#Password"), "error", "密码不能小于6位");
		            return false;
		        }
		        ClearTip($("#Password"));
		        return true;
		    }
		    
		    function PasswordConfirmValited() {		
		        var password = $.trim($("#Password").val());
		        var PasswordConfirm = $.trim($("#PasswordConfirm").val());		
		        if (PasswordConfirm == '') {
		            ShowTip($("#PasswordConfirm"), "error", "请输入密码");
		            return false;
		        }
		        if (password != PasswordConfirm) {
		            ShowTip($("#PasswordConfirm"), "error", "两次密码不一致");
		            return false;
		        }		
		        ClearTip($("#PasswordConfirm"));		
		        return true;
		    }	
		    
		    function ShowTip(ctrl, TipType, message) {
		        $(ctrl).next("span").removeClass().addClass("pass-" + TipType).html("<i></i>" + message);
		    }
		
		    function ClearTip(ctrl) {
		        $(ctrl).next("span").removeClass().html("");
		    }
		
		    $(function () {
		        $("#Password").blur(function () { return PasswordValited(); })
		        $("#PasswordConfirm").blur(function () { return PasswordConfirmValited(); })
		        $("#btnSubmit").click(function () {
		
		            if (PasswordValited() == false)
		                return false;
		
		            if (PasswordConfirmValited() == false)
		                return false;
		
		            $("form").submit();
		        });
		    });

		</script>

	</body>
</html>
