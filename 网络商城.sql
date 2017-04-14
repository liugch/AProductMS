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
--����Ա��
go
create table admins(
	adminId int primary key identity(1,1),	--����Ա���
	adminName varchar(50),					--����Ա����
	adminPassword varchar(50)				--����Ա����
)
--��Ʒ���ͱ�
go
create table pType(
	pTypeId int primary key identity(1,1),	--��Ʒ����
	pTypeName varchar(200)					--��Ʒ��������
)

insert into pType(pTypeName) values
	('����ˮ��'),('����ˮ��'),('��ѡ����'),('���൰Ʒ'),('����ˮ��'),
	('��Ʒ���'),('�����߲�'),('������ʳ'),('�����ӻ�'),('���Ͼ�ˮ'),('��Ʒ��ȯ')
select pTypeId,pTypeName from pType

--��Ʒ��Ϣ��
go
create table productInfo(
	pid int primary key identity(1,1),					--��Ʒ���
	pName varchar(200),									 --��Ʒ����
	pTypeInfoId int foreign key references pType(pTypeId),--��Ʒ����
	pDesc varchar(600),									 --��Ʒ����
	pPrice float,										--��Ʒ�۸�
	amount int,											--��Ʒ�������
	guiGe varchar(50),									--��Ʒ���
	pUptime datetime,									--��Ʒ�ϼ�ʱ��
	pPicture varchar(100)								--��ƷͼƬ
)
go
--����ˮ�� 1-8 һ��
insert into productInfo values
	('̩������ͷ����9-10�Լ1-2��)',1,null,149.00,100,'9-10��/��','2015-1-1','/AProductMS/images/9288693810339996_500.jpg'),
	('̩��ɽ��1kg',1,'������ժֱ������ζ�����֭�����򼴻�',58.00,100,'1kg/��','2015-1-2','/AProductMS/images/9288691846357043_500.jpg'),
	('��孽��ھ�ѡ�㽶Լ1.5kg',1,null,29.00 ,100,'Լ1.5kg/��','2015-1-3','/AProductMS/images/9288695451689192_500.jpg'),
	('Zespri�����������������3.3kgԭ��(22-25��)',1,null,149.00 ,100,'3.3kg/��','2015-1-4','/AProductMS/images/9288695212712157_500.jpg'),
	('Խ�Ϻ��Ļ�����2.5kg���й���Լ350g/��',1,'ԭ����ֱ�������������أ������֭�ļ����ʹ�',69.00 ,100,'1kg/��','2015-1-5','/AProductMS/images/9288696267317513_500.jpg'),
	('������ƻ��12��Լ150g/��',1,null,49.00,100,'12��/��','2015-1-6','/AProductMS/images/9288695257833697_500.jpg'),
	('���ô󳬴�ӣ��500g����30mm����',1,null,88.00,100,'500g/��','2015-1-7','/AProductMS/images/9288696302674186_500.jpg'),
	('̩������1��Լ700g/��',1,null,39.00,100,'1��/��','2015-1-8','/AProductMS/images/9288695723466995_500.jpg')
--����ˮ�� 9-12 ����
insert into productInfo values
	('��������500g',2,null,66.00,100,'500g/��','2015-1-1','/AProductMS/images/9288695898448117_500.jpg'),
	('�������Ծ�Ʒʯ��8��325g����/��',2,null,70.00,100,'8��/��','2015-1-2','/AProductMS/images/9288696329347339_500.jpg'),
	('ɽ��������Ʒ�츻ʿ5kg����80-85mm',2,null,109.00,100,'5kg/��','2015-1-3','/AProductMS/images/151010135435159_61909_500.jpg'),
	('������Ʒ�츻ʿ2.5kg����80-85mm',2,null,66.00,100,'2.5kg/��','2015-1-4','/AProductMS/images/151010145605426_10498_500.jpg')
