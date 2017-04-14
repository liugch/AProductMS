package com.filter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
 
public class CharsetFilter implements Filter {
	FilterConfig fconfig;
   
    public CharsetFilter() {
    }
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//将请求和响应对象强转为Http类型的请求和响应对象
		HttpServletRequest re = (HttpServletRequest) request;
		HttpServletResponse rs = (HttpServletResponse) response;
		//获取web.xml中的字符编码参数
		String charset = fconfig.getInitParameter("charset1");
		//设置http请求对象字符编码集
		re.setCharacterEncoding(charset);
		//设置http响应对象字符编码集
		rs.setCharacterEncoding("UTF-8");
		//设置http响应头的MIME类型
		rs.setContentType("text/html;charset="+charset);
		//放行,注意MyRequest为Http请求的对象强化版，主要增强了获取页面请求参数时指定字符集编码，防止get方法提交时有获取中文乱码
		chain.doFilter(new MyRequest(re, charset), response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		this.fconfig = fConfig;//获取过滤器config对象
	}

}
/**
 * 增强了获取页面请求参数时指定字符集编码，防止get方法提交时,
 * 重写getParameter()和getParameterValues()获取中文乱码
 * @author Administrator
 */
class MyRequest extends HttpServletRequestWrapper{	
	String charset = "UTF-8";
	public MyRequest(HttpServletRequest request) {
		super(request);
	}
	public MyRequest(HttpServletRequest request,String charset) {
		super(request);
		this.charset=charset;
		
	}

	@Override
	public String getParameter(String name) {
		String value =  super.getParameter(name);
		if(value==null)
			return value;
		
		if(this.getMethod().equalsIgnoreCase("get"))
			try {
				value = new String(value.getBytes("ISO-8859-1"),charset);
			} catch (UnsupportedEncodingException e) {
				value=null;
			}
		return value;
	}

	@Override
	public String[] getParameterValues(String name) {
		String values[] =  super.getParameterValues(name);
		if(values==null)
			return values;
		
		if(this.getMethod().equalsIgnoreCase("get"))
			for(int i=0; i<values.length; i++){
				try {
					values[i] = new String(values[i].getBytes("ISO-8859-1"),charset);
				} catch (UnsupportedEncodingException e) {
					values[i]=null;
				}
			}
		return values;
	}
	
	
}
