package com.yzm.code;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/YZM")
public class YZMServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//创建一个画布
		BufferedImage img = new BufferedImage(120,30, BufferedImage.TYPE_INT_RGB);
		//获取画笔
		Graphics2D g = img.createGraphics();
		//获取随机验证码
		String code = new YZMCode().getYZM();
		
		//设置背景
		g.setColor(new Color(191, 222, 251));
		g.fillRect(0, 0, 120, 30);
		
		//设置干扰线		
		Random r = new Random();
		for(int i=0; i<5; i++){
			int x1 = r.nextInt(120);
			int y1 = r.nextInt(30);
			int x2 = r.nextInt(120);
			int y2 = r.nextInt(30);
			
			g.setColor(new Color(255,0,200));
			g.drawLine(x1, y1, x2, y2);
		}
		
		//设置画笔颜色和字体
		g.setColor(Color.red);
		g.setFont(new Font("宋体",Font.BOLD,20));
		//将验证码画到画布中
		g.drawString(code, 10, 20);	
		
		//将验证码保存到session中
		request.getSession().setAttribute("sysYzm", code);
		//设置响应头
		response.setContentType("image/jpeg");
		
		//禁用客户端缓存
		//把图片写给客户机,再通知浏览器以图片方式打开数据,并且要通知浏览器不能缓存图片
        response.setHeader("Expires", "-1");
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Pragma","no-cache");

		//输出到客户端
        ImageIO.write(img, "jpg", response.getOutputStream());

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
