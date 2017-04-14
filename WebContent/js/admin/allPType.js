$(function(){
	//操作部分
	obj = {
		editRow : undefined,
		//删除商品类型
		deletes : function () {
			//获取已经选中的行
			var rows = $('#PType').datagrid('getSelections');
			if (rows.length > 0) {
				$.messager.confirm('确定操作', '您正在要删除所选的记录吗？', function (flag) {
					if (flag) {
						var ids = [];
						for (var i = 0; i < rows.length; i ++) {
							//获取选中类型的ID号
							ids.push(rows[i].pTypeId);
						}
						console.log(ids.join(','));
						$.ajax({
							type : 'POST',
							url : '/AProductMS/DeletePTye.action',
							data : {
								ptid : ids.join(','),
							},
							beforeSend : function () {
								$('#PType').datagrid('loading');
							},
							success : function (data) {
								if (data) {
									$('#PType').datagrid('loaded');
									$('#PType').datagrid('load');
									$('#PType').datagrid('unselectAll');
									$.messager.show({
										title : '提示',
										msg :''+data+'个类型被删除成功！',
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
		addss : function () {
			$('#save3,#redo3').show();	
			if (this.editRow==undefined) {
				//添加一行 
				$('#PType').datagrid('insertRow', {
					index : 0,
					row : {
					
					},
				});
				
				//将第一行设置为可编辑状态
				$('#PType').datagrid('beginEdit', 0);				
				this.editRow = 0;
			}		
		},//保存
		saves : function () {
			$('#PType').datagrid('endEdit', this.editRow);
		},
		//取消
		redos : function () {
			$('#save3,#redo3').hide();
			this.editRow = undefined;
			//回滚所有从创建或上一次调用
			//acceptChanges 函数后更改的数据
			$('#PType').datagrid('rejectChanges');
		},
	};
	
	
	//商品类性部分
	$("#PType").datagrid({
		url:'/AProductMS/AllPType.action',
		width:'300',
		height:'auto',
		title:'类型列表',
		rownumbers:true,//行号
		striped : true,//斑马线
		fitColumns:true,//自适应
		iconCls : 'icon-search',
		border:true,
		columns:[[
			{
				field : 'pTypeId',
				title : '编号',
				align:'center',
				checkbox : true,
			
			},
		   {
			 field:'pTypeName',
			 title:'类型名称',
			 width:200,
			 align:'center',
			 editor : {
				type : 'validatebox',
				options : {
					required : true,
				},
			},
		   }
		]],
		toolbar : '#tb1',
		//编辑之后
		onAfterEdit : function (rowIndex, rowData, changes) {
			console.log(rowData);
			$('#save3,#redo3').hide();
			var inserted = $('#PType').datagrid('getChanges', 'inserted');
			//修改商品
			if (inserted.length > 0) {
				url = '/AProductMS/AddPType.action';
			}
			$.ajax({
				type : 'POST',
				url : url,
				data : {
					//获取字段的值
					typeName:rowData.pTypeName,
				
				},
				beforeSend : function () {
					$('#PType').datagrid('loading');
				},
				success : function (data) {
					//console.log(data);
					if (data) {
						$('#PType').datagrid('loaded');
						$('#PType').datagrid('load');
						$('#PType').datagrid('unselectAll');
						$.messager.show({
							title : '提示',
							msg :  data,
						});
						obj.editRow = undefined;
					}
				},
			});
		},
	});
});

