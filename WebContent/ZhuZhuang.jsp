<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
  <%@ page import="java.awt.Font" %>
 <%@ page import="javax.swing.JPanel" %>
 <%@ page import="org.jfree.chart.ChartFactory" %>
 <%@ page import="org.jfree.chart.ChartPanel" %>
 <%@ page import="org.jfree.chart.JFreeChart" %>
 <%@ page import="org.jfree.chart.axis.CategoryAxis" %>
 <%@ page import="org.jfree.chart.plot.CategoryPlot" %>
 <%@ page import="org.jfree.chart.plot.PlotOrientation" %>
 <%@ page import="org.jfree.chart.title.TextTitle" %>
 <%@ page import="org.jfree.data.category.CategoryDataset" %>
 <%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>
 <%@ page import="org.jfree.ui.ApplicationFrame" %>
  <%@ page import=" org.jfree.chart.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
	<%

	//测试数据
    String[] timeValue = { "进口水果","国产水果","精选肉类","禽类单品","海鲜水产","乳萍糕点","新鲜蔬菜","方便速食","杂货粮油","饮料酒水","礼品礼券" };
    String[] se={"a","b","c","d","e","f","g","h","i","j","k"};
    int n[]={0,0,0,0,0,1,0,0,0,0,0};
    //new一个柱状图
	DefaultCategoryDataset dataset=new DefaultCategoryDataset();
    for (int i = 0; i < timeValue.length; i++) {

	   dataset.setValue(n[i],se[i],timeValue[i]);
}
    
    JFreeChart chart=ChartFactory.createBarChart("hi", "一周","销量", dataset, PlotOrientation.VERTICAL, true, true, false); //创建一个JFreeChart
    chart.setTitle(new TextTitle("鲜尚鲜一周种类销售图",new Font("宋体",Font.BOLD+Font.ITALIC,20)));//可以重新设置标题，替换“hi”标题
    CategoryPlot plot=(CategoryPlot)chart.getPlot();//获得图标中间部分，即plot
    CategoryAxis categoryAxis=plot.getDomainAxis();//获得横坐标
    categoryAxis.setLabelFont(new Font("微软雅黑",Font.BOLD,12));//设置横坐标字体
    
    String fileName = ServletUtilities.saveChartAsPNG(chart,800,600,session); 
    String url = request.getContextPath() + "/DisplayChart?filename=" + fileName;
    //根据文件名去临时目录下寻找该图片，这里的/DisplayChart路径要与配置文件里用户自定义的<url-pattern>一致

	%>
	<img src="<%= url %>" width="800" height="600">
</body>
</html>