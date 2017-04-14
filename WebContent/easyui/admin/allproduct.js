$(function(){
	//加载类型
	$.ajax({
		type:"post",
		url:"/AProductMS/AllPType.action",
		async:true,
		success:function(data,status,xhr){
			var arr=$.parseJSON(data);
			var html;
			$.each(arr, function(i,v) {
					html+="<option value='"+v.pTypeName+"'>"+v.pTypeName+"</option>";
			});
			$("#types").append(html);
		}
	});
	
	//商品
	obj = {
		editRow : undefined,
		//查找商品
		search : function () {
			$('#product').datagrid('load', {
				pName : $.trim($('input[name="proName"]').val()),
				typeName: $.trim($('select[name="typeNames"]').val()),
				fPrice : $.trim($('input[name="fPrice"]').val()),
				tPrice : $.trim($('input[name="tPrice"]').val()),
			});
		},
		//删除商品
		remove : function () {
			//获取已经选中的行
			var rows = $('#product').datagrid('getSelections');
			if (rows.length > 0) {
				$.messager.confirm('确定操作', '您正在要删除所选的记录吗？', function (flag) {
					if (flag) {
						var ids = [];
						for (var i = 0; i < rows.length; i ++) {
							//获取选中商品的ID号
							ids.push(rows[i].pid);
						}
						console.log(ids.join(','));
						$.ajax({
							type : 'POST',
							url : '/AProductMS/DeleteProduct.action',
							data : {
								proId : ids.join(','),
							},
							beforeSend : function () {
								$('#product').datagrid('loading');
							},
							success : function (data) {
								if (data) {
									$('#product').datagrid('loaded');
									$('#product').datagrid('load');
									$('#product').datagrid('unselectAll');
									$.messager.show({
										title : '提示',
										msg :''+data+'个商品被删除成功！',
									});
								}
							},
						});
					}
				});
			} else {
				$.messager.alert('提示', '请选择要删除的记录！', 'info');
			}
		},
		//修改商品参数
		edit : function () {
			//获取已选中的行
			var rows = $('#product').datagrid('getSelections');
			//如果选中的只有一个 才可以修改
			if (rows.length == 1) {
				if (this.editRow != undefined) {
					$('#product').datagrid('endEdit', this.editRow);
				}
				if (this.editRow == undefined) {
					//获取被选中的行的下标
					var index = $('#product').datagrid('getRowIndex', rows[0]);
					$('#save,#redo').show();
					//选中的行变成可编辑的状态
					$('#product').datagrid('beginEdit', index);
					this.editRow = index;
					//取消选中的行
					$('#product').datagrid('unselectRow', index);
				}
			} else {
				$.messager.alert('警告', '修改必须或只能选择一行！', 'warning');
			}
		},
		//保存
		save : function () {
			$('#product').datagrid('endEdit', this.editRow);
		},
		//取消
		redo : function () {
			$('#save,#redo').hide();
			this.editRow = undefined;
			//回滚所有从创建或上一次调用
			//acceptChanges 函数后更改的数据
			$('#product').datagrid('rejectChanges');
		},
		
	
	};
	$("#product").datagrid({
		url:'/AProductMS/AllProduct.action',
		width:'auto',
		height:'auto',
		title:'商品列表',
		rownumbers:true,//行号
		striped : true,//斑马线
		fitColumns:true,//自适应
		iconCls : 'icon-search',
		border:false,
		columns:[[
			{
				field : 'pid',
				title : '编号',
				width : 100,
				checkbox : true,
				align:'center',
			},
		   {
			 field:'pName',
			 title:'商品名称',
			 width:100,
			 align:'center',
			//变成可编辑的状态
			 editor : {
				type : 'validatebox',
				options : {
					required : true,
				},
			},
		   },
		   {
			 field:'pTypeName',
			 title:'商品类型',
			 width:100,
			 align:'center',
		   },  
		   {
			 field:'pPrice',
			 title:'商品价格',
			 width:100,
			 align:'center',
			 //变成可编辑的状态
			 editor : {
				type : 'validatebox',
				options : {
					required : true,
				},
			},
		   },  
		   {
			 field:'amount',
			 title:'商品数量',
			 width:100,
			 align:'center',
			 editor : {
					type : 'validatebox',
					options : {
						required : true,
					},
				},
			} , 
		   {
			 field:'pUptime',
			 title:'上架时间',
			 width:100,
			 align:'center',
		   }    
		]],
		
		toolbar : '#tb',
		pagination:true,
		pageList : [3, 6, 9],
		pageSize:3,
		pageNumber:1,
		
		//编辑之后
		onAfterEdit : function (rowIndex, rowData, changes) {
			//alert(rowData);
			console.log(rowData);
			$('#save,#redo').hide();
			var updated = $('#product').datagrid('getChanges', 'updated');
			var url = info =  '';
			//修改商品
			if (updated.length > 0) {
				url = '/AProductMS/UpdateProduct.action';
			//	info = '修改';
			}
			$.ajax({
				type : 'POST',
				url : url,
				data : {
					//获取字段的值
					pid:rowData.pid,
					pName:rowData.pName,
					pPrice:rowData.pPrice,
					amount:rowData.amount,
				},
				beforeSend : function () {
					$('#product').datagrid('loading');
				},
				success : function (data) {
					console.log(data);
					if (data) {
						$('#product').datagrid('loaded');
						$('#product').datagrid('load');
						$('#product').datagrid('unselectAll');
						$.messager.show({
							title : '提示',
							msg :  data,
						});
						obj.editRow = undefined;
					}
				},
			});
		},
		//当前的行的下标,和数据
		onDblClickRow : function (rowIndex, rowData) {
			if (obj.editRow != undefined) {
				//当已经选择了一个时候就把上一次的编辑结束掉
				$('#product').datagrid('endEdit', obj.editRow);
			}
			if (obj.editRow == undefined) {
				$('#save,#redo').show();
				$('#product').datagrid('beginEdit', rowIndex);
				//把这一次的行的下标给editRow
				obj.editRow = rowIndex;
			}
		},
		
	});
	
});

