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
		<title>注册</title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script type="text/javascript" src="js/jquery.validate.js" ></script>
		<script type="text/javascript" src="js/Reg.js" ></script>
		<script type="text/javascript" src="js/tab.js" ></script> 
		<script type="text/javascript" src="js/FormValidate.js" ></script>
		
		<link rel="stylesheet" href="css/regist.css" />
		<link rel="stylesheet" href="css/public.css" />
		<link rel="stylesheet" href="css/themes.css" />
		<style>
			label{
				color:red;
			}
		</style>
	</head>
	<body>
	<c:if test="${requestScope.rigistmsg !=null }">
		<script type="text/javascript">
			alert("${requestScope.rigistmsg}");
		</script>
	</c:if>
	<div class="popout protocol-poput">
	    <div class="popout-wrap">
	        <div class="popout-con">
	            <div class="title"  >鲜尚鲜服务协议<a class="close" href="javascript:"></a>
	            </div>
	            <div class="con">
	                <div class="register-protocol">
	
	                    <p>本协议详述您在www.yiguo.com（"网站"）使用我们的服务所须遵守的条款和条件。如您有任何疑问，请及时联系我们。</p>
	
	                    <p>您注册成为易果网用户前，必须仔细阅读本用户协议和隐私声明，一旦您注册成为了易果网用户即表示您已经阅读、同意并接受本用户协议和隐私声明中所含的所有条款和条件。如果我们对本声明进行了任何变更，我们会在易果网网站页面上发布有关变更事项的通知，所有协议内容在发布之日后自动生效。如您不同意该修订，您必须终止您与易果网的用户关系。</p>
	
	                    <h4>一、用户注册： </h4>
	
	                    <h5>1. 用户资格：</h5>
	
	                    <p>易果网用户必须是适用法律下能够签订具有法律约束力的合同的个人。在不限制前述规定的前提下，我们的服务不向18周岁以下或被临时或无限期中止的易果网用户提供。如您不合资格，请不要使用我们的服务。您的易果网帐户不得向其他方转让或出售。易果网保留根据其意愿中止或终止您的帐户的权利。</p>
	
	                    <h5>2. 资料填写：</h5>
	
	                    <p> 为确保交易的正常进行，用户必须向易果网提供真实、有效的个人资料，如个人资料有任何变动，必须及时通知易果网更新。<br>
	                        	易果用户同意接收来自易果网或者易果网合作伙伴发出的邮件、信息、短信。
	                    </p>
	
	                    <h4>二、 隐私：</h4>
	
	                    <p> 易果网设有适用于所有用户并纳入用户协议的隐私声明。您应当在注册时阅读并接受隐私声明以使用易果网网站，且您在作为易果网用户期间将继续受其规定（及易果网对隐私声明作出的任何修订）的约束。<br>
						（1）个人数据资料。包括个人识别资料：如姓名、性别、年龄、出生日期、身份证号码(或护照号码)、电话、通信地址、住址、电子邮件地址等情况；个人背景：职业、教育程度、收入状况、婚姻、家庭状况。在未经您同意及确认之前，易果网不会将您的资料用于其它目的。<br>
						（2）使用非个人信息。易果网将通过您的IP地址来收集非个人化的信息，包括您的浏览器性质、操作系统种类、给您提供接入服务的ISP的域名等，以优化在您计算机屏幕上显示的页面。通过收集上述信息，我们亦进行客流量统计，从而改进网站的管理和服务。<br>
						（3）个人数据安全。易果网采用安全性的服务器使用控制设备保护您的个人数据。<br>
						（4）个人数据披露和限制利用。当国家机构依照法定程序要求易果网披露个人资料时，易果网将根据执法单位的要求或为公共安全目的提供个人资料。在此情况下披露的任何内容，易果网不承担任何责任。易果网在符合下列条件时，对个人资料进行必要范围以外利用：已取得您的书面同意；为免除您在生命、身体或财产方面之急迫危险；为防止他人权益之重大危害；为增进公共利益，且无害于您的重大利益。
	                   </p>
	                    <h4>三、交易：</h4>
	                    <p>用户在易果网进行物品购买时必须遵守以下条款： <br>
	                    	（1）您应就您使用易果网的服务及对物品购买遵守所有适用的中国法律、法规、条例和地方性法律要求。您还必须确保您遵守本用户协议和隐私声明及纳入上述文件的所有其它条款和规则的所有规定。<br>
	                    	（2）如您在易果网购买物品，您有义务完成与易果网的交易，但法律或本用户协议禁止的交易除外。通过对一项物品的下订单，您同意受该物品描述所含的出售条件的约束，只要该等出售条件不违反本协议或不是非法的。<br>
	                    	（3）易果网网站上的广告，价目表和声明并不构成要约。在易果网向您发送电子邮件确认收到并接受了您的订单之前，您和易果网之间不存在合同关系。易果网有权在发现了易果网网站上显现的产品及订单的明显错误或缺货的情况下，单方面撤回该信息或撤销合同。易果网保留对产品订购的数量的限制权。在下订单的同时，您也同时承认了您已经达到购买这些产品的法定年龄，并将对您在订单中提供的所有信息的真实性负责。<br>
	                    	（4）产品价格和可获性都在网站上指明。这类信息将随时更改且不发任何通知。送货费将另外结算，费用根据您选择的送货时间不同而异。如果发生了意外情况，在确认了您的订单后，由于供应商提价，税额变化引起的价格变化，或是由于网站的错误等造成价格变化，易果网会通过email或电话通知您，在易果网没有取消订单的情况下，让您决定是否取消订单。
	                    </p>
	                    <h4>四、物品质量与售后服务</h4>
	                    <p>（1）详见售后服务</p>
	                    <h4>五、网站安全： </h4>
	                    <p> 您同意，未经易果网明示书面准许，您不会为了任何目的使用任何机器人、蜘蛛软件、刷屏软件或其他自动方式进入网站。此外，您同意您将不会：<br>
	                    	（1）进行任何对易果网网站造成或可能造成（按易果网自行酌情确定）不合理或不合比例的重大负荷的行为；<br>
	                    	（2）未经易果网事先明示书面准许，对网站的任何内容（除您的个人信息以外）制作拷贝、进行复制、修改、制作衍生作品、分发或公开展示；<br>
	                    	（3）干扰或试图干扰网站的正常工作或网站上进行的任何活动；<br>
	                    	（4）在网站中使用违反适用的法律法规下可能视为被禁止或可能被禁止的任何内容；<br>
	                    	（5）对网站使用包含可能破坏、改变、删除、不利影响、秘密截取、未经授权而接触或征用任何系统、数据或个人资料的任何病毒、特洛依木马、蠕虫、定时炸弹、删除蝇、复活节彩蛋、间谍软件或其他电脑程序。
	                    </p>
	                    <h4>六、知识产权声明：</h4>
	                    <p>易果网所提供的网络服务的相关著作权、专利权、商标、商业秘密及其它任何所有权或权利，均属易果网所有。非经易果网的同意，任何人或用户均不得擅自下载、复制、传输、改编、编辑，否则应负所有法律责任。易果网拥有向用户提供网络服务过程中所产生并储存于易果网服务器中的任何数据信息的所有权。</p>                   
	                    <h4>七、免责声明： </h4>
	                    <p>易果网有义务在技术上确保网站的正常运行，尽力避免服务中断或将中断时间限制在最短时间内，保证用户网上交易活动的顺利进行。但如因不可抗力或其他易果网无法控制的原因使易果网网站崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，易果网不承担责任；任何用户向易果网提供错误、不完整、不实信息等造成不能正常使用易果网服务或遭受任何其他损失，概与易果网无关</p>
	                    <h4>八、卡券购买章程：</h4>
	                    <h5>第一章 总则</h5>
	                    <p><strong>第一条</strong><br>
	                        	公司名称：上海易果电子商务有限公司<br>
	                       	 	营业执照注册号：310105000320742<br>
	                        	单位地址：上海市广顺路33号A（北）楼<br>
	                        	法定代表人：金光磊<br>
	                        	主营业务：为水果、食用农产品、蔬菜、酒类商品等提供网上销售，寄递业务等。<br>
	                        <strong>第二条</strong>   经上海市（长宁区）商务委员会备案登记（备案编号：     卡样标识：    ），核准发行单用途商业预付卡（以下简称预付卡）。<br>
	                        <strong>第三条</strong>   本公司根据《中华人民共和国消费者权益保护法》和商务部《单用途商业预付卡管理办法试行》等法律法规，开展包括预付卡发行、受理、服务、管理等内容的预付卡业务，并对此负有主体责任。<br>
	                        <strong>第四条</strong>   根据预付卡服务及管理要求，本公司与中信银行合作，共同构成工作系统，其业务在上海市（ 长宁区）商务主管部门指导监督下进行。<br>
	                        <strong>第五条</strong> 易果卡面向个人及单位发行，存储介质包括磁条卡、券以及其他电子存储方式。<br>
	                        <strong>第六条</strong> 发行机构、购买人及其他当事人均须遵守本章程。<br>
	                        <strong>第七条</strong> 本章程涉及的部分名词遵从如下定义：<br>
	                        “购买人”（也称持卡人）是指使用易果卡用于支付的单位和个人。
	                    </p>
	
	                    <h5>第二章 购买</h5>
	                    <p>
	                        <strong>第八条</strong> 凡自愿遵守本章程，具有完全民事行为能力的购买人，均可向发行机构购买易果卡。<br>
	                        <strong>第九条</strong> 购卡人如果使用现金购卡，发行机构当即为购卡人激活卡片；购卡人使用非现金购卡，发行机构在资金到账后为购卡人激活卡片。只有激活的卡片才能进行消费。
	                    </p>
	
	                    <h5>第三章 使用及有效期</h5>
	                    <p>
	                        <strong>第十条</strong> 持卡人可凭易果卡在易果网或通过指定电话上进行交易，使用范围以易果网上的最新信息为准，交易以联机或脱机方式完成，并即时扣除预付价值。<br>
	                        <strong>第十一条</strong> 凡使用密码进行的交易，均视为购买人本人所为；基于持卡人联机交易打印的凭证和/或凭易果卡磁条、芯片卡号或密码等电子数据而办理的各项交易所产生的信息记录之一或全部均属于该项交易的有效凭据。<br>
	                        <strong>第十二条</strong> 易果卡不可以兑换现金。<br>
	                        <strong>第十三条</strong> 非实名易果卡不记名、不挂失、不可再次充值；<br>
	                        <strong>第十四条</strong> 购买人的易果卡毁损无法交易的，应当凭有效身份证件、损毁的易果卡在发行机构指定场所办理更换。<br>
	                        <strong>第十五条</strong> 不记名易果卡有效期为3年。
	                    </p>
	
	                    <h5>第四章 收费</h5>
	
	                    <p>
	                        <strong>第十六条</strong> 如果因持卡人原因要求退卡，应交回原开据的发票，发行机构在扣除已消费金额后返还余额，并同时收取余额30%的手续费。<br>
	                        <strong>第十七条</strong> 如果因发行机构原因要赎回卡片，发行机构应扣除已消费金额后向持卡人返还余额，不收取任何费用。<br>
	                        <strong>第十八条</strong> 如果因政策原因发行机构需要清退，发行机构应扣除已消费金额后向持卡人返还余额，并可根据国家关政策法规之规定收取一定手续费。
	                    </p>
	
	                    <h5>第五章 当事人权利义务</h5>
	                    <p>
	                        <strong>第十九条</strong>发行机构的权利<br>
	                        	（1）发行机构，有权要求购买人按规定提供个人、单位的身份信息及证明文件。<br>
	                        	（2）对于违反本章程使用易果卡的，发行机构有权暂停该易果卡的使用。<br>
	                        	（3）发行机构为购买人提供的各种免费增值服务，发行机构有单方终止的权利，且无须事先征得购买人同意。<br>
	                       	 	（4）因供电、通讯、系统故障等原因导致持卡人使用易果卡受阻的，发行机构可以为协助持卡人解决问题提供必要的帮助，但不承担因此可能给持卡人造成的损失。<br>
	                        <strong>第二十条</strong> 发行机构的义务<br>
	                        	（1）发行机构应当书面或通过易果网等提供易果卡使用的有关资料，包括章程、领用合约、使用说明、收费项目及标准等。<br>
	                        	（2）发行机构应当按约定通过有关渠道为持卡人提供服务，包括但不限于电话服务。<br>
	                        	（3）发行机构应依法对购买人的信息承担保密义务，未经当事人同意不得向任何单位或个人披露，但法律、法规和规章另有规定，或购买人与发行机构另有约定的除外。<br>
	                        <strong>第二十一条</strong> 购买人的权利<br>
	                        	（1）购买人享有按规定使用易果卡的权利。<br>
	                        	（2）购买人有权知悉易果卡的功能、使用方法、收费项目及标准。<br>
	                        	（3）购买人对易果卡交易有疑问的，有权在规定时间内向发行机构提出查询或更正要求。<br>
	                        	（4）购买人对发行机构未按章程提供服务的行为，有权向发行机构或有关主管机关进行投诉。<br>
	                        <strong>第二十二条</strong> 购买人的义务<br>
	                        	（1）如购买易果卡或国家政策要求的其他情形，购买人应当向发行机构提供真实有效的身份信息及证明文件，不得冒用他人身份或使用伪造、变造身份证明文件。<br>
	                        	（2）购买人未妥善保管易果卡，导致易果卡遗失、灭失的，应当自行承担经济损失。<br>
	                        	（3）购买人对易果卡、密码或密钥保管不善，导致他人冒用易果卡造成的经济损失，应当自行承担。<br>
	                        	（4）购买人未按约定进行交易造成经济损失的，应当自行承担。<br>
	                    </p>
	
	                    <h5>第六章 附则</h5>
	                    <p>
	                        <strong>第二十三条</strong> 本章程未尽事宜按照国家有关法律、法规、规章及行业惯例执行，如发行机构与购买人另有约定的，遵从双方约定。<br>
	                        <strong>第二十四条</strong> 发行机构有权对本章程进行修订。<br>
	                        <strong>第二十五条</strong> 本章程自发布之日起正式实施。 <br>
	                    </p>
	
	                    <h4>九、其他：</h4>
	
	                    <p>本协议在所有方面均受中华人民共和国法律管辖。本网站所有用户均不可撤销地受易果网持有人所在地的中国上海市长宁区法院及上级法院的管辖。本协议的规定是可分割的，如本协议任何规定被裁定为无效或不可执行，该规定可被删除而其余条款应予以执行。您同意，在发生并购，本协议和所有纳入的协议可由易果网自行酌情决定向第三方自动转让。标题仅为参考之用，在任何方面均不界定、限制、解释或描述该条的范围或限度。</p>
	
	                </div>
	                <div class="btnbox"><a class="btn-gn" href="javascript:">同意并继续</a></div>
	            </div>
	        </div>
	    </div>
	    <div class="popout-bg">&nbsp;</div>
	</div>
	<div>
		<div class="header clearfix">
		    <div class="wrap">
		        <div class="logo">
		            <a href="/AProductMS/index.jsp"></a>
		            <a href="/AProductMS/index.jsp" class="l2 goTop"></a>
		            <span class="h-tit">注册</span>
		     </div>
		    </div>
		</div>
		<form action="/AProductMS/Reist.do" method="post" id="reg">  
			<div class="register">
		        <div class="wrap">
		            <div class="tabbable">
		                <!-- tabs -->
		                <ul class="nav-tabs">
		                    <li id="tab1li"><a href="#tab1" data-toggle="tab">手机注册</a></li>
		                    <li id="tab2li"><a href="#tab2" data-toggle="tab">邮箱注册</a></li>
		                </ul>
		                <div class="tab-content">
		                    <div class="tab-pane active clearfix" id="tab1">
		                        <div class="fl">
		                            <p>
		                                <span class="field-name">用户名</span>
		                                <input class="input input-phone"   name="username" placeholder="请输入您的用户名" type="text" value="" />
		                                <span></span>
		                            </p>
		                           <!--  <p>
										<select id="sel"> 
		    								<option value=4 selected>4</option>
										</select>
		                                <span class="field-name">验证码</span>
            							<input type="text" id="verficode_tab1" name="yzm" placeholder="验证码" class="input input-yzm" />
            							<img title="看不清？点击换一张。" style="position:absolute;left:430px;top:160px" src="/AProductMS/YZM" onclick="this.src='/AProductMS/YZM?rnd='+ Math.random();" >
            							  <span id="yy"></span>      							  
		                            </p> -->
		                           <%--  <c:if test="${sysYzm !=null }">
		                            	 <script type="text/javascript">
			                            	 $("#Phone_Mobile").change(function(){
			                            		 var yzm=$("#verficode_tab1").text();
													if(yzm!="${sysYzm}"){
														$("#yy").text("验证码输入有误!").css("color","red");
													}
			                            	 });
										</script>
		                            </c:if> --%>
		                            <p>
		                                <span class="field-name">手机号</span>
		                                <input class="input input-phone" id="Phone_Mobile"  name="Phone_Mobile" placeholder="请输入您的手机号" type="text" value="" />
		                                <span id="iscunz"></span>
		                            </p>
		                             <p>
		                                <span class="field-name">姓名</span>
		                                <input class="input input-phone"  name="name" placeholder="请输入您的姓名" type="text" value="" />
		                               
		                                <span></span>
		                            </p>
		                           
		                            <p>
		                                <span class="field-name">手机验证码</span>
		                                <input class="input input-yzm" id="Phone_VerifyCode" name="Phone_VerifyCode" placeholder="手机验证码" type="text"  />
		                                <input type="button" class="btn-yzm" id="Phone_SendCode" value="获取验证码" name="phones" onclick="settime(this)" />
		                                 <input type="hidden" id="yyy">
		                                <span id="shouyzm"></span>
		                               
		                            </p>
		                         	 <p>
		                                <span class="field-name">邮箱</span>
		                                <input class="input input-mail" id="Email" name="Email" placeholder="请输入您的邮箱" type="text" value="" />
		                                <span></span>
		                            </p>
		                         	  <!--  <p>
		                                <span class="field-name">邮寄地址</span>
		                                <input class="input input-phone"  name="address" placeholder="请输入您的邮寄地址" type="text" value="" />
		                                <span></span>
		                            </p> -->
		                                <p>
		                                <span class="field-name">性别</span>
		                       				         男<input  name="sex" type="radio" value="1" />女<input  name="sex" type="radio" value="0" />
		                                <span></span>
		                            </p>
		                            <p>
		                                <span class="field-name">设置密码</span>
		                                <input class="input input-key" id="Phone_Password" name="Phone_Password" placeholder="6-20位字母、符号或数字" type="password" />
		                                <span></span>
		                            </p>
		                            <p>
		                                <span class="field-name">确认密码</span>
		                                <input class="input input-key" id="Phone_ConfimPassword" name="Phone_ConfimPassword" placeholder="再次输入密码" type="password" />
		                                <span></span>
		                            </p>
		                          
		                            <p>
		                                <span class="field-name"></span><label><input type="checkbox" id="tab1chk" checked="checked" />我已阅读并同意<a href="javascript:void(0)" class="green btn-protocol">《易果服务协议》</a><span></span></label>
		
		                            </p>
		                            <span></span>
		                            <p><span class="field-name"></span><input type="submit" value="立即注册" class="btn-green-l"></p>
		                        </div>
		                    </div>
		                    <script type="text/javascript"> 
								$(function () {
									//表单的验证
									$('#reg').validate({
										rules : {
											username : {
												required : true,
												minlength : 2,
											}, 
											Phone_Mobile : {
												required : true,
												number:true,
												maxlength:11,
											},
											Email : {
												email : true,
											}, 
											Phone_Password : {
												required : true,
												minlength:6,
											}, 
											Phone_ConfimPassword : {
												required : true,
												equalTo : '#Phone_Password',
											},
											
										},
										messages : {
											username : {
												required : '用户名不得为空！',
												minlength :jQuery.format('不用名得小于{0}位！'),
											},
											Phone_Mobile : {
												required : '电话号码不得为空！',
												number :'电话号码格式有误!',
												maxlength:jQuery.format('不得小于{0}位！'),
											},
											Email : {
												email : '邮箱格式不正确!',
											}, 
											Phone_Password : {
												required : '密码不能为空!',
												minlength:jQuery.format('不得小于{0}位！'),
											}, 
											Phone_ConfimPassword : {
												required : '确认密码不能为空!',
												equalTo : '前后密码不一致,请从新输入!',
											},
											
										}
									});
									//判断电话号码是否存在 
									$("#Phone_Mobile").on("change",function(){
										$.ajax({
											type:"post",
											url:"IsCunZ.action",
											async:true,
											data:{
												phone:$("#Phone_Mobile").val(),
											},
											success:function(data,status,xhr){
												//alert(data);
												if(data>0){
													$("#iscunz").text("该用户已存在!").css("color","red");
												}
											}
										});
									});
									$("#Phone_SendCode").one("click",function(){
										//alert("234");
										 $.ajax({
											type:"post",
											url:"Note.dos",
											data:{
												'phone':$("#Phone_Mobile").val()
											},
											success:function(data,status,xhr){
												if(data!=""){
													$("#yyy").val(data);
													//alert(data);
												}												
											}
											
								        });    
									});
									 //获取手机验证码
								});
								$("#Phone_VerifyCode").one("change",function(){
									if($("#yyy").val()!=$("#Phone_VerifyCode").val()&&$("#Phone_VerifyCode").val()!=""){
										$("#shouyzm").text("手机验证码输入有误!").css("color","red");
									}
								});
								//手机验证码
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
									setTimeout(function() { settime(obj) }  ,1000);
								};
								
						</script> 
		                    <div class="tab-pane clearfix" id="tab2">
		                        <div class="fl">
		                         
		                            <p>
		                                <span class="field-name">邮箱</span>
		                                <input class="input input-mail" id="Email" name="Email" placeholder="请输入您的邮箱" type="text" value="" />
		                                <span></span>
		                            </p>
		                            <p>
		                                <span class="field-name">设置密码</span>
		                                <input class="input input-key" id="Email_Password" name="Email_Password" placeholder="6-20位字母、符号或数字" type="password" />
		                                <span></span>
		                            </p>
		                            <p>
		                                <span class="field-name">确认密码</span>
		                                <input class="input input-key" id="Email_ConfimPassword" name="Email_ConfimPassword" placeholder="再次输入密码" type="password" />
		                                <span></span>
		                            </p>
		                            <p>
		                                <span class="field-name">手机号</span>
		                                <input class="input input-phone" id="Email_Mobile" name="Email_Mobile" placeholder="请输入您的手机号" type="text" value="" />
		                                <span></span>
		                            </p>
		                            <p>
		                                <span class="field-name">手机验证码</span>
		                                <input class="input input-yzm" id="Email_VerifyCode" name="Email_VerifyCode" placeholder="手机验证码" type="text" value="" />
		                                <input type="button" class="btn-yzm" id="Phone_SendCode" value="获取验证码"  />
		                                <span id="shouyzm"></span>
		                            </p>
		                         
		                            <p>
		                                <span class="field-name"></span><label><input type="checkbox" id="tab2chk" checked="checked" />我已阅读并同意
		                                	<a href="javascript:void(0)" class="green btn-protocol">《鲜尚鲜服务协议》</a><span></span></label>
		                            </p>
		                            <p><span class="field-name"></span><input type="submit" value="立即注册" class="btn-green-l" id="EmailReg"></p>
		                        </div>
		                        
		                    </div> 
		                </div>
		                <div class="right">                    
		                  	  我已经注册，现在就 <a class="orange" href="Login.jsp">登录</a>		                    
		                </div>
		            </div>
		            
		        </div>
		    </div>
			<input id="HdAction" name="HdAction" type="hidden" value="" /><input Value="8f90b73f-04ba-4cbf-a4a9-80a5ae28bb28" id="UserID" name="UserID" type="hidden" value="" />
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
	
	</body>
</html>
