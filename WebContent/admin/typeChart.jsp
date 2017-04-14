<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	
</head>
<body>
	<div style="padding:0 0 0 7px;color:#333;">
			年：<select name="year" style="width:100px">
					<option value="2016" >2016</option>
					<option value="2015">2015</option>
				</select>
			月：<select  name="month" style="width:100px">
					<option value="0">月份</option>
					<option value="1">一月</option>
					<option value="2">二月</option>
					<option value="3">三月</option>
					<option value="4">四月</option>
					<option value="5">五月</option>
					<option value="6">六月</option>
					<option value="7">七月</option>
					<option value="8">八月</option>
					<option value="9">九月</option>
					<option value="10">十月</option>
					<option value="11">十一月</option>
					<option value="12">十二月</option>
				
				</select>
			商品类型：	<select id="typ" name="type" style="width:110px">
					</select>
				<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="fun.typechart();">查询</a>
			
	</div>
	<div id="src">
	</div>
	<script type="text/javascript">
		$(function(){
			//加载类型
			$.ajax({
				type:"post",
				url:"/AProductMS/AllPType.action",
				async:true,
				success:function(data,status,xhr){
					var arr=$.parseJSON(data);
					//alert(arr);
					var html="";
					html+="<option value=''>商品类型</option>"
					$.each(arr, function(i,v) {
							html+="<option value='"+v.pTypeName+"'>"+v.pTypeName+"</option>";
					});
					$("#typ").append(html);
				},
				complete:function(){
					var date = new Date();
					$.ajax({
						type:"post",
						url:"/AProductMS/OutPTypeChart.action?"+date.getTime(),
						async:true,
						data:{
							'year':$("select[name='year']").val(),
							'month':$("select[name='month']").val(),
							'type':$("select[name='type']").val()
						},
						success:function(data,status,xhr){
						//	alert(data)
							$("#src").html("<img src='"+data+"?"+date.getTime()+"' width='850px' height='500px'>");
							
						}
					});
				}
			});
			
			fun={
				typechart : function(){
					
					var date = new Date();
					$.ajax({
						type:"post",
						url:"/AProductMS/OutPTypeChart.action?"+date.getTime(),
						async:true,
						data:{
							'year':$("select[name='year']").val(),
							'month':$("select[name='month']").val(),
							'type':$("select[name='type']").val()
						},
						success:function(data,status,xhr){
							//alert(data);
							$("#src").html("<img src='"+data+"?"+date.getTime()+"' width='850px' height='500px'>");
							//$("#src").html("<img src="+data+" width='800px' height='500px'>");
							//$("#src").prop("src",data);
						}
					});
				}	
			};
			
			
		});	
	</script>
	<!--引入自己开发adminJS-->
	<!-- <script src="/AProductMS/js/admin/typeChart.js" type="text/javascript" charset="utf-8"></script>  -->
	
</body>
</html>