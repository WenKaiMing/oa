/**
 * 考勤管理 核心接口
 * <p>封装应用层界面渲染与交互行为</p>
 * @author Happy
 */
var AM = {
	/**
	 * 初始化
	 */
	init : function() {
		$('#tabs').tabs({
			tabPosition:'left',
			fit : true,
			onSelect: function(title,index){
				switch (index) {
				case 0:
					if(!AM.rule.hasLoad){
						AM.rule.init();
					}
					break;
				case 1:
					if(!AM.location.hasLoad){
						AM.location.init();
					}
					break;
				case 2:
					if(!AM.attendance.hasLoad){
						AM.attendance.init();
					}
					break;

				default:
					break;
				}
			}
		});
		
		this.bindEvent();
	},
	/**
	 * 绑定事件
	 */
	bindEvent : function() {
		
	},
	
	/**
	 * 考勤规则模块
	 */
	rule : {
		hasLoad : false,
		/**
		 * 初始化
		 */
		init : function() {
			$('#rule_list').datagrid({
				fit: true,
				url: 'rule/query.action',
				title: '',
				iconCls: '',
				rownumbers: true,
				pagination: true,
				singleSelect:false,
				fitColumns: true,
				idField:'id',
				toolbar: [{
		            text:'新增规则',
		            iconCls:'icon-add',
		            handler:function(){
		            	try {
		            		$('#rule_form').form('clear');
			            	$("input[name='content.multiPeriod'][value=false]").click();
			            	$('#rule_organizations').combotree('clear');
			            	$('#rule_locations').combogrid('clear');
						} catch (e) {
							// TODO: handle exception
						}
						AM.rule.openEditDialog('新增规则');
		            }
		        },'-',{
		            text:'编辑',
		            iconCls:'icon-edit',
		            handler:function(){
		            	var row = $('#rule_list').datagrid('getSelected');
		            	if(row ==null){
		            		alert('请选择数据！');
		            		return false;
		            	}
		            	$('#rule_form').form('clear');
		            	//$('[name="_locations"]').val('');
		            	$.getJSON("rule/edit.action",{"id":row.id},function(result){
	        				if(1==result.status){
	        					/**
	        					var ls = result.data.locations;
	        					var lv = '';
	        					for(i in ls){
	        						lv+=ls[i].id+',';
	        					}
	        					if(lv.length>0) lv=lv.substring(0,lv.length-1);
	        					**/
	        					try {
	        						$('#rule_organizations').combotree('clear');
		    		            	$('#rule_locations').combogrid('clear');
								} catch (e) {
									// TODO: handle exception
								}
	        					$('#rule_form').form('load',{
	        						'content.name':result.data.name,
	        						'content.range':result.data.range,
	        						//'content.organizations':result.data.organizations,
	        						//'_locations':lv,
	        						'content.id':result.data.id,
	        						'content.multiPeriod':result.data.multiPeriod
	        					});
	        					AM.rule.openEditDialog('编辑规则',result.data);
	        				}else{
	        					//Utils.showMessage(result.message, "error");
	        				}
	        			});
		            	
		            }
		        },'-',{
		            text:'删除',
		            iconCls:'icon-remove',
		            handler:function(){
		            	var selects = $('#rule_list').datagrid('getChecked');
		            	if(selects.length==0){
		            		alert('请选择需要删除的数据！');
		            	}else{
		            		var msg = "您确定要删除吗？"; 
			            	var cfm = confirm(msg);
			            	if (cfm==true){ 
		            		var ids = "";
		            		for(var i=0;i<selects.length;i++){
		            			ids+=selects[i].id+";";
		            		}
		            		if(ids.length>0) ids = ids.substring(0,ids.length-1);
		            		$.getJSON("rule/delete.action",{"ids":ids},function(result){
		        				if(1==result.status){
		        					//Utils.showMessage(result.message, "info");
		        					$('#rule_list').datagrid('reload');
		        				}else{
		        					//Utils.showMessage(result.message, "error");
		        				}
		        			});
			            	}
		            	}
		            }
		        }],
		        //toolbar:'#tb'
			});
			
			this.bindEvent();
			this.hasLoad = true;
		},
		/**
		 * 绑定事件
		*/
		bindEvent : function() {
			
		},
		
		openEditDialog : function(title,rule){
			$('#rule_content_dialog').dialog({
			    title: title,
			    width: 500,
			    height: 360,
			    //cache: false,
			    //href: 'location/new.action',
			    modal: true,
			    //iconCls: 'icon-save',
                buttons: [{
                    text:'保存',
                    iconCls:'icon-ok',
                    handler:function(){
                    	$('#rule_organizationsText').val($('#rule_organizations').combotree('getText'));
                    	$('#rule_locationsText').val($('#rule_locations').combogrid('getText'));
                    	var isValid = $('#rule_form').form('validate');
                    	if (isValid){
                    		$('#rule_form').form('submit', {
                        	    url:'rule/save.action',
                        	    onSubmit: function(param){
                        	    },
                        	    success:function(data){
                        	    	$('#rule_list').datagrid('reload');
                        	    	$('#rule_form').form('clear');
                        	    }
                        	});
                    		$('#rule_content_dialog').dialog('close');
                    	}
                        
                    }
                },{
                    text:'取消',
                    handler:function(){
                    	$('#rule_content_dialog').dialog('close');$('#rule_organizations').combotree('clear');
                    }
                }]
			});
			$('#rule_organizations').combotree({
			    url: 'rule/getDepartments.action',
			    required: true,
			    cascadeCheck: true,
			    multiple: true
			});
			$('#rule_locations').combogrid({
				panelWidth: 200,
	            multiple: true,
	            idField: 'id',
	            textField: 'name',
	            url: 'location/querySimple.action',
	            method: 'get',
	            columns: [[
	                {field:'id',checkbox:true},
	                {field:'name',title:'考勤地点',width:160}
	            ]],
	            //required:true,
	            fitColumns: true
	            
			});
			if(rule){
				setTimeout(function(){
					//去除数据中的空格(兼容旧数据)
					var origin = rule.organizations.split(",");
					var datas = new Array(origin.length);
					for(var index = 0 ; index < origin.length; index++ ){
						datas[index] = origin[index].trim();
					}
					$('#rule_organizations').combotree('setValues',datas);
					var ls = [];
					for(i in rule.locations){
						ls.push(rule.locations[i].id);
					}
					$('#rule_locations').combogrid('setValues',ls);
				}, 1000);
			}
		}
	},
	
	/**
	 * 考勤地点模块
	 */
	location : {
		hasLoad : false,
		map:null,
		/**
		 * 初始化
		 */
		init : function() {
			location.map = new BMap.Map("location_map");   
			
			$('#locations_list').datagrid({
				fit: true,
				url: 'location/query.action',
				title: '',
				iconCls: '',
				rownumbers: true,
				pagination: true,
				singleSelect:false,
				fitColumns: true,
				idField:'id',
				toolbar: [{
		            text:'新增地点',
		            iconCls:'icon-add',
		            handler:function(){
		            	$('#location_form').form('clear');
		            	AM.location.openEditDialog('新增地点');
		            }
		        },'-',{
		            text:'编辑',
		            iconCls:'icon-edit',
		            handler:function(){
		            	var row = $('#locations_list').datagrid('getSelected');
		            	if(row ==null){
		            		alert('请选择数据！');
		            		return false;
		            	}
		            	$('#location_form').form('clear');
		            	$.getJSON("location/edit.action",{"id":row.id},function(result){
	        				if(1==result.status){
	        					$('#location_form').form('load',{
	        						'content.name':result.data.name,
	        						'content.longitude':result.data.longitude,
	        						'content.latitude':result.data.latitude,
	        						'content.id':result.data.id,
	        					});
	        					AM.location.openEditDialog('编辑地点',new BMap.Point(result.data.longitude,result.data.latitude));
	        				}else{
	        					//Utils.showMessage(result.message, "error");
	        				}
	        			});
		            	
		            }
		        },'-',{
		            text:'删除',
		            iconCls:'icon-remove',
		            handler:function(){
		            	var selects = $('#locations_list').datagrid('getChecked');
		            	if(selects.length==0){
		            		alert('请选择需要删除的数据！');
		            	}else{
		            		var msg = "您确定要删除吗？"; 
			            	var cfm = confirm(msg);
			            	if (cfm==true){ 
		            		var ids = "";
		            		for(var i=0;i<selects.length;i++){
		            			ids+=selects[i].id+";";
		            		}
		            		if(ids.length>0) ids = ids.substring(0,ids.length-1);
		            		$.getJSON("location/delete.action",{"ids":ids},function(result){
		        				if(1==result.status){
		        					//Utils.showMessage(result.message, "info");
		        					$('#locations_list').datagrid('reload');
		        				}else{
		        					//Utils.showMessage(result.message, "error");
		        				}
		        			});
			            	}
		            	}
		            }
		        }]
		        //toolbar:'#tb'
			});
			
			this.bindEvent();
			this.hasLoad = true;
		},
		/**
		 * 绑定事件
		*/
		bindEvent : function() {
			$('#location_search_btn').bind('click', function(){//查询地址
				// 创建地址解析器实例
		    	var myGeo = new BMap.Geocoder();
		    	// 将地址解析结果显示在地图上,并调整地图视野
		    	myGeo.getPoint($('#location_addr').val(), function(point){
		    		if (point) {
		    			location.map.clearOverlays();
		    			location.map.centerAndZoom(point, 18);
		    			location.map.addOverlay(new BMap.Marker(point));
		    			$('#location_longitude').val(point.lng);
		    			$('#location_latitude').val(point.lat);
		    		}else{
		    			alert("地址不够详细，无法解析！");
		    		}
		    	});//$('#locations_content_dialog').dialog('close');
		    });
		},
		
		openEditDialog : function(title,defaultPoint){
			$('#locations_content_dialog').dialog({
			    title: title,
			    width: 600,
			    height: 430,
			    //cache: false,
			    //href: 'location/new.action',
			    modal: true,
			    iconCls: 'icon-save',
                buttons: [{
                    text:'保存',
                    iconCls:'icon-ok',
                    handler:function(){
                    	var isValid = $('#location_form').form('validate');
                    	if (isValid){
	                    	$('#location_form').form('submit', {
	                    	    url:'location/save.action',
	                    	    onSubmit: function(param){
	                    	    },
	                    	    success:function(data){
	                    	    	$('#locations_list').datagrid('reload');
	                    	    	$('#location_form').form('clear');
	                    	    }
	                    	});
	                    	
	                        $('#locations_content_dialog').dialog('close');
                    	}
                    }
                },{
                    text:'取消',
                    handler:function(){
                    	$('#locations_content_dialog').dialog('close');
                    }
                }]
			});
			// 百度地图API功能
			
	    	var point = new BMap.Point(116.331398,39.897445);
	    	location.map.centerAndZoom(point,13);
	    	if(defaultPoint){
	    		setTimeout(function(defaultPoint){
	    			$('#location_search_btn').trigger("click");
	    		}, 500);
	    		
	    	}
		}
	},
	/**
	 * 考勤记录模块
	 */
	attendance : {
		hasLoad : false,
		/**
		 * 初始化
		 */
		init : function() {
			
			$('#attendance_list').datagrid({
				fit: true,
				url: 'attendance/query.action',
				title: '',
				iconCls: '',
				rownumbers: true,
				pagination: true,
				singleSelect:true,
				fitColumns: true,
				idField:'id',
				toolbar: '#attendance_list_tb',
				view: detailview,
				detailFormatter:function(index,row){
			          return '<div style="padding:1px"><table id="ddv-' + index + '"></table></div>';
			    },
			    onExpandRow: function(index,row){
			          $('#ddv-'+index).datagrid({
			            url:'attendance/doQueryAttendanceDetail.action?attendanceId='+row.id,
			            fitColumns:true,
			            singleSelect:true,
			            rownumbers:true,
			            loadMsg:'',
			            height:'auto',
			            columns:[[
			              {field:'timeRegion',title:'时间范围'},
			              {field:'signinTime',title:'签到时间'},
			              {field:'signoutTime',title:'签退时间'},
			              {field:'signinLocation',title:'签到地点',formatter: function(value,row,index){
								if (value && value.length>0){
									return eval('(' + value + ')').name;
								} else {
									return value;
								}
							}},
			              {field:'signoutLocation',title:'签退地点',formatter: function(value,row,index){
								if (value && value.length>0){
									return eval('(' + value + ')').name;
								} else {
									return value;
								}
							} },
			              {field:'workingHours',title:'工作时长'},
			              {field:'status',title:'考勤状态' ,formatter: function(value,row,index){
								if (value){
									var rtn = '';
									switch(value){
										case 1:
											rtn='正常';
											break;
										case -1:
											rtn='迟到';
											break;
										case -2:
											rtn='早退';
											break;
										case -3:
											rtn='迟到且早退';
											break;
										case -4:
											rtn='地点异常';
											break;
									}
									return rtn;
								} else {
									return '未知';
								}
							}}
			            ]],
			            onResize:function(){
			              $('#attendance_list').datagrid('fixDetailRowHeight',index);
			            },
			            onLoadSuccess:function(){
			              setTimeout(function(){
			                $('#attendance_list').datagrid('fixDetailRowHeight',index);
			              },0);
			            }
			          });
			          $('#attendance_list').datagrid('fixDetailRowHeight',index);
			        }
			});
			this.bindEvent();
			this.hasLoad = true;
		},
		/**
		 * 绑定事件
		*/
		bindEvent : function() {
			$("#attendance_list_tb_btn_search").on("click",function(e){
				$('#attendance_list').datagrid('load',{
					startDate: $("#attendance_list_tb_startDate").datebox('getValue'),
					endDate: $("#attendance_list_tb_endDate").datebox('getValue'),
					name: $("#attendance_list_tb_name").val()
				});
			});
			$("#attendance_list_tb_btn_reset").on("click",function(e){
				jQuery("#attendance_list_tb").find("input[type='text']").each(function(){
					$(this).val("");
				});
				jQuery("#attendance_list_tb_name").val("");
			});
			$("#attendance_list_tb_btn_export").on("click",function(e){
				var params = {};
				params["startDate"] = $("#attendance_list_tb_startDate").datebox('getValue');
				params["endDate"] = $("#attendance_list_tb_endDate").datebox('getValue');
				params["name"] = $("#attendance_list_tb_name").val();
				var url = contextPath + "/attendance/attendance/exportAttendanceDetail.action?" + $.param(params, true);
			    window.open(url);
			});
		}
		
	},
	
	/**
	 * 缓存对象
	 */
	cache : {
		
		target : null,//事件发起对象
	}
	
};

