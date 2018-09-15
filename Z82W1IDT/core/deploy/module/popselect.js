function PopSelect(objName) {
	this.Obj = objName;	
	this.dateInput = null
	this.bodyStr = '';
};	

PopSelect.prototype.getStyle = function() {
	var str = '<style type="text/css">\n';
	str += '.popselect{position:absolute;width:80px!important;width /**/:142px;height:95px!important;height /**/:95px;background-color:black;left:0px;top:0px;z-index:9999;}\n';
	//str += '.sel{width:200px;heigth:200;}';
	str += 'html>body #PopSelect{width:142px;174px;}';
	str += '</style>\n';
	return str;
};

PopSelect.prototype.toString = function() {   
	var str ="";
	str += this.getStyle();
	str += '<div Author="alin" class="popselect" style="display:none;" onselectstart="return false" oncontextmenu="return false" id="PopSelect">\n';
	str += this.getBody();
	str += '</div>';
	return str;
};
	
PopSelect.prototype.setBody = function(str) {
	this.bodyStr = str;
}

PopSelect.prototype.getBody = function() {
	var str = "";
	if (this.bodyStr != '') {
		return bodyStr;
	}
	
	str += '<select id='+ this.Obj +' size="6">';
	var hour = 23;
	for(var i = 0; i <= hour; i++) {
		var minute = 2;
		for(var n = 0; n < minute; n++) {
			var h = i >= 10 ? i : '0' + i; // hour str
			var m = n * 30 > 0 ? n * 30 : '00'; // minute str
			str += '<option value="'+ h + ":" + m +'">';
			str += h + ":" + m;
			str += '</option>';
		}
	}
	str += '</select>';
	return str;
};
	
//show select
PopSelect.prototype.show = function() {
	if (arguments.length >  3  || arguments.length == 0) {
		alert("??????????????????????" );
		return;
	}   
		
	var _sel = null;
	var _evObj = null;
	var _initValue = null  
		
	for(i = 0; i < arguments.length; i++) {
		if(typeof(arguments[i]) == "object" && arguments[i].type == "text"){
			_sel = arguments[i];
		} else if(typeof(arguments[i]) == "object") {
			_evObj = arguments[i];
		} else if(typeof(arguments[i]) == "string") {
			_initValue = arguments[i];
		}  
	}
	
	_evObj = _evObj || _sel;
	inputObj = _sel;
	targetObj = _evObj
		
	if(!_sel){alert("????????????!"); return;}
		
	this.dateInput = _sel;
	   
	_sel = _sel.value;
	   
	if(_sel == "" && _initValue) _sel = _initValue;   
	   
	this.bindSel();       
	getObjById(this.Obj).style.width = getWidth(_evObj);
	var _target = getPosition(_evObj);   
	var _obj = getObjById("PopSelect");
	_obj.style.width = getWidth(_evObj);
	_obj.style.left = _target.x + 'px';
	if((document.body.clientHeight - (_target.y + _evObj.clientHeight)) >= _obj.clientHeight) {        
		_obj.style.top = (_target.y + _evObj.clientHeight) + 'px';
	} else {	  
		_obj.style.top = (_target.y - _obj.clientHeight) + 'px';
	} 
	
	_obj.style.display = ""; 
};

//hide select
PopSelect.prototype.hide = function() {
	var obj = getObjById("PopSelect");
	obj.style.display = "none";   
};

PopSelect.prototype.bindSel = function() {
	_sel = getObjById(this.Obj);
	_sel.onclick = Function(this.Obj + ".onClick(this)");
};

PopSelect.prototype.onClick = function(obj) {  
  //alert(obj.innerHTML);
  if(obj.innerHTML != "")  this.dateInput.value = obj.options[_sel.selectedIndex].value;
  this.hide();
};

/******************************************??????????????********************************************************/
var inputObj = null; //????????
var targetObj = null;	//????????????
var dragObj = null; //????????????
var mouseOffset = null; //??????????????

//????????
function getObjById(obj)
{
   if(document.getElementById)
   {
     return document.getElementById(obj);
   }
   else
   {
     alert("????????????!");
   }
}

//????????????
function mouseCoords(ev)
{
	if(ev.pageX || ev.pageY){
		return {x:ev.pageX, y:ev.pageY};
	}
	return {
		x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
		y:ev.clientY + document.body.scrollTop  - document.body.clientTop
	};
}

//??????????????????
function getPosition(e)
{
	var left = 0;
	var top  = 0;
	while (e.offsetParent){
		left += e.offsetLeft /*+ (e.currentStyle?(parseInt(e.currentStyle.borderLeftWidth)).NaN0():0)*/;
		top  += e.offsetTop /*+ (e.currentStyle?(parseInt(e.currentStyle.borderTopWidth)).NaN0():0)*/;
		e = e.offsetParent;
	}

	left += e.offsetLeft /*+ (e.currentStyle?(parseInt(e.currentStyle.borderLeftWidth)).NaN0():0)*/;
	top  += e.offsetTop /*+ (e.currentStyle?(parseInt(e.currentStyle.borderTopWidth)).NaN0():0)*/;

	return {x:left, y:top};
}

//??????????????(????size??cols??????width px)
function getWidth(e) {
	var rtn = 0;
	if (e.type == 'text') {
		rtn = 100 + (e.size / 10 - 1) * 70;
	} else if(e.type == 'textarea') {
		rtn = 100 + (e.cols / 10 - 1) * 70;
	}

	return rtn;
}

//????????????????
function getMouseOffset(target, ev)
{
	ev = ev || window.event;
	var docPos    = getPosition(target);
	var mousePos  = mouseCoords(ev);
	return {x:mousePos.x - docPos.x, y:mousePos.y - docPos.y};
}

//??????????
function closeSelect(evt){
	evt = evt || window.event; 
	var _target= evt.target || evt.srcElement; 
	
	if(!_target.getAttribute("Author") &&  _target != inputObj && _target != targetObj)
	 {
	   getObjById("PopSelect").style.display = "none"; 	  
	 }  
}


/**********************************End ????????**********************************************/


document.onclick = Function("closeCalendar(); closeSelect();");


/*****************************************************????************************************************************/
