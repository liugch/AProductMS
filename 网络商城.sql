use master
if DB_ID('pdb') is not null
	drop database pdb
create database pdb
use pdb
if object_id('admins') is not null
	 drop table admins
if object_id('pType') is not null
	 drop table pType
if object_id('productInfo') is not null
	 drop table productInfo
if object_id('pictureList') is not null
	 drop table pictureList
if object_id('pictureList2') is not null
	 drop table pictureList2	 
if object_id('[user]') is not null
	 drop table [user]
if object_id('orderForm') is not null
	 drop table orderForm
if object_id('orderList') is not null
	 drop table orderList
if object_id('comment') is not null
	 drop table comment
if object_id('reply') is not null
	 drop table reply
if object_id('shopping_cart') is not null
	 drop table shopping_cart
--管理员表
go
create table admins(
	adminId int primary key identity(1,1),	--管理员编号
	adminName varchar(50),					--管理员姓名
	adminPassword varchar(50)				--管理员密码
)
--商品类型表
go
create table pType(
	pTypeId int primary key identity(1,1),	--商品种类
	pTypeName varchar(200)					--商品种类名称
)

insert into pType(pTypeName) values
	('进口水果'),('国产水果'),('精选肉类'),('禽类蛋品'),('海鲜水产'),
	('乳品糕点'),('新鲜蔬菜'),('方便速食'),('粮油杂货'),('饮料酒水'),('礼品礼券')
select pTypeId,pTypeName from pType

--商品信息表
go
create table productInfo(
	pid int primary key identity(1,1),					--商品编号
	pName varchar(200),									 --商品名称
	pTypeInfoId int foreign key references pType(pTypeId),--商品种类
	pDesc varchar(600),									 --商品描述
	pPrice float,										--商品价格
	amount int,											--商品库存数量
	guiGe varchar(50),									--商品规格
	pUptime datetime,									--商品上架时间
	pPicture varchar(100)								--商品图片
)
go
--进口水果 1-8 一月
insert into productInfo values
	('泰国金枕头榴莲9-10斤（约1-2个)',1,null,149.00,100,'9-10斤/份','2015-1-1','/AProductMS/images/9288693810339996_500.jpg'),
	('泰国山竹1kg',1,'产区鲜摘直供；果味酸甜多汁，轻抿即化',58.00,100,'1kg/组','2015-1-2','/AProductMS/images/9288691846357043_500.jpg'),
	('常瀛进口精选香蕉约1.5kg',1,null,29.00 ,100,'约1.5kg/份','2015-1-3','/AProductMS/images/9288695451689192_500.jpg'),
	('Zespri佳沛新西兰绿奇异果3.3kg原箱(22-25个)',1,null,149.00 ,100,'3.3kg/箱','2015-1-4','/AProductMS/images/9288695212712157_500.jpg'),
	('越南红心火龙果2.5kg（中果）约350g/个',1,'原产地直供，富含花青素，清甜多汁的减负鲜果',69.00 ,100,'1kg/份','2015-1-5','/AProductMS/images/9288696267317513_500.jpg'),
	('智利青苹果12个约150g/个',1,null,49.00,100,'12个/份','2015-1-6','/AProductMS/images/9288695257833697_500.jpg'),
	('加拿大超大樱桃500g果径30mm以上',1,null,88.00,100,'500g/份','2015-1-7','/AProductMS/images/9288696302674186_500.jpg'),
	('泰国丑柚1个约700g/个',1,null,39.00,100,'1个/份','2015-1-8','/AProductMS/images/9288695723466995_500.jpg')
--国产水果 9-12 二月
insert into productInfo values
	('陕西冬枣500g',2,null,66.00,100,'500g/份','2015-1-1','/AProductMS/images/9288695898448117_500.jpg'),
	('云南蒙自精品石榴8个325g以上/个',2,null,70.00,100,'8个/份','2015-1-2','/AProductMS/images/9288696329347339_500.jpg'),
	('山东蓬莱精品红富士5kg果径80-85mm',2,null,109.00,100,'5kg/箱','2015-1-3','/AProductMS/images/151010135435159_61909_500.jpg'),
	('陕西精品红富士2.5kg果径80-85mm',2,null,66.00,100,'2.5kg/箱','2015-1-4','/AProductMS/images/151010145605426_10498_500.jpg')
--方便速食	13-16 三月
insert into productInfo values
	('优形蒸煮鸡胸肉丁(男神款)150g',8,null,9.9,100,'150g/盒','2015-1-1','/AProductMS/images/9288694497419450_500.jpg'),
	('希波鸡肉串480g',8,null,46.90,100,'1袋','2015-1-2','/AProductMS/images/9288693186928767_500.jpg'),
	('五芳英雄礼品粽1.2kg',8,null,199.00,100,'1.2kg/盒','2015-1-3','/AProductMS/images/9288694177210543_500.jpg'),
	('龙凤香菇素菜包420g',8,null,12.80,100,'420g/包','2015-1-4','/AProductMS/images/151010145934748_425720_500.jpg')		
--饮料酒水17-20 五月
insert into productInfo values
	('莱宝精酿鲜啤酒旗装皮尔森黄啤650ml*6',10,'EURO2015 激情“旗”呐喊 国旗定制装',238.00 ,100,'650ml*6/箱','2015-1-1','/AProductMS/images/9288696268071177_500.jpg'),
	('斐素100%凤梨苹果混合果汁310ml',10,null,17.8,100,'310ml/瓶','2015-1-3','/AProductMS/images/9288695223951582_500.jpg'),
	('机灵麦片蔓越莓黑芝麻味320g',10,null,35.00 ,100,'320/袋','2015-1-4','/AProductMS/images/9288693446582414_500.jpg'),
	('斐素100%苹果小麦草柠檬混合果蔬汁310ml',10,null,17.80 ,100,'310ml/瓶','2015-1-5','/AProductMS/images/9288695224180958_500.jpg')
--海鲜水产	20-21 四月
insert into productInfo values
	('大湖有机冰川龙斑鱼500g',5,null,66.00 ,100,'500g/包','2015-1-1','/AProductMS/images/9288693207441537_500.jpg'),
	('大湖野生有机冰川小阿刁鱼280g',5,null,22.00 ,100,'280g/包','2015-1-2','/AProductMS/images/9288693207769217_500.jpg'),
	('越南草虾(16-20只）400g',5,'弹嫩爽滑，不皱不缩',77.00 ,100,'400g/包','2015-1-3','/AProductMS/images/9288690708651899_500.jpg'),
	('原膳南美白虾仁（中）250g',5,'引进养殖虾种，鲜嫩不腥，烹饪不缩',38.00 ,100,'250g/袋','2015-1-4','/AProductMS/images/9288696350482700_500.jpg')
	
