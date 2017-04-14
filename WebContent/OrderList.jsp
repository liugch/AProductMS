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
        <title>我的订单</title>
        <script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
        <script type="text/javascript" src="js/jquery-ui-1.12.0.custom/jquery-ui.min.js" ></script>
        <script type="text/javascript" src="js/topdsp.js" ></script>
        <script type="text/javascript" src="js/adw.js" ></script>
        <script type="text/javascript" src="js/common.js" ></script>
        <script type="text/javascript" src="js/jquery-1.7.2-min.js" ></script>
        <script src="js/handlebars-v3.0.1.js"></script>
        <script src="js/jquery.superslide.js"></script>
        <script src="js/utaste.js"></script>
        <script src="js/sidebar.js"></script>
        <script src="js/jquery.scrollLoading-min.js"></script>
        <script src="js/search.js"></script>
        <script src="js/global-v2.js"></script>
        <script src="js/base.js"></script>
        <script src="js/app.js"></script>
        <script src="js/chat.js"></script>  
        <script src="js/util.js"></script>         
    	<script src="js/myorder.js"></script>
        <link rel="stylesheet" href="css/myorder.css" />
        <link rel="stylesheet" href="css/public.css" />
        <link rel="stylesheet" href="css/returns.css" />
        <link rel="stylesheet" href="css/search.css" />
        <link rel="stylesheet" href="css/themes.css" />
        <link rel="stylesheet" href="css/yg.css" />
    </head>
    <body id="body">
    	<div id="w">
    		<!------- 弹出框 ------->
        <div class="popout soldOut-poput">
            <div class="popout-wrap">
                <div class="popout-con">
                    <div class="title"><i></i>提 示</div>
                    <div class="con">
                        <h1>您设置了该商品到货通知！</h1>
                        <p>
                            我们会将到货通知信息及时发送到您的邮箱：<br> <a href="#"><u>Xushun@yiguo.com</u></a> <a href="#" target="_blank">修改邮箱</a>
                        </p>
                        <div class="btnbox"><a class="confirm" href="javascript:">确  认</a><a class="cancel" href="javascript:">取  消</a></div>
                    </div>
                </div>
            </div>
            <div class="popout-bg">&nbsp;</div>
        </div>

        <div class="w">
            <!------- 顶部工具栏 ------->
            


