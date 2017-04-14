package com.comment.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.dao.ReplyDao;
import com.comment.entity.Reply;

@WebServlet("/SendReply.action")
public class SendReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SendReplyServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int comId=Integer.parseInt(request.getParameter("comId"));
		int pid=Integer.parseInt(request.getParameter("pid"));
		String comment=request.getParameter("conmment");
		/*System.out.println("comId://////"+comId);
		System.out.println("pid:///////"+pid);
		System.out.println("comment:////"+comment);*/
		Reply r=new Reply();
		r.setPid(pid);
		r.setrContent(comment);
		r.setrUserId(-1);
		r.setrComId(comId);
		ReplyDao rdao=new ReplyDao();
		int n=rdao.sendReply(r);
		response.getWriter().println(n);
	}

}
