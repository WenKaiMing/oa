var holders;
var answers;
var redWill = "<span class='isWill'>*</span>";
var singleEditDiv = null;

/**
 * 问卷编辑
 */
var QM = {

	questionnaire : {
		init : function(json) {
			holders = $.parseJSON(json);
			if (holders == null) {
				holders = new Array();
			}
			var $maindiv = $("#maiDiv");
			$(holders).each(function(a) {
				var holder = holders[a];
				var $div = $("<div></div>");
				var $topic = QM.questionnaire._createDiv(holder);
				$div.append($topic);
				
				var status = $("input[name='content.status']").val();
				if(status == 0){
					var $editdiv = QM.questionnaire._createEditDiv(holder);
					$editdiv.hide();
					$div.append($editdiv);
					
					$div.hover(function() {
						$editdiv.show();
					}, function() {
						$editdiv.hide();
					});
					
				}

				$maindiv.append($div);
				$maindiv.append("<br>");
			});
		},
		
		/**
		 * 新建试题
		 */
		createHolder : function(type) {
			var holder = new Object();

			holder.id = Math.uuid();
			holder.type = type;
			holder.topic = "请输入标题？";

			if (type.indexOf("test") >= 0) {
				holder.code = 5;
			}

			switch (type) {
			case 'voteradio':
			case 'radio':
			case 'check': //多选
			case 'votecheck': { //投票多选
				var options = new Array();
				var option = new Object();
				option.name = "选项";
				options.add(option);
				var option2 = new Object();
				option2.name = "选项";
				options.add(option2);
				holder.options = options;
				holder.order = 1;
				break;
			}
			case 'input': {
				holder.isdefault = false;
				holder.defaultValue = "";
				holder.heightValue = 1;
				holder.widthValue = "50%";
				holder.underlineStyle = false;
				break;
			}
			case 'matrixradio': {
				holder.leftLabel = "外观\n性能";
				var options = new Array();
				var option1 = new Object()
				option1.name = "非常满意";
				var option2 = new Object()
				option2.name = "满意";
				var option3 = new Object()
				option3.name = "一般";
				var option4 = new Object()
				option4.name = "不满意";
				var option5 = new Object()
				option5.name = "非常不满意";
				options.add(option1);
				options.add(option2);
				options.add(option3);
				options.add(option4);
				options.add(option5);
				holder.options = options;
				break;
			}
			case 'matrixcheck': {
				holder.leftLabel = "百度\n谷歌\n搜狗";
				var options = new Array();
				var option1 = new Object()
				option1.name = "速度快";
				var option2 = new Object()
				option2.name = "准确率多";
				var option3 = new Object()
				option3.name = "信息量多";
				var option4 = new Object()
				option4.name = "界面美观";
				options.add(option1);
				options.add(option2);
				options.add(option3);
				options.add(option4);
				holder.options = options;
				break;
			}
			case 'matrixinput': { // 矩阵填空题
				holder.leftLabel = "外观\n性能";
				break;
			}
			case 'coderadio': { // 评分单选题
				var options = new Array();
				var option = new Object();
				option.name = "选项";
				option.code = 1;
				option.isNull = false;
				options.add(option);
				var option2 = new Object();
				option2.name = "选项";
				option2.code = 2;
				option2.isNull = false;
				options.add(option2);
				var option3 = new Object();
				option3.name = "选项";
				option3.isNull = true;
				options.add(option3);
				holder.options = options;
				break;
			}
			case 'codecheck': { // 评分多选题
				var options = new Array();
				var option = new Object();
				option.name = "选项";
				option.code = 1;
				option.isNull = false;
				options.add(option);
				var option2 = new Object();
				option2.name = "选项";
				option2.code = 2;
				option2.isNull = false;
				options.add(option2);
				var option3 = new Object();
				option3.name = "选项";
				option3.isNull = true;
				options.add(option3);
				holder.options = options;
				break;
			}
			case 'codematrix': { // 评分矩阵题
				holder.leftLabel = "外观\n性能";
				var options = new Array();
				var option1 = new Object()
				option1.name = "选项";
				option1.code = 1;
				option1.isNull = false;
				var option2 = new Object()
				option2.name = "选项";
				option2.code = 2;
				option2.isNull = false;
				var option3 = new Object()
				option3.name = "选项";
				option3.code = 3;
				option3.isNull = false;
				var option4 = new Object()
				option4.name = "选项";
				option4.code = 4;
				option4.isNull = false;
				var option5 = new Object()
				option5.name = "选项";
				option5.code = 5;
				option5.isNull = false;
				options.add(option1);
				options.add(option2);
				options.add(option3);
				options.add(option4);
				options.add(option5);
				holder.options = options;
				break;
			}
			case 'testcheck':
			case 'testradio': {
				var options = new Array();
				var option = new Object();
				option.name = "选项";
				option.isAnswer = true;
				options.add(option);
				var option2 = new Object();
				option2.name = "选项";
				option2.isAnswer = false;
				options.add(option2);
				holder.options = options;
				holder.code = 5;
				break;
			}
			case 'testinput': {
				holder.isdefault = false;
				holder.defaultValue = "";
				holder.heightValue = 1;
				holder.widthValue = "50%";
				holder.underlineStyle = false;
				holder.code = 5;
				holder.standardanswer = "";
				holder.answer = "";
				break;
			}
			case 'head':{
				holder.heightValue = 1;
				holder.widthValue = "50%";
				break;
			}
			}
			return holder;
		},
		
		/**
		 * 添加试题
		 */
		addQ : function(type) {
			if (holders == null) {
				holders = new Array();
			}
			var index = holders.length;

			var holder = QM.questionnaire.createHolder(type);

			holders.add(holder);
			var $maindiv = $("#maiDiv");

			var $div = $("<div></div>");
			var $topic = QM.questionnaire._createDiv(holder);
			var $editdiv = QM.questionnaire._createEditDiv(holder);
			$div.append($topic);
			$div.append($editdiv);

			$div.hover(function() {
				$editdiv.show();
			}, function() {
				$editdiv.hide();
			});

			$maindiv.append($div);

			var container = $('#main');

			container
					.animate(
							{
								scrollTop : ($div.offset().top
										- container.offset().top + container
										.scrollTop())
							}, 1000);

			$maindiv.append("<br>");
		},

		_createEditDiv : function(holder) {
			var $editdiv = $("<div class='stuff'></div>");
			var index = holders.indexOf(holder);
			var $editA = $("<span index='" + index + "' id='" + holder.id
					+ "_editText' class='Button_Edit'>编辑</span>");
			/**
			 * 编辑按钮
			 */
			$editA.click(function() {
				var index = $(this).attr("index");

				var $maiDiv = $("#maiDiv")
				var $div = $maiDiv.children("div").eq(index);
				$(".stuff .Button_Edit").text("编辑");
				$(".stuff span").show();
				$div.addClass("selected");

				var a = parseInt(index);
				var holder = holders[a];
				var $newEdit = $("#" + holder.id + "_editDiv");
				
				if ($newEdit.length > 0) {
					$newEdit.remove();
					$div.removeClass("selected");
					$(this).parent().find("span").show();
					$(this).text("编辑");
				} else {
					QM.questionnaire.editElement(holder);
					$(this).parent().find("span").hide();
					$(this).text("取消");
				}
			});
			
			/**
			 * 删除按钮
			 */
			var $deleteA = $("<span index='" + index + "' class='Button_Edit_delete'>删除</span>");
			$deleteA.click(function() {
				var index = $(this).attr("index");
				var a = parseInt(index);
				holders.removeAt(a);
				QM.questionnaire.updateDiv(holders);
			});
			
			/**
			 * 上移按钮
			 */
			var $upA = $("<span index='" + index + "' class='Button_Edit_Blue'>上移</span>");
			$upA.click(function() {
				var index = $(this).attr("index");
				var a = parseInt(index);
				if (a != 0) {
					holders.move(a, -1);
					QM.questionnaire.updateDiv(holders);
				}
			});
			
			/**
			 * 下移按钮
			 */
			var $downA = $("<span index='" + index + "' class='Button_Edit_Blue'>下移</span>");
			$downA.click(function() {
				var index = $(this).attr("index");
				var a = parseInt(index);
				if (a != (holder.length - 1)) {
					holders.move(a, 1);
					QM.questionnaire.updateDiv(holders);
				}
			});
			
			/**
			 * 最前按钮
			 */
			var $firstA = $("<span index='" + index + "' class='Button_Edit_Blue'>最前</span>");
			$firstA.click(function() {
				var index = $(this).attr("index");
				var a = parseInt(index);
				holders.moveFirstIndex(a);
				QM.questionnaire.updateDiv(holders);
			});
			
			/**
			 * 最后按钮
			 */
			var $lastA = $("<span index='" + index + "' class='Button_Edit_Blue'>最后</span>");
			$lastA.click(function() {
				var index = $(this).attr("index");
				var a = parseInt(index);
				holders.moveLastIndex(a);
				QM.questionnaire.updateDiv(holders);
			});

			$editdiv.append($editA);
			$editdiv.append($deleteA);
			$editdiv.append($upA);
			$editdiv.append($downA);
			$editdiv.append($firstA);
			$editdiv.append($lastA);
			return $editdiv;
		},

		updateDiv : function(holders) {
			var $maindiv = $("#maiDiv");
			$maindiv.html("");

			$(holders).each(function(a) {
				var holder = holders[a];
				var $div = $("<div></div>");
				var $topic = QM.questionnaire._createDiv(holder);
				$div.append($topic);

				var $editdiv = QM.questionnaire._createEditDiv(holder);
				$div.append($editdiv);

				$div.hover(function() {
					$editdiv.show();
				}, function() {
					$editdiv.hide();
				});

				$maindiv.append($div);
				$maindiv.append("<br>");
			});
		},

		/**
		 * 初始化试题
		 * 
		 * @param holder
		 * @returns
		 */
		_createDiv : function(holder) {
			// 类型
			var type = holder.type;
			
			var id = holder.id;
			
			var number = holders.indexOf(holder);

			var topic = holder.topic;
			
			var headCount=0
			
			for(var a=0; a<number;a++){
				var h=holders[a];
				if(h.type=="head"){
					headCount++;
				}
			}

			// 题目
			if(type=="head"){
				var title = topic;
			}else{
				var title = (number + 1 - headCount) + "、" + topic;
			}
			//题目外围div
			var $div = $("<div></div>");
			//标题
			var $titleDiv = $("<div></div>");

			$titleDiv.text(title);

			// 是否必填
			if (holder.isWill) {
				$titleDiv.prepend($(redWill));
			}

			// 是否有分值
			if (type.indexOf("test") >= 0 && holder.code > 0) {
				var $code = $("<span>(分数:" + holder.code + ")</span>");
				$code.css("color", "orange");
				$titleDiv.append($code);
			}

			$div.append($titleDiv);

			switch (type) {
			case "radio": {
				var options = holder.options;

				var order = parseInt(holder.order);
				if (!order) {
					order = 1;
				}

				if (options != null) {
					var $radioTable = $("<table class='optionTable' style='margin-top: 10px;'></table>");

					for (var i = 0; i < options.length; i++) {

						if (i % order == 0) {
							$radioTable.append("<tr></tr>");
						}
						var $tr = $radioTable.find("tr:last");

						var option = options[i];
						var name = option.name;
						var $radioDiv = $("<span id='Tab_hover2'><td></td></span>");
						// 添加选项
						var $radio = $("<span id='text_right_tab'><input type='radio' name='" + id
								+ "' value='" + name + "'/></span>");
						// 添加默认值
						if (option.selected) {
							$radio.children().attr("checked", "checked");
						}

						$radio.click(function() {
							holder.value = name;
						});

						$radioDiv.append($radio);
						// 是否含有图片
						if(holder.isPic && option.pic != ""){
							var $pic = $('<a href="'+option.pic+'" target="_blank">'
									+'<img class="filePic" src="'+option.pic+'" style="width: 50px;"></a>');
							$radioDiv.append($pic);
						}
						$radioDiv.append(option.name);
						// 是否填空
						if (option.isText) {
							var $text = $("<input type='text'/>");
							$radioDiv.append($text);

							if (option.isWill) {
								$radioDiv
										.prepend(redWill)
							}
						}
						$tr.append($radioDiv);
					}
					$div.append($radioTable);
				}
				break;
			}
			case "check": {
				var options = holder.options;
				if (options != null) {

					var order = parseInt(holder.order);
					if (!order) {
						order = 1;
					}
					var $checkTable = $("<table style='margin-top: 10px;'id='Tab_hover2'></table>");

					for (var i = 0; i < options.length; i++) {
						var option = options[i];
						var name = option.name;

						if (i % order == 0) {
							$checkTable.append("<tr class='table_Tab'></tr>");
						}

						var $tr = $checkTable.find("tr:last");

						var $checkDiv = $("<span id='Tab_hover2'><td></td></span>");
						// 添加选项
						var $check = $("<span id='text_right_tab'><input type='checkbox' name='" + id
								+ "' value='" + name + "'/></span>");
						// 添加默认值
						if (option.selected) {
							$check.children().attr("checked", "checked");
						}

						$check.click(function() {
							holder.value = name;
						});

						$checkDiv.append($check);
						// 是否含有图片
						if(holder.isPic && option.pic != ""){
							var $pic = $('<a href="'+option.pic+'" target="_blank">'
									+'<img class="filePic" src="'+option.pic+'" style="width: 50px;"></a>');
							$checkDiv.append($pic);
						}
						$checkDiv.append(option.name);
						// 是否填空
						if (option.isText) {
							$checkDiv.append("<input type='text'/>");

							if (option.isWill) {
								$checkDiv.append(redWill);
							}
						}
						$tr.append($checkDiv);
					}
					$div.append($checkTable);
				}
				break;
			}
			case "head" : {
				break;
			}
			case "input": {
				var $inputDiv = $("<div  style='margin-top: 10px; '></div>");
				var $input = $("<textarea readonly='readonly' style='resize: none;' name='" + id + "'/>");
				$inputDiv.append($input);

				// 设置高度
				var height = parseInt(holder.heightValue);
				$input.attr("row", height);
				$input.css("height", (height * 22) + "px")
				// 设置宽度
				$input.css("width", holder.widthValue);

				// 设置下拉样式
				if (holder.underlineStyle) {
					$input.css("border", "0px");
					$input.css("border-bottom", "solid 1px #7F9DB9");
				}

				// 设置默认值
				if (holder.isdefault) {
					$input.val(holder.defaultValue);
				}

				$div.append($inputDiv);
				break;
			}
			case "matrixradio": { //矩阵单选
				var $table = $("<table width='100%' style='margin-top: 10px; '><tr><td/></tr></table>");
				var labels = holder.leftLabel.split("\n");
				var options = holder.options;
				for (var j = 0; j < options.length; j++) {
					var option = options[j];
					var $trLast = $table.find("tr:last");
					$trLast.append("<td>" + option.name + "</td>");
				}
				for (var i = 0; i < labels.length; i++) {
					var $trLast = $table.find("tr:last");
					$trLast.after("<tr class='table_Tab'><td></tr>");

					$table.find("tr:last td:eq(0)").html(labels[i]);

					for (var k = 0; k < options.length; k++) {
						var option = options[k];
						var $last = $table.find("tr:last");
						$last.append("<td><input type='radio' name='"
								+ holder.id + "_" + labels[i] + "' value='" + k
								+ "'/></td>");
					}
				}

				var width = 100 / (options.length + 1);

				$table.css("text-align", "center").find("tr:first").find("td")
						.attr("width", width + "%");

				$div.append($table);

				break;
			}
			case "matrixcheck": { // 矩阵多选题
				// 定义一个表格
				var $table = $("<table width='100%; style='margin-top: 10px; '><tr><td/></tr></table>");
				// 切割标签
				var labels = holder.leftLabel.split("\n");
				// 获取选项
				var options = holder.options;
				// 定制表头
				for (var j = 0; j < options.length; j++) {
					var option = options[j];
					var $trLast = $table.find("tr:last");
					$trLast.append("<td>" + option.name + "</td>");
				}
				// 定制内容
				for (var i = 0; i < labels.length; i++) {
					var $trLast = $table.find("tr:last");

					$trLast.after("<tr class='table_Tab'><td></tr>");

					$table.find("tr:last td:eq(0)").html(labels[i]);

					for (var k = 0; k < options.length; k++) {
						var option = options[k];
						var $last = $table.find("tr:last");
						$last.append("<td><input type='checkbox' name='"
								+ holder.id + "_" + labels[i] + "_"
								+ option.name + "' value='" + option.name
								+ "'/></td>");
					}
				}

				var width = 100 / (options.length + 1);

				$table.css("text-align", "center").find("tr:first").find("td")
						.attr("width", width + "%");

				$div.append($table);

				break;
			}
			case "matrixinput": { // 矩阵填空题
				// 定义一个表格
				var $table = $("<table width='100%;' style='margin-top: 10px; '><tr><td/></tr></table>");
				// 切割标签
				var labels = holder.leftLabel.split("\n");
				// 获取选项
				var options = holder.options;
				// 定制内容
				for (var i = 0; i < labels.length; i++) {
					var $trLast = $table.find("tr:last");
					$trLast.after("<tr class='table_Tab matrixinput_Tr'><td></tr>");

					$table.find("tr:last td:eq(0)").html(labels[i]);

					var $last = $table.find("tr:last");
					$last.append("<td style='text-align:left;'><textarea readonly='readonly' style='resize:none;width:60%;' name='" + holder.id + "_"
							+ labels[i] + "' row='1' value='" + labels[i]
							+ "'/></td>");
				}

				$table.css("text-align", "center").find("tr:first");

				$div.append($table);
				break;
			}
			case "coderadio": {
				var options = holder.options;
				if (options != null) {
					$(options)
							.each(
									function(b) {
										var option = options[b];
										var name = option.name;
										var $radioDiv = $("<div style='margin-top: 10px;'></div>");
										// 添加选项
										var $radio = $("<span id='text_right_tab'><input style='margin-top:10px;' type='radio' name='"
												+ id
												+ "' value='"
												+ name
												+ "'/></span>");
										// 添加默认值
										if (option.isAnswer) {
											$radio.attr("checked", "checked");
										}

										$radio.click(function() {
											holder.value = name;
										});

										$radioDiv.append($radio);

										if (option.isNull) {
											$radioDiv
													.append(option.name
															+ "<span style='color:orange;'>(分数:0)</span>");
										} else {
											$radioDiv
													.append(option.name
															+ "<span style='color:orange;'>(分数:"
															+ option.code
															+ ")</span>");
										}

										$div.append($radioDiv);
									});
				}
				break;
			}
			case "codecheck": {
				var options = holder.options;
				if (options != null) {
					$(options)
							.each(
									function(b) {
										var option = options[b];
										var name = option.name;
										var $radioDiv = $("<div style='margin-top: 10px;'></div>");
										// 添加选项
										var $checkbox = $("<span id='text_right_tab'><input type='checkbox' name='"
												+ id
												+ "' value='"
												+ name
												+ "'/></span>");

										$radioDiv.append($checkbox);

										if (option.isNull) {
											$radioDiv
													.append(option.name
															+ "<span style='color:orange;'>(分数:0)</span>");
										} else {
											$radioDiv
													.append(option.name
															+ "<span style='color:orange;'>(分数:"
															+ option.code
															+ ")</span>");
										}

										$div.append($radioDiv);
									});
				}
				break;
			}

			case "codematrix": {
				var $table = $("<table width='100%; style='margin-top: 10px;'><tr><td/></tr></table>");
				var labels = holder.leftLabel.split("\n");
				var options = holder.options;
				for (var j = 0; j < options.length; j++) {
					var option = options[j];
					var $trLast = $table.find("tr:last");
					$trLast.append("<td>" + option.name + "</td>");
				}
				for (var i = 0; i < labels.length; i++) {
					var $trLast = $table.find("tr:last");
					$trLast.after("<tr class='table_Tab'><td></tr>");

					$table.find("tr:last td:eq(0)").html(labels[i]);

					for (var k = 0; k < options.length; k++) {
						var option = options[k];
						var $last = $table.find("tr:last");
						$last.append("<td><input type='radio' name='"
								+ holder.id + "_" + labels[i] + "' value='"
								+ option.code + "'/></td>");
					}
				}

				var width = 100 / (options.length + 1);

				$table.css("text-align", "center").find("tr:first").find("td")
						.attr("width", width + "%");

				$div.append($table);

				break;
			}
			case "testradio": {
				var options = holder.options;
				if (options != null) {
					$(options)
							.each(
									function(b) {
										var option = options[b];
										var name = option.name;
										var $radioDiv = $("<div  style='margin-top: 10px;'></div>");
										// 添加选项
										var $radio = $("<span id='text_right_tab'><input type='radio' name='"
												+ id
												+ "' value='"
												+ name
												+ "'/></span>");
										// 添加默认值
										if (option.isAnswer) {
											$radio.attr("checked", "checked");
										}

										$radio.click(function() {
											holder.value = name;
										});

										$radioDiv.append($radio);

										if (option.isAnswer) {
											$radioDiv
													.append("<span style='color:orange;'>"
															+ option.name
															+ "(正确答案)</span>");
										} else {
											$radioDiv.append(option.name);
										}

										$div.append($radioDiv);
									});
				}
				break;
			}
			case "testcheck": {
				var options = holder.options;
				if (options != null) {
					$(options)
							.each(
									function(b) {
										var option = options[b];
										var name = option.name;
										var $radioDiv = $("<div  style='margin-top: 10px;'></div>");
										// 添加选项
										var $radio = $("<span id='text_right_tab'><input type='checkbox' name='"
												+ id
												+ "' value='"
												+ name
												+ "'/></span>");
										// 添加默认值
										if (option.isAnswer) {
											$radio.attr("checked", "checked");
										}

										$radio.click(function() {
											holder.value = name;
										});

										$radioDiv.append($radio);

										if (option.isAnswer) {
											$radioDiv
													.append("<span style='color:orange;'>"
															+ option.name
															+ "(正确答案)</span>");
										} else {
											$radioDiv.append(option.name);
										}

										$div.append($radioDiv);
									});
				}
				break;
			}
			case "testinput": {
				var $inputDiv = $("<div style='margin-top: 10px;'></div>");
				var $input = $("<textarea readonly='readonly' style='resize:none;' name='" + id + "'/>");
				$inputDiv.append($input);

				// 设置高度
				var height = parseInt(holder.heightValue);
				$input.attr("row", height);
				$input.css("height", (height * 22) + "px")
				// 设置宽度
				$input.css("width", holder.widthValue);

				// 设置下拉样式
				if (holder.underlineStyle) {
					$input.css("border", "0px");
					$input.css("border-bottom", "solid 1px #7F9DB9");
				}

				// 设置默认值
				if (holder.isdefault) {
					$input.val(holder.defaultValue);
				}

				$div.append($inputDiv);
				break;
			}
			case "voteradio": {
				var $table = $("<table width='100%' style='margin-top: 10px;'></table>");
				var options = holder.options;
				for (var j = 0; j < options.length; j++) {
					var option = options[j];

					var name = option.name;
					var $checkDiv = $("<div  style='margin-top: 10px;'></div>");
					// 添加选项
					var $check = $("<span id='text_right_tab'><input type='radio' name='" + id
							+ "' value='" + name + "'/></span>");
					// 添加默认值
					if (option.selected) {
						$check.children().attr("checked", "checked");
					}

					$checkDiv.append($check);
					$checkDiv.append(option.name);

					// 是否填空
					if (option.isText) {
						var $text = $("<input type='text'/>");
						$checkDiv.append($text);

						if (option.isWill) {
							$checkDiv
									.append("<span style='color:red;'>*</span>")
						}
					}

					var $tr = $("<tr class='table_Tab'></tr>")
					var $td = $("<td style='text-align:left'></td>");

					var $td2 = $("<td style='text-align:left'>0票(0.00%)</td>");
					$td.append($checkDiv);

					$tr.append($td);
					$tr.append($td2);

					$table.append($tr);
				}

				$table.css("text-align", "center").find("tr:first").find("td")
						.attr("width", "50%");

				$div.append($table);

				break;
			}
			case "votecheck": {
				var $table = $("<table width='100%' style='margin-top: 10px; '></table>");
				var options = holder.options;
				for (var j = 0; j < options.length; j++) {
					var option = options[j];

					var name = option.name;
					var $checkDiv = $("<div style='margin-top: 10px;'></div>");
					// 添加选项
					var $check = $("<span id='text_right_tab'><input type='checkbox' name='" + id
							+ "' value='" + name + "'/></span>");
					// 添加默认值
					if (option.selected) {
						$check.children().attr("checked", "checked");
					}

					$check.click(function() {
						holder.value = name;
					});

					$checkDiv.append($check);
					$checkDiv.append(option.name);

					// 是否填空
					if (option.isText) {
						var $text = $("<input type='text'/>");
						$checkDiv.append($text);

						if (option.isWill) {
							$checkDiv
									.prepend("<span style='color:red;'>*</span>")
						}
					}

					var $tr = $("<tr class='table_Tab'></tr>")
					var $td = $("<td style='text-align:left'></td>");

					var $td2 = $("<td style='text-align:left'>0票(0.00%)</td>");
					$td.append($checkDiv);

					$tr.append($td);
					$tr.append($td2);

					$table.append($tr);
				}

				$table.css("text-align", "center").find("tr:first").find("td")
						.attr("width", "50%");

				$div.append($table);

				break;
			}
			case "head": {
				
				break;
			}

			}

			if (holder.isTips) {
				var $tipDiv = $("<div class='tips_div'></div>");
				$tipDiv.html("填写提示:" + holder.tips);
				$div.append($tipDiv);
			}
			
			return $div;
		},

		/**
		 * 返回json试题
		 */
		encodeJson : function() {
			var js = JSON.stringify(holders);
			return js;
		},

		/**
		 * 显示编辑框
		 */
		editElement : function(holder) {

			// 判断当前holder的位置
			var index = holders.indexOf(holder);
			var type = holder.type;
			// 复制并显示编辑框
			var $editDiv = $("#editDiv");
			var $newDiv = $editDiv.clone(true);
			
			//判断是否唯一设计器  如果不是则移除
			if(singleEditDiv != null){
				singleEditDiv.remove();
				singleEditDiv = null;
			}
			
			singleEditDiv = $newDiv;
			
			$newDiv.attr("id", holder.id + "_editDiv");
			$newDiv.attr("index", index);
			$newDiv.show();

			// 获取当前选中div
			var $div = $("#maiDiv").children("div").eq(index);
			$div.append($newDiv);

			// 题目标题
			var $topic = $newDiv.find("#topic");
			$topic.text(holder.topic);

			// 题目类型
			var $type = $newDiv.find("#type");
			switch (holder.type) {
			case "radio": {
				$type.html("单选题");
				break;
			}
			case "check": {
				$type.html("多选题");
				break;
			}
			case "matrixradio": {
				$type.html("矩阵单选题")
				break;
			}
			case "matrixcheck": {
				$type.html("矩阵多选题");
				break;
			}
			case "matrixinput": {
				$type.html("矩阵填空题");
				break;
			}
			case "coderadio": {
				$type.html("评分单选题");
				break;
			}
			case "codecheck": {
				$type.html("评分多选题");
				break;
			}
			case "codematrix": {
				$type.html("评分矩阵单选题");
				break;
			}
			case "testradio": {
				$type.html("考试单选题");
				break;
			}
			case "testcheck": {
				$type.html("考试多选题");
				break;
			}
			case "testinput": {
				$type.html("考试填空题");
				break;
			}
			case "voteradio": {
				$type.html("投票单选题");
				break;
			}
			case "votecheck": {
				$type.html("投票多选题");
				break;
			}
			}

			var $isWill = $newDiv.find("#isWill");
			var $divWill= $newDiv.find("#divWill");
			// 是否必填
			if(type=="head"){
				$divWill.css({"display":"none"});
				$isWill.attr("checked", false);
			}else{
				//todo
				$isWill.attr("checked", "checked");
			}
			if (holder.isWill) {
				$isWill.attr("checked", "checked");
			} else {
				$isWill.removeAttr("checked");
			}
			
			//图片题
			var $isPic = $newDiv.find("#isPic");
			var $divPic= $newDiv.find("#divPic");
			$isPic.prop("checked",holder.isPic);

			// 是否填写提示
			var $isTips = $newDiv.find("#isTips");
			var $divTips=$newDiv.find("#divTips");
			
			if(type=="head"){
				$divTips.css({"display":"none"});
				$isTips.attr("checked", false);
			}else{
				//todo
				//$isTips.attr("checked", false);
				if (holder.isTips) {
					$isTips.attr("checked", "checked");
				} else {
					$isTips.attr("checked", false);
				}
			}

			// 填写提示
			var $tips = $newDiv.find("#tips");
			$tips.val(holder.tips);

			// 考试类型题目分值赋值
			if (type.indexOf("test") >= 0) {
				var code = holder.code;
				var $code_select = $("#code_select");

				if (code > 0) {
					$code_select.val(parseInt(code));
				} else {
					$code_select.val(5);
				}
			}

			// 选相值
			switch (type) {
			case "voteradio":
			case "radio": {
				var $optionDiv = $newDiv.find("#optionDiv");
				$optionDiv.show();
				if(type == "radio"){
					var $isPicDiv = $newDiv.find("#divPic");
					$isPicDiv.show();
					
					// 其他操作按钮
					$isPicDiv.find("#isPic").click(function() {
						if($(this).prop("checked")){
							$optionDiv.addClass("isPic");
							
						}else{
							$optionDiv.removeClass("isPic");
						}
						
					});
				}
				var $optionsTable = $newDiv.find("#optionsTable");
				$optionsTable.show();
				var options = holder.options;
				if (options != null) {
					for (var i = 0; i < options.length; i++) {
						var option = options[i];					
						this._addOption($optionsTable, holder, option, i)
						file_upload_init(holder,option, i);
					}
				}
				
				if(holder.isPic){
					$optionDiv.addClass("isPic");
					
				}else{
					$optionDiv.removeClass("isPic");
				}

				// 其他操作按钮
				$optionDiv.find("#newOptions").click(
						function() {
							var trSize = $(this).parents("#optionDiv").find("#optionsTable tr").size();
							var newOption = new Object();
							newOption.name = "选项";
							QM.questionnaire._addOption($optionsTable, holder,
									newOption, trSize);

							file_upload_init(holder,newOption, trSize);
						});
				
				
				
				if("voteradio" == type){
					var $order_td = $optionDiv.find("#order_td");
					$order_td.hide();
				}

				var $order = $optionDiv.find("#order");
				var order = parseInt(holder.order);
				if (!order) {
					order = 1;
				}

				$order.val(order);
				
				
				
				break;
			}
			case "check": //多选题
			case "votecheck": { //投票多选
				var $optionDiv = $newDiv.find("#optionDiv");
				$optionDiv.show();
				if(type == "check"){
					var $isPicDiv = $newDiv.find("#divPic");
					$isPicDiv.show();
					
					// 其他操作按钮
					$isPicDiv.find("#isPic").click(function() {
						if($(this).prop("checked")){
							$optionDiv.addClass("isPic");
							
						}else{
							$optionDiv.removeClass("isPic");
						}
						
					});
				}
				var $optionsTable = $newDiv.find("#optionsTable");
				$optionsTable.show();
				var options = holder.options;
				for (var i = 0; i < options.length; i++) {
					var option = options[i];
					this._addOption($optionsTable, holder, option, i)
					file_upload_init(holder,option, i);
				}
				
				if(holder.isPic){
					$optionDiv.addClass("isPic");
					
				}else{
					$optionDiv.removeClass("isPic");
				}

				// 其他操作按钮
				$optionDiv.find("#newOptions").click(
						function() {
							var trSize = $(this).parents("#optionDiv").find("#optionsTable tr").size();
							var newOption = new Object();
							newOption.name = "选项";
							QM.questionnaire._addOption($optionsTable, holder,
									newOption, trSize);
							file_upload_init(holder,newOption, trSize);
						});
				
				
				
				if("votecheck" == type){
					var $order_td = $optionDiv.find("#order_td");
					$order_td.hide();
				}

				var $order = $optionDiv.find("#order");
				var order = parseInt(holder.order);
				if (!order) {
					order = 1;
				}

				$order.val(order);
				break;
			}
			case "input": {
				var $inputDiv = $newDiv.find("#inputDiv");
				$inputDiv.show();

				// 设置高度参数
				var $heightValue = $inputDiv.find("#heightValue");
				$heightValue.val(holder.heightValue);

				// 设置宽度参数
				var $widthValue = $inputDiv.find("#widthValue");
				$widthValue.val(holder.widthValue);

				// 下拉样式
				var $underlineStyle = $inputDiv.find("#underlineStyle");
				if (holder.underlineStyle) {
					$underlineStyle.attr("checked", "checked");
				}

				var $isdefault = $inputDiv.find("#isdefault");
				var $defaultValue = $inputDiv.find("#defaultValue");
				if (holder.isdefault) {
					$isdefault.attr("checked", "checked");
					$defaultValue.show();
					$defaultValue.val(holder.defaultValue);
				}

				$isdefault.click(function() {
					if (this.checked) {
						$defaultValue.show();
					} else {
						$defaultValue.hide();
					}
				})

				break;
			}
			case "matrixradio":
			case "matrixcheck": { // 矩阵多选题
				var options = holder.options;
				var $matrixDiv = $newDiv.find("#matrixDiv");
				$matrixDiv.show();

				var $leftLabel = $matrixDiv.find("#leftLabel");
				$leftLabel.val(holder.leftLabel);

				var $matrixOption = $matrixDiv.find("#matrixOption");
				for (var i = 0; i < options.length; i++) {
					var option = options[i];
					this._addOption($matrixOption, holder, option);
				}
				$matrixDiv.find("#newOptions").click(
						function() {
							var trSize = $(this).parents("#optionDiv").find("#optionsTable tr").size();
							var newOption = new Object();
							newOption.name = "选项";
							QM.questionnaire._addOption($matrixOption, holder,
									newOption, trSize);
							file_upload_init(holder,newOption, trSize);
						});

				break;
			}

			case "matrixinput": { // 矩阵填空题
				var $matrixDiv = $newDiv.find("#matrixDiv");
				$matrixDiv.show();

				var $leftLabel = $matrixDiv.find("#leftLabel");
				$leftLabel.val(holder.leftLabel);

				var $matrixOptionDiv = $matrixDiv.find("#matrixOptionDiv");
				$matrixOptionDiv.hide();
				break;
			}

			case "codecheck":
			case "coderadio": { // 评分单选
				var $codeDiv = $newDiv.find("#codeDiv");
				var $codeTable = $newDiv.find("#codeOption");
				$codeDiv.show();
				$codeTable.show();

				var options = holder.options;
				for (var i = 0; i < options.length; i++) {
					var option = options[i];
					this._addOption($codeTable, holder, option)
				}

				$codeDiv.find("#newOptions").click(function() {
					var trSize = $(this).parents("#optionDiv").find("#optionsTable tr").size();
					var newOption = new Object();
					newOption.name = "选项";
					QM.questionnaire._addOption($codeTable, holder, newOption, trSize);
					file_upload_init(holder,newOption, trSize);
				});

				break;
			}

			case "codematrix": { // 评分矩阵单选题
				var options = holder.options;
				var $matrixDiv = $newDiv.find("#codeMatrixDiv");
				$matrixDiv.show();

				var $leftLabel = $matrixDiv.find("#leftLabel");
				$leftLabel.val(holder.leftLabel);

				var $matrixOption = $matrixDiv.find("#matrixOption");
				for (var i = 0; i < options.length; i++) {
					var option = options[i];
					this._addOption($matrixOption, holder, option);
				}
				$matrixDiv.find("#newOptions").click(function() {
					var trSize = $(this).parents("#optionDiv").find("#optionsTable tr").size();
							var newOption = new Object();
							newOption.name = "选项";
							QM.questionnaire._addOption($matrixOption, holder, newOption, trSize);
							file_upload_init(holder,newOption, trSize);
						});

				break;
			}

			case "testradio": {
				var $optionsDiv = $newDiv.find("#testOptionDiv");
				var $optionsTable = $newDiv.find("#testOption");
				$optionsDiv.show();
				$optionsTable.show();
				var options = holder.options;
				for (var i = 0; i < options.length; i++) {
					var option = options[i];
					this._addOption($optionsTable, holder, option)
				}

				var $code_select = $optionsDiv.find("#code_select");

				var code = parseInt(holder.code);
				if (!code) {
					code = 0;
				}

				$code_select.val(code);

				$optionsDiv.find("#newOptions").click(
						function() {
							var trSize = $(this).parents("#optionDiv").find("#optionsTable tr").size();
							var newOption = new Object();
							newOption.name = "选项";
							QM.questionnaire._addOption($optionsTable, holder,
									newOption, trSize);
							file_upload_init(holder,newOption, trSize);
						});
				break;
			}
			case "testcheck": { // 考试多选题
				var $optionsDiv = $newDiv.find("#testOptionDiv");
				var $optionsTable = $newDiv.find("#testOption");
				$optionsDiv.show();
				$optionsTable.show();
				var options = holder.options;
				for (var i = 0; i < options.length; i++) {
					var option = options[i];
					this._addOption($optionsTable, holder, option)
				}

				var $code_select = $optionsDiv.find("#code_select");

				var code = parseInt(holder.code);
				if (!code) {
					code = 0;
				}

				$code_select.val(code);

				// 其他操作按钮
				$optionsDiv.find("#newOptions").click(
						function() {
							var trSize = $(this).parents("#optionDiv").find("#optionsTable tr").size();
							var newOption = new Object();
							newOption.name = "选项";
							QM.questionnaire._addOption($optionsTable, holder,
									newOption, trSize);
							file_upload_init(holder,newOption, trSize);
						});
				break;
			}
			case "testinput": {
				var $inputDiv = $newDiv.find("#inputDiv");
				$inputDiv.show();

				//显示考试题属性
				var $testAttribute = $newDiv.find("#testAttribute");
				$testAttribute.show();

				// 设置高度参数
				var $heightValue = $inputDiv.find("#heightValue");
				$heightValue.val(holder.heightValue);

				// 设置宽度参数
				var $widthValue = $inputDiv.find("#widthValue");
				$widthValue.val(holder.widthValue);

				// 下划线样式
				var $underlineStyle = $inputDiv.find("#underlineStyle");
				if (holder.underlineStyle) {
					$underlineStyle.attr("checked", "checked");
				}

				var $isdefault = $inputDiv.find("#isdefault");
				var $defaultValue = $inputDiv.find("#defaultValue");
				if (holder.isdefault) {
					$isdefault.attr("checked", "checked");
					$defaultValue.show();
					$defaultValue.val(holder.defaultValue);
				}

				var $code_select = $inputDiv.find("#code_select");

				var code = parseInt(holder.code);
				if (!code) {
					code = 0;
				}

				$code_select.val(code);

				$isdefault.click(function() {
					if (this.checked) {
						$defaultValue.show();
					} else {
						$defaultValue.hide();
					}
				});

				var $standardanswer = $inputDiv.find("#standard_answer");
				$standardanswer.val(holder.standardanswer);

				break;
			}
			
			}

			var $complete = $newDiv.find("#completeB");
			var $cancelBtn = $newDiv.find("#completeC");
			$complete.attr("index", index);
			$cancelBtn.attr("index", index);
			$complete.click(function() {
				var index = $(this).attr("index");
				var holder = holders[index];
				
				if($isTips.get(0).checked && $tips.val() == ""){
					alert("请输入填写提示");
					return false;
				}
				
				var $div = $("#maiDiv").children("div").eq(index);

				$div.removeClass("selected");

				var $editText = $("#" + holder.id + "_editText");
				
				$editText.parent().find("span").show();
				$editText.text("编辑");

				$(".stuff").hide();

				holder.topic = $topic.val();
				holder.isWill = $isWill.get(0).checked;
				holder.isTips = $isTips.get(0).checked;
				holder.tips = $tips.val();
				holder.isPic = $isPic.get(0).checked;

				var type = holder.type;
				if (type.indexOf("test") >= 0) {
					var $code_select = $("#code_select");
					holder.code = $code_select.val();
				}
				
				// 选相值
				switch (holder.type) {
				case "radio":
				case "voteradio": {
					// 获取除了标题列外的
					holder.options = new Array();

					var $optionDiv = $("#optionDiv");
					var $order = $optionDiv.find("#order");
					holder.order = $order.val();
				
					var $optionTable = $("#optionsTable tr:gt(0)");
					if($optionTable.length <= 0){
						alert("请新增选项");
						return false;
					}
					for (var i = 0; i < $optionTable.length; i++) {
						var option = new Object();
						var tr = $optionTable.get(i);
						var $optionName = $(tr).find("td:eq(0)").find("input");
						var $uploadPic = $(tr).find("td:eq(1)").find(".uploader-list");
						var $texts = $(tr).find("td:eq(2)").find("div").children();
						var $selected = $(tr).find("td:eq(3)").find("input");
						
						option.name = $optionName.val();
						var imgUrl = $uploadPic.find("img").attr("src");
						if(holder.isPic){
							if(imgUrl != ""){
								option.pic = imgUrl;
							}else{
								alert("[" + option.name + "]图片未上传!");
								return false;
							}
						}

						$texts.each(function(t) {
							if (t == 0) {
								option.isText = this.checked;
							}
							if (t == 2) {
								option.isWill = this.checked;
							}
						})

						option.selected = $selected.get(0).checked;
						holder.options.add(option);
					}
					break;
				}
				case "check":
				case "votecheck": {
					// 获取除了标题列外的
					holder.options = new Array();
					var $optionTable = $("#optionsTable tr:gt(0)");
					if($optionTable.length <= 0){
						alert("请新增选项");
						return false;
					}
					var $optionDiv = $("#optionDiv");
					var $order = $optionDiv.find("#order");
					holder.order = $order.val();
					for (var i = 0; i < $optionTable.length; i++) {
						var option = new Object();
						var tr = $optionTable.get(i);
						var $optionName = $(tr).find("td:eq(0)").find("input");
						var $uploadPic = $(tr).find("td:eq(1)").find(".uploader-list");
						var $texts = $(tr).find("td:eq(2)").find("div").children();
						var $selected = $(tr).find("td:eq(3)").find("input");

						option.name = $optionName.val();
						var imgUrl = $uploadPic.find("img").attr("src");
						
						if(holder.isPic){
							if(imgUrl != ""){
								option.pic = imgUrl;
							}else{
								alert("[" + option.name + "]图片未上传!");
								return false;
							}
						}
						
						
						
						$texts.each(function(t) {
							if (t == 0) {
								option.isText = this.checked;
							}
							if (t == 2) {
								option.isWill = this.checked;
							}
						});

						option.selected = $selected.get(0).checked;
						holder.options.add(option);
					}
					break;
				}
				case "input": {
					var $inputDiv = $(this).parent().find("#inputDiv");

					// 设置高度参数
					var $heightValue = $inputDiv.find("#heightValue");
					holder.heightValue = $heightValue.val();

					// 设置宽度参数
					var $widthValue = $inputDiv.find("#widthValue");
					holder.widthValue = $widthValue.val();

					var $underlineStyle = $inputDiv.find("#underlineStyle");
					holder.underlineStyle = $underlineStyle[0].checked;

					if($inputDiv.find("#isdefault").get(0).checked && $inputDiv.find("#defaultValue").val() == ""){
						alert("请输入默认值");
						return false;
					}
					
					var $isdefault = $inputDiv.find("#isdefault");
					holder.isdefault = $isdefault[0].checked;

					var $defaultValue = $inputDiv.find("#defaultValue");
					holder.defaultValue = $defaultValue.val();

					break;
				}
				case "matrixradio": // 矩阵单选
				case "matrixcheck": { // 矩阵多选
					var $matrixDiv = $(this).parent().find("#matrixDiv");
					var $leftLabel = $matrixDiv.find("#leftLabel");
					
					holder.leftLabel = $leftLabel[0].value;

					// 获取除了标题列外的
					holder.options = new Array();
					var $optionTable = $matrixDiv
							.find("#matrixOption tr:gt(0)");
					if($optionTable.length <= 0){
						alert("请新增选项");
						return false;
					}
					for (var i = 0; i < $optionTable.length; i++) {
						var option = new Object();
						var tr = $optionTable.get(i);
						var $optionName = $(tr).find("td:eq(0)").find("input");

						option.name = $optionName.val();

						holder.options.add(option);
					}
					break;
				}
				case "matrixinput": { // 矩阵填空
					var $matrixDiv = $(this).parent().find("#matrixDiv");
					var $leftLabel = $matrixDiv.find("#leftLabel");
					holder.leftLabel = $leftLabel.val();
					break;
				}
				case "coderadio": // 评分单选
				case "codecheck": { // 评分多选
					// 获取除了标题列外的
					holder.options = new Array();
					var $optionTable = $("#codeOption tr:gt(0)");
					if($optionTable.length <= 0){
						alert("请新增选项");
						return false;
					}
					for (var i = 0; i < $optionTable.length; i++) {
						var option = new Object();
						var tr = $optionTable.get(i);
						var $optionName = $(tr).find("td:eq(0)").find("input");
						var $code = $(tr).find("td:eq(3)").find("input:eq(0)");
						var $isNull = $(tr).find("td:eq(3)").find("input:eq(1)");

						option.name = $optionName.val();
						var code = parseInt($code.val());
						if (code > 0) {
							option.code = code;
						} else {
							option.code = 0;
						}
						option.isNull = $isNull[0].checked;

						holder.options.add(option);
					}
					break;
				}
				case "codematrix": {
					var $matrixDiv = $(this).parent().find("#codeMatrixDiv");
					var $leftLabel = $matrixDiv.find("#leftLabel");
					holder.leftLabel = $leftLabel[0].value;

					// 获取除了标题列外的
					holder.options = new Array();
					var $optionTable = $matrixDiv
							.find("#matrixOption tr:gt(0)");
					if($optionTable.length <= 0){
						alert("请新增选项");
						return false;
					}
					for (var i = 0; i < $optionTable.length; i++) {
						var option = new Object();
						var tr = $optionTable.get(i);
						var $optionName = $(tr).find("td:eq(0)").find("input");

						option.name = $optionName.val();

						var $code = $(tr).find("td:eq(2)").find("input:eq(0)");
						var $isNull = $(tr).find("td:eq(2)").find("input:eq(1)");

						var code = parseInt($code.val());
						if (code > 0) {
							option.code = code;
						} else {
							option.code = 0;
						}

						option.isNull = $isNull[0].checked;

						holder.options.add(option);
					}
					break;
				}
				case "testradio": {
					// 获取除了标题列外的
					holder.options = new Array();
					var $optionTable = $("#testOption tr:gt(0)");
					if($optionTable.length <= 0){
						alert("请新增选项");
						return false;
					}
					for (var i = 0; i < $optionTable.length; i++) {
						var option = new Object();
						var tr = $optionTable.get(i);
						var $optionName = $(tr).find("td:eq(0)").find("input");
						var $selected = $(tr).find("td:eq(2)").find("input");

						option.name = $optionName.val();

						option.isAnswer = $selected.get(0).checked;
						holder.options.add(option);
					}
					var $code_select = $("#testOptionDiv").find("#code_select");
					holder.code = $code_select.val();
					break;
				}

				case "testcheck": { // 考试多选题
					// 获取除了标题列外的
					holder.options = new Array();
					var $optionTable = $("#testOption tr:gt(0)");
					if($optionTable.length <= 0){
						alert("请新增选项");
						return false;
					}
					for (var i = 0; i < $optionTable.length; i++) {
						var option = new Object();
						var tr = $optionTable.get(i);
						var $optionName = $(tr).find("td:eq(0)").find("input");
						var $selected = $(tr).find("td:eq(2)").find("input");

						option.name = $optionName.val();

						option.isAnswer = $selected.get(0).checked;
						holder.options.add(option);
					}

					var $code_select = $("#testOptionDiv").find("#code_select");
					holder.code = $code_select.val();

					break;
				}
				case "testinput": {
					var $inputDiv = $(this).parent().find("#inputDiv");

					// 设置高度参数
					var $heightValue = $inputDiv.find("#heightValue");
					holder.heightValue = $heightValue.val();

					// 设置宽度参数
					var $widthValue = $inputDiv.find("#widthValue");
					holder.widthValue = $widthValue.val();

					var $underlineStyle = $inputDiv.find("#underlineStyle");
					holder.underlineStyle = $underlineStyle[0].checked;

					var $isdefault = $inputDiv.find("#isdefault");
					holder.isdefault = $isdefault[0].checked;

					var $defaultValue = $inputDiv.find("#defaultValue");
					holder.defaultValue = $defaultValue.val();

					var $code_select = $inputDiv.find("#code_select");
					holder.code = $code_select.val();

					var $standard_answer = $inputDiv.find("#standard_answer");
					holder.standardanswer = $standard_answer.val();

					break;
				}
				}

				var $createDiv = QM.questionnaire._createDiv(holder);
				var $newDiv = $("#" + holder.id + "_editDiv");
				$newDiv.remove();
				var $div = $("#maiDiv").children("div");
				$("#maiDiv").children("div").eq(index).children("div").eq(0)
						.html($createDiv);
			});
			
			$cancelBtn.click(function(){
				var index = $(this).attr("index");
				var holder = holders[index];

				var $div = $("#maiDiv").children("div").eq(index);

				$div.removeClass("selected");

				var $editText = $("#" + holder.id + "_editText");
				
				$editText.parent().find("span").show();
				$editText.text("编辑");

				$(".stuff").hide();
				
				if(holder.type=="radio" || holder.type=="check"){
					$div.find(".option-pic").not(".option-pic:first").each(function(i){
						var $img = $(this).find("img.filePic");
						var src = $img.attr("src");
						var optionPic = holder.options[i].pic;
						
						if(!optionPic || optionPic == "" || optionPic!=src){
							deleteAttachment(src.substr(contextPath.length),function(){});
						}
					})
				}
				$("#" + holder.id + "_editDiv").remove();

			});
			//$div.append($newDiv);
			
			
		},

		/**
		 * 选项题编辑器增加子项
		 */
		_addOption : function($optionsTable, holder, option, key) {
			// 选项列表最后插入一行
			var $lastTr = $optionsTable.find("tr:last");
			// 插入一行四列表格 各类型题目自由增减
			var $tr = $("<tr><td/><td class='option-pic' style='text-align: center;'/><td  style='text-align: left;'/><td  style='text-align: center;'/><td style='text-align: center;'/></tr>");
			$lastTr.after($tr);

			// 选项名
			var $optionName = $("<input type='text'/>");
			$optionName.val(option.name);
			// 查找选项列表最后一行的第一列数据
			$optionsTable.find("tr:last td:eq(0)").html($optionName);

			var type = holder.type;
			switch (type) {
			case "voteradio":
			case "radio": {
				// 是否可填空
				var $optionText = $("<div></div>");
				var $isText = $("<input type='checkbox' style='margin-right:10px'/>");
				var $textIsWill = $("<input type='checkbox'/>");
				var $isWillTitle = $("<span>  文本框必填</span>");
				
				var $isPicHtml = $('<div id="uploader-'+key+'">'
						+'<div id="fileList-'+key+'" class="uploader-list">'
						+'<a href="" target="_blank" style="display:none">'
						+'<img class="filePic" src="" style="width: 50px;" /></a></div>'
						+'<div id="filePicker-'+key+'">选择图片</div></div>');
				
				//var $isPicHtml = $('<input type="file" name="file_upload" id="file_upload" multiple="true" />');
				
				
				
				
				$textIsWill.hide();
				$isWillTitle.hide();
				$isText.click(function() {
					// 控制当前选中项同级下一个元素阴隐藏
					if (this.checked) {
						$textIsWill.show();
						$isWillTitle.show();
					} else {
						$textIsWill.hide();
						$isWillTitle.hide();
					}

				});

				if (option.isText) {
					$isText.attr("checked", "checked");
					$textIsWill.show();
					$isWillTitle.show();
				}

				if (option.isWill) {
					$textIsWill.attr("checked", "checked");
				}

				$optionText.append($isText).append($isWillTitle).append(
						$textIsWill);
				
				// 查找选项列表最后一行的第二列数据
				$optionsTable.find("tr:last td:eq(1)").html($isPicHtml);

				// 查找选项列表最后一行的第三列数据
				$optionsTable.find("tr:last td:eq(2)").html($optionText);

				// 是否默认
				var $selected = $("<input type='radio' name='optionRadio_"
						+ holder.id + "'/>");
				if (option.selected) {
					$selected.attr("checked", "checked")
				}
				// 查找选项列表最后一行的第四列数据
				$optionsTable.find("tr:last td:eq(3)").html($selected);
				break;
			}
			case "votecheck": //投票多选题
			case "check": { //多选题
				// 是否可填空
				var $optionText = $("<div style='margin-top: 10px; '></div>");
				var $isText = $("<input type='checkbox' style='margin-right:10px'/>");
				var $textIsWill = $("<input type='checkbox'/>");
				var $isWillTitle = $("<span>  文本框必填</span>");
				var $isPicHtml = $('<div id="uploader-'+key+'">'
						+'<div id="fileList-'+key+'" class="uploader-list">'
						+'<a href="" target="_blank" style="display:none">'
						+'<img class="filePic" src="" style="width: 50px;" /></a></div>'
						+'<div id="filePicker-'+key+'">选择图片</div></div>');
				
				
				$textIsWill.hide();
				$isWillTitle.hide();
				$isText.click(function() {
					// 控制当前选中项同级下一个元素阴隐藏
					if (this.checked) {
						$textIsWill.show();
						$isWillTitle.show();
					} else {
						$textIsWill.hide();
						$isWillTitle.hide();
					}

				});

				if (option.isText) {
					$isText.attr("checked", "checked");
					$textIsWill.show();
					$isWillTitle.show();
				}

				if (option.isWill) {
					$textIsWill.attr("checked", "checked");
				}
				$optionText.append($isText).append($isWillTitle).append(
						$textIsWill);
				
				
				// 查找选项列表最后一行的第二列数据
				$optionsTable.find("tr:last td:eq(1)").html($isPicHtml);

				// 查找选项列表最后一行的第三列数据
				$optionsTable.find("tr:last td:eq(2)").html($optionText);
				
				var $selected = $("<input type='checkbox' name='optionRadio_"
						+ holder.id + "'/>");
				if (option.selected) {
					$selected.attr("checked", "checked")
				}
				// 查找选项列表最后一行的第四列数据
				$optionsTable.find("tr:last td:eq(3)").html($selected);
				break;
			}
			case "matrixradio": {
				$optionsTable.find("tr:last td:last").remove();
				$optionsTable.find("tr:last td:last").remove();
				break;
			}
			case "matrixcheck": { // 矩阵多选题
				$optionsTable.find("tr:last td:last").remove();
				$optionsTable.find("tr:last td:last").remove();
				break;
			}
			case "coderadio": // 评分单选
			case "codecheck": { // 评分多选

				// 分数文本框
				var $code = $("<input type='text' name='" + holder.id + "_"
						+ option.name + "'/>");
				// 不计分
				var $isNull = $("<input type='checkbox' name='" + holder.id
						+ "'/>");
				$isNull.click(function() {
					$(this).prev().val("");
				});

				if (option.isNull) {
					$isNull.attr("checked", "checked")
				}

				$code.val(option.code)

				// 查找选项列表最后一行的第三列数据
				$optionsTable.find("tr:last td:eq(3)").append($code).append(
						"  不记分").append($isNull)
				break;
			}
			case "codematrix": {
				$optionsTable.find("tr:last td:last").remove();
				// 是否可填空
				// 查找选项列表最后一行的第二列数据

				// 分数文本框
				var $code = $("<input type='text' name='" + holder.id + "_"
						+ option.name + "'/>");
				// 不计分
				var $isNull = $("<input type='checkbox' name='" + holder.id
						+ "'/>");
				$isNull.click(function() {
					$(this).prev().val("");
				});

				if (option.isNull) {
					$isNull.attr("checked", "checked")
				}

				$code.val(option.code)

				// 查找选项列表最后一行的第三列数据
				$optionsTable.find("tr:last td:eq(2)").append($code).append(
						"  不记分").append($isNull)
				break;
			}

			case "testradio": {
				$optionsTable.find("tr:last td:last").remove();
				// 是否正确答案
				var $isAnswer = $("<input type='radio' name='optionRadio_"
						+ holder.id + "'/>");
				if (option.isAnswer) {
					$isAnswer.attr("checked", "checked");
				}
				// 查找选项列表最后一行的第三列数据
				$optionsTable.find("tr:last td:eq(2)").html($isAnswer);
				break;
			}
			case "testcheck": {
				$optionsTable.find("tr:last td:last").remove();
				// 是否正确答案
				var $isAnswer = $("<input type='checkbox' name='optionRadio_"
						+ holder.id + "'/>");
				if (option.isAnswer) {
					$isAnswer.attr("checked", "checked");
				}
				// 查找选项列表最后一行的第三列数据
				$optionsTable.find("tr:last td:eq(2)").html($isAnswer);
				break;
			}

			}
			var $delete = $("<a href='javascript:void(0)' class='Button_Edit_delete'>删除</a>");
			// 查找选项列表最后一行的最后一列数据
			$optionsTable.find("tr:last td:last").html($delete);
			$delete.click(function() {
				$(this).parent().parent().remove();
			});

		}
	}
}
