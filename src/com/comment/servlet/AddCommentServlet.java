package com.comment.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.dao.CommentDao;
import com.comment.entity.Comment;
import com.order.dao.orderFormDao;
import com.user.dao.UserDao;


@WebServlet("/AddComment.action")
public class AddCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AddCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*'phone':'${sessionScope.userName}',
		'pid':'${ps.pid}',
		'content':$("#speak").val(),	*/
		String phone=request.getParameter("phone");
		String pid=request.getParameter("pid");
		String content=request.getParameter("content");
		String isGood=request.getParameter("isGood");
		//System.out.println(phone+","+pid+","+content+","+isGood);
		int uid=new UserDao().getUseId(phone);
	//	System.out.println("uid::::"+uid);
		if(uid==0){
			response.getWriter().println("你还未购买该商品");
		}else{
			int isGoumai=new orderFormDao().isGouMai(uid);
			//System.out.println("isGoogd:"+isGood);;
			if(isGoumai>0){
				Comment c=new Comment();
				c.setComUserId(uid);
				c.setContent(content);
				c.setPid(Integer.parseInt(pid));
				c.setIsGood(isGood);
				CommentDao cdao=new CommentDao();
				boolean b=cdao.sendComment(c);
				//System.out.println(b);
				if(b){
					response.getWriter().println("发表成功");
				}else{
					response.getWriter().println("你还未购买该商品");
				}
			}else{
				response.getWriter().println("你还未购买该商品");
			}
		}
		
		
		
	}

}