--禽类蛋品22-25 六月
insert into productInfo values
	('黄果树谷香蛋490g',4,null,24.80 ,100,'10枚/盒','2015-1-1','/AProductMS/images/9288692850499691_500.jpg'),
	('邮星麻鸭松花蛋550g(10枚)',4,null,33.60,100,'800g/只','2015-1-2','/AProductMS/images/9288694473728186_500.jpg'),
	('尼松野鸭斑嘴鸭800g',4,null,145.00 ,100,'400g/包','2015-1-3','/AProductMS/images/9288694126190765_500.jpg'),
	('凤中皇月子鸡800g',4,null,158.00,100,'800g/袋','2015-1-4','/AProductMS/images/9288694150766765_500.jpg')
--乳品糕点26-29 七月
insert into productInfo values
	('黄油甜心70g',6,null,5.00 ,100,'70g/包','2015-1-1','/AProductMS/images/gd1.jpg'),
	('恬心卷（榴莲口味）',6,null,38.00,100,'200g/盒','2015-1-2','/AProductMS/images/gd2.jpg'),
	('达能碧悠醇品时刻原味发酵乳125克4连杯',6,null,15.90 ,100,'125g*4','2015-1-3','/AProductMS/images/gd4.jpg'),
	('宝莱全脂牛奶250ml',6,null,6.50,100,'250ml/罐','2015-1-4','/AProductMS/images/9288694150766765_500.jpg')
--礼品礼券30-33 八月
insert into productInfo values
	('美威进口冰鲜三文鱼礼盒2kg',11,null,588.00 ,100,'2kg/盒','2015-1-1','/AProductMS/images/lp1.jpg'),
	('元气·真牛礼包',11,null,324.80,100,'1盒','2015-1-2','/AProductMS/images/lp2.jpg'),
	('常瀛进口即食牛油果香蕉礼盒(小)',11,null,66.00 ,100,'1份','2015-1-3','/AProductMS/images/lp3.jpg'),
	('258元锦色提货券',11,null,258.00,100,'1张','2015-1-4','/AProductMS/images/lp4.jpg')
--精选肉类34-37 九月
insert into productInfo values
	('丹麦皇冠天然谷饲五花肉（带皮带骨）400g',3,null,28.90 ,100,'400g/包','2015-1-1','/AProductMS/images/jx1.jpg'),
	('丹麦皇冠天然谷饲猪肋排400g',3,null,38.00,100,'400g/包','2015-1-2','/AProductMS/images/jx2.jpg'),
	('丹麦皇冠天然谷饲猪软骨350g',3,null,25.90 ,100,'350g/包','2015-1-3','/AProductMS/images/jx3.jpg'),
	('金锣原味猪排80g',3,null,11.80,100,'80g/包','2015-1-4','/AProductMS/images/jx4.jpg')
--精选蔬菜38-41 十月
insert into productInfo values
	('精选柠檬香茅50g',7,null,10.80  ,100,'400g/份','2015-1-1','/AProductMS/images/9288694941524177_500.jpg'),
	('有机土豆350g',7,null,13.90,100,'350g/份','2015-1-2','/AProductMS/images/9288695596065006_500.jpg'),
	('蔬氏芝麻菜沙拉100g',7,null,18.80 ,100,'100g/组','2015-1-3','/AProductMS/images/9288692672274530_500.jpg'),
	('清美火锅油面筋60g',7,null,4.50,100,'60g/包','2015-1-4','/AProductMS/images/9288694034342057_500.jpg')
--杂货粮油42-45 十一月
insert into productInfo values
	('Mission麦西恩原味玉米脆170g',9,null,14.00  ,100,'170g/袋','2015-1-1','/AProductMS/images/9288694141264045_500.jpg'),
	('韩国农协风味泡菜500g',9,null,39.80,100,'500g/袋','2015-1-2','/AProductMS/images/9288693949145253_500.jpg'),
	('法国拉杜蓝乔葡萄籽油500ml',9,null,158.00 ,100,'500ml/瓶','2015-1-3','/AProductMS/images/9288693599182996_500.jpg'),
	('法国拉杜蓝乔巴旦木油250ml',9,null,168.00,100,'250ml/瓶','2015-1-4','/AProductMS/images/9288693453693070_500.jpg')

--新商品
insert into productInfo values
	('美国Moon Drops无籽黑提2kg',1,null,318.00 ,100,'2kg/份','2016-1-1','/AProductMS/images/9288696708079898_500.jpg'),
	('泰国龙眼1kg',1,null,28.00,100,'1kg/份','2016-1-2','/AProductMS/images/9288696306835722_500.jpg'),
	('美国黄金恐龙蛋6个约80g/个',1,null,60.00 ,100,'6个/份','2016-1-3','/AProductMS/images/9288696362901772_500.jpg'),
	('美国加州花色恐龙蛋8个约90g/个',1,null,69.00,100,'8个/箱','2016-1-4','/AProductMS/images/9288695038582998_500.jpg')
insert into productInfo values
	('美国红啤梨6个约210g个(GD)',1,null,73.00 ,100,'6个/份','2016-1-1','/AProductMS/images/9288689792819056_500.jpg'),
	('南非葡萄柚10个约280g个',1,null,65.00,100,'10个/份','2016-1-2','/AProductMS/images/9288696537456915_500.jpg'),
	('泰国红毛丹1kg(GD)',1,null,49.00 ,100,'1kg/份','2016-1-3','/AProductMS/images/9288693174902911_500.jpg'),
	('泰国释迦6个约300g个(GD)',1,null,168.00,100,'6个/份','2016-1-4','/AProductMS/images/9288695327695076_500.jpg')
 
----

