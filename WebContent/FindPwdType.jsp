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
		<script type="text/javascript" src="js/FormValidate.js" ></script>
		<script type="text/javascript" src="js/jquery.js" ></script>
		<script type="text/javascript" src="js/tab.js" ></script>
		<link rel="stylesheet" href="css/ForgetPw.css" />
		<link rel="stylesheet" href="css/public.css" />
		<link rel="stylesheet" href="css/themes.css" />
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
		<!-------  找回密码 ------->
		<div class="forget-pwd">
		    <div class="wrap clearfix">
		        <img class="f-step f-step2" src="img/2.png">
		        <p>
		            <span class="field-name">验证身份方式</span>
		            <select id="FindPwdType" name="FindPwdType">		
		                        <option value="mobile">手机验证</option>
		            </select>
		        </p>
		        <div id="divmobile" >
		        	  <form action="/AProductMS/fintype.action" id="frm" method="post">
		            <p>
		                <span class="field-name">手机号</span>
		                <label id="lblmobile">${sessionScope.Findphone }</label>
		              
		               	 <input type="hidden" id="Phone_Mobile" name="phone_mobile"   value="${sessionScope.Findphone }"/>
		               
		            </p>
		            	 </form>
		            <p>
		                <span class="field-name">请填写手机校验码</span>
		                <input class="input input-yzm" id="Phone_VerifyCode" name="Phone_VerifyCode" placeholder="手机验证码" type="text" value="" />
		                 <input type="button" class="btn-yzm" id="Phone_SendCode" value="获取验证码" name="phones"  onclick="settime(this)" />
		                  <input type="hidden" id="ttt">
		                  <span id="shouyzm"></span>
		            </p>
		            <div class="center">
		                <a class="btn-white-s" href="FindPwd.jsp">上一步</a><a  href="javascript:sub()" class="btn-green btn-green-s">下一步</a>
		            	<script>
		            		function sub(){
		            			/* if($("#Phone_SendCode").val()!=$("#ttt").val()){		            				
		            				$("#shouyzm").text("验证码有误!").css("color","red");
		            				return false;
		            			}else{
		            				$("#frm").submit();
		            			} */
		            			$("#frm").submit();
		            		}
		            	</script>
		            </div>
		        </div>
		    
		    </div>
		</div>
		
		<!-- userid 发短信用 -->
		<input type="hidden" id="UserID" name="UserID" value="c971478e-3078-4869-93e7-59b247b2ae7c" />
		

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
	    
		$("#Phone_SendCode").one("click",function(){
			 $.ajax({
				type:"post",
				url:"Note.dos",
				data:{
					phone:$("#Phone_Mobile").val()
				},
				success:function(data,status,xhr){
						
					if(data!=""){
						$("#ttt").val(data);
					}			
				}
	        });    
		});
	    
	    
	    
	    
		var countdown=60; 
		function settime(obj) { 
		    if (countdown == 0) { 
		        obj.removeAttribute("disabled");    
		        obj.value="获取验证码"; 
		        countdown = 60; 
		        return;
		    } else { 
		        obj.setAttribute("disabled", true); 
		        obj.value="重新发送(" + countdown + ")"; 
		        countdown--; 
		    } 
		setTimeout(function() { 
		    settime(obj) }
		    ,1000) 
		}
  
	</script>
	</body>
</html>