<div class="site-nav">
    


            <!------- 头部 ------->
    <div class="header clearfix">
        <div class="wrap">
            <div class="logo">
                <a href="index.html"></a>
            </div>
                    <!--搜索 开始-->
        <div class="search" style="position:relative;">
		    <div class="search-bar clearfix">
		        <input type="text" id="keyword" name="keyword" class="search-input" value="输入商品名／编号／拼音" onfocus=" if (this.value == '输入商品名／编号／拼音') {this.value = '';this.style.color = '#000';} " onblur=" if (this.value == '') {this.value = '输入商品名／编号／拼音';this.style.color = '#999';} " style="color: rgb(153, 153, 153);">
		        <input class="search-btn" type="submit" value="搜索">
		    </div>
    		<ul class="hide" id="shelper" style="display: none;"></ul>
		    <div class="search-keywords" id="keywords">
		        <script id="keywordstpl" type="text/x-handlebars-template">
		            {{#KeyWords}}
		            {{#equal IsImportant true}}
		            <a href="{{Link}}" class="hot" target="_blank">{{Text}}</a>
		            {{else}}
		            <a href="{{Link}}" target="_blank">{{Text}}</a>
		            {{/equal}}
		            {{/KeyWords}}
		        </script>
		    </div>
		</div>
                    <!--购物车 开始-->
                    

		<div class="shopping-cart">
		    <dl>
		        <dt class="shopping-btn"><a href="http://cart.yiguo.com"> <span class="totleNum"><b>0</b></span><b class="totlePrice">0.0</b></a></dt>
		        <dd class="shopping-list">
		            <div class="spacer"></div>
		            <div class="nogoods" style="display:none;">
		                购物车中还没有商品，赶紧选购吧！
		            </div>
		            <div class="goods">
		                <p id="deliveryType" style="display:none;">满100元包邮！</p>
		                <ul></ul>
		                <div class="price-total">
		                    <div><span class="totleNum">共<b>0</b>件商品</span><span>共计<b class="totlePrice">¥0.00</b></span></div>
		                    <div><a href="http://cart.yiguo.com/ShopCart.aspx" class="settleup">去购物车</a></div>
		                </div>
		            </div>
		        </dd>
		    </dl>
		</div>
                    <!--购物车 结束-->
                </div>
            </div>
            <!--商品分类 开始-->
            <div class="header-nav">
		    <div class="wrap">
		        <!--商品分类 开始-->
		        <div class="catalogs">
		            <div class="catalogs-title btn-green"><a href="#"><i></i>全部商品分类</a></div>
		            <div class="catalogs-list" id="_categry" style="display:none;">
		                <script id="_categorytpl" type="text/x-handlebars-template">
		    {{#each Catrgories}}
			    <div class="item">
			        <h3 class="t{{CategoryCode}}"><a href="/shop/{{CategoryCode}}.html"><i></i>{{CategoryName}}<s>&gt;</s></a></h3>
			        <div class="sub-item" style="display: none;">            
			            <h4><a href="/shop/{{CategoryCode}}.html"> {{CategoryName}}</a></h4>
			            <div class="sub-list">
			                {{#if SubCategory2}}
			                {{#each SubCategory2}}
			                <a href="/shop/{{CategoryCode}}.html" target="_blank">{{CategoryName}}</a>
			                {{/each}}
			                {{/if}}
			
			                {{#if SubCategory1}}
			                {{#each SubCategory1}}
			                <a href="/shop/{{CategoryCode}}.html" target="_blank">{{CategoryName}}</a>
			                {{/each}}
			                {{/if}}
			
			                {{#if SubCategory0}}
			                {{#each SubCategory0}}
			                <a href="/shop/{{CategoryCode}}.html" target="_blank">{{CategoryName}}</a>
			                {{/each}}
			                {{/if}}
			
			            </div>
			            <div class="catalogs-ad">
			                {{#each CategoryImageAd}}
			                <a href="{{Link}}"><img src="{{Image}}"></a>
			                {{/each}}
			            </div>
			        </div>
			    </div>
		    {{/each}}
		
		</script>
		
		            </div>
		        </div> 
		        <!--商品分类 结束-->
		        <div class="nav-items">
		            <ul id="homenav">
		                <script id="homenavtpl" type="text/x-handlebars-template">
		                    {{#HomeNav}}
		                    <li><a href="{{Link}}" target="_blank">{{Text}}</a></li>
		                    {{/HomeNav}}
		                </script>
		            </ul>
		        </div>
		    </div>
		</div>
			<div class="wrap">
                    <!--面包屑-->
			    <div class="crumbs">
			    	<a class="ml0" href="index.html">首页</a>&gt;<a href="/Trade/Index" class="j_ygnav">我的易果</a><span class="j_thridcrumbs hide">&gt;<a href="javascript:void(0)" class="on j_thirdnav"></a></span>
			    </div>
                <div class="content myyg">
                    <div class="sub">
                        <div class="menu j_menu">
                            <dl>
                                <dt>交易信息</dt>
                                <dd>
                                    <ul>
                                        <li><a href="/Trade/OrderList">我的订单</a></li>
                                        <li><a href="/Trade/MyCollection">我的收藏</a></li>
                                    </ul>
                                </dd>
                                <dt>账号信息</dt>
                                <dd>
                                    <ul>
                                        <li>
                                            <a href="/Account/PersonalProfile">个人资料</a>
                                        </li>
                                        <li><a href="/Account/Consignee">收货地址管理</a></li>
                                    </ul>
                                </dd>
                                <dt>售后服务</dt>
                                <dd>
                                    <ul>
                                        <li><a href="/Trade/BackOrder">在线退换货</a></li>
                                        <li><a href="/Trade/Advice">投诉建议</a></li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                        <div>
                            <div class="ad" style="height: 308px;">
                                <a href="#" target="_blank" style="display: none"><img src="/img/ad.jpg" width="194" height="308"></a>
                            </div>
                        </div>
                    </div>
					<div class="main myorder">
					    <div class="title">
					        我的订单
					        <div class="screened-select">
					            <div class="submitDate">
					                <select name="" class="sele" id="selspan">
					                    <option value="0" selected="">近一个月的订单</option>
					                    <option value="1">三个月内订单</option>
					                    <option value="2">近2年订单</option>
					                    <option value="3">历史订单</option>
					                </select>
					            </div>
					            <div class="orderState">
					                <select name="" class="sele" id="selstate">
					                    <option value="" selected="">全部状态</option>
					                    <option value="Payment1">等待付款</option>
					                    <option value="1">审核中</option>
					                    <option value="2">已确认</option>
					                    <option value="32">等待发货</option>
					                    <option value="4">等待收货</option>
					                    <option value="64">已完成</option>
					                    <option value="16">已取消</option>
					                </select>
					            </div>
					        </div>
					    </div>
					    <div class="order-table j_Loading" id="allorderlst">
					        <div class="order-list-head clearfix">
					            <span class="w520">订单信息</span>
					            <span class="w140">实付金额</span>
					            <span class="w140">订单状态</span>
					            <span class="w140">操作</span>
					        </div>
					        <div class="order-list-body">
					            <ul class="j_allorderli"></ul>
					        </div>
					    </div>
					    <!--页码 开始-->
					    <div class="paging j_active" id="j_pages">
					    </div>
					    <!--页码 结束-->
					
					    <script id="allorderstpl" type="text/x-handlebars-template">
					        {{#data}}
					        <li>
					            <table class="order-list j_product">
					                <thead>
					                    <tr>
					                        <th colspan="4"><div><span>订单号：{{SerialNumber}}</span><span>提交时间：{{RecCreateTime}}</span></div></th>
					                    </tr>
					                </thead>
					                <tbody>
					                    <tr>
					                        <td width="520" class="all-goods">
					                            {{#OrderDetails}}
					                            {{#if CommodityImgUrl}}
					                            <a href="{{CommodityUrl}}" target="_blank"><img class="j_product_img" src="{{CommodityImgUrl}}"></a>
					                            {{/if}}
					                            {{/OrderDetails}}
					                            <div class="m"><div>共计{{CommodityCount}}件商品</div></div>
					                        </td>
					                        <td class="amount" width="140">￥{{TotalPrice}}</td>
					                        <td width="140">{{OrderStateDesc}}</td>
					                        <td width="140" class="operate">
					                            {{#equal OrderType 4}}
					                            {{#if IsWaitingPay}}
					                            {{#equal IsOnline 1}}
					                            <div>
					                                <a class="btn-org" href="http://trade.yiguo.com/Rush/{{OrderId}}">立即支付</a>
					                            </div>
					                            {{/equal}}
					                            <div>
					                                <a class="btn-org" href="http://trade.yiguo.com/ConfirmPay/{{OrderId}}">修改支付</a>
					                            </div>
					                            {{/if}}
					                            {{#equal OrderState 1}}
					                            
					                            <div>                                
					                                {{#equal OrderSource 107}}
					                                <a href="javascript:void(0)">福利礼包订单</a>
					                                {{else}}
					                                <a href="javascript:void(0)" class="cancel" data-oid="{{OrderId}}">取消</a>
					                                {{/equal}}
					                            </div>
					                            {{/equal}}
					                            <div>
					                                <a target="_blank" href="../Trade/OrderDetail?orderId={{OrderId}}">查看详情</a>
					                            </div>
					                            {{else}}
					                            {{#if IsWaitingPay}}
					                            {{#equal IsOnline 1}}
					                            <div>
					                                <a class="btn-org" href="http://trade.yiguo.com/Rush/{{OrderId}}">立即支付</a>
					                            </div>
					                            {{/equal}}
					                            <div>
					                                <a class="btn-org" href="http://trade.yiguo.com/ConfirmPay/{{OrderId}}">修改支付</a>
					                            </div>
					                            {{/if}}
					                            {{#equal OrderState 1}}
					                            
					                            <div>
					                                {{#equal OrderSource 107}}
					                                <a href="javascript:void(0)">福利礼包订单</a>
					                                {{else}}
					                                <a href="javascript:void(0)" class="cancel" data-oid="{{OrderId}}">取消</a>
					                                {{/equal}}
					                            </div>
					                            {{/equal}}
					                            <div>
					                                <a target="_blank" href="../Trade/OrderDetail?orderId={{OrderId}}">查看详情</a>
					                            </div>
					                            {{#equal OrderState 16}}
					                            <div>
					                                <a href="javascript:void(0)" class="btn-buy" onclick="G.app.cart.Facade.addToCart_Ids(this, '{{CommodityIdForCard}}')">再次购买</a>
					                            </div>
					                            {{/equal}}
					                            {{#equal OrderState 4}}
					                            <div>
					                                <a href="../Trade/OrderDetail?orderId={{OrderId}}#order-process">物流跟踪</a>
					                            </div>
					                            {{/equal}}
					                            {{#equal OrderState 8}}
					                            <div>
					                                <a href="javascript:void(0)" class="btn-buy" onclick="G.app.cart.Facade.addToCart_Ids(this, '{{CommodityIdForCard}}')">再次购买</a>
					                            </div>
					                            <div>
					                                <a href="../Trade/CommodityVote">评价商品</a>
					                            </div>
					                            {{/equal}}
					                            {{#equal OrderState 64}}
					                            <div>
					                                <a href="javascript:void(0)" class="btn-buy" onclick="G.app.cart.Facade.addToCart_Ids(this, '{{CommodityIdForCard}}')">再次购买</a>
					                            </div>
					                            <div>
					                                <a href="../Trade/CommodityVote">评价商品</a>
					                            </div>
					                            {{/equal}}
					                            {{/equal}}
					                        </td>
					                    </tr>
					                </tbody>
					            </table>
					        </li>
					        {{/data}}
					    </script>					    
					</div>
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
	        <!------- 页尾结束 ------->
    	</div>
 	</body>
</html>