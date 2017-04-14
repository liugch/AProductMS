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
	
		   String p1_MerId = "10001126856"; // 商家编号
	        String r0_Cmd = request.getParameter("r0_Cmd"); //业务类型
	        String r1_Code = request.getParameter("r1_Code"); //扣款结果,该字段值为1时表示扣款成功.
	        String r2_TrxId = request.getParameter("r2_TrxId"); //YeePay易宝交易订单号
	        String r3_Amt = request.getParameter("r3_Amt");//扣款金额,交易结束后,YeePay易宝交易系统将实际扣款金额返回给商户
	        String r4_Cur = request.getParameter("r4_Cur");//交易币种,人民币为CNY
	        String r5_Pid = request.getParameter("r5_Pid");//商品ID
	        String r6_Order = request.getParameter("r6_Order");//商户订单号
	        String r7_Uid = request.getParameter("r7_Uid");//YeePay易宝会员ID
	        String r8_MP  = request.getParameter("r8_MP");//商户扩展信息,可以任意填写1K 的字符串,交易返回时将原样返回
	        String r9_BType = request.getParameter("r9_BType");//交易结果通知类型,1: 交易成功回调(浏览器重定向)2: 交易成功主动通知(服务器点对点通讯)
	        String rb_BankId  = request.getParameter("rb_BankId");//支付银行
	        String rp_PayDate = request.getParameter("rp_PayDate");//在银行支付时的时间
	        String hmac = request.getParameter("hmac");//MD5交易签名
	 
	        String keyValue = "69cl522AV6q613Ii4W6u8K6XuW8vM1N6bFgyv769220IuYe9u37N4y7rI4Pl"; // 商家密钥
	        boolean result = YeePayUtil.checkHmac(p1_MerId, r0_Cmd, r1_Code, r2_TrxId, r3_Amt,
	                r4_Cur, r5_Pid, r6_Order, r7_Uid, r8_MP, r9_BType, keyValue, hmac);
	        System.out.println("p1_MerId："+p1_MerId+",r0_Cmd："+r0_Cmd+",r1_Code："+r1_Code+",r2_TrxId："
	                +r2_TrxId+",r3_Amt："+r3_Amt+",r4_Cur："+r4_Cur+",r5_Pid："+r5_Pid+",r6_Order："
	                +r6_Order+",r7_Uid："+r7_Uid+",r8_MP："+r8_MP+",r9_BType："+r9_BType+",rb_BankId："+rb_BankId+",rp_PayDate："+rp_PayDate);
	        if(result){
	            if("1".equals(r1_Code)){//付款成功
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
	                request.setAttribute("errorMsg", "Sorry，支付失败！！！");
	            }
	        }else{
	            request.setAttribute("errorMsg", "Sorry，因数据来源非法，支付停止！！！");
	        }
	        request.getRequestDispatcher("payFail.jsp").forward(request, response);
	        return;
	    }
			

}
			
		
	


