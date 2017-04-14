package com.yzm.code;

import java.util.Random;

public class YZMCode {
	private final String letter="QWERTYUPASDFGHJKLZXCVBNM1234567890qwertyuiopasdfghjkzxcvbnm";
	private Random rand = new Random();
	
	public String getYZM(){
		StringBuffer yzm = new StringBuffer();
		for(int i=0; i<4; i++){
			int t = rand.nextInt(letter.length());
			yzm.append(letter.charAt(t));
		}
		return yzm.toString();
	}
	
	
	public static void main(String[] args) {
		System.out.println(new YZMCode().getYZM());
	}
}
