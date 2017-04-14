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
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.RectangleInsets;

import com.util.DBUitl;


@WebServlet("/OutPTypeChart2.action")
public class OutPTypeChartServlet2 extends HttpServlet {
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
						System.out.println(rs.getString("type")+"::"+rs.getDouble("outtotal")+"::::");
						  dataset.addValue(rs.getDouble("outtotal"),"2016年度每月销售量",rs.getString("type"));
						
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
	
		 JFreeChart chart = ChartFactory.createLineChart(
				 	"鲜尚鲜销量率图",
					"类型",
					"销售量",  
					  createDataset(year,month,""),// data
				    PlotOrientation.VERTICAL, // orientation
				    true, // include legend
				    true, // tooltips
				    false // urls
				    );
			 CategoryPlot plot = chart.getCategoryPlot();
			  // customise the range axis...
			  NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
			  rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
			  rangeAxis.setAutoRangeIncludesZero(true);
			  rangeAxis.setUpperMargin(0.20);
			  rangeAxis.setLabelAngle(Math.PI / 2.0); 
			  
		
	    	String savaPath=request.getSession().getServletContext().getRealPath("/images/jFreeChart/t2.jpg");
			System.out.println(savaPath);
	    	saveAsFile(chart, savaPath, 750,530);
			System.out.println("保存成功完成!");
		
		String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/images/jFreeChart/t2.jpg";
		System.out.println(url);
		response.getWriter().println(url);
	}

}
