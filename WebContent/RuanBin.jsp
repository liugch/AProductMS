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

	int n[]={0,0,0,0,0,1,0,0,0,0,0};	//�������  
	String[] timeValue = { "����ˮ��","����ˮ��","��ѡ����","���൥Ʒ","����ˮ��","��Ƽ���","�����߲�","������ʳ","�ӻ�����","���Ͼ�ˮ","��Ʒ��ȯ" };
	 
	DefaultPieDataset dpd = new DefaultPieDataset();		
	for(int i=0;i<timeValue.length;i++){
	    dpd.setValue(timeValue[i], n[i]);	   
	}
	
    

    
    JFreeChart chart = ChartFactory.createPieChart("ĳ��˾��֯�ṹͼ",dpd, true, false, false);
    
    String fileName = ServletUtilities.saveChartAsPNG(chart,800,600,session); 
    //ServletUtilities������web�����Ĺ����࣬����һ���ַ����ļ���,�ļ����Զ����ɣ����ɺõ�ͼƬ���Զ����ڷ�������tomcat������ʱ�ļ��£�temp��
    
    String url = request.getContextPath() + "/DisplayChart?filename=" + fileName;
    //�����ļ���ȥ��ʱĿ¼��Ѱ�Ҹ�ͼƬ�������/DisplayChart·��Ҫ�������ļ����û��Զ����<url-pattern>һ��
  
	System.out.print(url);
%>

<img src="<%= url %>" width="800" height="600">

</body>
</html>