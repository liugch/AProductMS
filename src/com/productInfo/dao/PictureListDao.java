package com.productInfo.dao;

import java.util.List;

import com.productInfo.entity.PictureList;
import com.productInfo.entity.PictureList2;
import com.util.DBUitl;

public class PictureListDao {
	/**
	 * ������Ʒ��Ų������е�  ͼƬ
	 * @param pid ��Ʒ���
	 * @return
	 */
	public List<PictureList> getAllPic(int pid){
		String sql="select * from pictureList where pid="+pid+" ";
		List<PictureList> list=DBUitl.executeQuery(sql, "com.productInfo.entity.PictureList");
		return list;
	}
	/**
	 * ���� ��Ʒ��Ų���ͼƬ
	 * @param pic  һ��ͼƬ����
	 * @return
	 */
	public int insertPic(PictureList pic){
		int n=0;
		String sql="insert into pictureList values(?,?,?,?)";
		n=DBUitl.PreparedUpdate(sql, pic.getPid(),pic.getPicOne(),pic.getPicTwo(),pic.getPicThree());
		return n;
	}
	public int deletePicture(String[] pids){
		int n=0;
		for(int i=0;i<pids.length;i++){
			String sql="delete pictureList where pid ="+pids[i]+"";
			n+=DBUitl.PreparedUpdate(sql);
		}
		return n;
	}
	
	
	/**
	 * ������Ʒ��Ų������е�  ͼƬ pictureList2
	 * @param pid ��Ʒ���
	 * @return
	 */
	
	public List<PictureList2> getAllPic2(int pid2){
		String sql="select * from pictureList2 where pid2="+pid2+" ";
		List<PictureList2> list=DBUitl.executeQuery(sql, "com.productInfo.entity.PictureList2");
		return list;
	}
	
	public int insertPic2(PictureList2 pic2){
		int n=0;
		String sql="insert into pictureList2 values(?,?,?,?,?,?)";
		n=DBUitl.PreparedUpdate(sql, pic2.getPid2(),pic2.getPicFour(),pic2.getPicFive(),pic2.getPicSix(),pic2.getPriSeven(),pic2.getPriEighT());
		return n;
	}
	
	public int deletePicture2(String[] pids2){
		int n=0;
		for(int i=0;i<pids2.length;i++){
			String sql="delete pictureList2 where pid2 ="+pids2[i]+"";
			n+=DBUitl.PreparedUpdate(sql);
		}
		return n;
	}
	
}