--������ʳ	13-16 ����
insert into productInfo values
	('�����������ⶡ(�����)150g',8,null,9.9,100,'150g/��','2015-1-1','/AProductMS/images/9288694497419450_500.jpg'),
	('ϣ�����⴮480g',8,null,46.90,100,'1��','2015-1-2','/AProductMS/images/9288693186928767_500.jpg'),
	('�巼Ӣ����Ʒ��1.2kg',8,null,199.00,100,'1.2kg/��','2015-1-3','/AProductMS/images/9288694177210543_500.jpg'),
	('�����㹽�ز˰�420g',8,null,12.80,100,'420g/��','2015-1-4','/AProductMS/images/151010145934748_425720_500.jpg')		
--���Ͼ�ˮ17-20 ����
insert into productInfo values
	('����������ơ����װƤ��ɭ��ơ650ml*6',10,'EURO2015 ���顰�족�ź� ���춨��װ',238.00 ,100,'650ml*6/��','2015-1-1','/AProductMS/images/9288696268071177_500.jpg'),
	('���100%����ƻ����Ϲ�֭310ml',10,null,17.8,100,'310ml/ƿ','2015-1-3','/AProductMS/images/9288695223951582_500.jpg'),
	('������Ƭ��Խݮ��֥��ζ320g',10,null,35.00 ,100,'320/��','2015-1-4','/AProductMS/images/9288693446582414_500.jpg'),
	('���100%ƻ��С������ʻ�Ϲ���֭310ml',10,null,17.80 ,100,'310ml/ƿ','2015-1-5','/AProductMS/images/9288695224180958_500.jpg')
--����ˮ��	20-21 ����
insert into productInfo values
	('����л�����������500g',5,null,66.00 ,100,'500g/��','2015-1-1','/AProductMS/images/9288693207441537_500.jpg'),
	('���Ұ���л�����С������280g',5,null,22.00 ,100,'280g/��','2015-1-2','/AProductMS/images/9288693207769217_500.jpg'),
	('Խ�ϲ�Ϻ(16-20ֻ��400g',5,'����ˬ�������岻��',77.00 ,100,'400g/��','2015-1-3','/AProductMS/images/9288690708651899_500.jpg'),
	('ԭ��������Ϻ�ʣ��У�250g',5,'������ֳϺ�֣����۲��ȣ���⿲���',38.00 ,100,'250g/��','2015-1-4','/AProductMS/images/9288696350482700_500.jpg')
	
--���൰Ʒ22-25 ����
insert into productInfo values
	('�ƹ������㵰490g',4,null,24.80 ,100,'10ö/��','2015-1-1','/AProductMS/images/9288692850499691_500.jpg'),
	('������Ѽ�ɻ���550g(10ö)',4,null,33.60,100,'800g/ֻ','2015-1-2','/AProductMS/images/9288694473728186_500.jpg'),
	('����ҰѼ����Ѽ800g',4,null,145.00 ,100,'400g/��','2015-1-3','/AProductMS/images/9288694126190765_500.jpg'),
	('���л����Ӽ�800g',4,null,158.00,100,'800g/��','2015-1-4','/AProductMS/images/9288694150766765_500.jpg')
--��Ʒ���26-29 ����
insert into productInfo values
	('��������70g',6,null,5.00 ,100,'70g/��','2015-1-1','/AProductMS/images/gd1.jpg'),
	('���ľ�������ζ��',6,null,38.00,100,'200g/��','2015-1-2','/AProductMS/images/gd2.jpg'),
	('���ܱ��ƴ�Ʒʱ��ԭζ������125��4����',6,null,15.90 ,100,'125g*4','2015-1-3','/AProductMS/images/gd4.jpg'),
	('����ȫ֬ţ��250ml',6,null,6.50,100,'250ml/��','2015-1-4','/AProductMS/images/9288694150766765_500.jpg')
