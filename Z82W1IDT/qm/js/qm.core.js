var holders;
var answers;

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

/**
 * 删除图片文件
 */
function deleteAttachment(imgUrl,callback){
	$.ajax({
		url: contextPath + "/qm/questionnaireservice/deleteAttachment.action?url="+imgUrl,
		success: function(result){
			if(1==result.status){
				if(callback && typeof callback == "function"){
					callback(result.data);
				}
			}
		}
	})
};

/**
 * 获取填空题数据
 * @params {}
 */
function getInputValue(params,callback){
	$.ajax({
		url : contextPath + "/qm/answerservice/inputreportform.action",
		async: false,
		cache:false,
		data:params,
		success : function(result) {
			if(1==result.status){
				if(callback && typeof callback == "function"){
					callback(result.data);
				}
			}
		}
	});
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