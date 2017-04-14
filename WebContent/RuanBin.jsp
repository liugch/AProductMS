<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="org.jfree.data.general.DefaultPieDataset,org.jfree.chart.ChartFactory
,org.jfree.chart.JFreeChart,org.jfree.chart.servlet.*" %>
    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>

<%

	int n[]={0,0,0,0,0,1,0,0,0,0,0};	//添加数据  
	String[] timeValue = { "进口水果","国产水果","精选肉类","禽类单品","海鲜水产","乳萍糕点","新鲜蔬菜","方便速食","杂货粮油","饮料酒水","礼品礼券" };
	 
	DefaultPieDataset dpd = new DefaultPieDataset();		
	for(int i=0;i<timeValue.length;i++){
	    dpd.setValue(timeValue[i], n[i]);	   
	}
	
    

    
    JFreeChart chart = ChartFactory.createPieChart("某公司组织结构图",dpd, true, false, false);
    
    String fileName = ServletUtilities.saveChartAsPNG(chart,800,600,session); 
    //ServletUtilities是面向web开发的工具类，返回一个字符串文件名,文件名自动生成，生成好的图片会自动放在服务器（tomcat）的临时文件下（temp）
    
    String url = request.getContextPath() + "/DisplayChart?filename=" + fileName;
    //根据文件名去临时目录下寻找该图片，这里的/DisplayChart路径要与配置文件里用户自定义的<url-pattern>一致
  
	System.out.print(url);
%>

<img src="<%= url %>" width="800" height="600">

</body>
</html>