(function($) {
	$.fn.obpmButton = function() {
		return this
				.each(function() {
					var $btn = jQuery(this);
					var activityType = $btn.attr("activityType");

					//29:批量签章;43:跳转
					//嵌入视图不使用批量签章和跳转按钮
					if((activityType == "29" || activityType == "43") && typeof DisplayView == 'object' && DisplayView.getTheView(this)){
						$btn.remove();
						return;
					}
					if  (activityType != "5") {//当按钮类型为5（流程处理）时，不做处理，具体渲染工作交由flowprcss.jsp完成
						var icon = "";
						var BtnStyle="btn-default";
						switch(activityType){
							case "1": //载入视图
								icon = '<i class="fa fa-list"></i>';
								BtnStyle="btn-primary"
								break;
							case "2": //创建
								icon = '<i class="fa fa-file-o"></i>';
								BtnStyle="btn-primary"
								break;
							case "3": //删除
								icon = '<i class="fa fa-trash-o"></i>';
								BtnStyle="btn-danger"
								break;
							case "4": //保存并启动流程
								icon = '<i class="fa fa-play-circle-o"></i>';
								BtnStyle="btn-success"
								break;
							case "5": //!流程处理
								icon = '<i class="fa fa-clock-o"></i>';
								BtnStyle="btn-primary"
								break;
							case "8": //关闭窗口
								icon = '<i class="fa fa-close"></i>';
								BtnStyle="btn-warning"
								break;
							case "10": //返回
								icon = '<i class="fa fa-arrow-circle-o-left"></i>';
								BtnStyle="btn-default"
								break;
							case "11": //保存并返回
								icon = '<i class="fa fa-reply"></i>';
								BtnStyle="btn-success"
								break;
							case "13": //无
								icon = '<i class="fa fa-cog"></i>';
								BtnStyle="btn-default"
								break;
							case "14": //网页打印(表单)
								icon = '<i class="fa fa-print"></i>';
								BtnStyle="btn-info"
								break;
							case "15": //网页打印含历史
								icon = '<i class="fa fa-print"></i>';
								BtnStyle="btn-info"
								break;
							case "16": //导出excel
								icon = '<i class="fa fa-sign-out"></i>';
								BtnStyle="btn-info"
								break;
							case "18": //清空所有数据
								icon = '<i class="fa fa-eraser"></i>';
								BtnStyle="btn-danger"
								break;
							case "19": //保存草稿不校检
								icon = '<i class="fa fa-check-circle-o"></i>';
								BtnStyle="btn-success"
								break;
							case "20": //批量提交
								icon = '<i class="fa fa-send-o"></i>';
								BtnStyle="btn-primary"
								break;
							case "21": //保存并复制
								icon = '<i class="fa fa-clone"></i>';
								BtnStyle="btn-success"
								break;
							case "25": //PDF导出
								icon = '<i class="fa fa-sign-out"></i>';
								BtnStyle="btn-info"
								break;
							case "26": //文件下载
								icon = '<i class="fa fa-download"></i>';
								BtnStyle="btn-info"
								break;
							case "27": //导入excel
								icon = '<i class="fa fa-sign-in"></i>';
								BtnStyle="btn-info"
								break;
							case "28": //电子签章
								icon = '<i class="fa fa-globe"></i>';
								BtnStyle="btn-primary"
								break;
							case "29": //批量签章
								icon = '<i class="fa fa-globe"></i>';
								BtnStyle="btn-primary"
								break;
							case "30": //自定义打印
								icon = '<i class="fa fa-print"></i>';
								BtnStyle="btn-info"
								break;
							case "33": //流程启动
								icon = '<i class="fa fa-user-plus"></i>';
								BtnStyle="btn-primary"
								break;
							case "34": //保存
								icon = '<i class="fa fa-save"></i>';
								BtnStyle="btn-success"
								break;
							case "36": //网页打印(视图)
								icon = '<i class="fa fa-print"></i>';
								BtnStyle="btn-info"
								break;
							case "37": //邮件短信分享
								icon = '<i class="fa fa-share-alt"></i>';
								BtnStyle="btn-info"
								break;
							case "42": //保存并新建
								icon = '<i class="fa fa-plus"></i>';
								BtnStyle="btn-success"
								break;
							case "43": //跳转
								icon = '<i class="fa fa-share-square-o"></i>';
								BtnStyle="btn-warning"
								break;
							default:
								break;
							
						}
						
						//按钮样式，默认值则保持不变 
						switch($btn.attr("colorType")){
						case "primary":
							BtnStyle="btn-primary"
							break;
						case "success":
							BtnStyle="btn-success"
							break;
						case "info":
							BtnStyle="btn-info"
							break;
						case "warning":
							BtnStyle="btn-warning"
							break;
						case "danger":
							BtnStyle="btn-danger"
							break;
						default:
							break;
						}
						
						
						if($btn.attr("iconType") == "custom"){
							try{
								var iconJson = JSON.parse($btn.attr("icon"));
								var _type = iconJson.type;
								var _icon = iconJson.icon;
								if(_type == "img"){
									icon = "<img style='height:16px;' src='"
										+ "../../../lib/icon/" + _icon + "' />";
								}else if(_type == "font"){
									icon = '<i class="'+_icon+'"></i>';
								}
							}
							catch(err){
								icon = "<img style='height:16px;' src='"
									+ "../../../lib/icon/" + $btn.attr("icon")
									+ "' />";
							}
						}
						var dis = "";
						if($btn.attr("disabled") == "disabled") 
							dis = "style = 'color:#aaa;'";
						
						var autoBuildClass = ""
						var autoBuildAttr = " autoBuild='false' "	
						if(activityType == undefined){
							autoBuildClass = "hide ";
							autoBuildAttr = " autoBuild='true' "
						}
						
						var onclick = this.onclick;
					
						$btn.replaceWith(jQuery(
										"<a class='"+ activityType +" "+ autoBuildClass +"vbtn btn "+BtnStyle+"' title='"
												+ $btn.attr("value")
												+ "' " + dis + autoBuildAttr + ">"
												+ icon + " " + $btn.attr("value")
												+ "</a>")
										.click(onclick));
						
					}
					
				});

	};
})(jQuery);