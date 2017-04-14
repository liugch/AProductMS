package com.jFreeChart;

import java.awt.Color;
import java.awt.Font;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.RectangleEdge;
import org.jfree.ui.RectangleInsets;

import com.util.DBUitl;


@WebServlet("/OutPTypeChart.action")
public class OutPTypeChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//数据源
	 private  CategoryDataset createDataset(int year,int month,String type){ //创建柱状图数据集
	        DefaultCategoryDataset dataset=new DefaultCategoryDataset();
	        StringBuffer sb=new StringBuffer();
	        sb.append("select distinct t.pTypeName as type,sum(p.amount)  as total, sum(o.amount) as outtotal from productInfo p inner join  orderList o on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId inner join orderForm f on f.oId=o.oListID where  f.isPayoff=1 and f.isOut=1 ");
		     if(year!=0){
	        	sb.append(" and DATEPART(YYYY,f.outTime)="+year+"");
	        }
	        if(month!=0){
	        	sb.append(" and MONTH(f.outTime)="+month+"");
	        }
	        if(type!=null&&!"".equals(type.trim())){
	        	sb.append(" and t.pTypeName='"+type+"'");
	        }
	        sb.append(" group by t.pTypeName");
	        //String sql="select t.pTypeName as type,sum(p.amount)  as total, sum(o.amount) as outtotal from productInfo p inner join  orderList o on o.pID=p.pid inner join pType t on t.pTypeId = p.pTypeInfoId inner join orderForm f on f.oId=o.oListID where  f.isPayoff=1 and f.isOut=1 group by t.pTypeName";
	        String sql=sb.toString();
	       System.out.println("sql:"+sql);
	        Connection conn=null;
	        PreparedStatement ps=null;
	        ResultSet rs=null;
	        try {
	        	conn=DBUitl.getCon();
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				while(rs.next()){
						//System.out.println(rs.getString("type")+"::"+rs.getInt("outtotal")+"::::");
					  dataset.setValue(rs.getInt("outtotal"),rs.getString("type"),rs.getString("type"));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				DBUitl.closeAll(rs, ps, conn);
			}
	     
	        return dataset;
	 }
	  //保存为文件   
	    private  void saveAsFile(JFreeChart chart, String outputPath, int weight, int height) {   
	        FileOutputStream out = null;
	        try {   
	            File outFile = new File(outputPath);   
	           if (!outFile.getParentFile().exists()) {   
	                outFile.getParentFile().mkdirs();   
	            }
	        
	            out = new FileOutputStream(outputPath);   
	            //保存为PNG文件   
	            ChartUtilities.writeChartAsJPEG(out, chart, weight, height);   
	            //保存为JPEG文件   
	            //ChartUtilities.writeChartAsJPEG(out, chart, weight, height);   
	            out.flush();   
	        } catch (FileNotFoundException e) {   
	            e.printStackTrace();   
	        } catch (IOException e) {   
	            e.printStackTrace();   
	        } finally {   
	            if (out != null) {   
	                try {   
	                    out.flush();
	                	out.close();   
	                } catch (IOException e) {   
	                  
	                }   
	            }   
	        }   
	    }   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int year=0;
		int month=0;
		String type=null;
		String years=request.getParameter("year");
		String months=request.getParameter("month");
		String types=request.getParameter("type");
		System.out.println("years"+years+",months"+months+",types"+types);
		if(years!=null&&!"".equals(years.trim()))
			year=Integer.parseInt(years);
		if(months!=null&&!"".equals(months.trim()))
			month=Integer.parseInt(months);
		if(types!=null&&!"".equals(types.trim()))
			type=types;
		JFreeChart chart = ChartFactory.createBarChart3D(
							"鲜尚鲜销量图",
							"类型",
							"销量",  
			                createDataset(year,month,type), 
			                PlotOrientation.VERTICAL, true, true, true
			                );

		CategoryPlot  plot = (CategoryPlot) chart.getPlot(); 
		//设置标题
		//TextTitle textTitle = chart.getTitle(); 
		//textTitle.setFont(new Font("黑体", Font.PLAIN,25)); 
	    //plot.setBackgroundPaint(Color.lightGray);
    	//plot.setBackgroundPaint(new Color(225, 255, 225));// 设置柱图背景色（注意，系统取色的时候要使用16位的模式来查看颜色编码，这样比较准确）
    	plot.setRangeGridlinesVisible(true);// 设置横虚线可见
    //	plot.setRangeGridlinePaint(Color.gray);// 虚线色彩
    
    	
    	//图例的位置
    	chart.getLegend().setPosition(RectangleEdge.RIGHT);
		/* 纵轴的刻度 重置*/
		/*NumberAxis numberAxis = (NumberAxis) plot.getRangeAxis();
		DecimalFormat df=new DecimalFormat("0%");
		numberAxis.setUpperBound(1);
		numberAxis.setNumberFormatOverride(df);
		numberAxis.setAutoTickUnitSelection(false);
	     //设置纵坐标值的间距为10
		numberAxis.setTickUnit(new NumberTickUnit(0.1));
	    //纵坐标值只能是0-100之间的值
		numberAxis.setRangeWithMargins(0, 1);*/
		
		/*横轴和纵轴标题的字体*/
		Font labelFont = new Font("黑体", Font.TRUETYPE_FONT, 12);   	
    	CategoryAxis domainAxis = plot.getDomainAxis();
    	//改整張圖的標題 
		
		 //圖下方軸
		 //座標上的文字 
		domainAxis.setTickLabelFont(labelFont); 
		 //標題文字
		domainAxis.setLabelFont(labelFont); 
		 //圖左邊軸 
		ValueAxis valueAxis2 =plot.getRangeAxis();
		 //座標上的文字 
		valueAxis2.setTickLabelFont(labelFont); 
		//標題文字
		 valueAxis2.setLabelFont(labelFont);
		 // X轴上的Lable让其45度倾斜
   		domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45); 
		// 设置距离图片左端距离 
   		//	domainAxis.setLowerMargin(0.03); 
		// 设置距离图片右端距离 
		//domainAxis.setUpperMargin(0.03);
		
		/*柱状的宽度的设定     和其他的属性*/
    	BarRenderer renderer = new BarRenderer();
    	//renderer.setItemMargin(0.1); //柱子之间的间隔
    	//renderer.setItemLabelAnchorOffset(-3); 
    	renderer.setMaximumBarWidth(0.02);// 设置柱子宽度//TODO 0.05
    	renderer.setMinimumBarLength(0.1);// 设置柱子高度
    	//renderer.setBaseOutlinePaint(Color.BLACK);// 设置柱子边框颜色
    	//renderer.setDrawBarOutline(true);// 设置柱子边框可见

    	/*每个柱子上显示数值*/
    
    	renderer.setItemMargin(0.0);
    	renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());//显示每个柱的数值
    	renderer.setBaseItemLabelsVisible(true);
    	
    	  
    	//图形  距离纵轴和横轴的 距离  new RectangleInsets(top, left, bottom, right)
    	//plot.setAxisOffset(new RectangleInsets(10D, 0, 10D, 0)); 
    	plot.setRenderer(renderer);
    	
    	renderer.setItemMargin(0.0);// 设置每个地区所包含的平行柱的之间距离
 
    	String savaPath=request.getSession().getServletContext().getRealPath("/images/jFreeChart/t.jpg");
		System.out.println(savaPath);
    	saveAsFile(chart, savaPath, 850,500);
		System.out.println("保存成功完成!");
		
		String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/images/jFreeChart/t.jpg";
		System.out.println(url);
		response.getWriter().println(url);
	
	}
	
}
