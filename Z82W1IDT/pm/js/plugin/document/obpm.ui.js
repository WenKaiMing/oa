(function($) {
	$.fn.obpmButton = function() {
		return this
				.each(function() {
					var $btn = jQuery(this);
					var val = $btn.attr("value");
					var activityType = $btn.attr("activityType");

					// 29:批量签章;43:跳转
					// 嵌入视图不使用批量签章和跳转按钮
					if ((activityType == "29" || activityType == "43")
							&& typeof DisplayView == 'object'
							&& DisplayView.getTheView(this)) {
						$btn.remove();
						return;
					}
					/*
					 * activityType: 已完成： 新建:2; 删除:3; 提交:5; 返回:10; 保存并返回:11;
					 * 未完成： 查询Document:1; 保存并启动流程:4; SCRIPT处理:6; 保存并关闭窗口:9;
					 * 无:13; 打印:14; 连同流程图一起打印:15; 导出Excel:16; 保存并新建:17;
					 * 保存草稿不执行校验:19; 批量审批按钮:20; 保存并复制:21; 查看流程图:22; PDF导出:25;
					 * 文件下载:26; Excel导入:27; 电子签章:28; 批量电子签章:29; 跳转操作:32;
					 * 启动流程:33; 视图打印:36; 转发:37; Dispatcher:39; 保存并新建:42; 跳转:43;
					 * 归档:45; 不再使用： 修改Document:7; 关闭窗口:8;
					 * 保存并新建(新建有一条有旧数据Document):12; 清掉所有这个form的数据: 18;
					 * FLEX打印:30; FLEX带流程历史打印:31;
					 */

					switch (activityType) {
					case "1":
						activityCss = "btn-orange";
						break;
					case "2":
					case "4":
					case "42":
						activityCss = "btn-positive";
						break;
					case "3":
						activityCss = "btn-negative";
						break;
					case "5":
						activityCss = "";
						break;
					case "10":
						activityCss = "";
						break;
					case "11":
					case "34":
						activityCss = "btn-primary";
						break;
					default:
						activityCss = "";
						break;
					}

					if (activityType != "5"
							&& (activityType == 1 || activityType == 2 || activityType == 3
									|| activityType == 4
									|| activityType == 34
									// || activityType == 10
									|| activityType == 11 || activityType == 13
									|| activityType == 21 || activityType == 42 || activityType == 19)) {// 当按钮类型为5（流程处理）时，不做处理，具体渲染工作交由flowprcss.jsp完成

						var onclick = this.onclick;
						var $btnN = jQuery(
								"<td><a class='btn " + activityCss
										+ " btn-block' data-transition='fade'>"
										+ val + "</a></td>").click(onclick);

						$btnN.insertAfter($btn);
						$btn.remove();
					} else if (activityType != "5") {
						$btn.remove();
					}
				});
	};
})(jQuery);