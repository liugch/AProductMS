<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta charset="UTF-8">
		<title>找回密码</title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script type="text/javascript" src="js/jquery-ui-1.12.0.custom/jquery-ui.min.js" ></script>
		<script type="text/javascript" src="js/FormValidate.js" ></script>
		<!--<script type="text/javascript" src="js/jquery.js" ></script>-->
		<script type="text/javascript" src="js/tab.js" ></script>
		<link rel="stylesheet" href="css/ForgetPw.css" />
		<link rel="stylesheet" href="css/public.css" />
		<link rel="stylesheet" href="css/themes.css" />
		<style type="text/css">
		
			#
		
		</style>

	</head>
	<body id="body">
    <!------- 顶部工具栏开始 ------->
    <div class="w">

        <!------- 顶部工具栏结束 ------->
		<script type="text/javascript">
		
		    $(function () {
		
		        $("#UserName").blur(function () {
		            return UserNameValited();
		        });
		
		        $("#VerifyCode").blur(function () {
		            return VerifyCodeValited();
		        });
		
		        $("#btnSubmit").click(function () {
		
		            if (UserNameValited() == false)
		                return false;
		
		            if (VerifyCodeValited() == false)
		                return false;
		
		            $("form").submit();
		        });
		
//		        $(".gray").click(function () {
//		            $("#imgcode").attr("src", "/verifycode" + "?_t=" + new Date().getTime());
//		        });
		    });
		
		    function UserNameValited() {
		        $("#UserName").next("span").removeClass();
		
		        if ($.trim($("#UserName").val()) == '') {
		            $("#UserName").next("span").addClass("pass-tip").html("<i></i>请输入您的手机号或邮箱");
		            return false;
		        }
		        else {
		            $("#UserName").next("span").html("");
		        }
		
		        if (Form.Validate($("#UserName").val())) {
		            $("#UserName").next("span").addClass("pass-tip").html("<i></i>" + Form.VC);
		            return false;
		        }
		
		        return true;
		    }
  
	        function test() {  
	            var inputRandom=document.getElementById("VerifyCode").value; 
	            var autoRandom=document.getElementById("autoRandom").innerHTML;
	            if(inputRandom==autoRandom) {  
	                alert("通过验证");  
	            } else {  
	                alert("没有通过验证");  
	            }  
	        }
		    function ShowErrorTip(key, content) {
		        $(key).nextAll("span").removeClass().addClass("pass-error").html("<i></i>" + content);
		    }
		</script>

		<form action="/AProductMS/finphone.do"  id="frm" method="post">    
			<div class="header clearfix">
		        <div class="wrap">
		            <div class="logo">
		                <a href="index.jsp" target="_blank"></a>
		                <a href="#body" target="_blank" class="l2 goTop"></a>
		                <span class="h-tit">找回密码</span>
		            </div>
		        </div>
		    </div>
		    <div class="forget-pwd">
        	<div class="wrap clearfix">
            	<img class="f-step f-step1" src="img/1.png">
		            <p>
		                <span class="field-name">手机号或邮箱</span>
		
		                <input type="text" id="UserName" name="UserName" class="input input-user" placeholder="请输入您的手机号或邮箱" />
		                <span></span>
		            </p>
		            <p>
						<select id="sel"> 
							<option value=4 selected>4</option>
						</select>
                        <span class="field-name">验证码</span>
						<input type="text" id="verficode_tab1" name="yzm" placeholder="验证码" class="input input-yzm" />
						<label id="autoRandom" value=""></label>
						<img title="看不清？点击换一张。" style="position:absolute;left:840px;top:335px" src="/AProductMS/YZM" onclick="this.src='/AProductMS/YZM?rnd='+ Math.random();" >
                        <span></span>
		            </p>
		            <div class="center">
		                <a id="btnSubmit" href="javascript:sub()" class="btn-green btn-green-l">下一步</a>
		            </div>
		        </div>
		    </div>
		</form>
									<script>
										function sub(){
											$("#frm").submit();
										}
									</script>
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


</html>
