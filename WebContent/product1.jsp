<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>商品详情</title>
        
        <script type="text/javascript" src="js/jquery-3.0.0.min.js" ></script>   	  	
    	<script type="text/javascript" src="js/product_detail.js" ></script>
    	<script src="js/jquery.luara.0.0.1.min.js"></script>
    	<script type="text/javascript" src="js/blowup.min.js"></script>   
    	<script src="js/jquery.fly.min.js"></script>    
        <link rel="stylesheet" href="css/public.css" />        
        <link rel="stylesheet" href="css/themes.css" />
        <link rel="stylesheet" href="css/product_detail.css" />	
		<link rel="shortcut icon" href="img/tu.png">
        <style>
		#xtlb{
			background:#D7E7F7;
			width:182px;
		}
		#xtlb img{
				margin:8px 5px;				
		}
		/* 头部 */
		#header{
			height:100px;
		}
		.search{
			margin-top:20px;
			margin-left:60px;
		}
		.login{
			float:right;
			padding-top:30px;
			padding-left:100px;
		}
		/* 购物车 */
		.u-flyer{display: block;width: 50px;height: 50px;border-radius: 50px;position: fixed;z-index: 9999;}
		/* 评论部分 */
		.Comt1{
 			padding-top: 20px;
 		}
 		.Comt1 .pAll{
 			color:#999;
 			line-height:20px;
 		}
 		#pp{
 			padding-top: 10px;
 		}
 		.line{
 			border-bottom: 1px dashed #ccc;
 			padding-top:14px;
 		}
 		/*  发表评论部分*/
		.com{
	 		display:block;
	 	}
 		.com textarea{
 			margin-top:20px;
 			border:2px solid #008842;
 			height: 180px;
		    width: 98%;
		    padding: 8px;
   			outline: none;  		
 		}
 		.com input{
			display: inline-block;
		    width: 140px;
		    height: 39px;
		    line-height: 39px;
		    border: 0;
		    background-color: #A0A525;
		    color: #FFF;
		    text-align: center;
		    position: absolute;
		    top:212px;
		    right:4px;
		    z-index: 2;
		    cursor: pointer;
 		}
 	/* 放大镜 */
		.magnify{
		width: 200px;
		position:relative;
	}
	/* 在这里我们来设置放大镜的样式 */
	.large {
		width: 180px;
		height: 180px;
		position: absolute;
		/* 圆角 */
		border-radius: 100%;
		/* 这里使用多重阴影、来实现玻璃的效果 */
		box-shadow: 0 0 0 7px rgba(255,255,255,0.8),0 0 7px 7px rgba(0,0,0,0.3),inset 0 0 40px 2px rgba(0,0,0,0.3); 
		/* 加载放大镜的图片 */
		background: url(img/iphone.jpg) no-repeat;
		/* 放大镜默认隐藏 */
		display: none;
	}
