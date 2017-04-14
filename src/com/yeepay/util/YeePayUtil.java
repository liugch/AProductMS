package com.yeepay.util;

public class YeePayUtil {
	 /**��ȡhmac 
	  * *@param p0_Cmd ҵ������ 
	  * @param p1_MerId �̻����
	  * @param p2_Order �̻�������
	  * @param p3_Amt ֧�����
	  * @param p4_Cur ���ױ��� 
	  * @param p5_Pid ��Ʒ����
	  * @param p6_Pcat ��Ʒ����
	  * @param p7_Pdesc ��Ʒ���� 
	  * @param p8_Url �̻�����֧���ɹ����ݵĵ�ַ
	  * @param p9_SAF �ͻ���ַ 
	  * @param pa_MP �̻���չ��Ϣ 
	  * @param pd_FrpId ���б��� 
	  * @param pr_NeedResponse Ӧ�����
	  * @param keyValue �̻���Կ *
	  *         @return */
	   public static String getHmac(String p0_Cmd, String p1_MerId, String p2_Order, String p3_Amt,
	            String p4_Cur, String p5_Pid, String p6_Pcat, String p7_Pdesc, String p8_Url, String p9_SAF, 
	            String pa_MP, String pd_FrpId, String pr_NeedResponse, String keyValue) {
	        String payInfo = new StringBuilder().//payInfo����֧����Ϣ
	        append(p0_Cmd).// ҵ������
	        append(p1_MerId).// �̻����
	        append(p2_Order).// �̻�������
	        append(p3_Amt).// ֧�����
	        append(p4_Cur).// ���ױ���
	        append(p5_Pid).// ��Ʒ����
	        append(p6_Pcat).// ��Ʒ����
	        append(p7_Pdesc).// ��Ʒ����
	        append(p8_Url).// �̻�����֧���ɹ����ݵĵ�ַ
	        append(p9_SAF).// �ͻ���ַ
	        append(pa_MP).// �̻���չ��Ϣ
	        append(pd_FrpId).// ���б���
	        append(pr_NeedResponse).// Ӧ�����
	        toString();
	        return DigestUtil.hmacSign(payInfo, keyValue);
	    }
	   /**
	     * У��hmac
	     * 
	     * @param p1_MerId �̻����
	     * @param r0_Cmd ҵ������
	     * @param r1_Code ֧�����
	     * @param r2_TrxId �ױ�֧��������ˮ��
	     * @param r3_Amt ֧�����
	     * @param r4_Cur ���ױ���
	     * @param r5_Pid ��Ʒ����
	     * @param r6_Order �̻�������
	     * @param r7_Uid �ױ�֧����ԱID
	     * @param r8_MP �̻���չ��Ϣ
	     * @param r9_BType ���׽����������
	     * @param keyValue ��Կ
	     * @param hmac ֧�����ط����ļ�����֤��
	     * @return
	     */
	    public static boolean checkHmac(String p1_MerId,
	            String r0_Cmd, String r1_Code, String r2_TrxId, String r3_Amt,
	            String r4_Cur, String r5_Pid, String r6_Order, String r7_Uid,
	            String r8_MP, String r9_BType, String keyValue, String hmac) {
	        String resultValue = new StringBuilder().
	        append(p1_MerId).// �̻����
	        append(r0_Cmd).// ҵ������
	        append(r1_Code).// ֧�����
	        append(r2_TrxId).// �ױ�֧��������ˮ��
	        append(r3_Amt).// ֧�����
	        append(r4_Cur).// ���ױ���
	        append(r5_Pid).// ��Ʒ����
	        append(r6_Order).// �̻�������
	        append(r7_Uid).// �ױ�֧����ԱID
	        append(r8_MP).// �̻���չ��Ϣ
	        append(r9_BType).// ���׽����������
	        toString();
	        String newHmac = DigestUtil.hmacSign(resultValue, keyValue);
			return newHmac.equals(hmac);
	    }
	 }
