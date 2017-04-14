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

	//��������
    String[] timeValue = { "����ˮ��","����ˮ��","��ѡ����","���൥Ʒ","����ˮ��","��Ƽ���","�����߲�","������ʳ","�ӻ�����","���Ͼ�ˮ","��Ʒ��ȯ" };
    String[] se={"a","b","c","d","e","f","g","h","i","j","k"};
    int n[]={0,0,0,0,0,1,0,0,0,0,0};
    //newһ����״ͼ
	DefaultCategoryDataset dataset=new DefaultCategoryDataset();
    for (int i = 0; i < timeValue.length; i++) {

	   dataset.setValue(n[i],se[i],timeValue[i]);
}
    
    JFreeChart chart=ChartFactory.createBarChart("hi", "һ��","����", dataset, PlotOrientation.VERTICAL, true, true, false); //����һ��JFreeChart
    chart.setTitle(new TextTitle("������һ����������ͼ",new Font("����",Font.BOLD+Font.ITALIC,20)));//�����������ñ��⣬�滻��hi������
    CategoryPlot plot=(CategoryPlot)chart.getPlot();//���ͼ���м䲿�֣���plot
    CategoryAxis categoryAxis=plot.getDomainAxis();//��ú�����
    categoryAxis.setLabelFont(new Font("΢���ź�",Font.BOLD,12));//���ú���������
    
    String fileName = ServletUtilities.saveChartAsPNG(chart,800,600,session); 
    String url = request.getContextPath() + "/DisplayChart?filename=" + fileName;
    //�����ļ���ȥ��ʱĿ¼��Ѱ�Ҹ�ͼƬ�������/DisplayChart·��Ҫ�������ļ����û��Զ����<url-pattern>һ��

	%>
	<img src="<%= url %>" width="800" height="600">
</body>
</html>