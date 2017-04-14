<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="java.awt.Font" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.Color" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.jfree.chart.ChartFactory" %>
<%@ page import="org.jfree.chart.ChartUtilities" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="org.jfree.chart.axis.NumberAxis" %>
<%@ page import="org.jfree.chart.labels.ItemLabelAnchor" %>
<%@ page import="org.jfree.chart.labels.ItemLabelPosition" %>
<%@ page import="org.jfree.chart.labels.StandardCategoryItemLabelGenerator" %>
<%@ page import="org.jfree.chart.plot.CategoryPlot" %>
<%@ page import="org.jfree.chart.plot.IntervalMarker" %>
<%@ page import="org.jfree.chart.plot.PlotOrientation" %>
<%@ page import="org.jfree.chart.renderer.category.LineAndShapeRenderer" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>
<%@ page import="org.jfree.ui.Layer" %>
<%@ page import="org.jfree.ui.LengthAdjustmentType" %>
<%@ page import="org.jfree.ui.TextAnchor" %>
<%@ page import=" org.jfree.chart.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
		<%
		  DefaultCategoryDataset linedataset = new DefaultCategoryDataset();
      	// ��������
      String series = "2016���ÿ��������";  // seriesָ�ľ��Ǳ����������������
                      //��� �������ߵ�������þ���Ҫ��ϵ��serise
                      //����˵setSeriesPaint ���������ߵ���ɫ

      	// ��������(������) 
      String[] time = new String[12];
      String[] timeValue = { "����ˮ��","����ˮ��","��ѡ����","���൥Ʒ","����ˮ��","��Ƽ���","�����߲�","������ʳ","�ӻ�����","���Ͼ�ˮ","��Ʒ��ȯ" };
      for (int i = 0; i < timeValue.length; i++) {
             time[i] = timeValue[i];
      }
      int n[]={0,0,0,0,0,1,0,0,0,0,0};
      //����������ֵ
      for (int i = 0; i < timeValue.length; i++) {
    	  					//ֵ      //series����������  //time[i] ��Ӧ�ĺ���
             linedataset.addValue(n[i], series, time[i]); 
      }


          //����ͼ�����
          JFreeChart chart = ChartFactory.createLineChart(null,// ������Ŀ���ַ�������
	                               "һ��", // ����
	                               "������(����)", // ����
	                               linedataset, // ������ݼ�
	                               PlotOrientation.VERTICAL, // ͼ�귽��ֱ
	                               true, // ��ʾͼ��
	                               false, // �������ɹ���
	                               false // ��������URL��ַ
	                               );
          	//������Ŀ������chart  ��������chart�ı�����ɫ

          	// ����ͼ��
          CategoryPlot plot = chart.getCategoryPlot();
          // ͼ�����Բ���
          plot.setBackgroundPaint(Color.white);
          plot.setDomainGridlinesVisible(true);  //���ñ����������Ƿ�ɼ�
          plot.setDomainGridlinePaint(Color.BLACK); //���ñ�����������ɫ
          plot.setRangeGridlinePaint(Color.GRAY);
          plot.setNoDataMessage("û������");//û������ʱ��ʾ������˵���� 
          // ���������Բ���
          NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
          rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
          rangeAxis.setAutoRangeIncludesZero(true); //�Զ�����
          rangeAxis.setUpperMargin(0.20);
          rangeAxis.setLabelAngle(Math.PI / 2.0); 
          rangeAxis.setAutoRange(false);
          // ������Ⱦ���� ��Ҫ�Ƕ�����������
          LineAndShapeRenderer renderer = (LineAndShapeRenderer) plot
                        .getRenderer();
          renderer.setBaseItemLabelsVisible(true);
          renderer.setSeriesPaint(0, Color.black);    //�������ߵ���ɫ
          renderer.setBaseShapesFilled(true);
          renderer.setBaseItemLabelsVisible(true);     
          renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(
                        ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_LEFT));
          renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());  

          renderer.setBaseItemLabelFont(new Font("Dialog", 1, 14));  //������ʾ�۵�������״
          plot.setRenderer(renderer);
          //������Ⱦ����
          double lowpress = 49; 
          double uperpress = 50;   //�趨����Ѫ��ֵ�ķ�Χ
        IntervalMarker inter = new IntervalMarker(lowpress, uperpress);  
        inter.setLabelOffsetType(LengthAdjustmentType.EXPAND); //  ��Χ������������
        inter.setPaint(Color.LIGHT_GRAY);// ���ɫ  
    
        inter.setLabelFont(new Font("SansSerif", 41, 14));  
        inter.setLabelPaint(Color.RED);  
        inter.setLabel("                                        �����������Χ");    //�趨����˵������
        plot.addRangeMarker(inter,Layer.BACKGROUND);  //���mark��ͼ��   BACKGROUNDʹ�����������������ǰ��

        // �����ļ������
       // File fos_jpg = new File("E://bloodSugarChart.jpg ");
         // ������ĸ������				// ͳ��ͼ����� // �� 	// ��
        	//ChartUtilities.saveChartAsJPEG(fos_jpg, chart, 700,	500);
         
        String fileName = ServletUtilities.saveChartAsPNG(chart,800,600,session); 
        //ServletUtilities������web�����Ĺ����࣬����һ���ַ����ļ���,�ļ����Զ����ɣ����ɺõ�ͼƬ���Զ����ڷ�������tomcat������ʱ�ļ��£�temp��
        
        String url = request.getContextPath() + "/DisplayChart?filename=" + fileName;
        //�����ļ���ȥ��ʱĿ¼��Ѱ�Ҹ�ͼƬ�������/DisplayChart·��Ҫ�������ļ����û��Զ����<url-pattern>һ��
      

      	
		%>
		<img src="<%=url %>">

</body>
</html>