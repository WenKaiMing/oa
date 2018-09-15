QM.Util = {
	cache : {
		
	},
	/**
	 * 获取用户头像图片url地址
	 * @param userId
	 */	
	getAvatar : function(userId){
		if(!this.cache[userId]){
			$.ajax({
				type: "GET",
				url: contextPath + "/contacts/getAvatar.action",
				data: {"id":userId},
				async: false,
				dataType: "json",
				success:function(result){
					if(1==result.status){
						QM.Util.cache[userId] = result.data;
					}
				}
			});
		}
		
		return this.cache[userId];;
	},
	/**
	 * 计算时间差
	 * @param date,date2
	 */
	daysCalc : function(date,date2){
		var startDateArr = date.split(/[- :]/); 
		var startDate = new Date(startDateArr[0], startDateArr[1]-1, startDateArr[2], startDateArr[3], startDateArr[4]);
		if(!date2 || date2 == ""){
			var nowDate = new Date();
		}else{
			var nowDate = new Date(date2);
		}
		var msDate = nowDate.getTime() - startDate.getTime();
		//计算出相差天数
		var days=Math.floor(msDate/(24*3600*1000));
		//计算出小时数
		var leave1 = msDate%(24*3600*1000);//计算天数后剩余的毫秒数
		var hours = Math.floor(leave1/(3600*1000));
		//计算相差分钟数
		var leave2 = leave1%(3600*1000);//计算小时数后剩余的毫秒数
		var minutes = Math.floor(leave2/(60*1000));
		//计算相差秒数
		var leave3=leave2%(60*1000);//计算分钟数后剩余的毫秒数
		var seconds=Math.round(leave3/1000);
		//alert(" 相差 "+days+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒");	
		var timeCalc = {
			    "days": days,
			    "hours": hours,
			    "minutes": minutes,
			    "seconds": seconds
			};
		return timeCalc;
	},
	/**
	 * 格式化模板
	 * @param str, model
	 */
	format : function(str, model) {//格式化指定键值的模板
		for (var k in model) {
			var re = new RegExp("{" + k + "}", "g");
			str = str.replace(re, model[k]);
		}
		return str;
	},
	/**
	 * 控制loading层
	 */
	controlLoading : function(active) {
		if(active == "show"){
			$("#loadingToast").show();
		}else{
			$("#loadingToast").hide();
		}
	},
	_createAnswer : function() {
		var answers = new Array();
		if (QM.cache.writeConJson != null) {
			for (var g = 0; g < QM.cache.writeConJson.length; g++) {
				var answer = new Object();
				var holder = QM.cache.writeConJson[g];
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
	/**
	 * 验证题目必填项
	 */
	checkRequired : function() {
		// 判断是否符合必填题填写 true为有没填的 false为没有没填的
		var requred = false;
		for (var g = 0; g < QM.cache.writeConJson.length; g++) {
			var holder = QM.cache.writeConJson[g];
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
								if(option.isText){
									var text = $("input[name='"+holder.id+"'][id='"+option.name+"']:visible").val();
									if(option.isWill && (text == null || text.length <= 0)){
										flag = false;
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
										var $item = $("input[name='"+holder.id+"_"+labels[i]+"'][value='"+option.name+"']:visible");
										if ($item.prop("checked")) {
											flag = true;
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
									}else{
										flag = true;
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
		var answers = QM.Util._createAnswer();
		var js = JSON.stringify(answers);
		return js;
	}
}

/**
 * 上移
 * @param $ele
 */
function moveUpElement($ele){
    if ($ele.index() != 0) {
    	$ele.prev().before($ele);
    }
}

/**
 * 下移
 */
function moveDownElement($ele){
	var length = $ele.parent().children().length;
	if($ele.index() != length-1){
		$ele.next().after($ele);
	}
}

	

Array.prototype.indexOf = function(c) {
	for (var b = 0, a = this.length; b < a; b++) {
		if (this[b] == c) {
			return b;
		}
	}
	return -1;
};
Array.prototype.moveUp = function(b) {
	var a = this.indexOf(b);
	return this._moveElement(a, -1);
};
Array.prototype.moveFirst = function(b) {
	var a = this.indexOf(b);
	while (this._moveElement(a--, -1)) {
	}
};
Array.prototype.moveFirstIndex = function(b) {
	while (this._moveElement(b--, -1)) {
	}
};
Array.prototype.moveFirst = function(b) {
	var a = this.indexOf(b);
	while (this._moveElement(a--, -1)) {
	}
};
Array.prototype.moveDown = function(b) {
	var a = this.indexOf(b);
	return this._moveElement(a, 1);
};
Array.prototype.moveLast = function(b) {
	var a = this.indexOf(b);
	while (this._moveElement(a++, 1)) {
	}
};
Array.prototype.moveLastIndex = function(a) {
	while (this._moveElement(a++, 1)) {
	}
};
Array.prototype.moveTo = function(d, e) {
	var a = this.indexOf(d);
	var c = Math.abs(e - a);
	if (a < e) {
		for (var b = 0; b < c; b++) {
			this._moveElement(a++, 1);
		}
	} else {
		for (var b = 0; b < c; b++) {
			this._moveElement(a--, -1);
		}
	}
};

Array.prototype.move = function(a, d) {
	var c, b;
	if (a < 0 || a >= this.length) {
		return false;
	}
	c = a + d;
	if (c < 0 || c >= this.length || c == a) {
		return false;
	}
	b = this[c];
	this[c] = this[a];
	this[a] = b;
	return true;
};

Array.prototype._moveElement = function(a, d) {
	var c, b;
	if (a < 0 || a >= this.length) {
		return false;
	}
	c = a + d;
	if (c < 0 || c >= this.length || c == a) {
		return false;
	}
	b = this[c];
	this[c] = this[a];
	this[a] = b;
	return true;
};
Array.prototype.add = function(item) {  
    this.push(item);  
} 
Array.prototype.insertAt = function(b, a) {
	this.splice(a, 0, b);
};
Array.prototype.insertBefore = function(b, a) {
	this.insertAt(b, this.indexOf(a));
};
Array.prototype.remove = function(a) {
	this.removeAt(this.indexOf(a));
	return a;
};
Array.prototype.removeAt = function(a) {
	var b = this[a];
	if (b) {
		this.splice(a, 1);
	}
	return b;
};

$(function () {
	if (/Android/gi.test(navigator.userAgent)) {
	    window.addEventListener('resize', function () {
	        if (document.activeElement.tagName == 'INPUT' || document.activeElement.tagName == 'TEXTAREA') {
	            window.setTimeout(function () {
	                document.activeElement.scrollIntoViewIfNeeded();
	            }, 0);
	        }
	    })
	}
});
