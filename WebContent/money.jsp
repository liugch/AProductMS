<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>结算</title>
	    <link href="/AProductMS/css/public.css" rel="stylesheet" type="text/css" />
	    <link href="/AProductMS/css/yg.css" rel="stylesheet" type="text/css" />
	    <link href="css/order.css" rel="stylesheet" type="text/css" />
	    <link href="css/themes.css" rel="stylesheet" type="text/css" />
	    <link href="css/jquery-ui.css" rel="stylesheet" type="text/css" />
	    <link href="css/msgbox.css" rel="stylesheet" type="text/css" />
   		<link rel="shortcut icon" href="img/tu.png">
	    <script src="js/jquery.js"></script>
	    <script src="js/topdsp.js"></script>
	    <script type="text/javascript" src="js/open-shut.js"></script>
	    <script type="text/javascript" src="js/tab.js"></script>
	    <script type="text/javascript" src="js/modal.js"></script>
	    <script type="text/javascript" src="js/order.js"></script>
	    <script type="text/javascript" src="js/global-v2.js"></script>
	    <script type="text/javascript" src="js/msgbox.js"></script>
	    <script type="text/javascript" src="js/jquery.validate.js"></script>
	    <script type="text/javascript" src="js/jquery.tmpl.js"></script>
	    <script type="text/javascript" src="js/jquery.jTemplates.js"></script>
	    <script type="text/javascript" src="js/orderCity.js"></script>
	    <script type="text/javascript" src="js/orderProcess.js"></script>
	    <script type="text/javascript" src="js/orderController.js"></script>
    </head>
    <body id="body">

    	<div class="w">
    		<div class="header clearfix">
		        <div class="wrap">
		            <div class="logo">
		                <a href="index.jsp" target="_blank"></a>               
		            </div>           
		            <div class="steps">
		                <ul>
		                    <li class="on"><b class="b1"></b><span>我的购物车</span></li>
		                    <li class="on"><i></i><b class="b2"></b><span>确认订单信息</span></li>
		                    <li><i></i><b class="b3"></b><span>成功提交订单</span></li>
		                </ul>
		            </div>
		        </div>
		    </div>
    		<div class="order">
	    <div class="wrap">
	        <h2>填写核对订单信息</h2>
	        <div class="order-alert">
	            <!--收货信息-->
	            <div id="order1" class="order-mode complete">
	                <h3><i class="o-i-receive"></i>收货信息</h3>
	                <div class="o-receive">
	                    <div>
	                        <ul id="receive1">
	                        	<li><label class="selected"><input type="radio" name="receive">
	                        		<strong id="name">&nbsp;</strong>
	                        		<span id="add">广东</span> 
	                        		<span id="city">珠海</span>
	                        		<span id="qu">斗门区</span>
	                        		<span id="lu">&nbsp;</span>
	                        		<span id="phone">&nbsp;</span>
	                        		
	                        		<a href="###" class="btn-setdefault">设为默认地址</a>
	                        		<a data-toggle="modal" href="#myModal1" data-backdrop="static" class="btn-edit">编辑</a>
	                        		<a href="###" class="btn-del">删除</a><b></b></label>                        		
	                        	</li>
	                        </ul>                       
	                        <a id="receive3" href="###" class="link oReceiveClose" style="display:none;">展开其他地址</a>
	                        <a data-toggle="modal" href="#myModal1" data-backdrop="static" class="link" id="theAddress" style="cursor:pointer;"><i></i>使用新地址</a>
	                    </div>
	                    
						<div id="customDelivery" style="display:none">
						    <a class="link selectedConsignee" style="cursor:pointer; display:none">选择配送地址</a>
						    <div class="pickup">
						        <h4>到自提点自取</h4>
						        <ul class="pickup-addr"></ul>
						        <div class="consignee-info">
						            <span>提货人：<input id="" type="text" class="input" name="Custom-ConsigneeName"></span>
						            <span>电话：<input id="" type="text" class="input" name="Custom-ConsigneePhone"></span>
						        </div>
						        <div class="pickup-agree"><input type="checkbox" checked="">
						        	我已阅读并同意
						        	<a data-toggle="modal" data-backdrop="static" href="#myModal3" class="selected" style="text-decoration: underline;">《易果生鲜自提服务协议》</a>
						        </div>
						    </div>
						</div>
	                </div>
	            </div>
	            <!--配送信息-->
	            <div id="order2" class="order-mode complete">
	                <h3><i class="o-i-delivery"></i>配送信息</h3>
	                <div class="o-delivery">
	                	<table class="table">
		                	<thead> 
		                		<tr>                 
		                			<th>非收货时间</th>                 
		                			<th>运费</th>                 
		                			<th>配送方式</th>                 
		                			<th>备注</th>             
		                		</tr>         
		                	</thead>         
		                	<tbody>             
		                		<tr>                 
		                			<td>                     
		                				<a data-toggle="modal" href="#myModal2" data-backdrop="static" class="selected" id="theDeliveryDate">星期一 9-12 全天09:00-21:00</a>                     
		                				<span id="theSelectedDeliveryDate" style="display:none;">2016-08-17</span>                     
		                				<span id="theSelectedPeriod" style="display:none;">0</span>                     
		                				<span id="theDeliveryMethod" style="display:none;">合作方快递</span>                 
		                			</td>                 
		                			<td><span id="serverFreight">包邮</span>&nbsp;</td>                 
		                			<td>合作方快递</td>                 
		                			<td>可配送至全国大部分区域</td>             
		                		</tr>         
		                	</tbody>     
	                	</table>
	                </div>
	            </div>
	     
	            <!--发票信息-->
	            <div id="order4" class="order-mode">
	                <h3><i class="o-i-invoice"></i>发票信息</h3>
	                <div class="o-invoice">
						<label><input type="checkbox" style="cursor:pointer;">需要发票</label>
						 <!--<div class="o-invoice-item">
						    <div class="tab j_style">发票类型：<label class="selected" data-style="1">电子发票</label><label data-style="0">纸质发票</label>
						        <div class="promptbox">
						            <span></span>
						            <div class="dorpdown" style="display: none;">
						                <i></i>
						                1.&nbsp;发票金额为订单实际付款金额，不含销售折扣、优惠券和账户余额等使用预付卡支付的金额；<br>
						                2.&nbsp;电子发票：<br>
						                （1）电子发票是税局认可的有效收付款凭证，其法律效力、基本用途及使用规定同纸质发票，如需纸质发票可自行下载打印；<br>
						                （2）如购买的商品暂不支持电子发票开具，系统将自动更换为纸质发票。
						            </div>
						        </div>
						    </div> 
						    <div class="tab j_content" style="display: none;">发票内容：<label>食品</label><label class="selected">水果</label></div>
						    <p><a class="link add-info" style="cursor:pointer;"><i></i>新增发票信息</a></p>
						    <div class="o-invoice-info">
						        <p>发票类型：普通发票</p>
						        <p>
						            发票抬头：
						            <label>
						                <input type="radio" name="theUnitName" id="one" checked="">个人
						            </label>
						            <label><input type="radio" name="theUnitName" id="some">单位</label>
						            <input style="display:none;" id="theInvoiceTitle" type="text" placeholder="请填写单位名称">
						        </p>
						        <p><a id="theInvoiceSave" href="###" class="btn-save">保存</a><a id="theInvoiceCancel" href="javascript:void(0);" class="btn-cancel">取消</a></p>
						    </div>
						    <div class="tab"></div>
						    <div class="tab"><p><span>* 注：如需开具明细发票请取消选中“需要发票”并致电400-000-7788转1号键联系客服。</span></p></div>
						</div>
	                </div>-->
	            </div>
	            <!--商品信息-->
	            <div id="order5" class="order-mode">
	                <h3>
	                    <i class="o-i-commodity"></i>商品信息
	                    <a class="backcart" href="shopping_cart.jsp">返回购物车&gt;&gt;</a>
	                </h3>
	                <div class="o-commodity">
						<table class="table">
						    <thead>
						        <tr>
						            <th width="590">商品名称</th>
						            <th>单价</th>
						            <th>数量</th>
						            <th>规格</th>
						            <th>金额小计</th>
						        </tr>
						    </thead>
						    <tbody >
					            <tr>
					                <td  ><span style="width:100px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					                <a  target="_blank" href="#">${sessionScope.names}</a>
					                    <i class="i-butui" title="不支持七天无理由退换货"></i>
					                </td>
					                <td>￥${ sessionScope.price}</td>
					                <td>${sessionScope.amount }</td>
					                <td>${sessionScope.guige }</td>
					                <td>￥${ sessionScope.price}</td>
					            </tr>
						    </tbody>
						</table>
						<div class="mt10 clearfix">
						    <div class="fl">补充说明：<input id="txtWebRemark" type="text" placeholder="选填，补填要求"></div>
						    <div class="fr"><i class="i-butui"></i>不支持七天无理由退换货</div>
						</div>  
	                </div>
	            </div>
	            
	            <div id="orderPlus" class="order-mode-last">
	                <h3><i class="o-i-order"></i>订货人信息</h3>
	                <div class="o-order">
	                    <div>订货人姓名：<input id="OrderUserName" type="text" class="input" placeholder="非必填" maxlength="20"></div>
	                    <div>订货人手机：<input id="OrderUserMobile" type="text" class="input" placeholder="非必填" maxlength="15"></div>
	                </div>
	            </div>
	            <div id="order7" class="statistic">
	                <p class="right">商品金额：￥<span>${sessionScope.price}</span></p>
	                <p class="right">运费：￥<span>0.00</span></p>
	                <p class="right">优惠金额：￥-<span>0.00</span></p>
	            </div>
	            <div class="settle-space"></div>
	            <div id="order71" class="cart-footer clearfix settle settle-fixed">
	                <div class="wrap">
	                    <div class="right">
	                        <span class="none">运费：<em>￥</em><em>0.00</em>元</span>
	                        <span class="none">商品金额：<em>￥</em><em>${sessionScope.price}</em>元</span>
	                        <span class="fs14">应付款：<em>￥</em><em> ${ sessionScope.price}  </em></span>
	                        <a href="javascript:;" id="btnn" class="btn" style="background-color: rgb(255, 83, 23);" >提交订单</a>
	                        <script>
	                        $(function(){
	                        	                  	
	                        });
                        		/* function sub(){
	                        		window.open("https://one.teegon.com/buy/createorder?id=f9b949d125d3d476cb78fb02c9a0a9a7");
	                       		 }
	                        	 */
	                        </script>
	                    </div>
	                </div>
	            </div>
	            <div id="order72" style="display:none;">
	                <input type="hidden"  name="payAmount" value="<%-- ${ sessionScope.price} 支付金额过大--%>0.01"><!-- 支付金额 -->
	                <input type="hidden"  name="orderNumber" value="4321321"><!-- 订单支付 -->					
	                <input type="hidden">
	                <input type="hidden" >
	                <input type="hidden" >
	                <input type="hidden" >
	              
	      
	             
	            </div>
	           
	        </div>
	    </div>
	</div>
	<!-- 新添加地址部分 -->  -->
	<div class="modal fade in" id="myModal1" style="display: none;">
	    <div class="modal-header">
	        <a class="close" data-dismiss="modal">×</a>
	        <h3><i class="i-newaddr"></i>使用新地址</h3>
	    </div> 
	    <form name="frm">
	    <div class="modal-body">
	        <div id="theAddressForm" name="theAddressForm" method="post" novalidate="novalidate">
	            <div class="control-group">
	                <label class="control-label" for="textarea">收货人姓名：</label>
	                <div class="controls">
	                    <input type="text"  id="ConsigneeName"   class="input-l" name="ConsigneeName" >
	                </div>
	            </div>
	            <div class="control-group">
	                <label class="control-label" for="textarea">手机号码：</label>
	                <div class="controls">
	                <input id="ConsigneeMobile" name="ConsigneeMobile" type="text" class="input-l" placeholder=""></div>
	            </div>
	            <div class="control-group">
	                <label class="control-label" for="textarea">收货地址：</label>
	                <div class="controls">
	                    <select id="ProvinceId" name="ProvinceId"><option value="">选择</option><option value="312d0556-0671-4f2e-8bac-7b8873b5a03a">上海</option><option value="98373b1b-201c-4753-b540-14bb1cd6564e">上海(郊区)</option><option value="eabbe02f-59e0-46e6-90e7-cd8a89dbb98f">北京</option><option value="15b6c4e6-69f2-4001-a631-62c0c36102b1">北京(郊区)</option><option value="93570b8c-0a0a-4818-8317-75a0d14093a5">天津</option><option value="de66faa1-cb91-4af7-a6c9-3269f9f9e169">浙江</option><option value="75ff9dce-aba7-4dce-a40d-d70ed77a1d22">江苏</option><option value="da114907-9426-421c-a710-9d319e6a67fd">河北</option><option value="gd">广东</option><option value="69f262ff-cf4f-4920-a10a-7880e27dd440">甘肃</option><option value="ebe771a5-36fb-4116-a98f-7afb5290b334">贵州</option><option value="8253d296-8c94-4935-87f6-8a61cd8a9cf3">河南</option><option value="e615d764-bdd3-4758-913a-59ed8503a5de">广西</option><option value="a6804a4e-e46c-4121-b964-fcf80db3bf74">湖北</option><option value="1b1bd95f-7fd4-4f6e-9e3a-340b1f6c3cc5">海南</option><option value="64c4d7d4-e511-425e-ad09-03defd808faf">湖南</option><option value="1935e31f-5600-48cd-9550-054a0a7c44ce">黑龙江</option><option value="55584cd4-e249-4cd8-9895-462e637e463e">江西</option><option value="7b98f60b-bf6b-414a-a1a4-fec9ef121b5f">吉林</option><option value="a3fd1ee3-6ac7-4161-9393-565fc875aa2b">福建</option><option value="322e0992-f6ea-426d-9794-a5fac5e91adf">辽宁</option><option value="76ba776c-a7df-44f8-8932-4a5a95eef734">宁夏</option><option value="78e4e930-5c94-4cd8-b3b9-1cbc0963efa6">内蒙古</option><option value="8ce3d107-f0d0-42c3-bbcd-a03463fbe1f3">青海</option><option value="09806a8f-dee4-46f6-9682-af8fb426d0e7">四川</option><option value="8dce2e33-92de-4e38-86b8-be3e4165cca9">陕西</option><option value="8ba9f215-379f-451d-893b-0ac3fb6b1f52">山东</option><option value="e1071724-bdbf-4947-becd-64621f189676">山西</option><option value="62024572-439c-46e2-816e-37f52534ef2d">安徽</option><option value="693c737b-d014-4572-8c80-17ecf4bafd98">新疆</option><option value="b9c713c2-aa5f-4aa3-9d26-a3494c95e739">西藏</option><option value="7d975a49-01ff-4a74-accf-e0ef2f5bddac">云南</option><option value="7c046210-81f3-4638-a09b-6b2e8ecbe957">重庆</option></select>
	                    <select id="AreaId" name="AreaId"><option value="">选择</option><option value="2f58ebeb-e46d-467c-941c-3ced514bd50b">揭阳市</option><option value="afc79d4e-e1af-4a4f-ad63-2a0eb069125e">云浮市</option><option value="a6fc470b-82ff-4b86-87f6-992cf9e0a2c2">汕尾市</option><option value="63179983-02f7-44a3-a69f-0f9589e44a35">惠州市</option><option value="6a637459-eca9-46b8-964d-35c11cad039a">佛山市</option><option value="9d6d831e-5036-4714-aa15-398b89f07189">梅州市</option><option value="20c2f64b-c91f-4095-8fb4-3f1fbbb55f82">东莞市</option><option value="b9d27a3f-ddba-4e4d-8577-652b96fcf6a8">湛江市</option><option value="3f4f22dc-7a00-460c-82c1-678df82258bf">汕头市</option><option value="f7330b43-1177-4686-9a04-9f5176d046e3">清远市</option><option value="29bd9fa7-274c-4257-85e2-a22e2cd1d2ce">中山市</option><option value="43ba3517-6aa8-423b-9f02-a3b0fd681740">江门市</option><option value="7ad3a2db-ec28-4eca-bfe9-d317cc468a85">茂名市</option><option value="c8dbd17f-a8e0-43b1-b9ce-de1efdc2670e">广州市</option><option value="4dff6fcd-b320-4bc2-a6f1-eb2f51ce4904">潮州市</option><option value="c84a6dea-7701-4433-8092-ee3fab7360ec">河源市</option><option value="0718b3bf-b99b-4aa4-97bd-4a4da0b92464">珠海市</option><option value="8ce475d7-fa62-456e-a190-58e2589dced2">韶关市</option><option value="49c234d6-d1c7-4b9d-be06-e2ebd08e4618">肇庆市</option><option value="0540d74e-0ffb-4a3a-ab79-ec590dd49947">深圳市</option><option value="0b5447d8-dc18-43eb-849d-96f362588d13">阳江市</option></select>
	                    <select id="DistrictId" name="DistrictId"><option value="">选择</option><option value="0adfa021-8a23-43dd-8b08-3918b83dd5e5">金湾区</option><option value="059755f8-2d5f-4471-9df8-13fcd49cabd5">香洲区</option><option value="dbf105c7-4c58-45b3-9e8e-d6d9b5f1278f">斗门区</option></select>
	                    <input type="hidden" id="IsOuterLoop" name="IsOuterLoop">
	                </div>
	            </div>
	            <div class="control-group">
	                <label class="control-label" for="textarea">详细地址：</label>
	                <div class="controls"><input id="ConsigneeAddress" name="ConsigneeAddress" type="text" class="input-xl"></div>
	            </div>
	            <div class="control-group">
	                <label class="control-label" for="textarea">固定电话：</label>
	                <div class="controls">
	                    <input id="ConsigneeTel" name="ConsigneeTel" type="text" class="input-l" placeholder="">
	                </div>
	            </div>
	            <div class="control-group">
	                <label class="control-label" for="textarea">邮政编码：</label>
	                <div class="controls"><input id="PostCode" name="PostCode" type="text" class="input-m"></div>
	            </div>
	         
	            <div class="control-group">
	                <label class="control-label" for="textarea"></label>
	                <div class="controls">
	                    <input id="btnSaveConsignee" type="button" class="btn-save close"  data-dismiss="modal"  value="保存" style="cursor:pointer;">
	                </div>
	            </div>
	        </div>     
	    </div>
	    </form>  
	    <!--更改 是否已经付款               添加收货的地址 以及备注 -->
	   <script type="text/javascript">
		   	$(function(){
		   		$("#btnn").on("click",function(){
	        		$.ajax({
	        			"url":"/AProductMS/paybegin.action",	
	            		"type":"post",
	            		/*oId int primary key identity(1,1),		--订单编号
	            		oNo int,								--订单序号
	            		userID int foreign key references  [user](userID),	--用户编号
	            		submitTime datetime ,		--提交订单时间
	            		outTime datetime,			--发货时间
	            		totalPrice float,			--总金额
	            		remark varchar(200),		--买家备注
	            		IPAddress varchar(200),		--买家地址
	            		isPayoff int,				--买家是否付款
	            		isOut int					--是否发货 */
	            		 "data":{
	            			 'IPAddress':$("#name").text()+$("#add").text()+$("#city").text()+$("#qu").text()+$("#lu").text(),
	            			 'remark':$("#txtWebRemark").val(),
	            		 },                  	
	            		success:function(data,status,xhr){
	            		//	alert(data);
	            			window.open(data);
	            		}	            		
	            	});
	        	});	      
		   	})
	   </script>
	</div>

	
	
	<div class="modal fade in" id="myModal2" style="display: none;">
	    <div class="modal-header">
	        <a id="theTimecolse" class="close" data-dismiss="modal">×</a>
	        <h3><i class="i-slctime"></i>选择非收货时间</h3>
	    </div>
	    <div class="modal-body">
	        <table class="table">
	            <thead>
	                <tr>
	                    <th class="left">时间段</th>                  
	                	<th>星期一</th>
	                	<th>星期二</th>
	                	<th>星期三</th>
	                	<th>星期四</th>
	                	<th>星期五</th>
	                	<th>星期六</th>
	                	<th>星期日</th>
	                	<th>周末</th>
	                </tr>
	            </thead>
	            <tbody>
	                <tr>
	                    <td>全天09:00-21:00</td>   
	                	<td id="a0"><a href="###" id="b0">可选</a><b></b></td>
	                	<td id="a1"><a href="###" id="b1">可选</a></td>
	                	<td id="a2"><a href="###" id="b2">可选</a></td>
	                	<td id="a3"><a href="###" id="b3">可选</a></td>
	                	<td id="a4"><a href="###" id="b4">可选</a></td>
	                	<td id="a5"><a href="###" id="b5">可选</a></td>
	                	<td id="a6"><a href="###" id="b6">可选</a></td>
	                	<td id="a7"><a href="###" id="b7">可选</a></td>
	                </tr>
	               
	            </tbody>
	        </table>
	        
	        <p>若由于我方原因未能及时送到，将免除此单运费</p>
	        <span class="selectCustomDeliveryTips" style="display:none;margin-top: 20px;line-height: 40px;color: #777;">因生鲜产品特殊性，请您在选定日期的工作时间内到您选择的自提点提货，以免逾期影响商品品质或口感。</span>
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
 	<script>
 		$("#btnSaveConsignee").on("click",function(){	
 			var savName=$("#name").text($("#ConsigneeName").val());
 			var savPhone=$("#phone").text($("#ConsigneeMobile").val());
 			var savXiangXi=$("#lu").text($("#ConsigneeAddress").val());
 			
 		});
 		$("#b0").on("click",function(){
 			$("#a0").attr("class","selected");
 			$("#b0").text("已选");
 			$("#theDeliveryDate").text("星期一 全天09:00-21:00");
 			
 			$("#a1").removeClass("selected");
 			$("#b1").text("可选");
 			
 			$("#a2").removeClass("selected");
 			$("#b2").text("可选");
 			
 			$("#a3").removeClass("selected");
 			$("#b3").text("可选");
 			
 			$("#a4").removeClass("selected");
 			$("#b4").text("可选");
 			
 			$("#a5").removeClass("selected");
 			$("#b5").text("可选");
 			
 			$("#a6").removeClass("selected");
 			$("#b6").text("可选");
 			
 			$("#a7").removeClass("selected");
 			$("#b7").text("可选");
 			
 		});
 		
 		$("#b1").on("click",function(){
 			$("#a0").removeClass("selected");
 			$("#b0").text("可选");
 			
 			
 			$("#a1").attr("class","selected");
 			$("#b1").text("已选");
 			$("#theDeliveryDate").text("星期二  全天09:00-21:00");
 			
 			$("#a2").removeClass("selected");
 			$("#b2").text("可选");
 			
 			$("#a3").removeClass("selected");
 			$("#b3").text("可选");
 			
 			$("#a4").removeClass("selected");
 			$("#b4").text("可选");
 			
 			$("#a5").removeClass("selected");
 			$("#b5").text("可选");
 			
 			$("#a6").removeClass("selected");
 			$("#b6").text("可选");
 			
 			$("#a7").removeClass("selected");
 			$("#b7").text("可选");
 			
 		});
 		$("#b2").on("click",function(){

 			$("#a0").removeClass("selected");
 			$("#b0").text("可选");
 			
 			
 			$("#a1").removeClass("selected");
 			$("#b1").text("可选");
 			
 			
 			$("#a2").attr("class","selected");
 			$("#b2").text("已选");
 			$("#theDeliveryDate").text("星期三  全天09:00-21:00");
 			
 			$("#a3").removeClass("selected");
 			$("#b3").text("可选");
 			
 			$("#a4").removeClass("selected");
 			$("#b4").text("可选");
 			
 			$("#a5").removeClass("selected");
 			$("#b5").text("可选");
 			
 			$("#a6").removeClass("selected");
 			$("#b6").text("可选");
 			
 			$("#a7").removeClass("selected");
 			$("#b7").text("可选");
 			
 		});
 		
 		$("#b3").on("click",function(){

 			$("#a0").removeClass("selected");
 			$("#b0").text("可选");
 			
 			
 			$("#a1").removeClass("selected");
 			$("#b1").text("可选");
 			
 			
 			$("#a2").removeClass("selected");
 			$("#b2").text("可选");
 			
 			
 			$("#a3").attr("class","selected");
 			$("#b3").text("已选");
 			$("#theDeliveryDate").text("星期四   全天09:00-21:00");
 			
 			$("#a4").removeClass("selected");
 			$("#b4").text("可选");
 			
 			$("#a5").removeClass("selected");
 			$("#b5").text("可选");
 			
 			$("#a6").removeClass("selected");
 			$("#b6").text("可选");
 			
 			$("#a7").removeClass("selected");
 			$("#b7").text("可选");
 			
 		});
 		
 		$("#b4").on("click",function(){

 			$("#a0").removeClass("selected");
 			$("#b0").text("可选");
 			
 			
 			$("#a1").removeClass("selected");
 			$("#b1").text("可选");
 			
 			
 			$("#a2").removeClass("selected");
 			$("#b2").text("可选");
 			
 			
 			$("#a3").removeClass("selected");
 			$("#b3").text("可选");
 			
 			
 			$("#a4").attr("class","selected");
 			$("#b4").text("已选");
 			$("#theDeliveryDate").text("星期五  全天09:00-21:00");
 			
 			$("#a5").removeClass("selected");
 			$("#b5").text("可选");
 			
 			$("#a6").removeClass("selected");
 			$("#b6").text("可选");
 			
 			$("#a7").removeClass("selected");
 			$("#b7").text("可选");
 			
 		});
 		

 		$("#b5").on("click",function(){

 			$("#a0").removeClass("selected");
 			$("#b0").text("可选");
 			
 			
 			$("#a1").removeClass("selected");
 			$("#b1").text("可选");
 			
 			
 			$("#a2").removeClass("selected");
 			$("#b2").text("可选");
 			
 			
 			$("#a3").removeClass("selected");
 			$("#b3").text("可选");
 			
 			
 			$("#a4").removeClass("selected");
 			$("#b4").text("可选");
 		
 			
 			$("#a5").attr("class","selected");
 			$("#b5").text("已选");
 			$("#theDeliveryDate").text("星期六   全天09:00-21:00");
 			
 			$("#a6").removeClass("selected");
 			$("#b6").text("可选");
 			
 			$("#a7").removeClass("selected");
 			$("#b7").text("可选");
 			
 		});
 		
 		$("#b6").on("click",function(){

 			$("#a0").removeClass("selected");
 			$("#b0").text("可选");
 			
 			
 			$("#a1").removeClass("selected");
 			$("#b1").text("可选");
 			
 			
 			$("#a2").removeClass("selected");
 			$("#b2").text("可选");
 			
 			
 			$("#a3").removeClass("selected");
 			$("#b3").text("可选");
 			
 			
 			$("#a4").removeClass("selected");
 			$("#b4").text("可选");
 		
 			
 			$("#a5").removeClass("selected");
 			$("#b5").text("可选");
 			
 			
 			$("#a6").attr("class","selected");
 			$("#b6").text("已选");
 			$("#theDeliveryDate").text("星期日   全天09:00-21:00");
 			
 			$("#a7").removeClass("selected");
 			$("#b7").text("可选");
 			
 		});
 		
 		$("#b7").on("click",function(){

 			$("#a0").removeClass("selected");
 			$("#b0").text("可选");
 			
 			
 			$("#a1").removeClass("selected");
 			$("#b1").text("可选");
 			
 			
 			$("#a2").removeClass("selected");
 			$("#b2").text("可选");
 			
 			
 			$("#a3").removeClass("selected");
 			$("#b3").text("可选");
 			
 			
 			$("#a4").removeClass("selected");
 			$("#b4").text("可选");
 		
 			
 			$("#a5").removeClass("selected");
 			$("#b5").text("可选");
 			
 			
 			$("#a6").removeClass("selected");
 			$("#b6").text("可选");
 		
 			
 			$("#a7").attr("class","selected");
 			$("#b7").text("已选");
 			$("#theDeliveryDate").text("周末两天  09:00-21:00");
 			
 		});
 		
 		
 	</script>
</html>