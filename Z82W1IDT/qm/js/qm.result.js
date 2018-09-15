var holders;
var answers;
var QM = {
	open:false,
	question:0,
	correct:0,
	result:{
		init : function(holderjson,answerjson){
			
			holders = $.parseJSON(holderjson);
			var $maindiv = $("#maiDiv");
			$(holders).each(function(a){
				var holder = holders[a];
				var $topic = QM.result._createDiv(holder);
				$maindiv.append($topic);
			});
			
			answers = $.parseJSON(answerjson);
			if(answers){
				for(var i=0;i<answers.length;i++){
					var answer = answers[i];
					var $div = $maindiv.children("#"+answer.id);
					
					var index = $div.index();
					var holder = holders[index];
					
					
					switch(answer.type){
						case "coderadio":
						case "voteradio":
						case "radio":
							{   
							    //todo
							    if(answer.type=="coderadio"){
							    	QM.open=true;
							    	QM.question+=1;
						    	    QM.correct+=1;
							    }
								var $answerDiv = $("<div id='Scoring_results'></div>");
								$answerDiv.append("选择的答案是：")
								if(answer.options){
									
									for(var b=0;b<answer.options.length;b++){
										var option = answer.options[b];
										
										if(option.pic && option.pic!=""){
											var $pic = $('<a href="'+contextPath+option.pic+'" target="_blank">'
													+'<img class="filePic" src="'+contextPath+option.pic+'" style="width: 50px;"></a>');
											$answerDiv.append($pic);
										}
										
										$answerDiv.append(option.name);
										
										
										
										if(option.explains){
											$answerDiv.append("("+option.explains+")");
										}
										
									}
								}
								$div.append($answerDiv);
								break;
							}
						case "votecheck":
						case "codecheck":
						case "check":
							{
							    //todo
						        if(answer.type=="codecheck"){
						    	    QM.open=true;
						    	    QM.question+=1;
						    	    QM.correct+=1;
						        }
								var $answerDiv = $("<div id='Scoring_results'></div>");
								$answerDiv.append("选择的答案是：")
								if(answer.options){
									
									var result = "";
									
									for(var b=0;b<answer.options.length;b++){
										var option = answer.options[b];
										
										if(result != null && result.length >0){
											result += " | ";
										}
										
										if(option.pic && option.pic!=""){
											var pic = '<a href="'+contextPath+option.pic+'" target="_blank">'
													+'<img class="filePic" src="'+contextPath+option.pic+'" style="width: 50px;"></a>';
											result += pic;
										}
										result += option.name;
										if(option.explains){
											result += "("+option.explains+")";
										}
										if(option.code != null){
											var code = option.code;
											result += "<span color='orange'>("+code+"分)</span>";
										}
									}
									$answerDiv.append(result);
								}
								$div.append($answerDiv);
								break;
							}
						case "input":   //填空题
							{
								var $answerDiv = $("<div id='Scoring_results'></div>");
								$answerDiv.append("填写的答案是：")
								$answerDiv.append(answer.value);
								$div.append($answerDiv);
								break;
							}
						case "matrixradio"://矩阵单选
						case "matrixcheck":    //矩阵多选
						case "codematrix":{    //评分矩阵单选题
							//todo
					        if(answer.type=="codematrix"){
					    	    QM.open=true;
					    	    QM.question+=1;
					    	    QM.correct+=1;
					        }
							var $titleDiv = $("<div style='margin-left: 25px;'></div>");
							$titleDiv.append("选择的答案是：");
							
							var $answerDiv = $("<div id='Scoring_results'></div>");
							
							var labels = holder.leftLabel.split("\n");
							for(var k=0;k<labels.length;k++){
								var label = labels[k];
								$answerDiv.append(label+": &nbsp;&nbsp;");
								if(answer.options){
									var result = "";
									for(var b=0;b<answer.options.length;b++){
										var option = answer.options[b];
										if(option.index.indexOf(label+"_") >=0){
											if(result != null && result.length >0){
												result += " | ";
											}
											result += option.value
										}
									}
									$answerDiv.append(result);
								}
//								$answerDiv.append("<br></br>");
								$answerDiv.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
							}
							$div.append($titleDiv);
							$div.append($answerDiv);
							break;
						}
						case "matrixinput":{
							var $titleDiv = $("<div style='margin-left: 25px;'></div>");
							$titleDiv.append("选择的答案是：");
							
							var $answerDiv = $("<div id='Scoring_results'></div>");
							
							var options = answer.options;
							for(var b=0;b<options.length;b++){
								var option = options[b];
								$answerDiv.append(option.name +" : ");
								$answerDiv.append(option.value);
//								$answerDiv.append("<br></br>");
								$answerDiv.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
							}
							$div.append($titleDiv);
							$div.append($answerDiv);
							break;
						}
						case "testradio":
							{
                                //todo
							    QM.open=true;
							    QM.question+=1;
							
								var $answerDiv = $("<div id='Scoring_results' style='margin-bottom: 0px;'></div>");
								$answerDiv.append("选择的答案是：");
								
								var $rightDiv = $("<div style='margin-bottom: 10px;'></div>");
								$rightDiv.append("<div style='margin-left: 25px;'>答案解析：</div>");
								
								
								var right = false;
								
								if(answer.options){
									
									for(var b=0;b<answer.options.length;b++){
										var option = answer.options[b];
										$answerDiv.append(option.name);
										if(option.isAnswer){
											right = true;
											QM.correct+=1;
											$answerDiv.append("(<span style='color:green'>正确</span>)");
											$div.append($answerDiv);
										}else{
											$answerDiv.append("(<span style='color:red'>错误</span>)");
											$div.append($answerDiv);
										}
									}
								}
								
								//构建答案解析
								for(var j=0;j<holder.options.length;j++){
									var option = holder.options[j];
									//构建选项集合
									var $optionDiv = $("<div id='Scoring_results' style='margin-bottom: 0px;'></div>");
									$optionDiv.append(option.name);
									if(option.isAnswer){
										$optionDiv.append("(<span style='color:green'>正确答案</span>)");
									}
									$rightDiv.append($optionDiv);
								}
								$div.append($rightDiv);
								
								break;
							}
							
					case "testcheck":
						{
						    //todo
					        QM.open=true;
					        QM.question+=1;
					    
							var $answerDiv = $("<div id='Scoring_results' style='margin-bottom: 0px;'></div>");
							$answerDiv.append("选择的答案是：");
							
							var $rightDiv = $("<div style='margin-left: 25px;margin-bottom: 10px;'></div>");
							$rightDiv.append("答案解析：");
							
							var rightNumber = 0;
							var errorNumber = 0;
							if(answer.options){
								
								var result = "";
								
								for(var b=0;b<answer.options.length;b++){
									var option = answer.options[b];
									if(result != null && result.length >0){
										result += " | ";
									}
									result += option.name
									if(option.isAnswer){
										rightNumber ++;
									}else{
										errorNumber ++;
									}
								}
								
								$answerDiv.append(result);
								
								var rights =answer.right.split("&&");
								if(rights.length == rightNumber && errorNumber==0){
									QM.correct+=1;
									$answerDiv.append("(<span style='color:green'>正确</span>)");
									$div.append($answerDiv);
								}else{
									$answerDiv.append("(<span style='color:red'>错误</span>)");
									$div.append($answerDiv);
								}
								
							}
							
							//构建答案解析
							for(var j=0;j<holder.options.length;j++){
								var option = holder.options[j];
								//构建选项集合
								var $optionDiv = $("<div></div>");
								$optionDiv.append(option.name);
								if(option.isAnswer){
									$optionDiv.append("(<span style='color:green'>正确答案</span>)");
								}
								$rightDiv.append($optionDiv);
							}
							$div.append($rightDiv);
							
							break;
						}
						case "testinput":  //考试填空题
						{
							//todo
						    QM.open=true;
						    QM.question+=1;
							
							var $answerDiv = $("<div id='Scoring_results'></div>");
							$answerDiv.append("填写的答案是：")
							$answerDiv.append(answer.value);
							
							var $rightDiv = $("<div style='margin-left: 25px;'></div>");
							$rightDiv.append("正确答案:");
							
							if(answer.value == answer.standardanswer){
								QM.correct+=1;
								$answerDiv.append("(<span style='color:green'>正确</span>)");
								$div.append($answerDiv);
							}else{
								$answerDiv.append("(<span style='color:red'>错误</span>)");
								$rightDiv.append(answer.standardanswer);
								$div.append($answerDiv);
								$div.append($rightDiv);
							}
							
							break;
						}
					}
				}
			}
		},
		
		/**
		 * 初始化试题
		 * @param holder
		 * @returns
		 */
		_createDiv : function(holder){
			var id = holder.id;
			var number = holders.indexOf(holder);
			
			var topic = holder.topic;
			var type = holder.type;
			
			/*//题目
			var title = (number+1) + "、" +topic;*/
			
            var headCount=0;
			for(var a=0; a<number;a++){
				var h=holders[a];
				if(h.type=="head"){
					headCount++;
				}
			}
			// 题目
			if(type!="head"){
				var title = (number + 1 - headCount) + "、" + topic;
			}else{
				var title = topic;
			}
			
			var $div = $("<div id='"+id+"'></div>");
			var $titleDiv = $("<div></div>");
			
			$titleDiv.text(title);
			
			//是否必填
			if(holder.isWill){
				var $will = $("<span>*</span>");
				$will.css("color","red");
				$titleDiv.prepend($will);
			}
			
			//判断是否考试题
			if(type.indexOf("test")>=0){
				var code = holder.code;
				$titleDiv.append("(<span style='color:orange'>分值:"+code+"</span>)");
			}
			
			$div.append($titleDiv);
			return $div;
		}
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