select * from productInfo			
--图片列表
go
create table pictureList(
	picid int primary key identity(1,1),--图片编号
	pid int foreign key references productInfo(pid),--商品编号
	picOne varchar(100),					--第一张图片
	picTwo varchar(100),					--第二张图片
	picThree varchar(100)					--第三张图片
)
go
insert into pictureList values
	(1,'/AProductMS/images/9288693810339996_500.jpg','/AProductMS/images/9288693810372764_500.jpg','/AProductMS/images/9288693810405532_500.jpg'),
	(2,'/AProductMS/images/9288691846357043_500.jpg','/AProductMS/images/9288691846389811_500.jpg','/AProductMS/images/9288691846422579_500.jpg'),
	(3,'/AProductMS/images/9288695451689192_500.jpg','/AProductMS/images/9288695451721960_500.jpg','/AProductMS/images/9288695451754728_500.jpg'),
	(4,'/AProductMS/images/9288695451689192_500.jpg','/AProductMS/images/9288695451853032_500.jpg','/AProductMS/images/9288695213007069_500.jpg'),
	(5,'/AProductMS/images/9288696267317513_500.jpg','/AProductMS/images/9288696267350281_500.jpg','/AProductMS/images/9288696267383049_500.jpg'),
	(6,'/AProductMS/images/9288695257833697_500.jpg','/AProductMS/images/9288695257833697_500.jpg','/AProductMS/images/9288695257833697_500.jpg'),
	(7,'/AProductMS/images/9288696302674186_500.jpg','/AProductMS/images/9288696302805258_500.jpg','/AProductMS/images/9288696302838026_500.jpg'),
	(8,'/AProductMS/images/9288695723466995_500.jpg','/AProductMS/images/9288695723499763_500.jpg','/AProductMS/images/9288695723532531_500.jpg'),
	(9,'/AProductMS/images/9288695898448117_500.jpg','/AProductMS/images/9288695898382581_500.jpg','/AProductMS/images/9288695898349813_500.jpg'),
	(10,'/AProductMS/images/9288696329347339_500.jpg','/AProductMS/images/9288696329380107_500.jpg','/AProductMS/images/9288696329347339_500.jpg'),
	(11,'/AProductMS/images/151010135435159_61909_500.jpg','/AProductMS/images/151010135436001_61909_500.jpg','/AProductMS/images/151010135436906_61909_500.jpg'),
	(12,'/AProductMS/images/151010145605426_10498_500.jpg','/AProductMS/images/151010145604584_10498_500.jpg','/AProductMS/images/151010145605426_10498_500.jpg'),
	(13,'/AProductMS/images/9288694497419450_500.jpg','/AProductMS/images/9288694497616058_500.jpg','/AProductMS/images/9288694497648826_500.jpg'),
	(14,'/AProductMS/images/9288693186928767_500.jpg','/AProductMS/images/9288693199773825_500.jpg','/AProductMS/images/9288693199806593_500.jpg'),
	(15,'/AProductMS/images/9288694177210543_500.jpg','/AProductMS/images/9288694177243311_500.jpg','/AProductMS/images/9288694177276079_500.jpg'),
	(16,'/AProductMS/images/151010145934748_425720_500.jpg','/AProductMS/images/151010145935481_425720_500.jpg','/AProductMS/images/151010145936199_425720_500.jpg'),
	(17,'/AProductMS/images/9288695723466995_500.jpg','/AProductMS/images/9288696268136713_500.jpg','/AProductMS/images/9288696268169481_500.jpg'),
	(18,'/AProductMS/images/9288695223951582_500.jpg','/AProductMS/images/9288695223951582_500 (1).jpg','/AProductMS/images/9288695223984350_500.jpg'),
	(19,'/AProductMS/images/9288693446582414_500.jpg','/AProductMS/images/9288693446680718_500.jpg','/AProductMS/images/9288693446615182_500.jpg'),
	(20,'/AProductMS/images/9288695224180958_500.jpg','/AProductMS/images/9288695224213726_500.jpg','/AProductMS/images/9288695224246494_500.jpg'),
	(21,'/AProductMS/images/9288693207441537_500.jpg','/AProductMS/images/9288693207474305_500.jpg','/AProductMS/images/9288693207507073_500.jpg'),
	(22,'/AProductMS/images/9288693207769217_500.jpg','/AProductMS/images/9288693207801985_500.jpg','/AProductMS/images/9288693207834753_500.jpg'),
	(23,'/AProductMS/images/9288690708651899_500.jpg','/AProductMS/images/9288690708750203_500.jpg','/AProductMS/images/9288690708782971_500.jpg'),
	(24,'/AProductMS/images/9288696350482700_500.jpg','/AProductMS/images/9288696350515468_500.jpg','/AProductMS/images/9288696350548236_500.jpg'),
	(25,'/AProductMS/images/9288692850499691_500.jpg','/AProductMS/images/9288692850532459_500.jpg','/AProductMS/images/9288692850565227_500.jpg'),
	(26,'/AProductMS/images/9288694473728186_500.jpg','/AProductMS/images/9288694473760954_500.jpg','/AProductMS/images/9288694473793722_500.jpg'),
	(27,'/AProductMS/images/9288694126190765_500.jpg','/AProductMS/images/9288694126223533_500.jpg','/AProductMS/images/9288694126256301_500.jpg'),
	(28,'/AProductMS/images/9288694150766765_500.jpg','/AProductMS/images/9288694150799533_500.jpg','/AProductMS/images/9288694150832301_500.jpg'),
	(29,'/AProductMS/images/gd1.jpg','/AProductMS/images/gd1-1.jpg','/AProductMS/images/gd1-2.jpg'),
	(30,'/AProductMS/images/gd2.jpg','/AProductMS/images/gd2-1.jpg','/AProductMS/images/gd2-2.jpg'),
	(31,'/AProductMS/images/gd3.jpg','/AProductMS/images/gd3-1.jpg','/AProductMS/images/gd3-2.jpg'),
	(32,'/AProductMS/images/gd4.jpg','/AProductMS/images/gd4-1.jpg','/AProductMS/images/gd4-2.jpg'),
	
	(33,'/AProductMS/images/lp1.jpg','/AProductMS/images/lp1-1.jpg','/AProductMS/images/lp1-2.jpg'),
	(34,'/AProductMS/images/lp2.jpg','/AProductMS/images/lp2-1.jpg','/AProductMS/images/lp2-2.jpg'),
	(35,'/AProductMS/images/lp3.jpg','/AProductMS/images/lp3-1.jpg.jpg','/AProductMS/images/lp3-2.jpg'),
	(36,'/AProductMS/images/lp4.jpg','/AProductMS/images/lp4-1.jpg','/AProductMS/images/lp4-2.jpg'),
	
	(37,'/AProductMS/images/jx1.jpg','/AProductMS/images/jx1-1.jpg','/AProductMS/images/jx1-2.jpg'),
	(38,'/AProductMS/images/jx2.jpg','/AProductMS/images/jx2-1.jpg','/AProductMS/images/jx2-2.jpg'),
	(39,'/AProductMS/images/jx3.jpg','/AProductMS/images/jx3-1.jpg','/AProductMS/images/jx3-2.jpg'),
	(40,'/AProductMS/images/jx4.jpg','/AProductMS/images/jx4-1.jpg','/AProductMS/images/jx4-2.jpg'),
	
	(41,'/AProductMS/images/9288694941524177_500.jpg','/AProductMS/images/9288694941589713_500.jpg','/AProductMS/images/9288694941622481_500.jpg'),
	(42,'/AProductMS/images/9288695596065006_500.jpg','/AProductMS/images/9288695596032238_500.jpg','/AProductMS/images/9288695595999470_500.jpg'),
	(43,'/AProductMS/images/9288692672274530_500.jpg','/AProductMS/images/9288692672307298_500.jpg','/AProductMS/images/9288692672340066_500.jpg'),
	(44,'/AProductMS/images/9288694034342057_500.jpg','/AProductMS/images/9288694034407593_500.jpg','/AProductMS/images/9288694034440361_500.jpg'),
	
	(45,'/AProductMS/images/9288694141264045_500.jpg','/AProductMS/images/9288694141296813_500.jpg','/AProductMS/images/9288694141329581_500.jpg'),
	(46,'/AProductMS/images/9288693949210789_500.jpg','/AProductMS/images/9288693949178021_500.jpg','/AProductMS/images/9288693949145253_500.jpg'),
	(47,'/AProductMS/images/9288693599182996_500.jpg','/AProductMS/images/9288693599150228_500.jpg','/AProductMS/images/9288693599215764_500.jpg'),
	(48,'/AProductMS/images/9288693453693070_500.jpg','/AProductMS/images/9288693453725838_500.jpg','/AProductMS/images/9288693453660302_500.jpg')