</style>
    </head>
    <body id="body">
    	<div class="zy">
    		<!-- 头部   -->
			<div class="header clearfix" id="header">
				<div class="wrap">
					<div class="logo">
						<a href="index.jsp"></a>
					</div>
					<!--  搜索框     -->
					<div class="search">
						<div class="search-box clearfix">
						<form action="/AProductMS/get.do" method="post">
							<input type="text" id="keyword" name="pName" class="search-input" value="输入商品名／编号／拼音" onfocus=" if (this.value == '输入商品名／编号／拼音') {this.value = '';this.style.color = '#000';} " onblur=" if (this.value == '') {this.value = '输入商品名／编号／拼音';this.style.color = '#999';} " style="color: rgb(153, 153, 153);">
							<input class="search-btn" type="submit" value="搜索">
						</form>
						</div>
					</div>
					<!--    登录，注册        -->
					<div class="login">
						<a id="end" href="/AProductMS/shopping_cart.jsp" style="	display: inline-block; width:80px;">我的购物车</a>
						<a id="jies" href="/AProductMS/shopping_cart.jsp" style="display: inline-block; width:80px;">去结算</a>
						<a href="/AProductMS/Login.jsp" id="islogin"> 登录</a>&nbsp;|&nbsp;
						<a href="/AProductMS/Regist.jsp">注册 </a>&nbsp;
					</div>
					<c:if test="${ userName !=null }">
						<script type="text/javascript">
							$("#islogin").text("${userName}");
						</script>
					</c:if> 
				</div>
			</div>
		</div>
    	<div class="wrap">
   			<c:forEach var="ps" items="${sessionScope.li}"  >
    			<!--面包屑-->
			    <div class="crumbs">
			        <a class="ml0" href="/">首页</a>
			        <a href='#'>进口水果</a>
			        ${ps.pName}
			    </div>
			    <!--产品详情-->
			    <div class="content clearfix">
			        <div class="product-intro clearfix j_product">
			            <!--预览图-->
		            	<div class="pic-preview">
			                
		           		 </div> 
		           		 
			            <div class="product-info">
			                <div class="summary-name">
			                    <h1>${ps.pName}</h1>
			                    <p>${ps.pDesc }</p>
			                    <input type="hidden" name="CommodityId" id="CommodityId" value="fe25b08c-59d0-4c2a-8c1b-b5f6de4ec354" />
			                </div>
			                <div class="summary-price clearfix">
			                    <div class="pro-price">
			                        <div>
			                            <span>价格：</span>
			                            <span><em>¥</em><strong>${ps.pPrice }</strong></span>
			                        </div>
			                    </div>
			                    <div class="pro-review">
			                        <p>总体满意度</p>
			                        <p><b>5.0</b> 分</p>		                       
			                    </div>
			                </div>
			                <div class="summary-other clearfix">
			                    <div class="left">
			                        <span class="pro-promo fl" style="margin-bottom:5px;"><em>促</em>夏日包邮特惠第一波</span>
									<div class="pro-promo clearfix" style="margin-bottom:0px;padding-bottom:0px;border-bottom:none;">
									    <ul>
									    </ul>
									</div>                      
									<div class="choose clearfix">
		                                <div class="dt">规格：</div>
		                                <div class="dd">
		                                    <ul>
	                                            <li class="">
	                                                <a href="#">
	                                                    <span>￥${ps.pPrice}</span>
	                                                    <span>${ps.guiGe }</span>
	                                                    <i></i>
	                                                </a>
	                                            </li>
		                                    </ul>
		                                </div>
		                            </div>
			                        <div class="pro-service"><b>16:00</b> 后完成订单 预计 <b>8月17日</b> 送达</div>
			                        <div class="pro-amount clearfix">
			                            <span>
			                            	<div class="dt">数量：</div>
			                            <div class="dd">
			                                <div class="spinner">
			                                    <button class="decrease" style="width:14px;heigth:28px;font-size:16px;" >-</button>
			                                    <input type="text" class="spinner value" style="width:40px;height:20px;text-align:center;" value="1" id="p_number">
			                                    <button class="increase" style="width:14px;heigth:28px;font-size:16px;">+</button>
			                                </div>
			                                <div class="addcart" style="margin-top:34px;margin-left:-50px;"><a class="btn-gn" href="javascript:;" >加入购物车</a></div>
			                            </div>
			                            </span>
			                        </div>			                        		
			                    </div>
			                    <div class="right">
			                        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="zx">
			                            <tbody>                         
			                                <tr><th>商品编号：</th><td>12872</td></tr>
			                                <tr><th>商品状态：</th><td><font color='2CA6E0'>冷藏</font></td></tr>
			                                <tr><th>发货地：</th><td>广州</td></tr>                                
			                            </tbody>
			                        </table>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>			   
	     
	      <!--显示图片-->
		    <script>
          		$(function(){
          			//添加到购物车
          			$(".addcart").bind("click",function(){	      
						//alert("${userName}");
						if("${userName}"!=null&&"${userName}"!=""){
							var offset = $("#end").offset();
	    					var addcar = $(this);
	    					var img = $('.img').attr('src');
	    					var flyer = $('<img class="u-flyer" src="'+img+'">');
	    					flyer.fly({
	    						start: {
	    							left: event.pageX,
	    							top: event.pageY
	    						},
	    						end: {
	    							left: offset.left+10,
	    							top: offset.top+10,
	    							width: 0,
	    							height: 0
	    						},
	    						onEnd: function(){			    						
	    							this.destory();
	    						}
	    					});
	    					$.ajax({
	        	    			type:"post",
	        	    			url:"/AProductMS/AddCart.action",
	        	    			data:{
	        	    				'pid':'${ps.pid}',
	        	    			},
	        	    			success:function(data,status,xhr){
	        	    			}
	           		 		});
							
						}else{						
							alert("你还没有登录!还不能加入购物车");
						}
					});
          			 		
        		 /* 加载图片 */
          		 	$.ajax({
      	    			type:"post",
      	    			url:"/AProductMS/GetAllPrice.action",
      	    			data:{
      	    				'pid':'${ps.pid}',
      	    			},
      	    			success:function(data,status,xhr){
      	    				//console.log(data);
      	    				//alert("chenggong");
      	    				var all=$.parseJSON(data)
      						var html="";
      	    				$.each(all, function(i,v) {
      	    					
      	    					html+='<div class="pic-big">';
      	    					//html+='<img class="j_product_img img" width="500px" height="500px" src="'+v.picOne+'" style="display:  block;">';
      	    					html+='<div class="magnify">';
      	    					html+='<div class="large"></div>';
      	    					html+=	'<img  class ="j_product_img img" src="'+v.picOne+'" style="display: block;" width=500px heigth=500px>';
      	    					html+=	'</div>';
      	    					html+='</div>';
      	    					html+='<div class="pic-thumb">';
      	    					html+='<div class="picList">';
      	    					html+='<ul id="mouseo">';
      	    					html+=' <li><img width="85" height="85" src="'+v.picOne+'"></li>';
      	    					html+=' <li><img width="85" height="85" src="'+v.picTwo+'"></li>';
      	    					html+=' <li><img width="85" height="85" src="'+v.picThree+'"></li>';
      	    					html+='</ul>';
      	    					html+='</div>';
      	    					html+='</div>';
      	    				});
      	    				$(".pic-preview").html(html);    	    			       	    					      	    				
      	    			},
      	    			complete:function(){
      	    				$("#mouseo li img").bind("mouseover",function(){
      	    					$(".j_product_img").prop("src",$(this).prop("src"));
      	    				});
      	    				
      	    				 /* 图片放大镜*/    	    			
      		   				var native_width = 0;
      		   				var native_height = 0;
      		   				// 首先、我们应该获得图像的实际尺寸、（本地的图片）
      		   				$('.img').load(function(){       	    				
      		   					var img_obj = new Image();
      		   					img_obj.src = $(this).attr('src');
      		   					native_width = img_obj.width;
      		   					native_height = img_obj.height;       	    				
      		   					$('.magnify').mousemove(function(e){ 
      		   						
      		   						var magnify_offset = $(this).offset();    	    					
      		   						var mouse_x = e.pageX - magnify_offset.left;
      		   						var mouse_y = e.pageY - magnify_offset.top;
      		   						if( mouse_x > 0 && mouse_y > 0 && mouse_x < $(this).width() && mouse_y < $(this).height() ){
      		   							$('.large').fadeIn(100);
      		   						}else{
      		   							$('.large').fadeOut(100);
      		   						}
      		   						if($('.large').is(':visible')){
      		   							var rx = Math.round(mouse_x/$('.img').width()*native_width - $('.large').width()/2)*-1;
      		   							var ry = Math.round(mouse_y/$('.img').height()*native_height - $('.large').height()/2)*-1;
      		   							var bgp = rx + 'px ' + ry + 'px';
      		   							var gx = mouse_x - $('.large').width()/2;
      		   							var gy = mouse_y - $('.large').height()/2;
      		   							$('.large').css({
      		   								'left':gx,
      		   								'top':gy,
      		   								'backgroundPosition':bgp
      		   							});
      		   						}
      		   					});
      		   				});	    				       	          		 				 	
      	    			}     	    			
     	    		});
           				
          		 });
         		 /* 增加减数量 */
         		$(".increase").click(function() {
		        $(this).prev().val(parseInt($(this).prev().val()) + 1);
		        $(".decrease").attr("disabled",false);
			        
				});										 
				$(".decrease").click(function() {
					
			        if($(this).next().val()<=2){
			        	//alert("数量不能小于1");
			        	$(".decrease").attr("disabled","disabled");
			        }
			        $(this).next().val(parseInt($(this).next().val()) - 1);
				});
				/* 获取各种评论的数量 */
				$.ajax({
	    			type:"post",
	    			url:"/AProductMS/AllCommentCount.action",
	    			data:{
	    				'pid':'${ps.pid}',
	    			},
	    			success:function(data,status,xhr){
	    				//alert(data);
	    				$("#all").text(data);
	    			},
	    		});
				
				$.ajax({
	    			type:"post",
	    			url:"/AProductMS/isGoodCommentCount.action",
	    			data:{
	    				'pid':'${ps.pid}',
	    				'isgood':'好评',
	    			},
	    			success:function(data,status,xhr){
	    				//alert(data);
	    				$("#vote_hp").text(data);
	    			},
	    		});
				$.ajax({
	    			type:"post",
	    			url:"/AProductMS/isGoodCommentCount.action",
	    			data:{
	    				'pid':'${ps.pid}',
	    				'isgood':'中评',
	    			},
	    			success:function(data,status,xhr){
	    				//alert(data);
	    				$("#vote_zp").text(data);
	    			},
	    		});
				$.ajax({
	    			type:"post",
	    			url:"/AProductMS/isGoodCommentCount.action",
	    			data:{
	    				'pid':'${ps.pid}',
	    				'isgood':'差评',
	    			},
	    			success:function(data,status,xhr){
	    				//alert(data);
	    				$("#vote_cp").text(data);
	    			},
	    		});
				
				
				/* 加载评论 */
				$.ajax({
	    			type:"post",
	    			url:"/AProductMS/GetCommentByPid.action",
	    			data:{
	    				'pid':'${ps.pid}',
	    				'isgood':'a',
	    			},
	    			success:function(data,status,xhr){
	    				
	    				var html="";
	    				var alls=$.parseJSON(data);
	    				
	    				$.each(alls,function(i,v){
	    					html+='<div class="Comt1">';
	    					html+='<table>';
	    					html+='<tr>';
	    					html+='		<td rowspan="2" width="50px"><img src="images/userphoto.jpg" width="42px" height="43px" /></td>';
	    					html+='		<td class="pAll">'+v.commentTime+'</td>';
	    					html+='	</tr>';
	    					html+='	<tr>';
	    					html+='		<td class="pAll" height="16px"><a href="javarscript:;" style="text-decoration: none;" class="huifu">回复</a></td>';
	    					html+='	</tr>';
	    					html+='	<tr>';
	    					html+='		<td colspan="2" id="pp">'+v.content+'</td>';
	    					html+='	</tr>';
	    					html+='</table>';
	    					html+='<p class="line"></p>';
	    					html+='</div>	';		
	    				});
	    				$("#comments").html(html);
	    			},
	    		});
				
            </script>
            <script type="text/javascript">
            	$(function(){
            		$("#haop").on("click",function(){
            			$(this).attr("class","on");
            			$("#alls").removeClass("on");
            			$("#zhongp").removeClass("on");
            			$("#chap").removeClass("on");
            			
    					$.ajax({
    		    			type:"post",
    		    			url:"/AProductMS/GetCommentByPid.action",
    		    			data:{
    		    				'pid':'${ps.pid}',
    		    				'isgood':'好评',
    		    			},
    		    			success:function(data,status,xhr){
    		    				
    		    				var html="";
    		    				var alls=$.parseJSON(data);
    		    				
    		    				$.each(alls,function(i,v){
    		    					html+='<div class="Comt1">';
    		    					html+='<table>';
    		    					html+='<tr>';
    		    					html+='		<td rowspan="2" width="50px"><img src="images/userphoto.jpg" width="42px" height="43px" /></td>';
    		    					html+='		<td class="pAll">'+v.commentTime+'</td>';
    		    					html+='	</tr>';
    		    					html+='	<tr>';
    		    					html+='		<td class="pAll" height="16px"><a href="javarscript:;" style="text-decoration: none;" class="huifu">回复</a></td>';
    		    					html+='	</tr>';
    		    					html+='	<tr>';
    		    					html+='		<td colspan="2" id="pp">'+v.content+'</td>';
    		    					html+='	</tr>';
    		    					html+='</table>';
    		    					html+='<p class="line"></p>';
    		    					html+='</div>	';		
    		    				});
    		    				$("#comments").html(html);
    		    			},
    		    		});
    				});
    				$("#zhongp").on("click",function(){
    					$(this).attr("class","on");
            			$("#alls").removeClass("on");
            			$("#haop").removeClass("on");
            			$("#chap").removeClass("on");
    					$("#isgoodss").val("中评");
    					
    					//alert($("#isgoodss").val());
    					$.ajax({
    		    			type:"post",
    		    			url:"/AProductMS/GetCommentByPid.action",
    		    			data:{
    		    				'pid':'${ps.pid}',
    		    				'isgood':'中评',
    		    			},
    		    			success:function(data,status,xhr){
    		    				
    		    				var html="";
    		    				var alls=$.parseJSON(data);
    		    				
    		    				$.each(alls,function(i,v){
    		    					html+='<div class="Comt1">';
    		    					html+='<table>';
    		    					html+='<tr>';
    		    					html+='		<td rowspan="2" width="50px"><img src="images/userphoto.jpg" width="42px" height="43px" /></td>';
    		    					html+='		<td class="pAll">'+v.commentTime+'</td>';
    		    					html+='	</tr>';
    		    					html+='	<tr>';
    		    					html+='		<td class="pAll" height="16px"><a href="javarscript:;" style="text-decoration: none;" class="huifu">回复</a></td>';
    		    					html+='	</tr>';
    		    					html+='	<tr>';
    		    					html+='		<td colspan="2" id="pp">'+v.content+'</td>';
    		    					html+='	</tr>';
    		    					html+='</table>';
    		    					html+='<p class="line"></p>';
    		    					html+='</div>	';		
    		    				});
    		    				$("#comments").html(html);
    		    			},
    		    		});
    				});
    				$("#chap").on("click",function(){
    					$(this).attr("class","on");
            			$("#alls").removeClass("on");
            			$("#haop").removeClass("on");
            			$("#zhongp").removeClass("on");
    					$("#isgoodss").val("差评");
    					//alert($("#isgoodss").val());
    					$.ajax({
    		    			type:"post",
    		    			url:"/AProductMS/GetCommentByPid.action",
    		    			data:{
    		    				'pid':'${ps.pid}',
    		    				'isgood':'差评',
    		    			},
    		    			success:function(data,status,xhr){
    		    				
    		    				var html="";
    		    				var alls=$.parseJSON(data);
    		    				
    		    				$.each(alls,function(i,v){
    		    					html+='<div class="Comt1">';
    		    					html+='<table>';
    		    					html+='<tr>';
    		    					html+='		<td rowspan="2" width="50px"><img src="images/userphoto.jpg" width="42px" height="43px" /></td>';
    		    					html+='		<td class="pAll">'+v.commentTime+'</td>';
    		    					html+='	</tr>';
    		    					html+='	<tr>';
    		    					html+='		<td class="pAll" height="16px"><a href="javarscript:;" style="text-decoration: none;" class="huifu">回复</a></td>';
    		    					html+='	</tr>';
    		    					html+='	<tr>';
    		    					html+='		<td colspan="2" id="pp">'+v.content+'</td>';
    		    					html+='	</tr>';
    		    					html+='</table>';
    		    					html+='<p class="line"></p>';
    		    					html+='</div>	';		
    		    				});
    		    				$("#comments").html(html);
    		    			},
    		    		});
    				});
    				$("#alls").bind("click",function(){
    					//alert(er);
    					$(this).attr("class","on");
            			$("#zhongp").removeClass("on");
            			$("#haop").removeClass("on");
            			$("#chap").removeClass("on");
    					
    					$.ajax({
    		    			type:"post",
    		    			url:"/AProductMS/GetCommentByPid.action",
    		    			data:{
    		    				'pid':'${ps.pid}',
    		    				'isgood':'差评',
    		    			},
    		    			success:function(data,status,xhr){		    				
    		    				var html="";
    		    				var alls=$.parseJSON(data);
    		    				
    		    				$.each(alls,function(i,v){
    		    					html+='<div class="Comt1">';
    		    					html+='<table>';
    		    					html+='<tr>';
    		    					html+='		<td rowspan="2" width="50px"><img src="images/userphoto.jpg" width="42px" height="43px" /></td>';
    		    					html+='		<td class="pAll">'+v.commentTime+'</td>';
    		    					html+='	</tr>';
    		    					html+='	<tr>';
    		    					html+='		<td class="pAll" height="16px"><a href="javarscript:;" style="text-decoration: none;" class="huifu">回复</a></td>';
    		    					html+='	</tr>';
    		    					html+='	<tr>';
    		    					html+='		<td colspan="2" id="pp">'+v.content+'</td>';
    		    					html+='	</tr>';
    		    					html+='</table>';
    		    					html+='<p class="line"></p>';
    		    					html+='</div>	';		
    		    				});
    		    				$("#comments").html(html);
    		    			},
    		    		});
    				});
            	});
            </script>
   			<!--商品详情-->     
          <div class="product-detail">
              <div class="detail-tab">
                  <ul class="detail-ul">
                      <li class="active"><a href="#details">商品详情</a></li>
                      <li><a href="#comment">用户评论</a></li>
                  </ul>                   
              </div>
              <div class="detail-content">
                  <!--商品详情-->
                  <div class="detail-item details clearfix" id="details">
				<table class="detail-table">
				    <tbody>
				            <tr>
				                <th>单果规格</th>
				                <td>约350g/个</td>
				            </tr>
				    </tbody>
				</table>
				<!--商品详情大图  -->
			    <div id="tupian"></div>  
			    
			    <script type="text/javascript">
			    	$(function(){
			    		$.ajax({
	       	    			type:"post",
	       	    			url:"/AProductMS/GetAllpriceServlet2.action",
	       	    			data:{
	       	    				'pid':'${ps.pid}',
	       	    			},
	       	    			success:function(data,status,xhr){
	       	    				var all=$.parseJSON(data)
	       	    				var html2=""
	       	    				$.each(all, function(i,v) {
	       	    					
	       	    					html2+='<p style="white-space: normal;"><img  src="'+v.picFour+'"/></p><p style="white-space: normal;"></p>';
	       	    					html2+='<p style="white-space: normal;"><img  src="'+v.picFive+'"/></p><p style="white-space: normal;"></p>';
	       	    					html2+='<p style="white-space: normal;"><img  src="'+v.picSix+'"/></p><p style="white-space: normal;"></p>';
	       	    					html2+='<p style="white-space: normal;"><img  src="'+v.priSeven+'"/></p><p style="white-space: normal;"></p>';
	       	    					html2+='<p style="white-space: normal;"><img  src="'+v.priEighT+'"/></p><p><br/></p>  ';
	       	    				});
	       	    				  
	       	    				$("#tupian").html(html2);
	       	    			}        		 		         				
          				 });	
			    	});
			    </script>
			     
			    <!-- 大图 -->		
				<!-- 
				<p style="white-space: normal;"><img src="images/houLongGuo/513691854545363209_880x806.jpg"/></p><p style="white-space: normal;"></p>
				<p style="white-space: normal;"><img src="images/houLongGuo/513691854545395977_880x640.jpg"/></p><p style="white-space: normal;"></p>
				<p style="white-space: normal;"><img src="images/houLongGuo/513691854545428745_880x968.jpg"/></p><p style="white-space: normal;"></p>
				<p style="white-space: normal;"><img src="images/houLongGuo/513691854545527049_880x639.jpg"/></p><p style="white-space: normal;"></p>
				<p style="white-space: normal;"><img src="images/houLongGuo/513691854545559817_880x534.jpg"/></p><p><br/></p>       
				    -->
                  </div>
                  <!--用户评论-->
                  <div class="detail-item " id="comment" style="display:none;">
                      <div class="comment-info clearfix">	                                              
                          <div class="comment-btn">                         
                          <!--     <a class="btn-gn" id="fabiao">我要评论</a> -->
                              <p>只有购买过该商品的用户才能评论</p>                                                   	 
                          </div>
                       		 
                      </div>
                      
                      <div class="comment-list clearfix">
                          <div class="comment-tab-wrap clearfix">
                              <div class="comment-tab">
                                  <span id="alls" class="on" >全部评论（<font id="all"></font>）</span>
                                  <span id="haop">好评（<font id="vote_hp"></font>）</span>
                                  <span id="zhongp">中评（<font id="vote_zp"></font>）</span>
                                  <span id="chap">差评（<font id="vote_cp"></font>）</span>   
                                  <input type="hidden" value="好评" id="isgoodss">                                
                              </div> 
                              <!-- 表表评论-->
                               <div id="com" class="com" >
										<textarea cols="28" rows="5" id="speak"  ></textarea>
										<input type="submit" value="发表" id="btn" />
								</div> 
								<script type="text/javascript">
								
										$("#btn").on("click",function(){
											if($("#speak").val()==""){
												$("#speak").focus();
												alert("评论内容不能为空");					
											}
										});
										/* $("#speak").on("keydown",function(){
											$("#speak").val("");
										}); */
							
								</script>
								<c:if test="${sessionScope.userName eq null}">
										<script type="text/javascript">
											
												$("#btn").on("click",function(){	
													$("#speak").focus();
													alert("你还没有登录不可以评论!");							
												});
										
									</script>
								</c:if>
								<c:if test="${sessionScope.userName ne null && sessionScope.userName !=''}">
									<script type="text/javascript">
										$(function(){
											
												$("#btn").on("click",function(){
													if($("#speak").val()!=""){
													//	alert("keyipll");
														$.ajax({
											    			type:'post',
											    			url:'/AProductMS/AddComment.action',
											    			data:{
											    				'phone':'${sessionScope.userName}',
											    				'pid':'${ps.pid}',
											    				'content':$("#speak").val(),
											    				'isGood':$("#isgoodss").val(),
											    			},
											    			success:function(data,status,xhr){
											    				alert(data);
											    			},
											    		});
													}
													
												});
																					
												
										});
									</script>
								</c:if>
								<!-- 评论 记录-->   
                              <div id="comments">
                              		<div class="Comt1">
										<table>
											<tr>
												<td rowspan="2" width="50px"><img src="images/userphoto.jpg" width="42px" height="43px" /></td>
												<td class="pAll">2016-01-15 19:01:04</td>
											</tr>
											<tr>
												<td class="pAll" height="16px"><a href="javarscript:;" style="text-decoration: none;">回复</a></td>
											</tr>
											<tr>
												<td colspan="2" id="pp">原来如此，面对残酷的现实，有时候如何选择是一道难题，尤其是面对生与死，血与火的抉择，还是你爱的人。但即使面对病魔，人们还是不想被干死，善与恶有时候也并不那么对立</td>
											</tr>
										</table>
										<p class="line"></p>
									</div>									
                              </div>                                                         
                          </div>
                      </div>
                  </div>
                 
              </div>
          </div>
      </c:forEach>   			
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