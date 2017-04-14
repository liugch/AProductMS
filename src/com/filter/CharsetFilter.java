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
		//���������Ӧ����ǿתΪHttp���͵��������Ӧ����
		HttpServletRequest re = (HttpServletRequest) request;
		HttpServletResponse rs = (HttpServletResponse) response;
		//��ȡweb.xml�е��ַ��������
		String charset = fconfig.getInitParameter("charset1");
		//����http��������ַ����뼯
		re.setCharacterEncoding(charset);
		//����http��Ӧ�����ַ����뼯
		rs.setCharacterEncoding("UTF-8");
		//����http��Ӧͷ��MIME����
		rs.setContentType("text/html;charset="+charset);
		//����,ע��MyRequestΪHttp����Ķ���ǿ���棬��Ҫ��ǿ�˻�ȡҳ���������ʱָ���ַ������룬��ֹget�����ύʱ�л�ȡ��������
		chain.doFilter(new MyRequest(re, charset), response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		this.fconfig = fConfig;//��ȡ������config����
	}

}
/**
 * ��ǿ�˻�ȡҳ���������ʱָ���ַ������룬��ֹget�����ύʱ,
 * ��дgetParameter()��getParameterValues()��ȡ��������
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
