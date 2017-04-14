<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/jquery-1.8.3.min.js"></script>
		<script src="js/jquery.luara.0.0.1.min.js"></script>
		<script src="js/jquery-ui-1.12.0.custom/jquery-ui.min.js"></script>
		<link rel="stylesheet" href="js/jquery-ui-1.12.0.custom/jquery-ui.min.css" />
		<link rel="stylesheet" href="css/style.css" type="text/css" media="all">
		<link rel="stylesheet" href="css/public.css" />
		<link rel="stylesheet" href="css/themes.css" />
		<!-- <link rel="stylesheet" href="css/xinxian.css"> -->
</head>
<body>
	<!-- 头部   -->
	<div class="header clearfix" id="header">
		<div class="wrap">
			<div class="logo">
				<a href="index.html"></a>
			</div>
			<!--  搜索框     -->
			<div class="search">
				<div class="search-box clearfix">
				<form action="get.do" method="post">
					<input type="text" id="keyword" name="pName" class="search-input" value="输入商品名／编号／拼音" onfocus=" if (this.value == '输入商品名／编号／拼音') {this.value = '';this.style.color = '#000';} " onblur=" if (this.value == '') {this.value = '输入商品名／编号／拼音';this.style.color = '#999';} " style="color: rgb(153, 153, 153);">
					<input class="search-btn" type="submit" value="搜索">
				</form>
				</div>
			</div>
			<!--    登录，注册        -->
			<div class="login">
				&nbsp;
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
	 <!-- 导航菜单 -->
	<div class="example">
		<ul class="nav">
			<li><a href="#">全部商品分类 ▼</a>
				<ul class="subs">
					<li><a href="#"><img src="img/jinkou.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;进口水果</a></li>
	                <li><a href="#"><img src="img/guochan.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;国产水果</a></li>
	                <li><a href="#" target="_blank"><img src="img/jinxuan.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;精选肉类</a></li>
	                <li><a href="#"><img src="img/qinlei.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;禽类蛋品</a></li>
	                <li><a href="#"><img src="img/haixian.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;海鲜水产</a></li>
	                <li><a href="#"><img src="img/rupin.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;乳品糕点</a></li>
	                <li><a href="#"><img src="img/shucai.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;新鲜蔬菜</a></li>
	                <li><a href="#"><img src="img/sushi.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;方便速食</a></li>
	                <li><a href="#"><img src="img/zahuo.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;粮油杂货</a></li>
	                <li><a href="#"><img src="img/yinliao.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;饮料酒水</a></li>
	                <li><a href="#"><img src="img/lipin.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;礼品礼券</a></li>
				</ul>
			</li>
		</ul>
	</div>
			
	
	
    <!--广告位-->
    <div class="wrap">
	    <div class="page_ad clearfix">
	        <a class="big" href="http://www.yiguo.com/products/0111_ganjuchengyou.html" target="_blank"><img src="http://img07.yiguoimg.com/e/others/160728/9288696047771900.jpg" width="1200" height="300"></a>
	        <a class="medium mr" href="http://www.yiguo.com/products/0101_qiyiguo.html#formCx" target="_blank"><img src="http://img06.yiguoimg.com/e/others/160422/9288693685919894.jpg" width="405" height="180"></a>
	        <a class="medium mr" href="http://www.yiguo.com/products/0109_pingguo.html#formCx" target="_blank"><img src="http://img07.yiguoimg.com/e/others/160225/9288692563517529.jpg" width="405" height="180"></a>
	        <a class="small mr" href="http://www.yiguo.com/product/10405.html" target="_blank"><img src="http://img07.yiguoimg.com/e/others/160707/9288695431110887.jpg" width="180" height="180"></a>
	        <a class="small" href="http://www.yiguo.com/products/0104_li.html#formCx" target="_blank"><img src="http://img06.yiguoimg.com/e/others/160620/9288695001686228.jpg" width="180" height="180"></a>
	 </div>
	    
	    
	    
	    
	</div>
	<!-- 商品 -->
	
	
	
	
	
	
	
	<div class="shanpinzt">
		<div class="spbk">	
			<!--循环体  -->
			<c:forEach var="p" items="${sessionScope.li}"  >
				<div class="sp">
					<img src="${p.pPicture}">
					<p>
						<a href="#">${p.pName}</a>	
					</p>
					<p style="color: red; font-size: 20px;">¥${p.pPrice}</p>
				</div>
			</c:forEach>
		</div>
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
		<!------- 侧边悬浮 ------->
		<a href="#"  id="kfu" onclick="ysf.open();return false;"></a> 
		<a href="javascript:;" id="btn" title="回到顶部"></a>
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
					var speedtop = backtop / 5;
					document.body.scrollTop = backtop - speedtop;
					if (backtop == 0) {
						clearInterval(timer);
					}
				}, 30);
			}
		</script>
	</body>
</html>