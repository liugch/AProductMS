package com.jFreeChart;

import java.util.List;
import java.util.Map;

import com.util.DBUitl;

public class JfChartDao {
	public boolean updateChart(String jName){
		String sql="update jfchart set jName ='"+jName+"' where jid=100";
		int n=DBUitl.PreparedUpdate(sql);
		if(n>0){
			return  true;
		}else{
			return false;
		}
	}
	public String getChart(){
		String sql="select jName from jfchart where jid=100";
		List<Map<String,Object>> list=DBUitl.getResultSet(sql);
		Map<String,Object> map=list.get(0);
		String jName=null;
		jName=(String) map.get("jName");

		return jName;
	}
}