--��Ʒ��ȯ30-33 ����
insert into productInfo values
	('�������ڱ������������2kg',11,null,588.00 ,100,'2kg/��','2015-1-1','/AProductMS/images/lp1.jpg'),
	('Ԫ������ţ���',11,null,324.80,100,'1��','2015-1-2','/AProductMS/images/lp2.jpg'),
	('��孽��ڼ�ʳţ�͹��㽶���(С)',11,null,66.00 ,100,'1��','2015-1-3','/AProductMS/images/lp3.jpg'),
	('258Ԫ��ɫ���ȯ',11,null,258.00,100,'1��','2015-1-4','/AProductMS/images/lp4.jpg')
--��ѡ����34-37 ����
insert into productInfo values
	('����ʹ���Ȼ�����廨�⣨��Ƥ���ǣ�400g',3,null,28.90 ,100,'400g/��','2015-1-1','/AProductMS/images/jx1.jpg'),
	('����ʹ���Ȼ����������400g',3,null,38.00,100,'400g/��','2015-1-2','/AProductMS/images/jx2.jpg'),
	('����ʹ���Ȼ���������350g',3,null,25.90 ,100,'350g/��','2015-1-3','/AProductMS/images/jx3.jpg'),
	('����ԭζ����80g',3,null,11.80,100,'80g/��','2015-1-4','/AProductMS/images/jx4.jpg')
--��ѡ�߲�38-41 ʮ��
insert into productInfo values
	('��ѡ������é50g',7,null,10.80  ,100,'400g/��','2015-1-1','/AProductMS/images/9288694941524177_500.jpg'),
	('�л�����350g',7,null,13.90,100,'350g/��','2015-1-2','/AProductMS/images/9288695596065006_500.jpg'),
	('����֥���ɳ��100g',7,null,18.80 ,100,'100g/��','2015-1-3','/AProductMS/images/9288692672274530_500.jpg'),
	('������������60g',7,null,4.50,100,'60g/��','2015-1-4','/AProductMS/images/9288694034342057_500.jpg')
--�ӻ�����42-45 ʮһ��
insert into productInfo values
	('Mission������ԭζ���״�170g',9,null,14.00  ,100,'170g/��','2015-1-1','/AProductMS/images/9288694141264045_500.jpg'),
	('����ũЭ��ζ�ݲ�500g',9,null,39.80,100,'500g/��','2015-1-2','/AProductMS/images/9288693949145253_500.jpg'),
	('��������������������500ml',9,null,158.00 ,100,'500ml/ƿ','2015-1-3','/AProductMS/images/9288693599182996_500.jpg'),
	('�����������ǰ͵�ľ��250ml',9,null,168.00,100,'250ml/ƿ','2015-1-4','/AProductMS/images/9288693453693070_500.jpg')

--����Ʒ
insert into productInfo values
	('����Moon Drops���Ѻ���2kg',1,null,318.00 ,100,'2kg/��','2016-1-1','/AProductMS/images/9288696708079898_500.jpg'),
	('̩������1kg',1,null,28.00,100,'1kg/��','2016-1-2','/AProductMS/images/9288696306835722_500.jpg'),
	('�����ƽ������6��Լ80g/��',1,null,60.00 ,100,'6��/��','2016-1-3','/AProductMS/images/9288696362901772_500.jpg'),
	('�������ݻ�ɫ������8��Լ90g/��',1,null,69.00,100,'8��/��','2016-1-4','/AProductMS/images/9288695038582998_500.jpg')
insert into productInfo values
	('������ơ��6��Լ210g��(GD)',1,null,73.00 ,100,'6��/��','2016-1-1','/AProductMS/images/9288689792819056_500.jpg'),
	('�Ϸ�������10��Լ280g��',1,null,65.00,100,'10��/��','2016-1-2','/AProductMS/images/9288696537456915_500.jpg'),
	('̩����ë��1kg(GD)',1,null,49.00 ,100,'1kg/��','2016-1-3','/AProductMS/images/9288693174902911_500.jpg'),
	('̩������6��Լ300g��(GD)',1,null,168.00,100,'6��/��','2016-1-4','/AProductMS/images/9288695327695076_500.jpg')
 