--

insert into pictureList values(49,'/AProductMS/images/9288696708079898_500.jpg','/AProductMS/images/9288696708145434_500.jpg','/AProductMS/images/9288696708178202_500.jpg')
insert into pictureList values(50,'/AProductMS/images/9288696306835722_500.jpg','/AProductMS/images/9288696306868490_500.jpg','/AProductMS/images/9288696306901258_500.jpg')
insert into pictureList values(51,'/AProductMS/images/9288696362901772_500.jpg','/AProductMS/images/9288696362934540_500.jpg','/AProductMS/images/9288696363000076_500.jpg')
insert into pictureList values(52,'/AProductMS/images/9288695038582998_500.jpg','/AProductMS/images/9288695038550230_500.jpg','/AProductMS/images/9288695038615766_500.jpg')
insert into pictureList values(53,'/AProductMS/images/9288689792819056_500.jpg','/AProductMS/images/9288689792851824_500.jpg','/AProductMS/images/9288689792884592_500.jpg')
insert into pictureList values(54,'/AProductMS/images/9288696537456915_500.jpg','/AProductMS/images/9288696537489683_500.jpg','/AProductMS/images/9288696537522451_500.jpg')
insert into pictureList values(55,'/AProductMS/images/9288693174902911_500.jpg','/AProductMS/images/9288693174968447_500.jpg','/AProductMS/images/9288693175001215_500.jpg')
insert into pictureList values(56,'/AProductMS/images/9288695327695076_500.jpg','/AProductMS/images/9288695327629540_500.jpg','/AProductMS/images/9288695327564004_500.jpg')

	
select * from pictureList
go

--图片详情列表
create table pictureList2(
	picid2 int primary key identity(1,1),			--图片编号
	pid2 int foreign key references productInfo(pid),--商品编号
	picFour varchar(100),					--第四张图片
	picFive varchar(100),					--第五张图片
	picSix varchar(100)	,					--第六张图片
	priSeven varchar(100),					--第七张图片
	priEighT varchar(100),					--第八张图片	
)

--


insert into pictureList2 values(1,'/AProductMS/images/513691852075540636_880x553.jpg','/AProductMS/images/513691852075573404_880x735.jpg','/AProductMS/images/513691852075606172_880x576.jpg','/AProductMS/images/513691852075704476_880x553.jpg','/AProductMS/images/513691852075638940_880x376.jpg')		
 insert into pictureList2 values(2,'/AProductMS/images/513691852570271922_880x522.jpg','/AProductMS/images/513691852570337458_880x671.jpg','/AProductMS/images/513691852570304690_880x279.jpg','/AProductMS/images/513691852570435762_880x315.jpg','/AProductMS/images/513691852570468530_880x469.jpg')		
 insert into pictureList2 values(3,'/AProductMS/images/513691849540607894_880x509.jpg','/AProductMS/images/513691849540640662_880x538.jpg','/AProductMS/images/513691849540673430_880x640.jpg','/AProductMS/images/513691849540738966_880x764.jpg','/AProductMS/images/513691849540706198_880x518.jpg')		
 insert into pictureList2 values(4,'/AProductMS/images/513691854517084424_880x506.jpg','/AProductMS/images/513691854517117192_880x445.jpg','/AProductMS/images/513691854517182728_880x685.jpg','/AProductMS/images/513691854517215496_880x577.jpg','/AProductMS/images/513691854517248264_880x515.jpg')
 insert into pictureList2 values(5,'/AProductMS/images/513691854545461513_880x232.jpg','/AProductMS/images/513691854545592585_880x588.jpg','/AProductMS/images/513691854545527049_880x639.jpg','/AProductMS/images/513691854545395977_880x640.jpg','/AProductMS/images/513691854545363209_880x806.jpg')
 insert into pictureList2 values(6,'/AProductMS/images/513691853594140900_880x762.jpg','/AProductMS/images/513691853593977060_880x245.jpg','/AProductMS/images/513691853594042596_880x746.jpg','/AProductMS/images/513691853594009828_880x706.jpg','/AProductMS/images/513691853594108132_880x696.jpg')
 insert into pictureList2 values(7,'/AProductMS/images/513691854563221770_880x635.jpg','/AProductMS/images/513691854563320074_880x1055.jpg','/AProductMS/images/513691854563352842_880x269.jpg','/AProductMS/images/513691854563385610_880x647.jpg','/AProductMS/images/513691854563287306_880x806.jpg')
 insert into pictureList2 values(8,'/AProductMS/images/513691855054676253_880x445.jpg','/AProductMS/images/513691855054774557_880x746.jpg','/AProductMS/images/513691855054643485_880x457.jpg','/AProductMS/images/513691855054709021_880x928.jpg','/AProductMS/images/513691855054840093_880x406.jpg')
 insert into pictureList2 values(9,'/AProductMS/images/513691855061197086_880x906.jpg','/AProductMS/images/513691855061098782_880x543.jpg','/AProductMS/images/513691855061131550_880x546.jpg','/AProductMS/images/513691855061164318_880x507.jpg','/AProductMS/images/513691855061229854_880x815.jpg')
 insert into pictureList2 values(10,'/AProductMS/images/513691854594646283_880x488.jpg','/AProductMS/images/513691854594580747_880x594.jpg','/AProductMS/images/513691854594679051_880x447.jpg','/AProductMS/images/513691854594744587_880x387.jpg','/AProductMS/images/513691854594777355_880x683.jpg')
 insert into pictureList2 values(11,'/AProductMS/images/513691849046859649_880x423.jpg','/AProductMS/images/513691849046826881_880x662.jpg','/AProductMS/images/513691849046892417_880x574.jpg','/AProductMS/images/513691849046925185_880x700.jpg','/AProductMS/images/513691849046957953_880x421.jpg')
 insert into pictureList2 values(12,'/AProductMS/images/513691849931431979_880x542.jpg','/AProductMS/images/513691849931464747_880x679.jpg','/AProductMS/images/513691849931399211_880x263.jpg','/AProductMS/images/513691849931563051_880x485.jpg','/AProductMS/images/513691849931595819_880x540.jpg')
 insert into pictureList2 values(37,'/AProductMS/images/513691853472768221_880x480.jpg','/AProductMS/images/513691853472702685_880x607.jpg','/AProductMS/images/513691853472800989_880x349.jpg','/AProductMS/images/513691853472833757_880x1135.jpg','/AProductMS/images/513691853472735453_880x546 (1).jpg')
 insert into pictureList2 values(38,'/AProductMS/images/513691852918825155_880x480.jpg','/AProductMS/images/513691852918923459_880x546.jpg','/AProductMS/images/513691852918956227_880x607.jpg','/AProductMS/images/513691852918890691_880x349.jpg','/AProductMS/images/513691852919021763_880x1101.jpg')
 insert into pictureList2 values(39,'/AProductMS/images/513691850948681827_880x347.jpg','/AProductMS/images/513691850948714595_880x841.jpg','/AProductMS/images/513691850948714595_880x841 (1).jpg','/AProductMS/images/513691850948747363_880x797.jpg','/AProductMS/images/513691850948780131_880x578.jpg')
 insert into pictureList2 values(40,'/AProductMS/images/513691849981599789_880x919.jpg','/AProductMS/images/513691849981501485_880x607.jpg','/AProductMS/images/513691849981534253_880x712.jpg','/AProductMS/images/513691849981567021_880x668.jpg','/AProductMS/images/513691849981632557_880x635.jpg')
 insert into pictureList2 values(29,'/AProductMS/images/9288683556020019.jpg','/AProductMS/images/9288683556085558.jpg','/AProductMS/images/9288683556085558.jpg','/AProductMS/images/9288683556085558.jpg','/AProductMS/images/9288683556085558.jpg')
