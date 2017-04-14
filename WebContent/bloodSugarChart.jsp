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
      	// 曲线名称
      String series = "2016年度每月销售量";  // series指的就是报表里的那条数据线
                      //因此 对数据线的相关设置就需要联系到serise
                      //比如说setSeriesPaint 设置数据线的颜色

      	// 横轴名称(列名称) 
      String[] time = new String[12];
      String[] timeValue = { "进口水果","国产水果","精选肉类","禽类单品","海鲜水产","乳萍糕点","新鲜蔬菜","方便速食","杂货粮油","饮料酒水","礼品礼券" };
      for (int i = 0; i < timeValue.length; i++) {
             time[i] = timeValue[i];
      }
      int n[]={0,0,0,0,0,1,0,0,0,0,0};
      //随机添加数据值
      for (int i = 0; i < timeValue.length; i++) {
    	  					//值      //series哪条数据线  //time[i] 对应的横轴
             linedataset.addValue(n[i], series, time[i]); 
      }


          //定义图标对象
          JFreeChart chart = ChartFactory.createLineChart(null,// 报表题目，字符串类型
	                               "一月", // 横轴
	                               "销售量(种类)", // 纵轴
	                               linedataset, // 获得数据集
	                               PlotOrientation.VERTICAL, // 图标方向垂直
	                               true, // 显示图例
	                               false, // 不用生成工具
	                               false // 不用生成URL地址
	                               );
          	//整个大的框架属于chart  可以设置chart的背景颜色

          	// 生成图形
          CategoryPlot plot = chart.getCategoryPlot();
          // 图像属性部分
          plot.setBackgroundPaint(Color.white);
          plot.setDomainGridlinesVisible(true);  //设置背景网格线是否可见
          plot.setDomainGridlinePaint(Color.BLACK); //设置背景网格线颜色
          plot.setRangeGridlinePaint(Color.GRAY);
          plot.setNoDataMessage("没有数据");//没有数据时显示的文字说明。 
          // 数据轴属性部分
          NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
          rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
          rangeAxis.setAutoRangeIncludesZero(true); //自动生成
          rangeAxis.setUpperMargin(0.20);
          rangeAxis.setLabelAngle(Math.PI / 2.0); 
          rangeAxis.setAutoRange(false);
          // 数据渲染部分 主要是对折线做操作
          LineAndShapeRenderer renderer = (LineAndShapeRenderer) plot
                        .getRenderer();
          renderer.setBaseItemLabelsVisible(true);
          renderer.setSeriesPaint(0, Color.black);    //设置折线的颜色
          renderer.setBaseShapesFilled(true);
          renderer.setBaseItemLabelsVisible(true);     
          renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(
                        ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_LEFT));
          renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());  

          renderer.setBaseItemLabelFont(new Font("Dialog", 1, 14));  //设置提示折点数据形状
          plot.setRenderer(renderer);
          //区域渲染部分
          double lowpress = 49; 
          double uperpress = 50;   //设定正常血糖值的范围
        IntervalMarker inter = new IntervalMarker(lowpress, uperpress);  
        inter.setLabelOffsetType(LengthAdjustmentType.EXPAND); //  范围调整——扩张
        inter.setPaint(Color.LIGHT_GRAY);// 域顏色  
    
        inter.setLabelFont(new Font("SansSerif", 41, 14));  
        inter.setLabelPaint(Color.RED);  
        inter.setLabel("                                        最低销售量范围");    //设定区域说明文字
        plot.addRangeMarker(inter,Layer.BACKGROUND);  //添加mark到图形   BACKGROUND使得数据折线在区域的前端

        // 创建文件输出流
       // File fos_jpg = new File("E://bloodSugarChart.jpg ");
         // 输出到哪个输出流				// 统计图表对象 // 宽 	// 高
        	//ChartUtilities.saveChartAsJPEG(fos_jpg, chart, 700,	500);
         
        String fileName = ServletUtilities.saveChartAsPNG(chart,800,600,session); 
        //ServletUtilities是面向web开发的工具类，返回一个字符串文件名,文件名自动生成，生成好的图片会自动放在服务器（tomcat）的临时文件下（temp）
        
        String url = request.getContextPath() + "/DisplayChart?filename=" + fileName;
        //根据文件名去临时目录下寻找该图片，这里的/DisplayChart路径要与配置文件里用户自定义的<url-pattern>一致
      

      	
		%>
		<img src="<%=url %>">

</body>
</html>