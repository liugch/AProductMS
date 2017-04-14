package com.yzm.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Note.dos")
public class NoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public NoteServlet() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");*/
		//获取电话号码
		String mobile=request.getParameter("phone");
		System.out.println("mobile:"+mobile);
		//产生随机的短信验证码
		Random rand= new Random();
		String content = rand.nextInt(10000)%(10000-1000+1) + 1000+"";//4位数的随机数;		
		
		String rc="【南方】您的验证码是"+content+"，有效时间5分钟，请不要告诉他人";
		String url=URLEncoder.encode(rc, "UTF-8");
		System.out.println(url);
		String httpUrl = "http://apis.baidu.com/kingtto_media/106sms/106sms";
		//String httpArg = "mobile=13205516161&content=%E3%80%90%E5%87%AF%E4%BF%A1%E9%80%9A%E3%80%91%E6%82%A8%E7%9A%84%E9%AA%8C%E8%AF%81%E7%A0%81%EF%BC%9A888888";
		String httpArg = "mobile="+mobile+"&content="+url+"&tag="+2;
		//String httpArg = "mobile="+mobile+"&content="+url;
		String jsonResult = request(httpUrl, httpArg);
		System.out.println("jsonResult:"+jsonResult);
		response.getWriter().println(content);
	}

	/**
	 * @param urlAll
	 *            :请求接口
	 * @param httpArg
	 *            :参数
	 * @return 返回结果
	 */
	public static String request(String httpUrl, String httpArg) {
	    BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();
	    httpUrl = httpUrl + "?" + httpArg;

	    try {
	        URL url = new URL(httpUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey", "4bac09a8726a01ae649b2e267e825aa9");
	        connection.connect();
	        InputStream is = connection.getInputStream();
	        reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
	        String strRead = null;
	        while ((strRead = reader.readLine()) != null) {
	            sbf.append(strRead);
	            sbf.append("\r\n");
	        }
	        reader.close();
	        result = sbf.toString();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
}