insert into pictureList2 values(30,'/AProductMS/images/9288683543502647.jpg','/AProductMS/images/9288683543568178.jpg','/AProductMS/images/9288683543633717.jpg','/AProductMS/images/9288683543699250.jpg','/AProductMS/images/9288683543699250.jpg')
insert into pictureList2 values(31,'/AProductMS/images/513691849932677163_880x669.jpg','/AProductMS/images/513691849932644395_880x622.jpg','/AProductMS/images/513691849932709931_880x556.jpg','/AProductMS/images/513691849932709931_880x556.jpg','/AProductMS/images/513691849932709931_880x556.jpg')
insert into pictureList2 values(32,'/AProductMS/images/513691850380877884_880x771.jpg','/AProductMS/images/513691850380910652_880x732.jpg','/AProductMS/images/513691850380845116_880x482.jpg','/AProductMS/images/513691850380976188_880x596.jpg','/AProductMS/images/513691850380976188_880x596.jpg')
insert into pictureList2 values(13,'/AProductMS/images/513691854479794437_880x200.jpg','/AProductMS/images/513691852775792827_880x681.jpg','/AProductMS/images/513691852775825595_880x497.jpg','/AProductMS/images/513691852775760059_880x640.jpg','/AProductMS/images/513691852775858363_880x289.jpg')
insert into pictureList2 values(14,'/AProductMS/images/513691851453243519_880x671.jpg','/AProductMS/images/513691851453276287_880x649.jpg','/AProductMS/images/513691851453177983_880x512.jpg','/AProductMS/images/513691851453210751_880x199.jpg','/AProductMS/images/513691851453210751_880x199.jpg')
insert into pictureList2 values(15,'/AProductMS/images/513691852442509487_880x681.jpg','/AProductMS/images/513691852442476719_880x473.jpg','/AProductMS/images/513691852442542255_880x633.jpg','/AProductMS/images/513691852442607791_880x446.jpg','/AProductMS/images/513691852442607791_880x446.jpg')
insert into pictureList2 values(16,'/AProductMS/images/513691851925102742_880x575.jpg','/AProductMS/images/513691851925135510_880x593.jpg','/AProductMS/images/513691851925168278_880x577.jpg','/AProductMS/images/513691851925201046_880x325.jpg','/AProductMS/images/513691851925201046_880x325.jpg')
insert into pictureList2 values(33,'/AProductMS/images/513691849772900390_880x1114.jpg','/AProductMS/images/513691849772965926_880x865.jpg','/AProductMS/images/513691849772933158_880x625.jpg','/AProductMS/images/513691849773096998_880x655.jpg','/AProductMS/images/513691849773228070_880x675.jpg')
insert into pictureList2 values(34,'/AProductMS/images/513691852592128179_880x611.jpg','/AProductMS/images/513691852592029875_880x537.jpg','/AProductMS/images/513691852592062643_880x728.jpg','/AProductMS/images/513691852592160947_880x724.jpg','/AProductMS/images/513691852592095411_880x329.jpg')
insert into pictureList2 values(49,'/AProductMS/images/513691854996775197_880x574.jpg','/AProductMS/images/513691854996807965_880x614.jpg','/AProductMS/images/513691854996742429_880x678.jpg','/AProductMS/images/513691854996906269_880x525.jpg','/AProductMS/images/513691854996840733_880x347.jpg')
insert into pictureList2 values(50,'/AProductMS/images/513691854665359631_880x566.jpg','/AProductMS/images/513691854665425167_880x568.jpg','/AProductMS/images/513691854665392399_880x852.jpg','/AProductMS/images/513691854665457935_880x546.jpg','/AProductMS/images/513691854665490703_880x628.jpg')
insert into pictureList2 values(51,'/AProductMS/images/513691854629314828_880x496.jpg','/AProductMS/images/513691854629282060_880x495.jpg','/AProductMS/images/513691854629347596_880x472.jpg','/AProductMS/images/13691854629445900_880x799.jpg','/AProductMS/images/513691854629413132_880x490.jpg')
insert into pictureList2 values(52,'/AProductMS/images/513691853304144086_880x448.jpg','/AProductMS/images/513691853304209622_880x463.jpg','/AProductMS/images/513691853304176854_880x471.jpg','/AProductMS/images/513691853304275158_880x558.jpg','/AProductMS/images/513691853304242390_880x163.jpg')
insert into pictureList2 values(53,'/AProductMS/images/513691854931632409_880x527.jpg','/AProductMS/images/513691854931665177_880x594.jpg','/AProductMS/images/513691854931599641_880x539.jpg','/AProductMS/images/513691854931730713_880x647.jpg','/AProductMS/images/513691854931763481_880x350.jpg')
insert into pictureList2 values(54,'/AProductMS/images/513691854897848600_880x1138.jpg','/AProductMS/images/513691854897783064_880x588.jpg','/AProductMS/images/513691854897815832_880x854.jpg','/AProductMS/images/513691854897979672_880x980.jpg','/AProductMS/images/513691854897914136_880x576.jpg')
insert into pictureList2 values(55,'/AProductMS/images/513691851440562303_880x813.jpg','/AProductMS/images/513691851440529535_880x563.jpg','/AProductMS/images/513691851440627839_880x819.jpg','/AProductMS/images/513691851440595071_880x382.jpg','/AProductMS/images/513691851440562303_880x813.jpg')
insert into pictureList2 values(56,'/AProductMS/images/513691853592699108_880x473.jpg','/AProductMS/images/513691853592764644_880x740.jpg','/AProductMS/images/513691853592731876_880x517.jpg','/AProductMS/images/513691853592797412_880x575.jpg','/AProductMS/images/513691853592830180_880x770.jpg')
insert into pictureList2 values(28,'/AProductMS/images/513691852557394098_880x734.jpg','/AProductMS/images/513691852557426866_880x365.jpg','/AProductMS/images/513691852557459634_880x575.jpg','/AProductMS/images/513691852557492402_880x498.jpg','/AProductMS/images/513691852557557938_880x469.jpg')
insert into pictureList2 values(27,'/AProductMS/images/513691852908798146_880x395.jpg','/AProductMS/images/513691852908863682_880x428.jpg','/AProductMS/images/513691852908896450_880x459.jpg','/AProductMS/images/513691852908994754_880x434.jpg','/AProductMS/images/513691852908830914_880x422.jpg')
insert into pictureList2 values(26,'/AProductMS/images/513691852750102714_880x706.jpg','/AProductMS/images/513691852750168250_880x388.jpg','/AProductMS/images/513691852750201018_880x366.jpg','/AProductMS/images/513691852750069946_880x431.jpg','/AProductMS/images/513691852750102714_880x706.jpg')
insert into pictureList2 values(25,'/AProductMS/images/513691851166130286_880x563.jpg','/AProductMS/images/513691851165966446_880x468.jpg','/AProductMS/images/513691851165999214_880x409.jpg','/AProductMS/images/513691851166031982_880x789.jpg','/AProductMS/images/513691851165933678_880x378.jpg')
insert into pictureList2 values(21,'/AProductMS/images/513691851644248203_880x801.jpg','/AProductMS/images/513691851644280971_880x809.jpg','/AProductMS/images/513691851644379275_880x631.jpg','/AProductMS/images/513691851644313739_880x979.jpg','/AProductMS/images/513691851644346507_880x448.jpg')
insert into pictureList2 values(22,'/AProductMS/images/513691851643723915_880x800.jpg','/AProductMS/images/513691851643789451_880x809.jpg','/AProductMS/images/513691851643822219_880x632.jpg','/AProductMS/images/513691851643756683_880x979.jpg','/AProductMS/images/513691851643887755_880x426.jpg')
insert into pictureList2 values(23,'/AProductMS/images/513691851807563922_880x697.jpg','/AProductMS/images/513691851807629458_880x962.jpg','/AProductMS/images/513691851807498386_880x283.jpg','/AProductMS/images/513691851807596690_880x557.jpg','/AProductMS/images/513691851807563922_880x697.jpg')
insert into pictureList2 values(24,'/AProductMS/images/513691855052710173_880x621.jpg','/AProductMS/images/513691855052742941_880x448.jpg','/AProductMS/images/513691855052808477_880x447.jpg','/AProductMS/images/513691855052841245_880x503.jpg','/AProductMS/images/513691855052775709_880x233.jpg')