----

select * from productInfo			
--ͼƬ�б�
go
create table pictureList(
	picid int primary key identity(1,1),--ͼƬ���
	pid int foreign key references productInfo(pid),--��Ʒ���
	picOne varchar(100),					--��һ��ͼƬ
	picTwo varchar(100),					--�ڶ���ͼƬ
	picThree varchar(100)					--������ͼƬ
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

--ͼƬ�����б�
create table pictureList2(
	picid2 int primary key identity(1,1),			--ͼƬ���
	pid2 int foreign key references productInfo(pid),--��Ʒ���
	picFour varchar(100),					--������ͼƬ
	picFive varchar(100),					--������ͼƬ
	picSix varchar(100)	,					--������ͼƬ
	priSeven varchar(100),					--������ͼƬ
	priEighT varchar(100),					--�ڰ���ͼƬ	
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


--�û���
go
create table [user](
	userID int primary key identity(1,1),--�û����
	username varchar(100),		--�û���
	[password] varchar(100),	--����
	name varchar(100),			--����
	sex int,					--�Ա�
	phone varchar(100),			--�绰
	post varchar(200),			--�ʼĵ�ַ
	email varchar(200),			--����
)
insert [user]values('test1','123456','������',1,'18379850930','�㶫�麣','18379850930@163.com')
insert [user]values('test2','123456','����',1,'13411111111','�㶫�麣','123@163.com')
insert [user]values('test3','123456','����',0,'1341111155','�㶫����','1234@163.com')
insert [user]values('test4','123456','����',0,'1341111145','�㶫����','1234@163.com')
insert [user]values('test5','123456','����',1,'13411111443','�㶫����','12345@163.com')
insert [user]values('test6','123456','����',1,'13411111153','�㶫����','12345@163.com')
insert [user]values('test7','123456','����',0,'1341111117','�㶫�麣','12346@163.com')
insert [user]values('test8','123456','����',1,'13411111112','�㶫����','12347@163.com')
select * from [user] 
--������Ϣ��
go
create table orderForm(
	oId int primary key identity(1,1),		--�������
	oNo int,								--�������
	userID int foreign key references  [user](userID),	--�û����
	submitTime datetime ,		--�ύ����ʱ��
	outTime datetime,			--����ʱ��
	totalPrice float,			--�ܽ��
	remark varchar(200),		--��ұ�ע
	IPAddress varchar(200),		--��ҵ�ַ
	isPayoff int,				--����Ƿ񸶿�
	isOut int					--�Ƿ񷢻�
) 

--δ����� ��������
insert orderForm values(11493,1,'2016-1-5',null,298.00,'��Ҫ���ʵ�','�й�����',1,0)
insert orderForm values(1107493,2,'2016-1-6',null,116.00,'��Ҫ���ʵ�','�й�����',1,0)
insert orderForm values(11123145,4,'2016-2-7',null,58.90,'��Ҫ���ʵģ�������','�й�����',1,0)
insert orderForm values(111231,5,'2016-5-6',null,298.00,'��Ҫ���ʵģ�������','�й�����',1,0)
insert orderForm values(11345333,6,'2016-4-16',null,98.00 ,'��Ҫ���ʵ�','�й�����',0,0)
insert orderForm values(11321,3,'2016-6-10',null,176.00,'��Ҫ���ʵģ�������','�й�����',1,0)
--���� ���� �Ǹ�����
--һ��  һ������  
insert orderForm values(840734,1,'2016-1-5','2016-1-6',298.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(844745,2,'2016-1-6','2016-1-7',116.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(231255,4,'2016-1-10','2016-1-11',58.90,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(231453,5,'2016-1-18','2016-1-19',298.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(423334,6,'2016-1-16','2016-1-17',98.00 ,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(4234134,3,'2016-1-25','2016-1-26',176.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--     ��������
insert orderForm values(678931,1,'2016-8-5','2016-8-6',132.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(72431,2,'2016-8-9','2016-8-10',140.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(442311,4,'2016-8-7','2016-8-8',218.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(47311,5,'2016-8-6','2016-8-9',132.00,'��Ҫ���ʵģ�������','�й�����',1,1)

--   ��������
insert orderForm values(44541,1,'2016-8-5','2016-8-6',27.7,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(42341,2,'2016-8-9','2016-8-10',140.70,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(49451,4,'2016-8-7','2016-8-8',597.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(624311,5,'2016-8-6','2016-8-9',38.40,'��Ҫ���ʵģ�������','�й�����',1,1)

-- ������
insert orderForm values(5541,1,'2016-8-5','2016-8-6',264.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(5231,2,'2016-8-9','2016-8-10',88.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(3423551,4,'2016-8-7','2016-8-8',308.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(54311,5,'2016-8-6','2016-8-9',152.0,'��Ҫ���ʵģ�������','�й�����',1,1)

--������
insert orderForm values(445541,1,'2016-8-5','2016-8-6',714.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(942431,2,'2016-8-9','2016-8-10',53.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(3243551,4,'2016-8-7','2016-8-8',108.0,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(925311,5,'2016-8-6','2016-8-9',71.20,'��Ҫ���ʵģ�������','�й�����',1,1)

--������
insert orderForm values(234411,1,'2016-8-5','2016-8-6',124.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(524311,2,'2016-8-9','2016-8-10',168.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(452511,4,'2016-8-7','2016-8-8',725.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(15311,5,'2016-8-6','2016-8-9',790.00,'��Ҫ���ʵģ�������','�й�����',1,1)
-- ������
insert orderForm values(5451,1,'2016-8-5','2016-8-6',30.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(5434651,3,'2016-8-9','2016-8-10',228.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(54541,4,'2016-8-7','2016-8-8',95.40,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(443331,5,'2016-8-6','2016-8-9',39.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--������
insert orderForm values(5655451,1,'2016-8-5','2016-8-6',1176.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(43341,3,'2016-8-9','2016-8-10',649.60,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(55441,4,'2016-8-7','2016-8-8',132.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(6431441,5,'2016-8-6','2016-8-9',516.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--������
insert orderForm values(45551,1,'2016-8-5','2016-8-6',57.80,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(35631,3,'2016-8-9','2016-8-10',76.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(4541,4,'2016-8-7','2016-8-8',51.80,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(24441,5,'2016-8-6','2016-8-9',23.60,'��Ҫ���ʵģ�������','�й�����',1,1)
-- ʮ����
insert orderForm values(15552,1,'2016-8-5','2016-8-6',108.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(114532,3,'2016-8-9','2016-8-10',139.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(115542,4,'2016-8-7','2016-8-8',188.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(3142,5,'2016-8-6','2016-8-9',450.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--ʮһ����
insert orderForm values(1232,1,'2016-8-5','2016-8-6',140.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(3532,3,'2016-8-9','2016-8-10',398.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(2542,4,'2016-8-7','2016-8-8',1580.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(23142,5,'2016-8-6','2016-8-9',1680.00,'��Ҫ���ʵģ�������','�й�����',1,1)



----ʣ�����ͺ��·� ����
insert orderForm values(6787493,1,'2016-2-5','2016-2-6',132.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(724493,2,'2016-2-9','2016-2-10',140.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(44231231,4,'2016-2-7','2016-2-8',218.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(471231,5,'2016-2-6','2016-2-9',132.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--����
insert orderForm values(4434454,1,'2016-3-5','2016-3-6',27.7,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(424934,2,'2016-3-9','2016-3-10',140.70,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(494545,4,'2016-3-7','2016-3-8',597.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(6245431,5,'2016-3-6','2016-3-9',38.40,'��Ҫ���ʵģ�������','�й�����',1,1)
--����
insert orderForm values(7344554,1,'2016-4-5','2016-4-6',264.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(854523,2,'2016-4-9','2016-4-10',88.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(842342355,4,'2016-4-7','2016-4-8',308.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(8255431,5,'2016-4-6','2016-4-9',152.0,'��Ҫ���ʵģ�������','�й�����',1,1)
--����
insert orderForm values(9344554,1,'2016-5-5','2016-5-6',714.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(9554243,2,'2016-5-9','2016-5-10',53.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(923424355,4,'2016-5-7','2016-5-8',108.0,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(925554431,5,'2016-5-6','2016-5-9',71.20,'��Ҫ���ʵģ�������','�й�����',1,1)
--����
insert orderForm values(2343244,1,'2016-6-5','2016-6-6',124.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(9255243,2,'2016-6-9','2016-6-10',168.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(4523545,4,'2016-6-7','2016-6-8',725.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(15724431,5,'2016-6-6','2016-6-9',790.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--����
insert orderForm values(2355545,1,'2016-7-5','2016-7-6',30.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(14543465,3,'2016-7-9','2016-7-10',228.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(4465454,4,'2016-7-7','2016-7-8',95.40,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(2624333,5,'2016-7-6','2016-7-9',39.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--����
insert orderForm values(234565545,1,'2016-8-5','2016-8-6',1176.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(1454334,3,'2016-8-9','2016-8-10',649.60,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(4435544,4,'2016-8-7','2016-8-8',132.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(233643144,5,'2016-8-6','2016-8-9',516.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--����
insert orderForm values(234555,1,'2015-9-5','2015-9-6',57.80,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(133563,3,'2015-9-9','2015-9-10',76.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(44454,4,'2015-9-7','2015-9-8',51.80,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(244314,5,'2015-9-6','2015-9-9',23.60,'��Ҫ���ʵģ�������','�й�����',1,1)
-- ʮ��
insert orderForm values(1141555,1,'2015-10-5','2015-10-6',108.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(114554533,3,'2015-10-9','2015-10-10',139.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(114645554,4,'2015-10-7','2015-10-8',188.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(11443314,5,'2015-10-6','2015-10-9',450.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--ʮһ��
insert orderForm values(1234005,1,'2015-11-5','2015-11-6',140.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(3525543,3,'2015-11-9','2015-11-10',398.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(23454,4,'2015-11-7','2015-11-8',1580.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(252314,5,'2015-11-6','2015-11-9',1680.00,'��Ҫ���ʵģ�������','�й�����',1,1)
--ʮ����
insert orderForm values(24350405,1,'2015-12-5','2015-12-6',140.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(23445443,3,'2015-12-9','2015-12-10',398.00,'��Ҫ���ʵ�','�й�����',1,1)
insert orderForm values(244554,4,'2015-12-7','2015-12-8',1580.00,'��Ҫ���ʵģ�������','�й�����',1,1)
insert orderForm values(2436314,5,'2015-12-6','2015-12-9',1680.00,'��Ҫ���ʵģ�������','�й�����',1,1)

select * from orderForm

--�����б���Ϣ��
go
create table orderList(
	oListID int primary key identity(1,1),				--�����б���
	oLID int foreign key references orderForm(oId) ,	--�������
	pID int foreign key references productInfo(pid),	--��Ʒ���
	amount int											--������Ʒ����
)
--δ�����
insert  orderList values(1,1,3)
insert  orderList values(2,2,3)
insert  orderList values(3,3,3)
insert  orderList values(4,4,3)
insert  orderList values(5,5,3)
insert  orderList values(6,6,3)
-- һ����
insert  orderList values(7,1,3)
insert  orderList values(8,2,3)
insert  orderList values(9,3,3)
insert  orderList values(10,4,3)
insert  orderList values(11,5,3)
insert  orderList values(12,6,3)
--����
insert  orderList values(13,9,3)
insert  orderList values(14,10,3)
insert  orderList values(15,11,3)
insert  orderList values(16,12,3)
--����
insert  orderList values(17,13,3)
insert  orderList values(18,14,3)
insert  orderList values(19,15,3)
insert  orderList values(20,16,3)
--����
insert  orderList values(21,21,3)
insert  orderList values(22,22,3)
insert  orderList values(23,23,3)
insert  orderList values(24,24,3)
--����
insert  orderList values(25,17,4)
insert  orderList values(26,18,4)
insert  orderList values(27,19,4)
insert  orderList values(28,20,4)
--����
insert  orderList values(29,25,4)
insert  orderList values(30,26,4)
insert  orderList values(31,27,4)
insert  orderList values(32,28,4)
--����
insert  orderList values(33,29,6)
insert  orderList values(34,30,6)
insert  orderList values(35,31,6)
insert  orderList values(36,32,6)
--����
insert  orderList values(37,33,7)
insert  orderList values(38,34,7)
insert  orderList values(39,35,7)
insert  orderList values(40,36,7)
--����
insert  orderList values(41,37,6)
insert  orderList values(42,38,6)
insert  orderList values(43,39,6)
insert  orderList values(44,40,6)
--ʮ��
insert  orderList values(45,41,9)
insert  orderList values(46,42,9)
insert  orderList values(47,43,9)
insert  orderList values(48,44,9)
--ʮһ��
insert  orderList values(49,45,10)
insert  orderList values(50,46,10)
insert  orderList values(51,47,10)
insert  orderList values(52,48,10)


--ʣ������ ���·� ����
--����
insert  orderList values(53,9,2)
insert  orderList values(54,10,2)
insert  orderList values(55,11,2)
insert  orderList values(56,12,2)
--����
insert  orderList values(57,13,3)
insert  orderList values(58,14,3)
insert  orderList values(59,15,3)
insert  orderList values(60,16,3)
--����
insert  orderList values(61,21,4)
insert  orderList values(62,22,4)
insert  orderList values(63,23,4)
insert  orderList values(64,24,4)
--����
insert  orderList values(65,17,3)
insert  orderList values(66,18,3)
insert  orderList values(67,19,3)
insert  orderList values(68,20,4)
--����
insert  orderList values(69,25,5)
insert  orderList values(70,26,5)
insert  orderList values(71,27,5)
insert  orderList values(72,28,5)
--����
insert  orderList values(73,29,6)
insert  orderList values(74,30,6)
insert  orderList values(75,31,6)
insert  orderList values(76,32,6)
--����
insert  orderList values(77,33,2)
insert  orderList values(78,34,2)
insert  orderList values(79,35,2)
insert  orderList values(80,36,2)
--����
insert  orderList values(81,37,2)
insert  orderList values(82,38,2)
insert  orderList values(83,39,2)
insert  orderList values(84,40,2)
--ʮ��
insert  orderList values(85,41,10)
insert  orderList values(86,42,10)
insert  orderList values(87,43,10)
insert  orderList values(88,44,10)
--ʮһ��
insert  orderList values(89,45,10)
insert  orderList values(90,46,10)
insert  orderList values(91,47,10)
insert  orderList values(92,48,10)

--ʮ����
insert  orderList values(93,45,10)
insert  orderList values(94,46,10)
insert  orderList values(95,47,10)
insert  orderList values(96,48,10)


--select * from orderList
----��Ӧ��Ʒ���͵Ľ�����Ʒ������
--select SUM(p.amount) ������  from productInfo p inner join pType t on p.pTypeInfoId=t.pTypeId 
--	where t.pTypeName='"+type+"'

--select distinct  t.pTypeName ����, sum(o.amount) ���������� from productInfo p inner join  orderList o on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId inner join orderForm f on f.oId=o.oListID
--	 where  f.isPayoff=1 and f.isOut=1 group by t.pTypeName

--select t.pTypeName as type,sum(p.amount)  as total, sum(o.amount) as outtotal from productInfo p inner join  orderList o on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId inner join orderForm f on f.oId=o.oListID where  f.isPayoff=1 and f.isOut=1  group by t.pTypeName
--select pTypeId,pTypeName from pType

----��Ӧ���� ��ͬ���·ݵ� ��Ʒ����������
--select * from (select t.pTypeName ����, sum(o.amount) ���������� from orderList o inner join productInfo p
--	on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId
--	inner join orderForm f on f.oId=o.oListID
--	where  f.isPayoff=1 and f.isOut=1
--	group by t.pTypeName) as b ,(select * from sum(amount)  as ������ from productInfo inner join  orderList o on o.pID=p.pid inner join pType t on t.pTypeId = pTypeInfoId inner join orderForm f on f.oId=o.oListID
--	 where  f.isPayoff=1 and f.isOut=1 group by t.pTypeName) as c
--go
--select datepart(mm,outTime) from orderForm where oId=7
--select * from orderList





















--���۱�
go
create table comment(
	comId int primary key identity(1,1),				--���۱��
	comUserId int foreign key references [user](userID) ,--�����˱��
	pid int foreign key references productInfo(pid) ,     --��Ʒ���
	content ntext,										--��������
	commentTime datetime,								--����ʱ��
	isGood varchar(20)									--�ǲ��к���?
)
select c.*,p.pName,u.username from comment c inner join productInfo p on p.pid=c.pid  inner join [user] u on c.comUserId=u.userID where 1=1 and isGood='����' and c.pid=5 order by  c.commentTime desc
insert into comment values(1,5,'�ܺó�','2015-10-10','����')	
insert into comment values(2,5,'һ���','2015-1-1','����')
insert into comment values(3,5,'�´�����','2015-3-7','����')
insert into comment values(4,5,'�ܺóԵ�Ŷ','2015-1-8','����')
insert into comment values(1,5,'�ܺó�,�ҽ�����Ҳ��������','2015-10-8','����')	
insert into comment values(2,5,'������Ŷ,','2015-1-1','����')
insert into comment values(3,5,'�´λ�������ҵ�','2015-3-5','����')
insert into comment values(4,5,'�����е���Ŷ','2015-1-3','����')
insert into comment values(5,1,'�����е���','2015-2-4','����')
insert into comment values(1,1,'�ܲ���Ŷ','2015-7-9','����')
insert into comment values(6,1,'�����ó�','2015-4-8','����')
select * from comment
--�ظ���

go
create table reply(
	rId int primary key identity(1,1),					--�ظ����
	rUserId int ,										--�ظ��˱��
	rComId int foreign key references comment (comId) , --���۱��
	pid int foreign key references productInfo(pid),	--�ظ���Ʒ�ı��
	rContent ntext,										--�ظ�����
	replyTime datetime									--�ظ�ʱ��ʱ��									--�ظ�����
)
select * from reply


--���ﳵ��
create table shopping_cart( 
	cid int primary key identity(1,1),							--���ﳵ��� 
	userID int foreign key references [user](userID),			--�û����
	[sid] int foreign key references productInfo(pid),			--��Ʒ���
	sPicture varchar(100),										--��ƷͼƬ
	sName  varchar(600),										--��Ʒ����
	price float,												--�۸�
	amount int,													--����
	total float,												--�ϼ�
	sguiGe varchar(50) ,										--���
)

select * from shopping_cart


--����Ա�˺�
go
insert into admins (adminName,adminPassword) values
	('21232F297A57A5A743894A0E4A801FC3','21232F297A57A5A743894A0E4A801FC3')
select * from admins


