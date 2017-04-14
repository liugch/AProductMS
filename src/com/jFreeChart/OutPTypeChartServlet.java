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
	
	//����Դ
	 private  CategoryDataset createDataset(int year,int month,String type){ //������״ͼ���ݼ�
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
	  //����Ϊ�ļ�   
	    private  void saveAsFile(JFreeChart chart, String outputPath, int weight, int height) {   
	        FileOutputStream out = null;
	        try {   
	            File outFile = new File(outputPath);   
	           if (!outFile.getParentFile().exists()) {   
	                outFile.getParentFile().mkdirs();   
	            }
	        
	            out = new FileOutputStream(outputPath);   
	            //����ΪPNG�ļ�   
	            ChartUtilities.writeChartAsJPEG(out, chart, weight, height);   
	            //����ΪJPEG�ļ�   
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
							"����������ͼ",
							"����",
							"����",  
			                createDataset(year,month,type), 
			                PlotOrientation.VERTICAL, true, true, true
			                );

		CategoryPlot  plot = (CategoryPlot) chart.getPlot(); 
		//���ñ���
		//TextTitle textTitle = chart.getTitle(); 
		//textTitle.setFont(new Font("����", Font.PLAIN,25)); 
	    //plot.setBackgroundPaint(Color.lightGray);
    	//plot.setBackgroundPaint(new Color(225, 255, 225));// ������ͼ����ɫ��ע�⣬ϵͳȡɫ��ʱ��Ҫʹ��16λ��ģʽ���鿴��ɫ���룬�����Ƚ�׼ȷ��
    	plot.setRangeGridlinesVisible(true);// ���ú����߿ɼ�
    //	plot.setRangeGridlinePaint(Color.gray);// ����ɫ��
    
    	
    	//ͼ����λ��
    	chart.getLegend().setPosition(RectangleEdge.RIGHT);
		/* ����Ŀ̶� ����*/
		/*NumberAxis numberAxis = (NumberAxis) plot.getRangeAxis();
		DecimalFormat df=new DecimalFormat("0%");
		numberAxis.setUpperBound(1);
		numberAxis.setNumberFormatOverride(df);
		numberAxis.setAutoTickUnitSelection(false);
	     //����������ֵ�ļ��Ϊ10
		numberAxis.setTickUnit(new NumberTickUnit(0.1));
	    //������ֵֻ����0-100֮���ֵ
		numberAxis.setRangeWithMargins(0, 1);*/
		
		/*�����������������*/
		Font labelFont = new Font("����", Font.TRUETYPE_FONT, 12);   	
    	CategoryAxis domainAxis = plot.getDomainAxis();
    	//�������D�Ę��} 
		
		 //�D�·��S
		 //�����ϵ����� 
		domainAxis.setTickLabelFont(labelFont); 
		 //���}����
		domainAxis.setLabelFont(labelFont); 
		 //�D��߅�S 
		ValueAxis valueAxis2 =plot.getRangeAxis();
		 //�����ϵ����� 
		valueAxis2.setTickLabelFont(labelFont); 
		//���}����
		 valueAxis2.setLabelFont(labelFont);
		 // X���ϵ�Lable����45����б
   		domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45); 
		// ���þ���ͼƬ��˾��� 
   		//	domainAxis.setLowerMargin(0.03); 
		// ���þ���ͼƬ�Ҷ˾��� 
		//domainAxis.setUpperMargin(0.03);
		
		/*��״�Ŀ�ȵ��趨     ������������*/
    	BarRenderer renderer = new BarRenderer();
    	//renderer.setItemMargin(0.1); //����֮��ļ��
    	//renderer.setItemLabelAnchorOffset(-3); 
    	renderer.setMaximumBarWidth(0.02);// �������ӿ��//TODO 0.05
    	renderer.setMinimumBarLength(0.1);// �������Ӹ߶�
    	//renderer.setBaseOutlinePaint(Color.BLACK);// �������ӱ߿���ɫ
    	//renderer.setDrawBarOutline(true);// �������ӱ߿�ɼ�

    	/*ÿ����������ʾ��ֵ*/
    
    	renderer.setItemMargin(0.0);
    	renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());//��ʾÿ��������ֵ
    	renderer.setBaseItemLabelsVisible(true);
    	
    	  
    	//ͼ��  ��������ͺ���� ����  new RectangleInsets(top, left, bottom, right)
    	//plot.setAxisOffset(new RectangleInsets(10D, 0, 10D, 0)); 
    	plot.setRenderer(renderer);
    	
    	renderer.setItemMargin(0.0);// ����ÿ��������������ƽ������֮�����
 
    	String savaPath=request.getSession().getServletContext().getRealPath("/images/jFreeChart/t.jpg");
		System.out.println(savaPath);
    	saveAsFile(chart, savaPath, 850,500);
		System.out.println("����ɹ����!");
		
		String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/images/jFreeChart/t.jpg";
		System.out.println(url);
		response.getWriter().println(url);
	
	}
	
}
