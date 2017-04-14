<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
		<meta charset="utf-8" />
		<title>主页</title>
		<script src="js/jquery-3.0.0.js"></script>
		<script src="js/jquery.luara.0.0.1.min.js"></script>
		
		<link rel="stylesheet" href="css/MyCss.css" />
		<link rel="stylesheet" href="css/style.css" type="text/css" media="all">
		<link rel="shortcut icon" href="img/tu.png">
		<style type="text/css">
	        *{	margin: 0; padding: 0; text-decoration: none; }
	        #container { width:1345px; height: 600px;overflow: hidden; position: relative;}
	        #list { width:8070px; height: 600px; position: absolute; z-index: 1;}
	        #list img { float: left; width:1345px;height:500px;}
	        #buttons { position: absolute; height: 10px; width: 100px; z-index: 2; bottom: 20px; right: 650px;}
	        #buttons span { cursor: pointer; float: left; border: 1px solid #fff; width: 12px; height: 10px; border-radius: 50%; background: #333; margin-right: 5px;}
	        #buttons .on {  background: orangered;}
	        .arrow { cursor: pointer; display: none; line-height: 100px;text-align: center; font-size: 36px; font-weight: bold; width: 40px; height: 100px;  position: absolute; z-index: 2; top: 170px; background-color: RGBA(0,0,0,.3); color: #fff;}
	        .arrow:hover { background-color: RGBA(0,0,0,.7);}
	        #container:hover .arrow { display: block;}
	        #prev { left: 20px;}
	        #next { right: 20px;}
   		 </style>
	</head>
	<body>
	<!--图片轮播  -->
	<script type="text/javascript">
        $(function () {
            var container = $('#container');
            var list = $('#list');
            var buttons = $('#buttons span');
            var prev = $('#prev');
            var next = $('#next');
            var index = 1;
            var len = 5;
            var interval = 1000;
            var timer;


            function animate (offset) {
                var left = parseInt(list.css('left')) + offset;
                if (offset>0) {
                    offset = '+=' + offset;
                }
                else {
                    offset = '-=' + Math.abs(offset);
                }
                list.animate({'left': offset}, 300, function () {
                    if(left > -200){
                        list.css('left', -1345 * len);
                    }
                    if(left < (-1345 * len)) {
                        list.css('left', -1345);
                    }
                });
            }

            function showButton() {
                buttons.eq(index-1).addClass('on').siblings().removeClass('on');
            }

            function play() {
                timer = setTimeout(function () {
                    next.trigger('mousemove');
                    play();
                }, interval);
            }
            function stop() {
                clearTimeout(timer);
            }

            next.bind('click', function () {
                if (list.is(':animated')) {
                    return;
                }
                if (index == 5) {
                    index = 1;
                }
                else {
                    index += 1;
                }
                animate(-1345);
                showButton();
            });

            prev.bind('click', function () {
                if (list.is(':animated')) {
                    return;
                }
                if (index == 1) {
                    index = 5;
                }
                else {
                    index -= 1;
                }
                animate(1345);
                showButton();
            });

            buttons.each(function () {
                 $(this).bind('mousemove', function () {
                     if (list.is(':animated') || $(this).attr('class')=='on') {
                         return;
                     }
                     var myIndex = parseInt($(this).attr('index'));
                     var offset = -1345 * (myIndex - index);

                     animate(offset);
                     index = myIndex;
                     showButton();
                 })
            });
            container.hover(stop, play);
            play();
        });
    </script>
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
						<a id="end" href="/AProductMS/shopping_cart.jsp"  style="	display: inline-block; width:80px;">我的购物车</a>
					<!-- 	<a id="jies" href="/AProductMS/shopping_cart.jsp" style="display: inline-block; width:80px;">去结算</a> -->
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
			<!--焦点图  -->
		    <div id="container" class="example2">
			  <div id="list" style="left: -1345px;">
			 	 <img src="img/lunbo/4.jpg" alt="5"/>	
			 	 <img src="img/lunbo/qiyi.jpg" alt="1"/>
		         <img src="img/lunbo/yeqin.jpg" alt="2"/>		     
			     <img src="img/lunbo/9288696350712076.jpg" alt="3"/>
		         <img src="img/lunbo/9288696322826507.jpg" alt="4"/>
		         <img src="img/lunbo/hxian.jpg" alt="5"/>
		         <img src="img/lunbo/qiyi.jpg" alt="1"/>	         
			    </div>
			    <div id="buttons">
			        <span index="1" class="on"></span>
			        <span index="2"></span>
			        <span index="3"></span>
			        <span index="4"></span>
			        <span index="5"></span>
			    </div>
			    <a href="javascript:;" id="prev" class="arrow">&lt;</a>
			    <a href="javascript:;" id="next" class="arrow">&gt;</a>
			</div>    
		 <!-- 导航菜单 -->
			<div class="example">
				<ul class="nav">
					<li><a href="#">全部商品分类 ▼</a>
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
							var ptype=parseInt(liLen+1);
							$("#lili").append('<li><a href="/AProductMS/jinkoshuiguo.jsp?pType='+ptype+'"><img src="img/zahuo.jpg" class="tubiao">&nbsp;&nbsp;&nbsp;&nbsp;<span class="typess"></span></a></li>');
						}
						$.each(all,function(i,v){
							//alert($(".typess").eq(i).text(v.pTypeName));
							$(".typess").eq(i).text(v.pTypeName);
						});									
					}
				});
			});
		</script>
			<!-- 商品楼层   -->
			<div class="commodity">
				<div class="floor-title" id="t01">
					<h3><a href="#" target="_blank"><img src="img/F1.png" class="fnum" id="jin">进口水果</a><span>进口苹果 | 佳沛专区 | 泰国鲜果</span></h3>					
				</div>
				<hr align="left" color=" #FD603C;"/>
				<div style="clear: both;">
					<div style="float: left;">
						<img src="img/jinkou/1.jpg" />
					</div>
					<div class="fentu">
						<img src="img/jinkou/2.jpg" />
						<img src="img/jinkou/3.jpg" />
						<img src="img/jinkou/4.jpg" />
					</div>
					<div class="fentu">
						<img src="img/jinkou/5.jpg" />
						<img src="img/jinkou/6.jpg" />
						<img src="img/jinkou/7.jpg" />
					</div>
				</div>
			</div>
			<div class="commodity" id="t02">
				<div class="floor-title1">
					<h3><a href="#" target="_blank"><img src="img/F2.png" class="fnum">国产水果</a><span>芒香四溢 | 南国风情 | 精选苹果</span></h3>
				</div>
				<hr align="left" color="#007F4D"/>
				<div >
					<div style="float: left;">
						<img src="img/guochan/1.jpg" />
					</div>
					<div class="fentu">
						<img src="img/guochan/2.jpg" />
						<img src="img/guochan/3.jpg" />
						<img src="img/guochan/4.jpg" />
					</div>
					<div class="fentu">
						<img src="img/guochan/5.jpg" />
						<img src="img/guochan/6.jpg" />
						<img src="img/guochan/7.jpg" />
					</div>
				</div>
			</div>
			<div class="commodity" id="t03">
				<div class="floor-title2">
					<h3><a href="#" target="_blank"><img src="img/F3.png" class="fnum">新鲜蔬菜</a><span>即食色拉 | 人气粗粮 |健康有机</span></h3>
				</div>
				<hr align="left" color="#C5CC46"/>
				<div >
					<div style="float: left;">
						<img src="img/shucai/1.jpg" />
					</div>
					<div class="fentu">
						<img src="img/shucai/2.jpg" />
						<img src="img/shucai/3.jpg" />
						<img src="img/shucai/4.jpg" />
					</div>
					<div class="fentu">
						<img src="img/shucai/5.jpg" />
						<img src="img/shucai/6.jpg" />
						<img src="img/shucai/7.jpg" />
					</div>
				</div>
			</div>
			<div class="commodity" id="t04">
				<div class="floor-title3">
					<h3><a href="#" target="_blank"><img src="img/F4.png" class="fnum">海鲜水产</a><span>刺身专区 |东海水产 | 海产干货</span></h3>
				</div>
				<hr align="left" color="#45C6CE"/>
				<div >
					<div style="float: left;">
						<img src="img/haixian/1.jpg" />
					</div>
					<div class="fentu">
						<img src="img/haixian/2.jpg" />
						<img src="img/haixian/3.jpg" />
						<img src="img/haixian/4.jpg" />
					</div>
					<div class="fentu">
						<img src="img/haixian/5.jpg" />
						<img src="img/haixian/6.jpg" />
						<img src="img/haixian/7.jpg" />
					</div>
				</div>
			</div>
			<div class="commodity" id="t05">
				<div class="floor-title4">
					<h3><a href="#" target="_blank"><img src="img/F5.png" class="fnum">精选肉类</a><span>欧洲天然猪 | 澳洲牛肉 | 肉类制品</span></h3>
				</div>
				<hr align="left" color="#FFCC00"/>
				<table border="0px" width="1200px" height="462px" cellpadding="0" cellspacing="0">
					<tr class="fentu">
						<td rowspan="3"><img src="img/jinxuan/1.jpg"></td>
						<td rowspan="2"><img src="img/jinxuan/2.jpg"></td>
						<td><img src="img/jinxuan/3.jpg"></td>
						<td><img src="img/jinxuan/4.jpg"></td>
						<td rowspan="3"><img src="img/jinxuan/12.jpg"></td>
					</tr>
					<tr class="fentu">
						<td><img src="img/jinxuan/5.jpg"></td>
						<td><img src="img/jinxuan/6.jpg"></td>
					</tr>
					<tr>
						<td colspan="3"><img src="img/jinxuan/7.png"></td>
					</tr>
				</table>	
			</div>
			<div class="commodity" id="t06">
				<div class="floor-title5">
					<h3><a href="#" target="_blank"><img src="img/F6.png" class="fnum">禽类蛋品</a><span>原味蒸品 | 原汁煲汤 | 禽类分割品</span></h3>
				</div>
				<hr align="left" color="#E08683"/>
				<table border="0px" width="1200px" height="462px" cellpadding="0" cellspacing="0">
					<tr class="fentu">
						<td rowspan="3"><img src="img/qinlei/1.jpg"></td>
						<td rowspan="2"><img src="img/qinlei/2.jpg"></td>
						<td><img src="img/qinlei/3.jpg"></td>
						<td><img src="img/qinlei/4.jpg"></td>
						<td rowspan="3"><img src="img/qinlei/7.jpg"></td>
					</tr>
					<tr class="fentu">
						<td><img src="img/qinlei/5.jpg"></td>
						<td><img src="img/qinlei/6.jpg"></td>
					</tr>
					<tr>
						<td colspan="3"><img src="img/qinlei/8.png"></td>
					</tr>
				</table>	
			</div>
			<div class="commodity" id="t07">
				<div class="floor-title6">
					<h3><a href="#" target="_blank"><img src="img/F7.png" class="fnum">粮油杂货</a><span>休闲零食 | 健康杂粮 | 进口食用油</span></h3>
				</div>
				<hr align="left" color="#B84F00"/>
				<table border="0px" width="1200px" height="462px" cellpadding="0" cellspacing="0">
					<tr class="fentu">
						<td rowspan="3"><img src="img/zahuo/1.jpg"></td>
						<td rowspan="2"><img src="img/zahuo/2.jpg"></td>
						<td colspan="2"><img src="img/zahuo/3.jpg"></td>
						<td rowspan="3"><img src="img/zahuo/4.jpg"></td>
					</tr>
					<tr class="fentu">
						<td colspan="2"><img src="img/zahuo/5.jpg"></td>
					</tr>
					<tr>
						<td colspan="3"><img src="img/zahuo/6.png"></td>
					</tr>
				</table>	
			</div>
			<div class="commodity" id="t08">
				<div class="floor-title7">
					<h3><a href="#" target="_blank"><img src="img/F8.png" class="fnum">乳品糕点</a><span>味全乳品 | 精选蛋糕 | try me 小蛋糕</span></h3>
				</div>
				<hr align="left" color="#764E00"/>
				<table border="0px" width="1200px" height="462px" cellpadding="0" cellspacing="0">
					<tr class="fentu">
						<td rowspan="3"><img src="img/gaodian/1.jpg"></td>
						<td rowspan="2"><img src="img/gaodian/2.jpg"></td>
						<td><img src="img/gaodian/3.jpg"></td>
						<td><img src="img/gaodian/4.jpg"></td>
						<td rowspan="3"><img src="img/gaodian/7.jpg"></td>
					</tr>
					<tr class="fentu">
						<td><img src="img/gaodian/5.jpg"></td>
						<td><img src="img/gaodian/6.jpg"></td>
					</tr>
					<tr>
						<td colspan="3"><img src="img/gaodian/8.png"></td>
					</tr>
				</table>	
			</div>
			<div class="commodity" id="t09">
				<div class="floor-title8">
					<h3><a href="#" target="_blank"><img src="img/F9.png" class="fnum">饮料酒水</a><span>饮用水 | 果汁 | 白葡萄酒</span></h3>
				</div>
				<hr align="left" color="#940505"/>
				<table border="0px" width="1200px" height="462px" cellpadding="0" cellspacing="0">
					<tr class="fentu">
						<td rowspan="3"><img src="img/yinliao/1.jpg"></td>
						<td rowspan="2"><img src="img/yinliao/2.jpg"></td>
						<td colspan="2"><img src="img/yinliao/3.jpg"></td>
						<td rowspan="3"><img src="img/yinliao/4.jpg"></td>
					</tr>
					<tr class="fentu">
						<td colspan="2"><img src="img/yinliao/5.jpg"></td>
					</tr>
					<tr>
						<td colspan="3"><img src="img/yinliao/6.png"></td>
					</tr>
				</table>	
			</div>
			<div class="commodity" id="t10">
				<div class="floor-title9">
					<h3><a href="#" target="_blank"><img src="img/F10.png" class="fnum">方便速食</a><span>避风塘 | 湾仔码头 | 龙凤</span></h3>
				</div>
				<hr align="left" color="#3CA3DC"/>
				<table border="0px" width="1200px" height="462px" cellpadding="0" cellspacing="0">
					<tr class="fentu">
						<td rowspan="3"><img src="img/sushi/1.jpg"></td>
						<td rowspan="2"><img src="img/sushi/2.jpg"></td>
						<td><img src="img/sushi/3.jpg"></td>
						<td><img src="img/sushi/4.jpg"></td>
						<td rowspan="3"><img src="img/sushi/7.jpg"></td>
					</tr>
					<tr class="fentu">
						<td><img src="img/sushi/5.jpg"></td>
						<td><img src="img/sushi/6.jpg"></td>
					</tr>
					<tr>
						<td colspan="3"><img src="img/sushi/8.png"></td>
					</tr>
				</table>	
			</div>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			<!-- 页尾 -->			
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
					var speedtop = backtop / 5;
					document.body.scrollTop = backtop - speedtop;
					if (backtop == 0) {
						clearInterval(timer);
					}
				}, 30);
			}
		</script>
		<script>
	        $(function(){
	        	$(".example2").luara({width:"1346",height:"400",interval:4500,selected:"seleted",deriction:"left"});
	        });
	    </script>
	</body>
</html>
