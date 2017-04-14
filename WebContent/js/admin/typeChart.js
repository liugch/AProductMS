$(function(){
	//加载类型
	$.ajax({
		type:"post",
		url:"/AProductMS/AllPType.action",
		async:true,
		success:function(data,status,xhr){
			var arr=$.parseJSON(data);
			alert(arr);
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