--用户表
go
create table [user](
	userID int primary key identity(1,1),--用户编号
	username varchar(100),		--用户名
	[password] varchar(100),	--密码
	name varchar(100),			--姓名
	sex int,					--性别
	phone varchar(100),			--电话
	post varchar(200),			--邮寄地址
	email varchar(200),			--邮箱
)
insert [user]values('test1','123456','刘明明',1,'18379850930','广东珠海','18379850930@163.com')
insert [user]values('test2','123456','张三',1,'13411111111','广东珠海','123@163.com')
insert [user]values('test3','123456','李四',0,'1341111155','广东深圳','1234@163.com')
insert [user]values('test4','123456','李四',0,'1341111145','广东深圳','1234@163.com')
insert [user]values('test5','123456','王五',1,'13411111443','广东深圳','12345@163.com')
insert [user]values('test6','123456','赵六',1,'13411111153','广东深圳','12345@163.com')
insert [user]values('test7','123456','田七',0,'1341111117','广东珠海','12346@163.com')
insert [user]values('test8','123456','王八',1,'13411111112','广东广州','12347@163.com')
select * from [user] 
--订单信息表
go
create table orderForm(
	oId int primary key identity(1,1),		--订单编号
	oNo int,								--订单序号
	userID int foreign key references  [user](userID),	--用户编号
	submitTime datetime ,		--提交订单时间
	outTime datetime,			--发货时间
	totalPrice float,			--总金额
	remark varchar(200),		--买家备注
	IPAddress varchar(200),		--买家地址
	isPayoff int,				--买家是否付款
	isOut int					--是否发货
) 

