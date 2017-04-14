<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 	<script src=" /AProductMS/js/jquery-3.0.0.js"></script> 
 	<script src="js/jquery.luara.0.0.1.min.js"></script>
   	<link rel="shortcut icon" href="img/tu.png">
    <link href="/AProductMS/css/public.css" rel="stylesheet" type="text/css">
    <link href="/AProductMS/css/yg.css" rel="stylesheet" type="text/csss">
    <link href="/AProductMS/css/cart.css" rel="stylesheet" type="text/css">
    <link href="css/order.css" rel="stylesheet" type="text/css" />
   	<link rel="stylesheet" href="css/MyCss.css" />
	<style type="text/css">
		#header{
			margin-top:-14px;
			height:100px;
			width:100%;
		}
		.gouwutou{
			margin:20px 75px 0 75px;;
			display: block;	
			background: url(img/gouwuche.png) no-repeat 0px 0px;
			height:45px;
		}
		.logo {
			float: left;
			width: 240px;
			padding: 0 35px 5px 0px;
			margin-right: 10px;
		}
		.logo a{
			display: block;
			width: 200px;
			height: 70px;
			background: url(img/logo.png) no-repeat left top;
		}			
	</style>
	
	</head>
<body id="body">
	<!-- 头部   -->
	<div class="header clearfix" id="header">
		<div class="wrap">
			<div class="logo">
				<a href="index.jsp"></a>
			</div>
			<div class="steps">
		                <ul>
		                    <li class="on"><b class="b1"></b><span>我的购物车</span></li>
		                    <li><i></i><b class="b2"></b><span>确认订单信息</span></li>
		                    <li><i></i><b class="b3"></b><span>成功提交订单</span></li>
		                </ul>
		            </div>
		</div>           
		            
	</div>
    <div class="gouwutou">
		<a style="float:right;color:#008842;padding-top:10px;"href="/AProductMS/index.jsp">继续购物>>></a>
	</div>
    <div class="cart-alert"style="margin:0 75px;" >
        <div class="cart-header" >
            <table class="cart-table">
                <tbody>
                    <tr>
                        <th class="cart-t-check">选择</th>
                        <th class="cart-t-info">商品信息</th>
                        <th class="cart-t-price">单价</th>
                        <th class="cart-t-num">购买数量</th>
                        <th class="cart-t-total">合计</th>
                        <th class="cart-t-spec">规格</th>
                        <th class="cart-t-opera">操作</th>
                    </tr>
                </tbody>
            </table>
       	</div>
            
         <!--购物车列表  -->
       <div class="cart-list" id="theInsulationCan">
       
       
			<form action="/AProductMS/odpay.action" method="post" name="frm" id="frm">
			<!-- 购物车信息 -->	
			<!-- 隐藏总价格 -->  
			   
			</form>
	
  		</div> 
  		 <!--总价格-->
		<div class="cart-slct-box">
        	 <div class="cart-footer clearfix settle">
            	 <div class="wrap">
	                 <div class="fl">
	                     <div>
	                     	<input type="checkbox" checked="checked" class="chkAll checkall">全选
		                     <a href="javascript:;" style="display:inline-block" id="btns"><i></i>删除选中的商品</a>
		                     <a href="Javascript:;" id="clearAll">清空购物车</a>
	                     </div>
	                 </div>
	                 <div class="fr">
	                  	 <span class="fs14">总价：<em>￥<span id="tota"></span></em></span>
					      <input id="SelectedCommIds" name="SelectedCommIds" type="hidden" value="">                              
					      <a href="javascript:tj()" class="btn" id="btnSubmit" style="cursor:pointer;">去结算</a> 
					    	<script  type="text/javascript">
					    		function tj(){
					    			$("#frm").submit();
					    		}
					    		
					    	</script>
					                
					</div>
    			</div>
			</div>
		</div>
	
  		  <script type="text/javascript">
        	  	$(function(){
        	  		var html="";
        	  		$.ajax({
    	    			type:"post",
    	    			url:'/AProductMS/ALLshopping.do',
    	    			data:{
    	    				'userName':'${userName}',
    	    			},
    	    			success:function(data,status,xhr){
    	    				var alls=$.parseJSON(data);
    	    			//	console.log(alls);
    	    				$.each(alls,function(i,v){
    	    					html+='<table class="cart-table">';
    	    					html+=' <tbody>';
    	    					html+='  <tr>';
    							html+='  <td class="cart-t-check"><input type="checkbox" id="cids" name="check" checked="checked" value="'+v.sid+'"></td>';
    							html+='  <td class="cart-t-img"><a href="#"><img src="'+v.sPicture+'"></a></td>';
    							html+='  <td class="cart-t-info"><a href="#">'+v.sName+'</a></td>';
    							html+='  <td class="cart-t-price">￥'+v.price+'</td>';
    							html+=' <td class="cart-t-num">';
    							html+='    <div class="quantity-form">';
    							html+='      <a href="javascript:void(0);" title="'+v.cid+'"  id="'+v.sid+'"  class="decrement diffs" style="vertical-align: mmiddle;line-height:22px;height:22px;border:1px solid #cacbcb;font-size:22px;" >-</a>';
    							html+='       <input type="text" class="itxt" name="amount" id="amount" value="'+v.amount+'">';
    							html+='      <a href="javascript:void(0);"  title="'+v.cid+'"  class="increment adds"  style="vertical-align: mmiddle;line-height:22px;height:22px;border:1px solid #cacbcb;font-size:22px;" >+</a>';
    							html+='   </div>';
    							html+='  </td>';
    							html+=' <td class="cart-t-total">￥<span class="total">'+v.total+'</span></td>';
    							html+=' <td class="cart-t-spec">'+v.sguiGe+'</td>';
    							html+='  <td class="cart-t-opera">';
    							html+='   <a href="javascript:void(0);" class="del" title="'+v.sid+'">删除</a>';
    							html+='  </td>';
    							html+=' </tr>';
    							html+='</tbody>';
    							html+='<input type="hidden" id="guige" name="gg" value="'+v.sguiGe+'" />';
        	    				html+='<input type="hidden" id="names" name="ming" value="'+v.sName+'" />';
        	    				html+='<input type="hidden" id="dan" name="danjia" value="'+v.price+'" />';
    							html+='  </table>';
    	    				});
    	    				
    	    				html+='<input type="hidden" id="uid" value="'+alls[0].userID+'" />';
    	    				html+='<input type="hidden" id="Prices" name="totalPrice" />';
    	    	

    	    			
    	    				$("#frm").html(html);   	    				
    	    			},
    	    			complete:function(){  	    				
    	    				$(".diffs").click(function(){		  	
    	    					//alert($(".diffs").prop("id"));
    		    				if($(".itxt").val()==1){
    		    					$(".diffs").prop("disabled","disabled");
    	    	  		 		}else{
	    	    	  		 		$.ajax({
	    	    		    			type:"post",
	    	    		    			url:'/AProductMS/UpdateAmount.action',
	    	    		    			data:{
	    	    		    				'cid':$(this).prop("title"),
	    	    		    				'op':'-',
	    	    		    			},
	    	    		    			success:function(data,status,xhr){
	    	    		    				
	    	    		    				window.location.reload();
	    	    		    		
	    	    		    			},
	    	    			    	}); 
    	    	  		 		}
    	    	  		 		    	  		 		
    	    		  		});
    	    	  		 	/* 增加数量 */
    	    		  		$(".adds").click(function(){		  	
    	    	  		 		//alert($(this).prop("title"));
    	    	  		 		$.ajax({
    	    		    			type:"post",
    	    		    			url:'/AProductMS/UpdateAmount.action',
    	    		    			data:{
    	    		    				'cid':$(this).prop("title"),
    	    		    				'op':'+',
    	    		    			},
    	    		    			success:function(data,status,xhr){
    	    		    				//alert(data);
    	    		    				window.location.reload();
    	    		    				
    	    		    			}
    	    			    	}); 
    	    		  		});
    	    		  		$(".del").click(function(){		  	
    	    	  		 		//alert($(this).prop("title"));
    	    	  		 		$.ajax({
    	    		    			type:"post",
    	    		    			url:'/AProductMS/DeleteCart.action',
    	    		    			data:{
    	    		    				'pid':$(this).prop("title"),
    	    		    			},
    	    		    			success:function(data,status,xhr){
    	    		    				//alert(data);
    	    		    				window.location.reload();
    	    		    			},
    	    			    	}); 
    	    		  		});
    	    		  		
    	    		  		/*计算总价格的  */
    	    		  		var d=0;
	    	  				var s=$(".total");
	    	  				for(var a=0;a<s.length;a++){
	    	  					d+=parseInt(s[a].innerText);
	    	  				}	
	    	  				$("#tota").text(d); 
	    	  				$("#Prices").val(d);
	    	  				
    	    			}
    	    			
    		    	});
        	  		// 赋值前往hidden   =================================
	  				
        	  		
        	  		
        	  		
        	  		var n=0;
        			$(".checkall").bind("click",function(){
        				n++;
        				if(n%2!=0){
        					$("input[name='check']").prop("checked",function(i,v){
        						return !v;
        					});
        				}else{
        					$("input[name='check']").prop("checked",true);
        					n=0;
        				}
        			});	 
        			$("#btns").click(function(){
        				  var num=0;
        				  var len=$("input[name='check']").length;
        				 // alert(len);
        				  for(var i=0;i<len;i++){
        					   if($("input[name='check']").prop("checked")){
        						  num++;
        					  } 
        				  }
        				  if(num==0){
        					  alert("你还没用选择呢?");
        					//  return false;
        				  }else{
    					 		//alert($('#frm').serialize());
	   				    		$.ajax({
	   				    			type:"post",
	   				    			url:"/AProductMS/DeletXunZ.action",
	   				    			data:$('#frm').serialize(),
	   				    			success:function(data,status,xhr){
	   				    				window.location.reload();
	   				    			},
	   				    		}); 
        				  }
        			  });
        			
        			$("#clearAll").bind("click",function(){
        				$.ajax({
			    			type:"post",
			    			url:"/AProductMS/DeleteAll.action",
			    			data:{
			    				'uid':$('#uid').val()
			    			},
			    			success:function(data,status,xhr){
			    				//alert(data);
			    				window.location.reload();
			    			},
				    	}); 	
        			});
        				
        	  	});
        	 </script>
      	
			
	</div>

