package com.yeepay.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yeepay.util.YeePayUtil;

/**
 * Servlet implementation class PayEndServlet
 */
@WebServlet("/PayEndServlet")
public class PayEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		   String p1_MerId = "10001126856"; // �̼ұ��
	        String r0_Cmd = request.getParameter("r0_Cmd"); //ҵ������
	        String r1_Code = request.getParameter("r1_Code"); //�ۿ���,���ֶ�ֵΪ1ʱ��ʾ�ۿ�ɹ�.
	        String r2_TrxId = request.getParameter("r2_TrxId"); //YeePay�ױ����׶�����
	        String r3_Amt = request.getParameter("r3_Amt");//�ۿ���,���׽�����,YeePay�ױ�����ϵͳ��ʵ�ʿۿ���ظ��̻�
	        String r4_Cur = request.getParameter("r4_Cur");//���ױ���,�����ΪCNY
	        String r5_Pid = request.getParameter("r5_Pid");//��ƷID
	        String r6_Order = request.getParameter("r6_Order");//�̻�������
	        String r7_Uid = request.getParameter("r7_Uid");//YeePay�ױ���ԱID
	        String r8_MP  = request.getParameter("r8_MP");//�̻���չ��Ϣ,����������д1K ���ַ���,���׷���ʱ��ԭ������
	        String r9_BType = request.getParameter("r9_BType");//���׽��֪ͨ����,1: ���׳ɹ��ص�(������ض���)2: ���׳ɹ�����֪ͨ(��������Ե�ͨѶ)
	        String rb_BankId  = request.getParameter("rb_BankId");//֧������
	        String rp_PayDate = request.getParameter("rp_PayDate");//������֧��ʱ��ʱ��
	        String hmac = request.getParameter("hmac");//MD5����ǩ��
	 
	        String keyValue = "69cl522AV6q613Ii4W6u8K6XuW8vM1N6bFgyv769220IuYe9u37N4y7rI4Pl"; // �̼���Կ
	        boolean result = YeePayUtil.checkHmac(p1_MerId, r0_Cmd, r1_Code, r2_TrxId, r3_Amt,
	                r4_Cur, r5_Pid, r6_Order, r7_Uid, r8_MP, r9_BType, keyValue, hmac);
	        System.out.println("p1_MerId��"+p1_MerId+",r0_Cmd��"+r0_Cmd+",r1_Code��"+r1_Code+",r2_TrxId��"
	                +r2_TrxId+",r3_Amt��"+r3_Amt+",r4_Cur��"+r4_Cur+",r5_Pid��"+r5_Pid+",r6_Order��"
	                +r6_Order+",r7_Uid��"+r7_Uid+",r8_MP��"+r8_MP+",r9_BType��"+r9_BType+",rb_BankId��"+rb_BankId+",rp_PayDate��"+rp_PayDate);
	        if(result){
	            if("1".equals(r1_Code)){//����ɹ�
	                request.setAttribute("r0_Cmd", r0_Cmd);
	                request.setAttribute("r1_Code", r1_Code);
	                request.setAttribute("r2_TrxId", r2_TrxId);
	                request.setAttribute("r3_Amt", r3_Amt);
	                request.setAttribute("r4_Cur", r4_Cur);
	                request.setAttribute("r5_Pid", r5_Pid);
	                request.setAttribute("r6_Order", r6_Order);
	                request.setAttribute("r7_Uid", r7_Uid);
	                request.setAttribute("r8_MP", r8_MP);
	                request.setAttribute("r9_BType", r9_BType);
	                request.setAttribute("rb_BankId", rb_BankId);
	                request.setAttribute("rp_PayDate", rp_PayDate);
	                request.getRequestDispatcher("paySuccess.jsp").forward(request, response);
	                return;
	            }else{
	                request.setAttribute("errorMsg", "Sorry��֧��ʧ�ܣ�����");
	            }
	        }else{
	            request.setAttribute("errorMsg", "Sorry����������Դ�Ƿ���֧��ֹͣ������");
	        }
	        request.getRequestDispatcher("payFail.jsp").forward(request, response);
	        return;
	    }
			

}
			
		
	


