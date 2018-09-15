(function($) {
	$.fn.obpmButtonField = function() {
		return this
				.each(function() {
					var $btn = jQuery(this);
					var val = $btn.attr("value");
					var activityType = $btn.attr("activityType");
					var clickBtn = $btn.attr("onclick");

					if ((activityType == "29" || activityType == "43")
							&& typeof DisplayView == 'object'
							&& DisplayView.getTheView(this)) {
						$btn.remove();
						return;
					}

					switch (activityType) {
					case "8": //关闭窗口
						BtnStyle="btn-warning-o"
						break;
					case "10": //返回
						BtnStyle="btn-default"
						break;
					case "11": //保存并返回
						BtnStyle="btn-success-o"
						break;
					case "13": //无
						BtnStyle="btn-default"
						break;
					case "14": //网页打印(表单)
						BtnStyle="btn-info-o"
						break;
					case "15": //网页打印含历史
						BtnStyle="btn-info-o"
						break;
					case "19": //保存草稿不校检
						BtnStyle="btn-success-o"
						break;
					case "21": //保存并复制
						BtnStyle="btn-success-o"
						break;
					case "25": //PDF导出
						BtnStyle="btn-info-o"
						break;
					case "26": //文件下载
						BtnStyle="btn-info-o"
						break;
					case "28": //电子签章
						BtnStyle="btn-primary-o"
						break;
					case "30": //自定义打印
						BtnStyle="btn-info-o"
						break;
					case "34": //保存
						BtnStyle="btn-success-o"
						break;
					case "37": //邮件短信分享
						BtnStyle="btn-info-o"
						break;
					case "42": //保存并新建
						BtnStyle="btn-success-o"
						break;
					case "43": //跳转
						BtnStyle="btn-warning-o"
						break;
					case "45": //归档
						BtnStyle="btn-success-o"
						break;
					default:
						BtnStyle="btn-default";
						break;
					}
					if (activityType != "5") {// 当按钮类型为5（流程处理）时，不做处理，具体渲染工作交由flowprcss.jsp完成
						$btn.addClass("vbtn btn "+BtnStyle+"");
					}
				});
	};
})(jQuery);