<!-- 尾部 -->
		<div class="footer_service">
		    <div class="wrap">
		        <ul>
		            <li class="s1">
		                <b>全球精选</b>
		                <span>一站式生鲜购物方案</span>
		            </li>
		            <li class="s2">
		                <b>多仓直发</b>
		                <span>特有次日达配送服务</span>
		            </li>
		            <li class="s3">
		                <b>源头直采</b>
		                <span>精选正宗品质好食材</span>
		            </li>
		            <li class="s4">
		                <b>天天底价</b>
		                <span>会员专属优惠购不停</span>
		            </li>
		        </ul>
		    </div>
		</div>
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
                        </a>
                    </p>
                </div>
            </div>
            <a href="#"  id="kfu" onclick="ysf.open();return false;"></a> 
            <a href="javascript:;" id="btn" title="回到顶部"></a>
		<script src="/AProductMS/js/online.js" defer async></script>
        </div>
		
		<script>
			var btntop = document.getElementById("btn");
			var look = document.documentElement.clientHeight;
			var timer = null;
			window.onscroll = function() {
				var backtop = document.body.scrollTop;
				if (backtop >= look/2) {
					btntop.style.display = "block";
				} else {
					btntop.style.display = "none";
				}
			}
			btntop.onclick = function() {
				timer = setInterval(function() {
					var backtop = document.body.scrollTop;
					var speedtop = backtop / 3;
					document.body.scrollTop = backtop - speedtop;
					if (backtop == 0) {
						clearInterval(timer);
					}
				}, 30);
			}
		</script>
  
</body>
</html>