--未付款的 六条数据
insert orderForm values(11493,1,'2016-1-5',null,298.00,'我要新鲜的','中国深圳',1,0)
insert orderForm values(1107493,2,'2016-1-6',null,116.00,'我要新鲜的','中国深圳',1,0)
insert orderForm values(11123145,4,'2016-2-7',null,58.90,'我要新鲜的，可以吗','中国深圳',1,0)
insert orderForm values(111231,5,'2016-5-6',null,298.00,'我要新鲜的，可以吗','中国深圳',1,0)
insert orderForm values(11345333,6,'2016-4-16',null,98.00 ,'我要新鲜的','中国深圳',0,0)
insert orderForm values(11321,3,'2016-6-10',null,176.00,'我要新鲜的，可以吗','中国深圳',1,0)
--那年 那月 那个类型
--一月  一个类型  
insert orderForm values(840734,1,'2016-1-5','2016-1-6',298.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(844745,2,'2016-1-6','2016-1-7',116.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(231255,4,'2016-1-10','2016-1-11',58.90,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(231453,5,'2016-1-18','2016-1-19',298.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(423334,6,'2016-1-16','2016-1-17',98.00 ,'我要新鲜的','中国深圳',1,1)
insert orderForm values(4234134,3,'2016-1-25','2016-1-26',176.00,'我要新鲜的，可以吗','中国深圳',1,1)
--     二个类型
insert orderForm values(678931,1,'2016-8-5','2016-8-6',132.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(72431,2,'2016-8-9','2016-8-10',140.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(442311,4,'2016-8-7','2016-8-8',218.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(47311,5,'2016-8-6','2016-8-9',132.00,'我要新鲜的，可以吗','中国深圳',1,1)

--   三个类型
insert orderForm values(44541,1,'2016-8-5','2016-8-6',27.7,'我要新鲜的','中国深圳',1,1)
insert orderForm values(42341,2,'2016-8-9','2016-8-10',140.70,'我要新鲜的','中国深圳',1,1)
insert orderForm values(49451,4,'2016-8-7','2016-8-8',597.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(624311,5,'2016-8-6','2016-8-9',38.40,'我要新鲜的，可以吗','中国深圳',1,1)

-- 四类型
insert orderForm values(5541,1,'2016-8-5','2016-8-6',264.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(5231,2,'2016-8-9','2016-8-10',88.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(3423551,4,'2016-8-7','2016-8-8',308.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(54311,5,'2016-8-6','2016-8-9',152.0,'我要新鲜的，可以吗','中国深圳',1,1)

--五类型
insert orderForm values(445541,1,'2016-8-5','2016-8-6',714.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(942431,2,'2016-8-9','2016-8-10',53.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(3243551,4,'2016-8-7','2016-8-8',108.0,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(925311,5,'2016-8-6','2016-8-9',71.20,'我要新鲜的，可以吗','中国深圳',1,1)

--六类型
insert orderForm values(234411,1,'2016-8-5','2016-8-6',124.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(524311,2,'2016-8-9','2016-8-10',168.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(452511,4,'2016-8-7','2016-8-8',725.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(15311,5,'2016-8-6','2016-8-9',790.00,'我要新鲜的，可以吗','中国深圳',1,1)
-- 七类型
insert orderForm values(5451,1,'2016-8-5','2016-8-6',30.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(5434651,3,'2016-8-9','2016-8-10',228.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(54541,4,'2016-8-7','2016-8-8',95.40,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(443331,5,'2016-8-6','2016-8-9',39.00,'我要新鲜的，可以吗','中国深圳',1,1)
--八类型
insert orderForm values(5655451,1,'2016-8-5','2016-8-6',1176.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(43341,3,'2016-8-9','2016-8-10',649.60,'我要新鲜的','中国深圳',1,1)
insert orderForm values(55441,4,'2016-8-7','2016-8-8',132.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(6431441,5,'2016-8-6','2016-8-9',516.00,'我要新鲜的，可以吗','中国深圳',1,1)
--九类型
insert orderForm values(45551,1,'2016-8-5','2016-8-6',57.80,'我要新鲜的','中国深圳',1,1)
insert orderForm values(35631,3,'2016-8-9','2016-8-10',76.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(4541,4,'2016-8-7','2016-8-8',51.80,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(24441,5,'2016-8-6','2016-8-9',23.60,'我要新鲜的，可以吗','中国深圳',1,1)
-- 十类型
insert orderForm values(15552,1,'2016-8-5','2016-8-6',108.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(114532,3,'2016-8-9','2016-8-10',139.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(115542,4,'2016-8-7','2016-8-8',188.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(3142,5,'2016-8-6','2016-8-9',450.00,'我要新鲜的，可以吗','中国深圳',1,1)
--十一类型
insert orderForm values(1232,1,'2016-8-5','2016-8-6',140.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(3532,3,'2016-8-9','2016-8-10',398.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(2542,4,'2016-8-7','2016-8-8',1580.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(23142,5,'2016-8-6','2016-8-9',1680.00,'我要新鲜的，可以吗','中国深圳',1,1)



----剩余类型和月份 并列
insert orderForm values(6787493,1,'2016-2-5','2016-2-6',132.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(724493,2,'2016-2-9','2016-2-10',140.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(44231231,4,'2016-2-7','2016-2-8',218.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(471231,5,'2016-2-6','2016-2-9',132.00,'我要新鲜的，可以吗','中国深圳',1,1)
--三月
insert orderForm values(4434454,1,'2016-3-5','2016-3-6',27.7,'我要新鲜的','中国深圳',1,1)
insert orderForm values(424934,2,'2016-3-9','2016-3-10',140.70,'我要新鲜的','中国深圳',1,1)
insert orderForm values(494545,4,'2016-3-7','2016-3-8',597.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(6245431,5,'2016-3-6','2016-3-9',38.40,'我要新鲜的，可以吗','中国深圳',1,1)
--四月
insert orderForm values(7344554,1,'2016-4-5','2016-4-6',264.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(854523,2,'2016-4-9','2016-4-10',88.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(842342355,4,'2016-4-7','2016-4-8',308.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(8255431,5,'2016-4-6','2016-4-9',152.0,'我要新鲜的，可以吗','中国深圳',1,1)
--五月
insert orderForm values(9344554,1,'2016-5-5','2016-5-6',714.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(9554243,2,'2016-5-9','2016-5-10',53.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(923424355,4,'2016-5-7','2016-5-8',108.0,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(925554431,5,'2016-5-6','2016-5-9',71.20,'我要新鲜的，可以吗','中国深圳',1,1)
--六月
insert orderForm values(2343244,1,'2016-6-5','2016-6-6',124.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(9255243,2,'2016-6-9','2016-6-10',168.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(4523545,4,'2016-6-7','2016-6-8',725.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(15724431,5,'2016-6-6','2016-6-9',790.00,'我要新鲜的，可以吗','中国深圳',1,1)
--七月
insert orderForm values(2355545,1,'2016-7-5','2016-7-6',30.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(14543465,3,'2016-7-9','2016-7-10',228.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(4465454,4,'2016-7-7','2016-7-8',95.40,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(2624333,5,'2016-7-6','2016-7-9',39.00,'我要新鲜的，可以吗','中国深圳',1,1)
--八月
insert orderForm values(234565545,1,'2016-8-5','2016-8-6',1176.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(1454334,3,'2016-8-9','2016-8-10',649.60,'我要新鲜的','中国深圳',1,1)
insert orderForm values(4435544,4,'2016-8-7','2016-8-8',132.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(233643144,5,'2016-8-6','2016-8-9',516.00,'我要新鲜的，可以吗','中国深圳',1,1)
--九月
insert orderForm values(234555,1,'2015-9-5','2015-9-6',57.80,'我要新鲜的','中国深圳',1,1)
insert orderForm values(133563,3,'2015-9-9','2015-9-10',76.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(44454,4,'2015-9-7','2015-9-8',51.80,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(244314,5,'2015-9-6','2015-9-9',23.60,'我要新鲜的，可以吗','中国深圳',1,1)
-- 十月
insert orderForm values(1141555,1,'2015-10-5','2015-10-6',108.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(114554533,3,'2015-10-9','2015-10-10',139.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(114645554,4,'2015-10-7','2015-10-8',188.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(11443314,5,'2015-10-6','2015-10-9',450.00,'我要新鲜的，可以吗','中国深圳',1,1)
--十一月
insert orderForm values(1234005,1,'2015-11-5','2015-11-6',140.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(3525543,3,'2015-11-9','2015-11-10',398.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(23454,4,'2015-11-7','2015-11-8',1580.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(252314,5,'2015-11-6','2015-11-9',1680.00,'我要新鲜的，可以吗','中国深圳',1,1)
--十二月
insert orderForm values(24350405,1,'2015-12-5','2015-12-6',140.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(23445443,3,'2015-12-9','2015-12-10',398.00,'我要新鲜的','中国深圳',1,1)
insert orderForm values(244554,4,'2015-12-7','2015-12-8',1580.00,'我要新鲜的，可以吗','中国深圳',1,1)
insert orderForm values(2436314,5,'2015-12-6','2015-12-9',1680.00,'我要新鲜的，可以吗','中国深圳',1,1)

select * from orderForm

--订单列表信息表
go
create table orderList(
	oListID int primary key identity(1,1),				--订单列表编号
	oLID int foreign key references orderForm(oId) ,	--订单编号
	pID int foreign key references productInfo(pid),	--商品编号
	amount int											--订单商品数量
)
--未付款的
insert  orderList values(1,1,3)
insert  orderList values(2,2,3)
insert  orderList values(3,3,3)
insert  orderList values(4,4,3)
insert  orderList values(5,5,3)
insert  orderList values(6,6,3)
-- 一类型
insert  orderList values(7,1,3)
insert  orderList values(8,2,3)
insert  orderList values(9,3,3)
insert  orderList values(10,4,3)
insert  orderList values(11,5,3)
insert  orderList values(12,6,3)
--二月
insert  orderList values(13,9,3)
insert  orderList values(14,10,3)
insert  orderList values(15,11,3)
insert  orderList values(16,12,3)
--三月
insert  orderList values(17,13,3)
insert  orderList values(18,14,3)
insert  orderList values(19,15,3)
insert  orderList values(20,16,3)
--四月
insert  orderList values(21,21,3)
insert  orderList values(22,22,3)
insert  orderList values(23,23,3)
insert  orderList values(24,24,3)
--五月
insert  orderList values(25,17,4)
insert  orderList values(26,18,4)
insert  orderList values(27,19,4)
insert  orderList values(28,20,4)
--六月
insert  orderList values(29,25,4)
insert  orderList values(30,26,4)
insert  orderList values(31,27,4)
insert  orderList values(32,28,4)
--七月
insert  orderList values(33,29,6)
insert  orderList values(34,30,6)
insert  orderList values(35,31,6)
insert  orderList values(36,32,6)
--八月
insert  orderList values(37,33,7)
insert  orderList values(38,34,7)
insert  orderList values(39,35,7)
insert  orderList values(40,36,7)
--九月
insert  orderList values(41,37,6)
insert  orderList values(42,38,6)
insert  orderList values(43,39,6)
insert  orderList values(44,40,6)
--十月
insert  orderList values(45,41,9)
insert  orderList values(46,42,9)
insert  orderList values(47,43,9)
insert  orderList values(48,44,9)
--十一月
insert  orderList values(49,45,10)
insert  orderList values(50,46,10)
insert  orderList values(51,47,10)
insert  orderList values(52,48,10)


--剩余类型 和月份 并列
--二月
insert  orderList values(53,9,2)
insert  orderList values(54,10,2)
insert  orderList values(55,11,2)
insert  orderList values(56,12,2)
--三月
insert  orderList values(57,13,3)
insert  orderList values(58,14,3)
insert  orderList values(59,15,3)
insert  orderList values(60,16,3)
--四月
insert  orderList values(61,21,4)
insert  orderList values(62,22,4)
insert  orderList values(63,23,4)
insert  orderList values(64,24,4)
--五月
insert  orderList values(65,17,3)
insert  orderList values(66,18,3)
insert  orderList values(67,19,3)
insert  orderList values(68,20,4)
--六月
insert  orderList values(69,25,5)
insert  orderList values(70,26,5)
insert  orderList values(71,27,5)
insert  orderList values(72,28,5)
--七月
insert  orderList values(73,29,6)
insert  orderList values(74,30,6)
insert  orderList values(75,31,6)
insert  orderList values(76,32,6)
--八月
insert  orderList values(77,33,2)
insert  orderList values(78,34,2)
insert  orderList values(79,35,2)
insert  orderList values(80,36,2)
--九月
insert  orderList values(81,37,2)
insert  orderList values(82,38,2)
insert  orderList values(83,39,2)
insert  orderList values(84,40,2)
--十月
insert  orderList values(85,41,10)
insert  orderList values(86,42,10)
insert  orderList values(87,43,10)
insert  orderList values(88,44,10)
--十一月
insert  orderList values(89,45,10)
insert  orderList values(90,46,10)
insert  orderList values(91,47,10)
insert  orderList values(92,48,10)

--十二月
insert  orderList values(93,45,10)
insert  orderList values(94,46,10)
insert  orderList values(95,47,10)
insert  orderList values(96,48,10)


--select * from orderList
----对应商品类型的进货商品总数量
--select SUM(p.amount) 总数量  from productInfo p inner join pType t on p.pTypeInfoId=t.pTypeId 
--	where t.pTypeName='"+type+"'

--select distinct  t.pTypeName 类型, sum(o.amount) 销售总数量 from productInfo p inner join  orderList o on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId inner join orderForm f on f.oId=o.oListID
--	 where  f.isPayoff=1 and f.isOut=1 group by t.pTypeName

--select t.pTypeName as type,sum(p.amount)  as total, sum(o.amount) as outtotal from productInfo p inner join  orderList o on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId inner join orderForm f on f.oId=o.oListID where  f.isPayoff=1 and f.isOut=1  group by t.pTypeName
--select pTypeId,pTypeName from pType

----对应类型 不同年月份的 商品销售总数量
--select * from (select t.pTypeName 类型, sum(o.amount) 销售总数量 from orderList o inner join productInfo p
--	on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId
--	inner join orderForm f on f.oId=o.oListID
--	where  f.isPayoff=1 and f.isOut=1
--	group by t.pTypeName) as b ,(select * from sum(amount)  as 总数量 from productInfo inner join  orderList o on o.pID=p.pid inner join pType t on t.pTypeId = pTypeInfoId inner join orderForm f on f.oId=o.oListID
--	 where  f.isPayoff=1 and f.isOut=1 group by t.pTypeName) as c
--go
--select datepart(mm,outTime) from orderForm where oId=7
--select * from orderList





















--评论表
go
create table comment(
	comId int primary key identity(1,1),				--评论编号
	comUserId int foreign key references [user](userID) ,--评论人编号
	pid int foreign key references productInfo(pid) ,     --商品编号
	content ntext,										--评论内容
	commentTime datetime,								--评论时间
	isGood varchar(20)									--是差中好评?
)
select c.*,p.pName,u.username from comment c inner join productInfo p on p.pid=c.pid  inner join [user] u on c.comUserId=u.userID where 1=1 and isGood='好评' and c.pid=5 order by  c.commentTime desc
insert into comment values(1,5,'很好吃','2015-10-10','好评')	
insert into comment values(2,5,'一般吧','2015-1-1','中评')
insert into comment values(3,5,'下次再来','2015-3-7','好评')
insert into comment values(4,5,'很好吃的哦','2015-1-8','好评')
insert into comment values(1,5,'很好吃,我叫朋友也来这里买','2015-10-8','好评')	
insert into comment values(2,5,'还不错哦,','2015-1-1','中评')
insert into comment values(3,5,'下次还是来这家店','2015-3-5','好评')
insert into comment values(4,5,'物流有点慢哦','2015-1-3','差评')
insert into comment values(5,1,'物流有点慢','2015-2-4','中评')
insert into comment values(1,1,'很不错哦','2015-7-9','好评')
insert into comment values(6,1,'超级好吃','2015-4-8','好评')
select * from comment
--回复表

go
create table reply(
	rId int primary key identity(1,1),					--回复编号
	rUserId int ,										--回复人编号
	rComId int foreign key references comment (comId) , --评论编号
	pid int foreign key references productInfo(pid),	--回复商品的编号
	rContent ntext,										--回复内容
	replyTime datetime									--回复时间时间									--回复内容
)
select * from reply


--购物车表
create table shopping_cart( 
	cid int primary key identity(1,1),							--购物车编号 
	userID int foreign key references [user](userID),			--用户编号
	[sid] int foreign key references productInfo(pid),			--商品编号
	sPicture varchar(100),										--商品图片
	sName  varchar(600),										--商品名称
	price float,												--价格
	amount int,													--数量
	total float,												--合计
	sguiGe varchar(50) ,										--规格
)

select * from shopping_cart


--管理员账号
go
insert into admins (adminName,adminPassword) values
	('21232F297A57A5A743894A0E4A801FC3','21232F297A57A5A743894A0E4A801FC3')
select * from admins


