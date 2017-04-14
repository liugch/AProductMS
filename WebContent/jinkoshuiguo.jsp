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
		<script src="js/jquery-3.0.0.min.js"></script>
		<script src="js/jquery.luara.0.0.1.min.js"></script>
		<script src="js/jquery.fly.min.js"></script>
		<link rel="shortcut icon" href="img/tu.png">
		<title>商品</title>
		
		<style>
		/*头部*/
		body{
			margin: 0;
			font-family: "微软雅黑";
			background:#F7F8F8;
		}
		
		body,ul,li,ol,img{
			margin: 0;
			padding: 0;
			list-style: none;
		}
		div{
			display: block;
		}
		.zy{
			padding: 0;
		}
		.header{
			width: 100%;
			background: #E0E0E0;
			margin-right:0px;
		}
		
		.logo {
			float: left;
			width: 240px;
			padding: 0px 35px 5px 0px;
		}
		.logo a{
			display: block;
			width: 200px;
			height: 70px;
			background: url(img/logo.png) no-repeat 50px 0px;
		}
		
		/*搜索框*/
		.search{
			float:left; 
			width:528px;
			padding: 25px 30px ;
		}
		.search .search-input{
			float:left;
			width:425px;
			height:30px; 
			line-height:26px; 
			padding:0 10px; 
			border:1px solid #008842; 
			background:#FFFFFF;
		}
		.search.search-input:focus{
			background: #ffff;
		}
		.search-btn{
			float:left; 
			display:block; 
			width:81px; 
			height:32px; 
			line-height:28px; 
			padding:0; 
			border:none; 
			cursor:pointer; 
			color:#fff; 
			font-size:14px; 
			background:#008842;
		}
		.search-hot{
			font-size: 5px;
			padding: 10px 10px 5px 0;
		}
		.search-hot a:link{
			color: #000000;
			text-decoration: none;
		}
		.search-hot a:hover{
			color: #009757;
		}
		/*登录，注册*/
		.login{
			float:right;
			padding: 30px 45px 20px 30px;
			font-size: 5px;
		}
		.login a:link{
			color:#007F4D;
			text-decoration: none;
		}
		.login a:hover{
			color: #009757;
			text-decoration: underline;
		}
		.login a:visited{
			color:#008842;
		}
		/*导航栏*/
		.example {
		    position:relative;
		    top: -28px;
		    left:25px;
		    margin:0 auto;
		    padding:30px 30px 0px 60px;
		    border-radius:3px;
		    -moz-border-radius:3px;
		    -webkit-border-radius:3px;
		    z-index:9999;
		}
		.nav,.nav ul {
		    list-style:none;
		}
		.nav {
		    position:relative;
		}
		.nav ul {
		   width:250px;
		   overflow:hidden;
		   position:absolute;
		   top:46px;
		   
		}
		
		.nav li a {
		    background-color:#009757;
		    border:1px solid #009757;
		    color:#FFF;
		    display:block;
		    font-size:14px;
		    line-height:30px;
		    padding:5px 20px;
		    text-decoration:none;
		    width: 135px;
		    text-align: center;
		}
		.nav ul li a {
		    background:white;
		    border-color:white;
		    color:#000;
		    line-height:20px;
		    
		}
		
		.nav li:hover ul li a {
			font-size: 13px;
		    line-height:20px;
		}
		.tubiao{
			width: 15px;
			height: 15px;
		}
		.subs{
			display: none;
		}
		.subs a:hover{
			transform: translate(10px,0);
			transition: all 0.45s;
		}
		/* 尾部*/
		.footer{ 
			clear: both;
			padding-bottom:20px; 
			font-size: 5px; 
			padding: 0 0 0 45px;
			margin-top:-40px;
		}
		.footer{ 
			margin:30px auto 0;
		}
		.footer dl{
			width:190px; 
			float:left; 
			margin-left:50px; 
			display:inline;
		}
		.footer .col1 dt{
			background-position:0 0;
			height:23px; 
			line-height:23px; 
			background:url(img/xinshou.png) no-repeat; 
			font-size:14px; text-indent:40px;
		}
		.footer .col2 dt{
			background-position:0 -23px;
			height:23px; 
			line-height:23px; 
			background:url(img/fukuan.png) no-repeat; 
			font-size:14px; 
			text-indent:40px;
		}
		.footer .col3 dt{
			background-position:0 -46px;
			height:23px; 
			line-height:23px; 
			background:url(img/peisong.png) no-repeat; 
			font-size:14px; 
			text-indent:40px;
		}
		.footer .col4 dt{
			background-position:0 -69px;
			height:23px; 
			line-height:23px; 
			background:url(img/fuwu.png) no-repeat; 
			font-size:14px; 
			text-indent:40px;
		}
		.footer .col5 dt{
			background-position:0 -92px;
			height:23px; 
			line-height:23px; 
			background:url(img/guanyu.png) no-repeat; 
			font-size:14px; 
			text-indent:40px;
		}
		
		.footer dl dd{
			border-left:1px dashed #A8A8A8; 
			padding-left:20px; 
			height:110px; 
			min-height:110px; 
			margin:15px 0 0 13px;
		}
		.footer dl dd a{
			color:#575556; 
			line-height:22px; 
			text-decoration: none;
		}
		.footer dl dd a:hover{
			text-decoration:underline; 
			color:#008842;
		}
		.footer .service{
			clear:both; 
			text-align:center; 
			padding:-20px 0 20px; 
			color:#008842; 
			font-size:14px;
		}
		.footer .service span{ 
			display:inline-block; 
			padding:100px 10px 0 10px;
		}
		.footer .copyright{
			clear:both; 
			color:#717171; 
			text-align:center;
			line-height:22px; 
		}
		.footer .copyright a{
			color:#717171;
		}
		.footer .copyright a:hover{
			color:#008842;
		}
		.footer .authentication a{ 
			display:inline-block; 
			position: relative; 
			margin:0 10px; 
			zoom: 1; 
			vertical-align:middle;
		}
		
		.footer_service{ 
			clear: both;
			background:#e0e0e0; 
			margin-top:30px; 
			padding:20px 0px;
			width:100%;
			height: 80px;
		}
		.footer_service ul{ 
			list-style:none;
		}
		.footer_service li.s1{ 
			float:left; 
			width:190px; 
			height:42px; 
			margin-left:55px; 
			margin-left:44px; 
			padding-left:55px; 
			background:url(img/quanqiu.png) no-repeat left top;
			}
		.footer_service li.s2{ 
			float:left; 
			width:190px; 
			height:42px; 
			margin-left:55px;
			margin-left:44px; 
			padding-left:55px; 
			background:url(img/duochan.png) no-repeat left top;
			}
		.footer_service li.s3{ 
			float:left; 
			width:190px; 
			height:42px; 
			margin-left:55px; 
			margin-left:44px; 
			padding-left:55px; 
			background:url(img/yuantou.png) no-repeat left top;
			}
		.footer_service li.s4{ 
			float:left; 
			width:190px; 
			height:42px; 
			margin-left:55px; 
			margin-left:44px; 
			padding-left:55px; 
			background:url(img/tiantian.png) no-repeat left top;
		}
		.footer_service .s1{ 
			background-position:0 0;
		}
		.footer_service .s2{ 
			background-position:0 -42px;
		}
		.footer_service .s3{ 
			background-position:0 -84px;
		}
		.footer_service .s4{ 
			background-position:0 -126px;
		}
		.footer_service li b{ 
			display:block; 
			padding-left:15px; 
			color:#007f4d; 
			font: normal 18px/25px "Microsoft YaHei"; 
			border-left:1px solid #a6a6a6;
		}
		.footer_service li span{ 
			display:block; 
			padding-left:15px; 
			border-left:1px solid #a6a6a6;
		}
		.wrap{
			height:80px; 
			padding:5px 0 5px 50px;
		}
		
		
		
		/*------侧边悬浮导航------*/
		#kfu{ 
			width:51px; 
			height:43px; 
			position:fixed; 
			left:50%; 
			margin-left: 620px; 
			bottom:70px; 
			background:url(img/kefu.jpg) no-repeat left top;
		}
		#kfu:hover{
			background: url(img/kefu.jpg) no-repeat 0px -44px;
		}
		#btn{
			width:51px; 
			height:43px; /*display: none;*/ 
			position:fixed; 
			left:50%; 
			margin-left: 620px; 
			bottom:30px; 
			background:url(img/top.jpg) no-repeat left top;
		}
		#btn:hover {
			background:url(img/top.jpg) no-repeat 0 -44px;
		}
		
		
		
		
				
		/* 图片部分 */
		#center{
			margin-left:80px;
		}
		
		
		/* 广告部分 */
		#gg{
			margin-top:-28px;
			padding-left:5px;
		}
		.dowm{
			display:inline-block;
			padding:10px 5px 5px 0px;
		}
		#gg>a:hover img{
			-webkit-box-shadow:0 0 5px #333;  
  			-moz-box-shadow:0 0 5px #333;  
  			box-shadow:0 0 5px #333;
		}
		/*排序  */
		#pai{
			width:1200px;
			font-size: 14px;
			margin:10px 0px 30px 4px;
		}
		#pai a{
			border:1px solid #E0E0E0;
			display: inline-block;
			float: left;
			text-decoration: none;
			padding:5px 5px;
			color: #444;
		}
		#pai a:hover{
			color:#008000;
		}
		.aa{
			border-right:none;
		}
		/*商品  */
		.gouwu{
		    display: block;
		    width: 80px;
		    height: 26px;
		    margin: 0 auto;
		    line-height: 28px;
		    color: #fff;
		    background: #008742;
		    -webkit-border-radius: 4px;
		    -moz-border-radius: 4px;
		    border-radius: 4px;
		    padding: 5px 60px;
		    opacity: 0;
		    text-decoration: none;
		}
		
		#t1:hover .gouwu{
			 opacity: 1;
		}
		#product{
			clear: both;
			margin-top:10px;
		}
		/* 购物车 */
		.u-flyer{display: block;width: 50px;height: 50px;border-radius: 50px;position: fixed;z-index: 9999;}
		
		
		/* 商品类型 */
		#pt{
			font-size:16px;
			/* color:#a6a6a6; */
			position: absolute;
			right: 80px;
			top:180px;
		}
		#ptype{
			color:#009757;
		}
	</style>
	</head>
	<body>
	
		<div class="header clearfix" id="header">
			<div class="wrap">
				<div class="logo">
					<a href="index.jsp"><img src=""></a>
				</div>
				<!--  搜索框     -->
				<div class="search">
					<div class="search-box clearfix">
					<form action="" method="post">
						<input type="text" id="keyword" name="pName" class="search-input" value="输入商品名／编号／拼音" onfocus=" if (this.value == '输入商品名／编号／拼音') {this.value = '';this.style.color = '#000';} " onblur=" if (this.value == '') {this.value = '输入商品名／编号／拼音';this.style.color = '#999';} " style="color: rgb(153, 153, 153);">
						<input class="search-btn" id="pName" type="button" value="搜索">
					</form>
					</div>
				</div>
				<!--   登录，注册        -->
				<div class="login">
					<a id="end" href="/AProductMS/shopping_cart.jsp"  style="display: inline-block; width:80px;">我的购物车</a>
					<!-- <a id="jies" href="/AProductMS/shopping_cart.jsp" style="display: inline-block; width:80px;">去结算</a> -->
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
		
    	<%
			/*获取传过来的type id 并保存在request 作用域中  */
			int pType=Integer.parseInt(request.getParameter("pType"));
			request.setAttribute("pType", pType);
		%>
		<!--导航部分-->
		<div class="example">
			<ul class="nav">
				<li><a href="#" id="tpyes">全部商品分类 ▼</a>
					<ul class="subs" id="lili">
	                	<li><a href="/AProductMS/jinkoshuiguo.jsp?pType=1" ><img src="img/jinkou.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
						<li><a href="/AProductMS/jinkoshuiguo.jsp?pType=2" ><img src="img/guochan.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
		             	<li><a href="/AProductMS/jinkoshuiguo.jsp?pType=3" ><img src="img/jinxuan.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
			             <li><a href="/AProductMS/jinkoshuiguo.jsp?pType=4" ><img src="img/qinlei.jpg" class="tubiao"> &nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
			             <li><a href="/AProductMS/jinkoshuiguo.jsp?pType=5" ><img src="img/haixian.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
			             <li><a href="/AProductMS/jinkoshuiguo.jsp?pType=6"><img src="img/rupin.jpg" class="tubiao"> &nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
			             <li><a href="/AProductMS/jinkoshuigu.jsp?pType=7" ><img src="img/shucai.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
			             <li><a href="/AProductMS/jinkoshuiguo.jsp?pType=8"><img src="img/sushi.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
			             <li><a href="/AProductMS/jinkoshuiguo.jsp?pType=9" ><img src="img/zahuo.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
			             <li><a href="/AProductMS/jinkoshuiguo.jsp?pType=10"><img src="img/yinliao.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>
			             <li><a href="/AProductMS/jinkoshuiguo.jsp?pType=11"><img src="img/lipin.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>	
					</ul>
				</li>
			</ul>
		</div>
		<!--商品类型  -->
		<div id="pt">
			<p>商品类型/<span id="ptype"></span></p>
		</div>
		<c:if test="${pType ne null }">
			<script type="text/javascript">
			$.ajax({
				type:"post",
				url:"/AProductMS/GetTypeName.action",
				async:true,
				data:{
					'tid':'${pType}'
				},
				success:function(data,status,xhr){
				//	alert(data);
					$("#ptype").text(data);
				}
			});
			</script>
		</c:if>
		
		<script>
			$(function(){				
				$.ajax({
					type:"post",
					url:"/AProductMS/AllPType.action",
					async:true,
					success:function(data,status,xhr){
						var all=$.parseJSON(data);
						var len=all.length;
						var liLen=$("#lili > li").length;
						//alert("len:"+len);
						//alert("liLen:"+liLen);
						if(len>liLen){
							//alert(liLen+1);
							$("#lili").append('<li><a href="/AProductMS/jinkoshuiguo.jsp?pType='+liLen+1+'"><img src="img/zahuo.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>');
						}
						$.each(all,function(i,v){
							//alert($(".typess").eq(i).text(v.pTypeName));
							$(".typess").eq(i).text(v.pTypeName);
						});									
					},
					complete:function(){
						$("#tpyes").mouseover(function(){
							$(".subs").css("display","block");
						});
						$(".subs").mouseleave(function(){
							$(this).css("display","none");
						});
					}
				});
				
				
			});
		</script>
		
		
	<div id="center">
		    <!--广告位-->
   		 <!-- <div id="gg">
	        <a href="http://www.yiguo.com/products/0111_ganjuchengyou.html" target="_blank"><img src="images/01.jpg" width="1200" height="300"></a>
	        <a class="dowm" href="http://www.yiguo.com/products/0101_qiyiguo.html#formCx" target="_blank"><img src="images/02.jpg" width="405" height="180"></a>
	        <a class="dowm" href="http://www.yiguo.com/products/0109_pingguo.html#formCx" target="_blank"><img src="images/03.jpg" width="405" height="180"></a>
	        <a class="dowm" href="http://www.yiguo.com/product/10405.html" target="_blank"><img src="images/04.jpg" width="180" height="180"></a>
	        <a class="dowm" href="http://www.yiguo.com/products/0104_li.html#formCx" target="_blank"><img src="images/05.jpg" width="180" height="180"></a>
    	</div> -->
        
	     <!--排序-->
	    <div id="pai">
            <a class="aa" id="price1" href="javascript:;" >默认排序</a>
            <a class="aa" id="price2" href="javascript:;">销量</a>
            <a class="aa" id="price3" href="javascript:;">价格</a>
            <a class="aa" id="price4" href="javascript:;">评论</a>
            <input id="price" type="hidden" value="0"/>
	    </div>
	    
    	<div id="product">
    	</div>
    	
		<script type="text/javascript">
			$(function(){
				$("#price1").on("click",function(){
					$("#price").prop("value","0");
				});
				$("#price2").on("click",function(){
					$("#price").prop("value","0");
				});
				$("#price3").on("click",function(){
					$("#price").prop("value","1");
				});
				$("#price4").on("click",function(){
					$("#price").prop("value","0");
				});
			});
		</script>
    	<!-- 关键字进行搜索 -->
    	<c:if test="${requestScope.pType !=null}">
    	<script type="text/javascript">
    		$("#pName").on("click",function(){
	    		$.ajax({
	    			type:"post",
	    			url:'/AProductMS/AllType.action',
	    			data:{
	    				'pricetype':$("#price").val(),
	    				'pType':'${pType}',
	    				'pName':$("#keyword").val(),
	    			},
	    			success:function(data,status,xhr){	
	    				//console.log(data);
	    				var all=$.parseJSON(data);
						var html="";
						$.each(all,function(i,v){
							html+="<div id='t1' style='float:left;position: relative;margin:4px 5px;'>"
								html+="<img class='img'  title='"+v.pid+"' src='"+v.pPicture+"'width='290px'height='290px' style='display:block;z-index:1000' />"
								html+="<div style=' width:290px;height:100px;background:#fff;margin-top:-16px;'>";
									html+="<p style=''>"+v.pName+"</p>"
									html+="<p style='color:red;font-size:20px;'>¥"+v.pPrice+"</p>"
								html+="</div>";
								html+="<div style='position: absolute;bottom: 100px; left: 40px; '>"
								//	html+="<p>"+v.pDesc+"</p>"
								html+="<a href='javascript:;'  class='gouwu' title='"+v.pid+"'>加入购物车</a>"
								html+="</div>"
							html+="</div>"
						});
						$("#product").html(html);
						
	    			},
	    			complete:function(){					   
						 $(".gouwu").bind("click",function(e,i){	
							// alert("${userName}");
							if("${userName}"!=null&&"${userName}"!=""){
								var offset = $("#end").offset();
		    					var addcar = $(this);
		    					var tit=$(this).prop("title")
		    					var img = $('.img[title='+tit+']').prop('src');
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
					    				'pid':$(this).prop("title"),
					    			},
					    			success:function(data,status,xhr){
					    				//alert(data);
					    			},
				    			});	
								
							}else{
								
								alert("你还没有登录!还不能加入购物车");
							}
						 });
						 $(".img").click(function(){							
							 window.location.href="/AProductMS/GetProduct_Info.action?pid="+$(this).prop("title")+"";						
						 });
					}
	    		});
	    		
	    		
	    		
	    	});
    	</script>
	    	
	    	
    	</c:if>
    	<!-- 价格进行的排序 -->
    	<c:if test="${requestScope.pType !=null}">
    	<script type="text/javascript">
    		$("#price3").on("click",function(){
    			//alert($("#price").val());
    			$.ajax({
	    			type:"post",
	    			url:'/AProductMS/AllType.action',
	    			data:{
	    				'pricetype':$("#price").val(),
	    				'pType':'${pType}',
	    				'pName':'',
	    			},
	    			success:function(data,status,xhr){	
	    				//console.log(data);
	    				var all=$.parseJSON(data);
						var html="";
						$.each(all,function(i,v){
							html+="<div id='t1' style='float:left;position: relative;margin:4px 5px;'>"
								html+="<img class='img'  title='"+v.pid+"' src='"+v.pPicture+"'width='290px'height='290px' style='display:block;z-index:1000' />"
								html+="<div style=' width:290px;height:100px;background:#fff;margin-top:-16px;'>";
									html+="<p style=''>"+v.pName+"</p>"
									html+="<p style='color:red;font-size:20px;'>¥"+v.pPrice+"</p>"
								html+="</div>";
								html+="<div style='position: absolute;bottom: 100px; left: 40px; '>"
								//	html+="<p>"+v.pDesc+"</p>"
								html+="<a href='javascript:;'  class='gouwu' title='"+v.pid+"'>加入购物车</a>"
								html+="</div>"
							html+="</div>"
						});
						$("#product").html(html);
						
	    			},
	    			complete:function(){					   
						 $(".gouwu").bind("click",function(e,i){	
							// alert("${userName}");
							if("${userName}"!=null&&"${userName}"!=""){
								var offset = $("#end").offset();
		    					var addcar = $(this);
		    					var tit=$(this).prop("title")
		    					var img = $('.img[title='+tit+']').prop('src');
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
					    				'pid':$(this).prop("title"),
					    			},
					    			success:function(data,status,xhr){
					    				//alert(data);
					    			},
				    			});	
								
							}else{
								
								alert("你还没有登录!还不能加入购物车");
							}
						 });
						 $(".img").click(function(){							
							 window.location.href="/AProductMS/GetProduct_Info.action?pid="+$(this).prop("title")+"";						
						 });
				}
	    		});
	    	});
    	</script>
    	</c:if>
	</div>
	<!-- 商品部分-->
	<c:if test="${requestScope.pType !=null}">
		<script type="text/javascript">
			$(function(){
				 $.ajax({
					type:"post",
					url:"/AProductMS/AllType.action",
					data:{
						'pricetype':$("#price").val(),
						'pType':'${pType}',
						'pName':'',
					},
					success:function(data,status,xhr){
						//console.log(data);
						var all=$.parseJSON(data);
						var html="";
						$.each(all,function(i,v){
							html+="<div id='t1'  style='float:left;position: relative;margin:4px 5px;'>"
								html+="<img class='img' title='"+v.pid+"' src='"+v.pPicture+"'width='290px'height='290px' style='display:block;cursor: pointer;' />"
								html+="<div style=' width:290px;height:100px;background:#fff;margin-top:-16px;'>";
									html+="<p style=''>"+v.pName+"</p>"
									html+="<p style='color:red;font-size:20px;'>¥"+v.pPrice+"</p>"
								html+="</div>";
								html+="<div style='position: absolute;bottom: 100px; left: 40px; '>"
								//	html+="<p>"+v.pDesc+"</p>"
									html+="<a href='javascript:;'  class='gouwu' title='"+v.pid+"'>加入购物车</a>"
								html+="</div>"
							html+="</div>"
						});
						$("#product").html(html);
				
					},
					complete:function(){					   
							 $(".gouwu").bind("click",function(e,i){	
								 //alert("${userName}");
								if("${userName}"!=null&&"${userName}"!=""){
									var offset = $("#end").offset();
			    					var addcar = $(this);
			    					var tit=$(this).prop("title")
			    					var img = $('.img[title='+tit+']').prop('src');
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
						    				'pid':$(this).prop("title"),
						    			},
						    			success:function(data,status,xhr){
						    				//alert(data);
						    			},
					    			});	
									
								}else{
									
									alert("你还没有登录!还不能加入购物车");
								}
							 });
							 $(".img").click(function(){							
								 window.location.href="/AProductMS/GetProduct_Info.action?pid="+$(this).prop("title")+"";						
							 });
					}
				}); 
				 
			});
		</script>
		
	</c:if>
	
	
	
	
		
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