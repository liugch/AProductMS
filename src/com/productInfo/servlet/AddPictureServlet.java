package com.productInfo.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/AddPictures.action")
public class AddPictureServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String PATH_FOLDER = "/";
	private static String TEMP_FOLDER = "/";
	@Override
	public void init(ServletConfig config) throws ServletException {
		ServletContext servletCtx = config.getServletContext();
		//���ñ����·��
		PATH_FOLDER = servletCtx.getRealPath("/images/admin/upload");
		File file=new File(PATH_FOLDER);
		if(!file.exists()&&!file.isDirectory()){
			System.out.println("�ļ�������!");
			file.mkdir();//�������ļ�
		}
		//��ʱ�����·��
		TEMP_FOLDER = servletCtx.getRealPath("/images/admin/uploadTemp");
		File file2=new File(TEMP_FOLDER);
		if(!file2.exists()&&!file2.isDirectory()){
			System.out.println("�ļ�������!");
			file2.mkdir();//�������ļ�
		}
	}	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); 
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");	
		DiskFileItemFactory factory = new DiskFileItemFactory();	
		factory.setRepository(new File(TEMP_FOLDER));		
		factory.setSizeThreshold(1024 * 1024);
		
		ServletFileUpload upload = new ServletFileUpload(factory);	
		try {			
			List<FileItem> list = upload.parseRequest(request);		
			FileItem item = getUploadFileItem(list);
			//��ȡ�ļ���
			String filename = getUploadFileName(item);
			//�ļ����������
			String saveName = new Date().getTime() + filename.substring(filename.lastIndexOf("."));
			//���ʵ�����
			String picUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/images/admin/upload/"+saveName;
			System.out.println("��ŵ�·��:" + PATH_FOLDER);
			System.out.println("�ļ���:" + filename);
			System.out.println("��������ʵ�����:" + picUrl);
			//������ļ�
			item.write(new File(PATH_FOLDER, saveName)); 	
			/*ImageDao i=new ImageDao();
			int n=i.insertIamge(saveName);
			System.out.println("nn:"+n);*/
			PrintWriter writer = response.getWriter();			
			writer.print("{");
			writer.print("msg:\":"+item.getSize()+",filename:"+filename+"\"");
			writer.print(",picUrl:\"" + picUrl + "\"");
			writer.print("}");
			
			writer.close();
		
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	/*�ж��Ƿ����ļ���*/
	private FileItem getUploadFileItem(List<FileItem> list) {
		for (FileItem fileItem : list) {
			if(!fileItem.isFormField()) {
				return fileItem;
			}
		}
		return null;
	}
	/* ��ȡ�ļ���*/
	private String getUploadFileName(FileItem item) {		
		String value = item.getName();	
		int start = value.lastIndexOf("/");		
		String filename = value.substring(start + 1);		
		return filename;
	}

	
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
