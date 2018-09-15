var holders;
var answers;
/**
 * 问卷填写
 */
var QM = {

	answer : {
		init : function(holderjson, answerjson) {
			holders = $.parseJSON(holderjson);
			if (holders == null) {
				holders = new Array();
			}
			var $maindiv = $("#maiDiv");
			$(holders).each(function(a) {
				var holder = holders[a];
				var $div = $("<div></div>");
				var $topic = QM.answer._createDiv(holder);
				$div.append($topic);
				$maindiv.append($div);
				$maindiv.append("<br>");
				$maindiv.append("<br>");
			});

			answers = $.parseJSON(answerjson);
			if (answers) {
				for (var i = 0; i < answers.length; i++) {
					var answer = answers[i];
					switch (answer.type) {
					case "radio": {
						if (answer.options) {
							for (var b = 0; b < answer.options.length; b++) {
								var option = answer.options[b];
								var $aa = $("#" + answer.id).find(
										"input[name='" + answer.id
												+ "'][value='" + option.name
												+ "'] ");

								$aa.attr("checked", "checked");

								var $bb = $("#" + answer.id).find(
										"#" + answer.id + option.name);
								$bb.val(option.explains);
							}
						}
						break;
					}
					case "check": {
						if (answer.options) {
							for (var b = 0; b < answer.options.length; b++) {
								var option = answer.options[b];
								var $aa = $("#" + answer.id).find(
										"input[name='" + answer.id
												+ "'][value='" + option.name
												+ "'] ");

								$aa.attr("checked", "checked");

								var $bb = $("#" + answer.id).find(
										"#" + answer.id + option.name);
								$bb.val(option.explains);
							}
						}
						break;

					}

					}
				}
			}

			var $completeB = $("#completeB");
			$completeB.click(function() {
				QM.answer.encodeJson(holderjson);
			});
		},

		/**
		 * 初始化试题
		 * 
		 * @param holder
		 * @returns
		 */
		_createDiv : function(holder) {
			var id = holder.id;
			var type = holder.type;
			var number = holders.indexOf(holder);

			var topic = holder.topic;

			var headCount=0;
			
			for(var a=0; a<number;a++){
				var h=holders[a];
				if(h.type=="head"){
					headCount++;
				}
			}
			
			var $div;
			var $titleDiv
			// 题目
			if(type!="head"){
				var title = (number + 1 - headCount) + "、" + topic;
				$div = $("<div style='padding: 15px 0px 0px 35px;border-bottom: 1px #e7e7e7 solid;' id='" + id + "'></div>");
				$titleDiv = $("<div></div>");
			}else{
				var title = topic;
				$div = $("<div style='padding: 15px 0px 0px 35px;height:1px;' id='" + id + "'></div>");
				$titleDiv = $("<div style='display:inline-block;font-size:16px;color:#9c9c9c;'></div>");
			}
			

			$titleDiv.text(title);

			// 是否必填
			if (holder.isWill) {
				var $will = $("<span>*</span>");
				$will.css("color", "red");
				$titleDiv.prepend($will);
			}

			if (type.indexOf("test") >= 0) {
				var $code = $("<span style='color:orange'>(分数:" + holder.code
						+ ")</span>");
				$titleDiv.append($code)
			}

			$div.append($titleDiv);

			// 内容

			switch (type) {
			case "radio": {
				var options = holder.options;
				var order = holder.order;
				if (!order) {
					order = 1;
				}
				var $radioTable = $("<table style='width:100%; margin-top: 10px;'></table>");
				if (options != null) {
					for (var i = 0; i < options.length; i++) {
						var option = options[i];

						if (i % order == 0) {
							$radioTable.append("<tr id='user_Tab_hover'></tr>");
						}

						var $tr = $radioTable.find("tr:last");

						var name = option.name;
						var $radioDiv = $("<td></td>");
						
						
						
						// 添加选项
						var $radio = $("<input type='radio' name='" + id
								+ "' value='" + name + "'/>");
						
						$radioDiv.append($radio);

						// 是否含有图片
						if(holder.isPic && option.pic != ""){
							var $pic = $('<a data-id="'+holder.id+"-"+option.name+'" href="'+option.pic+'" target="_blank">'
									+'<img class="filePic" src="'+option.pic+'" style="width: 50px;"></a>');
							$radioDiv.append($pic);
						}
						
						$radioDiv.append(option.name);
						
						var $text = null;
						var $span = null;
						// 是否填空
						if (option.isText) {
							var $text = $("<input type='text' name='"+id+"' id='" + option.name + "'/>");
							$radioDiv.append($text);

							if (option.isWill) {
								var $span = $("<span style='color:red;' name='"+id+"' id='"+option.name+"_span"+"'>*</span>");
								$radioDiv.append($span);
							}
							
							if (option.selected) {
								$text.show();
								if (option.isWill) {
									$span.show();
								}
							}else{
								$text.hide();
								if (option.isWill) {
									$span.hide();
								}
							}

						}
						
						// 添加默认值
						if (option.selected) {
							$radio.attr("checked", "checked");
						}

						$radio.change(function() {
							var $radios = $("input[name='" + id + "'][type='radio']");
							$radios.each(function(a) {
								var o = options[a];
								o.selected = this.checked;
								
								if(this.checked){
									
									$("input[name='"+id+"'][id='"+o.name+"']").show();
									$("span[name='"+id+"'][id='"+o.name+"_span"+"']").show();
									
								}else{
									$("input[name='"+id+"'][id='"+o.name+"']").hide();
									$("span[name='"+id+"'][id='"+o.name+"_span"+"']").hide();
								}
							})
						});

						$tr.append($radioDiv);
					}
					$div.append($radioTable);
				}
				break;
			}
			case "check": {
				var options = holder.options;
				var order = holder.order;
				if (!order) {
					order = 1;
				}
				var options = holder.options;
				if (options != null) {
					var $checkTable = $("<table style='width:100%; margin-top:10px;'></table>");
					for (var i = 0; i < options.length; i++) {
						var option = options[i];
						var name = option.name;

						if (i % order == 0) {
							$checkTable.append("<tr id='user_Tab_hover'></tr>");
						}

						var $tr = $checkTable.find("tr:last");

						var $checkDiv = $("<td></td>");
						// 添加选项
						var $check = $("<input type='checkbox' name='" + id
								+ "' value='" + name + "'/>");
						// 添加默认值
						if (option.selected) {
							$check.attr("checked", "checked");
						}

						$checkDiv.append($check);
						// 是否含有图片
						if(holder.isPic && option.pic != ""){
							var $pic = $('<a data-id="'+holder.id+"-"+option.name+'" href="'+option.pic+'" target="_blank">'
									+'<img class="filePic" src="'+option.pic+'" style="width: 50px;"></a>');
							$checkDiv.append($pic);
						}
						$checkDiv.append(option.name);

						$check.change(function() {
							var $checks = $("input[name='" + id + "'][type='checkbox']");
							$checks.each(function(a) {
								var o = options[a];
								o.selected = this.checked;
								
								//由选中状态改变文本框是否出现
								if(this.checked){
									$("input[name='"+id+"'][id='"+o.name+"']").show();
									$("span[name='"+id+"'][id='"+o.name+"_span"+"']").show();
								}else{
									$("input[name='"+id+"'][id='"+o.name+"']").hide();
									$("span[name='"+id+"'][id='"+o.name+"_span"+"']").hide();
								}
								
							})
						});

						// 是否填空
						if (option.isText) {
							var $text = $("<input type='text' name='"+id+"' id='" + option.name + "'/>");
							$checkDiv.append($text);

							if (option.isWill) {
								var $span = $("<span style='color:red;' name='"+id+"' id='"+option.name+"_span"+"'>*</span>");
								$checkDiv.append($span);
							}
							
							if (option.selected) {
								$text.show();
								if (option.isWill) {
									$span.show();
								}
							}else{
								$text.hide();
								if (option.isWill) {
									$span.hide();
								}
							}

						}
						$tr.append($checkDiv);
					}
					$div.append($checkTable);
				}
				break;
			}
			case "input": {
				var $inputDiv = $("<div class='pingfendanxuanti' id='user_Tab_hover'></div>");
				var $input = $("<textarea name='" + id + "'/>");
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

				$input.change(function() {
					holder.value = $(this).val();
				});

				$div.append($inputDiv);
				break;
			}
			case "matrixradio": {
				var $table = $("<table style='width:100%; margin-top:10px;'><tr><td/></tr></table>");
				var labels = holder.leftLabel.split("\n");
				var options = holder.options;
				for (var j = 0; j < options.length; j++) {
					var option = options[j];
					var $trLast = $table.find("tr:last");
					$trLast.append("<td>" + option.name + "</td>");
				}
				for (var i = 0; i < labels.length; i++) {
					var $trLast = $table.find("tr:last");
					$trLast.after("<tr id='user_Tab_hover'><td></tr>");

					$table.find("tr:last td:eq(0)").html(labels[i]);

					for (var k = 0; k < options.length; k++) {
						var option = options[k];
						var $last = $table.find("tr:last");
						$last.append("<td><input type='radio' name='"
								+ holder.id + "_" + labels[i] + "' value='" + option.name + "'/></td>");
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
				var $table = $("<table style='width:100%; margin-top:10px;'><tr><td/></tr></table>");
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
					$trLast.after("<tr id='user_Tab_hover'><td></tr>");

					$table.find("tr:last td:eq(0)").html(labels[i]);

					for (var k = 0; k < options.length; k++) {
						var option = options[k];
						var $last = $table.find("tr:last");

						// 矩阵选项id为题目编码+左行标签+选项名
						$last.append("<td><input type='checkbox' name='"
								+ holder.id + "_" + labels[i] + "' value='"
								+ option.name + "'/></td>");
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
				var $table = $("<table style='width:100%; margin-top:10px;'><tr><td/></tr></table>");
				// 切割标签
				var labels = holder.leftLabel.split("\n");
				// 获取选项
				var options = holder.options;
				// 定制内容
				for (var i = 0; i < labels.length; i++) {
					var $trLast = $table.find("tr:last");
					$trLast.after("<tr id='user_Tab_hover'><td style='text-align:left;'></tr>");

					$table.find("tr:last td:eq(0)").html(labels[i]);

					var $last = $table.find("tr:last");
					$last.append("<td style='text-align:left;'><textarea style='width:60%;min-width:400px' name='" + holder.id + "_"
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
					$(options).each(
							function(b) {
								var option = options[b];
								var name = option.name;
								var $radioDiv = $("<div class='pingfendanxuanti' id='user_Tab_hover'></div>");
								// 添加选项
								var $radio = $("<input type='radio' name='"
										+ id + "' value='" + name + "'/>");
								// 添加默认值
								if (option.isAnswer) {
									$radio.attr("checked", "checked");
								}

								$radio
										.change(function() {
											var $radios = $("input[name='" + id
													+ "']");
											$radios.each(function(a) {
												var o = options[a];
												o.selected = this.checked;
											})
										});

								$radioDiv.append($radio);

								$radioDiv.append(option.name);

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
										var $radioDiv = $("<div class='pingfendanxuanti' id='user_Tab_hover'></div>");
										// 添加选项
										var $checkbox = $("<input type='checkbox' name='"
												+ id
												+ "' value='"
												+ name
												+ "'/>");

										$checkbox.change(function() {
											var $checks = $("input[name='" + id
													+ "']");
											$checks.each(function(a) {
												var o = options[a];
												o.selected = this.checked;
											})
										});

										$radioDiv.append($checkbox);

										$radioDiv.append(option.name);

										$div.append($radioDiv);
									});
				}
				break;
			}

			case "codematrix": {
				var $table = $("<table width='100%'><tr><td/></tr></table>");
				var labels = holder.leftLabel.split("\n");
				var options = holder.options;
				for (var j = 0; j < options.length; j++) {
					var option = options[j];
					var $trLast = $table.find("tr:last");
					$trLast.append("<td>" + option.name + "</td>");
				}
				for (var i = 0; i < labels.length; i++) {
					var $trLast = $table.find("tr:last");
					$trLast.after("<tr  id='user_Tab_hover'><td></tr>");

					$table.find("tr:last td:eq(0)").html(labels[i]);

					for (var k = 0; k < options.length; k++) {
						var option = options[k];
						var $last = $table.find("tr:last");
						$last.append("<td><input type='radio' name='"
								+ holder.id + "_" + labels[i] + "' value='"
								+ option.name + "'/></td>");
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
					$(options).each(
							function(b) {
								var option = options[b];
								var name = option.name;
								var $radioDiv = $("<div class='pingfendanxuanti' id='user_Tab_hover'></div>");
								// 添加选项
								var $radio = $("<input  type='radio' name='"
										+ id + "' value='" + name + "'/>");
								$radio
										.change(function() {
											var $radios = $("input[name='" + id
													+ "']");
											$radios.each(function(a) {
												var o = options[a];
												o.selected = this.checked;
											})
										});

								$radioDiv.append($radio);

								$radioDiv.append(option.name);

								$div.append($radioDiv);
							});
				}
				break;
			}
			case "testcheck": {
				var options = holder.options;
				if (options != null) {
					$(options).each(
							function(b) {
								var option = options[b];
								var name = option.name;
								var $radioDiv = $("<div class='pingfendanxuanti' id='user_Tab_hover'></div>");
								// 添加选项
								var $radio = $("<input type='checkbox' name='"
										+ id + "' value='" + name + "'/>");

								$radio
										.change(function() {
											var $checks = $("input[name='" + id
													+ "']");
											$checks.each(function(a) {
												var o = options[a];
												o.selected = this.checked;
											})
										});

								$radioDiv.append($radio);

								$radioDiv.append(option.name);

								$div.append($radioDiv);
							});
				}
				break;
			}
			case "testinput": {
				var $inputDiv = $("<div class='pingfendanxuanti' id='user_Tab_hover'></div>");
				var $input = $("<textarea name='" + id + "'/>");
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

				$input.change(function() {
					holder.value = $(this).val();
				});

				$div.append($inputDiv);
				break;
			}
			case "voteradio": {
				var showVotePercent = false;
				var $table = $("<table width='100%'></table>");
				var options = holder.options;
				for (var j = 0; j < options.length; j++) {
					
					var option = options[j];

					var name = option.name;
					
					var $radioDiv = $("<div class='pingfendanxuanti'></div>");

					// 添加选项
					var $radio = $("<input type='radio' name='" + id
							+ "' value='" + name + "'/>");
					
					$radioDiv.append($radio);
					$radioDiv.append(option.name);
					
					var $text = null;
					var $span = null;
					// 是否填空
					if (option.isText) {
						var $text = $("<input type='text' name='"+id+"' id='" + option.name + "'/>");
						$radioDiv.append($text);

						if (option.isWill) {
							var $span = $("<span style='color:red;' name='"+id+"' id='"+option.name+"_span"+"'>*</span>");
							$radioDiv.append($span);
						}
						
						if (option.selected) {
							$text.show();
							if (option.isWill) {
								$span.show();
							}
						}else{
							$text.hide();
							if (option.isWill) {
								$span.hide();
							}
						}

					}
					
					// 添加默认值
					if (option.selected) {
						$radio.attr("checked", "checked");
					}

					$radio.change(function() {
						var $radios = $("input[name='" + id + "'][type='radio']");
						$radios.each(function(a) {
							var o = options[a];
							o.selected = this.checked;
							
							if(this.checked){
								
								$("input[name='"+id+"'][id='"+o.name+"']").show();
								$("span[name='"+id+"'][id='"+o.name+"_span"+"']").show();
								
							}else{
								$("input[name='"+id+"'][id='"+o.name+"']").hide();
								$("span[name='"+id+"'][id='"+o.name+"_span"+"']").hide();
							}
						})
					});


					var $tr = $("<tr id='user_Tab_hover' name='" + holder.id + "'></tr>");
					var $td = $("<td style='text-align:left'></td>");

					var $td2 = $("<td style='text-align:left' name='"
							+ option.name + "'>0票(0.00%)</td>");
					if(!showVotePercent){
						$td2.css("display","none");
					}
					$td.append($radioDiv);

					$tr.append($td);
					$tr.append($td2);

					$table.append($tr);
				}

				$table.css("text-align", "center").find("tr:first").find("td")
						.attr("width", "50%");

				$div.append($table);
				QM.answer.voteNumer(holder);
				break;
			}
			case "votecheck": {
				var showVotePercent = false;
				var $table = $("<table width='100%'></table>");
				var options = holder.options;
				for (var j = 0; j < options.length; j++) {
					var option = options[j];

					var name = option.name;
					var $checkDiv = $("<div class='pingfendanxuanti'></div>");
					// 添加选项
					var $check = $("<input type='checkbox' name='" + id
							+ "' value='" + name + "'/>");
					
					$checkDiv.append($check);
					$checkDiv.append(option.name);
					
					var $text = null;
					var $span = null;
					// 是否填空
					if (option.isText) {
						var $text = $("<input type='text' name='"+id+"' id='" + option.name + "'/>");
						$checkDiv.append($text);

						if (option.isWill) {
							var $span = $("<span style='color:red;' name='"+id+"' id='"+option.name+"_span"+"'>*</span>");
							$checkDiv.append($span);
						}
						
						if (option.selected) {
							$text.show();
							if (option.isWill) {
								$span.show();
							}
						}else{
							$text.hide();
							if (option.isWill) {
								$span.hide();
							}
						}

					}
					
					// 添加默认值
					if (option.selected) {
						$check.attr("checked", "checked");
					}

					$check.change(function() {
						var $checks = $("input[name='" + id + "'][type='checkbox']");
						$checks.each(function(a) {
							var o = options[a];
							o.selected = this.checked;
							
							if(this.checked){
								
								$("input[name='"+id+"'][id='"+o.name+"']").show();
								$("span[name='"+id+"'][id='"+o.name+"_span"+"']").show();
								
							}else{
								$("input[name='"+id+"'][id='"+o.name+"']").hide();
								$("span[name='"+id+"'][id='"+o.name+"_span"+"']").hide();
							}
						})
					});

					var $tr = $("<tr id='user_Tab_hover' name='" + holder.id + "'></tr>");
					var $td = $("<td style='text-align:left'></td>");

					var $td2 = $("<td style='text-align:left' name='"
							+ option.name + "'>0票(0.00%)</td>");
					if(!showVotePercent){
						$td2.css("display","none");
					}
					$td.append($checkDiv);

					$tr.append($td);
					$tr.append($td2);

					$table.append($tr);
				}

				$table.css("text-align", "center").find("tr:first").find("td")
						.attr("width", "50%");

				$div.append($table);
				QM.answer.voteNumer(holder);

				break;
			}
		}
			if (holder.isTips) {
				if(type=="head"){
				    var $tipDiv = $("<div class='tips_div'  class='pingfendanxuanti' style='display: inline-block;margin-left: 18px;color: red;'></div>");
				}else{
					var $tipDiv = $("<div class='tips_div'  class='pingfendanxuanti' style='margin-left: 18px;color: red;'></div>");
				}
				
				$tipDiv.html("填写提示 : " + holder.tips);
				$div.append($tipDiv);
			}
			return $div;
		},

		voteNumer : function(holder) {
			var $questionnaire_id = $("#questionnaire_id");
			var id = $questionnaire_id.val();
			$
					.ajax({
						type : 'POST',
						url : "../questionnaire/voteNumber.action",
						data : {
							'id' : id,
							'holder_id' : holder.id
						},
						dataType : "html",
						success : function(data) {
							if (data) {
								var charts = $.parseJSON(data);
								var t = {};
								for (var i = 0; i < charts.length; i++) {
									var object = charts[i];
									t[object.name] = t[object.name] || {
										name : object.name,
										count : 0
									};
									t[object.name].count++;
								}
								Object
										.keys(t)
										.map(
												function(key) {
													var name = t[key].name;
													var count = t[key].count;

													var id = "#" + holder.id
															+ "_" + name
															+ "_td";
													var $tr = $("tr[name='"
															+ holder.id + "']");
													var $td = $tr
															.children("td[name='"
																	+ name
																	+ "']");
													var sum = charts.length;
													var percent = (Math
															.round(count / sum
																	* 10000) / 100.00 + "%");

													$td.html(count + "票("
															+ percent + ")");
													
												});
							}
						},
						error : function(data, status) {
							alert("网络连接失败...");
						}
					});
		},

		_createAnswer : function() {
			var answers = new Array();
			if (holders != null) {
				for (var g = 0; g < holders.length; g++) {
					var answer = new Object();
					var holder = holders[g];
					answer.id = holder.id;
					var type = holder.type;
					answer.type = type;

					// 判断类型是否为答卷
					if (type.indexOf("test") >= 0) {
						answer.code = holder.code;
					}
					switch (holder.type) {
					case "voteradio":
					case "radio": 
					case "votecheck":
					case "check":{
						var answerOpts = new Array();
						var options = holder.options;
						if (options != null) {
							for (var b = 0; b < options.length; b++) {
								var answerOpt = new Object();
								var option = options[b];
								if (option.selected) {
									answerOpt.name = option.name;
									answerOpt.explains = option.explains;
									answerOpt.index = b;
									if(option.isText){
										var text = $("input[name='"+holder.id+"'][id='"+option.name+"']").val();
										answerOpt.explains = text;
									}
									if(option.pic && option.pic != ""){
										var url = $("a[data-id='"+holder.id+"-"+option.name+"']").find("img").attr("src");
										answerOpt.pic = url.substr(contextPath.length);
									}
									answerOpts.add(answerOpt);
								}
							}
						}
						answer.options = answerOpts;
						break;
					}
					case "codecheck":
					case "coderadio":{
						var answerOpts = new Array();
						var options = holder.options;
						var code = 0;
						if (options != null) {
							for (var b = 0; b < options.length; b++) {
								var answerOpt = new Object();
								var option = options[b];
								if (option.selected) {
									if(!option.isNull && (option.code != 0 || option.code != null)){
										code += option.code;
									}
									answerOpt.name = option.name;
									answerOpt.explains = option.explains;
									answerOpt.index = b;
									answerOpt.isNull = option.isNull;
									answerOpts.add(answerOpt);
								}
							}
						}
						answer.options = answerOpts;
						answer.code = code;
						break;
					}
					case "testinput": {
						answer.standardanswer = holder.standardanswer;
						answer.code = holder.code;
					}
					case "input": {
						if(holder.value == null){
							holder.value = "";
						}
						answer.value = holder.value;
						break;
					}
					case "testradio": {

						var answerOpts = new Array();
						// 记录正确答案;
						var right = "";
						var options = holder.options;
						if (options != null) {
							for (var b = 0; b < options.length; b++) {
								var answerOpt = new Object();
								var option = options[b];
								if (option.isAnswer) {
									right = option.name;
								}
								if (option.selected) {
									answerOpt.name = option.name;
									answerOpt.explains = option.explains;
									answerOpt.index = b;
									answerOpt.isAnswer = option.isAnswer;
									answerOpts.add(answerOpt);
								}
							}
						}
						answer.code = holder.code;
						answer.right = right;
						answer.options = answerOpts;
						break;
					}

					case "testcheck": {

						var answerOpts = new Array();
						// 记录正确答案;
						var right = "";
						var options = holder.options;
						if (options != null) {
							for (var b = 0; b < options.length; b++) {
								var answerOpt = new Object();
								var option = options[b];
								if (option.isAnswer) {
									if(right != null && right.length<=0){
										right = option.name ;
									}else{
										right += "&&" + option.name ;
									}
								}

								if (option.selected) {
									answerOpt.name = option.name;
									answerOpt.explains = option.explains;
									answerOpt.index = b;
									answerOpt.isAnswer = option.isAnswer;
									answerOpts.add(answerOpt);
								}
							}
						}
						answer.right = right;
						answer.options = answerOpts;
						answer.code = holder.code;
						break;
					}
					case "matrixradio":// 矩阵单选
					case "matrixcheck": // 矩阵多选
					case "codematrix": { // 评分矩阵单选题
						var answerOpts = new Array();
						// 记录正确答案;
						var right = "";
						var code = 0;
						var labels = holder.leftLabel.split("\n");
						var options = holder.options;
						if (options != null) {
							for (var i = 0; i < labels.length; i++) {
								var label = labels[i];
								for (var b = 0; b < options.length; b++) {
									var answerOpt = new Object();
									var option = options[b];
									var $item = $("input[name='"+holder.id+"_"+labels[i]+"'][value='"+option.name+"']");
									if ($item[0].checked) {
										
										if(!option.isNull && (option.code != 0 || option.code != null)){
											code += option.code;
										}
										
										answerOpt.name = label + "_"
												+ option.name;
										answerOpt.explains = option.explains;
										answerOpt.index =  answerOpt.name;
										answerOpt.value = option.name;
										answerOpt.isAnswer = option.isAnswer;
										answerOpts.add(answerOpt);
									}
								}
							}
						}
						answer.code = code;
						answer.right = right;
						answer.options = answerOpts;
						break;
					}
					case "matrixinput": {
						var labels = holder.leftLabel.split("\n");
						var answerOpts = new Array();
						for (var i = 0; i < labels.length; i++) {
							var answerOpt = new Object();
							var $item = $("textarea[name='"+ holder.id + "_" + labels[i]+"']");
							answerOpt.name = labels[i];
							answerOpt.value = $item.val();
							answerOpts.add(answerOpt);
						}
						answer.options = answerOpts;
						break;
					}
					}
					answers.add(answer);
				}

			}
			return answers;
		},

		checkRequired : function() {
			// 判断是否符合必填题填写 true为有没填的 false为没有没填的
			var requred = false;
			for (var g = 0; g < holders.length; g++) {
				var holder = holders[g];
				// 判断是否有填写 false没有填写 true有填写 默认为true
				var flag = false;
				
				//判断有必填题的时候
				if(holder.isWill){
					var type = holder.type;
					switch (type) {
						case "radio": 
						case "check":
						case "voteradio":
						case "votecheck":
						case "coderadio":
						case "codecheck":
						case "testcheck":
						case "testradio":{
							var options = holder.options;
							for (var b = 0; b < options.length; b++) {
								var option = options[b];
								if (option.selected) {
									flag = true;
									if(option.isText && option.isWill){
										var text = $("input[name='"+holder.id+"'][id='"+option.name+"']").val();
										if(text == null || text.length <= 0){
											flag = false;
											break;
										}
									}
								}
							}
							break;
						}
						case "testinput":
						case "input":{
							var value = holder.value;
							if(value != null && value.length >0){
								flag = true;
							}else{
								flag = false;
								break;
							}
							break;
						}
						case "matrixradio":
						case "matrixcheck":
						case "codematrix":{
							var labels = holder.leftLabel.split("\n");
							var options = holder.options;
							if (options != null) {
									for (var i = 0; i < labels.length; i++) {
										var label = labels[i];
										for (var b = 0; b < options.length; b++) {
											var answerOpt = new Object();
											var option = options[b];
											var $item = $("input[name='"+holder.id+"_"+labels[i]+"'][value='"+option.name+"']");
											if ($item[0].checked) {
												flag = true;
												break;
											}
										}
									}
								}
								break;
							}
							case "matrixinput": {
								var labels = holder.leftLabel.split("\n");
								var answerOpts = new Array();
								for (var i = 0; i < labels.length; i++) {
									var $item = $("textarea[name='"+ holder.id + "_" + labels[i]+"']");
									var value = $item.val();
									if(value != null && value.length>0){
										flag = true;
										break;
									}
								}
								break;
							}
						}
				}else{
					flag = true;
					//判断不是必填题且选项题中要说明必填时校验
					var type = holder.type;
					switch (type) {
						case "radio": 
						case "check":
						case "voteradio":
						case "votecheck":
						case "coderadio":
						case "codecheck":
						case "testcheck":
						case "textradio":{
							var options = holder.options;
							for (var b = 0; b < options.length; b++) {
								var option = options[b];
								if (option.selected) {
									if(option.isText && option.isWill){
										var text = $("input[name='"+holder.id+"'][id='"+option.name+"']").val();
										if(text == null || text.length <= 0){
											flag = false;
											break;
										}else{
											flag = true;
											break;
										}
									}
								}
							}
							break;
						}
					}
				}
				if (!flag) {
					requred = false;
					break;
				}else{
					requred = true;
				}
				
			}
			return requred;
		},

		/**
		 * 返回json试题
		 */
		encodeJson : function() {
			var answers = QM.answer._createAnswer();
			var js = JSON.stringify(answers);
			// $("#maiDiv").html('');
			// $("#maiDiv").append("重载后数据")
			//			QM.answer.init(holderJson,js);
			return js;
		}
	}
}
