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
		//����һ������
		BufferedImage img = new BufferedImage(120,30, BufferedImage.TYPE_INT_RGB);
		//��ȡ����
		Graphics2D g = img.createGraphics();
		//��ȡ�����֤��
		String code = new YZMCode().getYZM();
		
		//���ñ���
		g.setColor(new Color(191, 222, 251));
		g.fillRect(0, 0, 120, 30);
		
		//���ø�����		
		Random r = new Random();
		for(int i=0; i<5; i++){
			int x1 = r.nextInt(120);
			int y1 = r.nextInt(30);
			int x2 = r.nextInt(120);
			int y2 = r.nextInt(30);
			
			g.setColor(new Color(255,0,200));
			g.drawLine(x1, y1, x2, y2);
		}
		
		//���û�����ɫ������
		g.setColor(Color.red);
		g.setFont(new Font("����",Font.BOLD,20));
		//����֤�뻭��������
		g.drawString(code, 10, 20);	
		
		//����֤�뱣�浽session��
		request.getSession().setAttribute("sysYzm", code);
		//������Ӧͷ
		response.setContentType("image/jpeg");
		
		//���ÿͻ��˻���
		//��ͼƬд���ͻ���,��֪ͨ�������ͼƬ��ʽ������,����Ҫ֪ͨ��������ܻ���ͼƬ
        response.setHeader("Expires", "-1");
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Pragma","no-cache");

		//������ͻ���
        ImageIO.write(img, "jpg", response.getOutputStream());

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
