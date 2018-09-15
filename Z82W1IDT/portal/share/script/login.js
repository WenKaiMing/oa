//企业域验证
function showDomainTips(obj,tips) {
	var tipsArea = document.getElementById("tipsdiv_Domain");
	var tipscontain =document.getElementById("easyDomaintip-text");
	tipsArea.style.display="block";
	tipscontain.innerHTML = tips;
	var style = "font-size:12px; color:blue;";
}
function disableDomainTips(obj) {
	var tipsArea = document.getElementById("tipsdiv_Domain");
	var tipscontain =document.getElementById("easyDomaintip-text");
	tipsArea.style.display="none";
	tipscontain.innerHTML = "&nbsp;";
}
//验证码验证
function showCodeTips(obj,tips) {
	var tipsArea = document.getElementById("tipsdiv_code");
	var tipscontain =document.getElementById("easyCodetip-text");
	tipsArea.style.display="block";
	tipscontain.innerHTML = tips;
	var style = "font-size:12px; color:blue;";
}
function disableCodeTips(obj) {
	var tipsArea = document.getElementById("tipsdiv_code");
	var tipscontain =document.getElementById("easyCodetip-text");
	tipsArea.style.display="none";
	tipscontain.innerHTML = "&nbsp;";
}

function changeLanguage(){
	var obj = document.getElementById("debug");
	var showCode = document.getElementsByName("_showCode")[0].value;
	var url = contextPath+'/core/multilanguage/change.action';
	if (obj != null && obj.value != null)
		url = url + "?debug="+obj.value;
	
	if(showCode){
		if(url.indexOf("?")>0){
			url = url + "&showCode=" + showCode;
		}else{
			url = url + "?showCode=" + showCode;
		}
	}
	document.forms[0].action = url;
	document.forms[0].submit();
}


var timeout = "";//企业域下拉列表中使用
function showDomain(){		
	document.getElementById('domain').style.display="block";
	var domainHeight = document.getElementById("domain").offsetHeight;		
	if(domainHeight>350){
		document.getElementById("domain").style.height=350+"px";
	}
}
function hideDomain(){	
	timeout = window.setTimeout("document.getElementById('domain').style.display='none'",300);	
}
function hiddendoMainOver(){	
	window.clearTimeout(timeout);
}
function selectDomain(obj){
	var option = document.getElementsByName('domainName');	
	var domain=obj.innerHTML;	
	option[0].value=domain;
	document.getElementById('domain').style.display='none';
}


function focusOn(obj) {
	obj.select();
	obj.focus();
}
window.onload=function(){ 
    //要初始化的东西  
	//changeWidth();
} 

window.onresize = function() {
	//reSize();
	changeWidth();
	
};

function reSize(){
	var obj = document.getElementById("loginform");
	var contentObj = document.getElementById("content");
	var browserHeight = document.documentElement.offsetHeight;
	var browserWidth = document.documentElement.offsetWidth;
	if(browserWidth<650){
		document.getElementById("bodyid").style.overflow="auto";
	}else{
		document.getElementById("bodyid").style.overflow="hidden";
	}
	if(browserHeight<450){
		document.getElementById("bodyid").style.overflow="auto";
	}
	if (obj) {
		obj.style.height = browserHeight - 30 + "px";
		obj.style.width = browserWidth -3+ "px";
	}
}
//点击之后，显示“登录中...”
function login_ing(obj,type){
	var b = new Base64();
	var pw = document.getElementsByName("_pd")[0];
	var str = b.encode(pw.value);
	if(str.length>2){
		var lp = str.substr(0,2);
		var rp = str.substr(2,str.length);
		pw.value = rp+lp;
	}
	var un = document.getElementsByName("_ac")[0];
	var str2 = b.encode(un.value);
	if(str2.length>2){
		var lp = str2.substr(0,2);
		var rp = str2.substr(2,str2.length);
		un.value = rp+lp;
	}
	var btn = document.getElementById("tijiao");
	btn.value = btn.value + "ing...";
	btn.onclick = null;
}

//点击之后，显示“登录中...”
function login_ing(obj,event){
	
	if(document.getElementsByName("browserType")[0] != null && document.getElementsByName("browserType")[0].value == "phone"){
		var name =  document.getElementsByName("_ac")[0].value;
		if(name == null || name == undefined || name == ""){
			 alert("账号名不能为空");
			 var event = event || window.event;
			 event.preventDefault(); // 兼容标准浏览器
			 window.event.returnValue = false; // 兼容IE6~8
			 return false;
		}
	}
	
	var b = new Base64();
	var pw = document.getElementsByName("_pd")[0];
	var str = b.encode(pw.value);
	if(str.length>2){
		var lp = str.substr(0,2);
		var rp = str.substr(2,str.length);
		pw.value = rp+lp;
	}
	var un = document.getElementsByName("_ac")[0];
	var str2 = b.encode(un.value);
	if(str2.length>2){
		var lp = str2.substr(0,2);
		var rp = str2.substr(2,str2.length);
		un.value = rp+lp;
	}
	var btn = document.getElementById("tijiao");
	btn.value = btn.value + "ing...";
	btn.onclick = null;
}
//登陆内容的宽度不时改变
function changeWidth(){
	var loginWidth=0;
	var num = document.getElementById("loginInfo").getElementsByTagName("li").length;
	var li = document.getElementById("loginInfo").getElementsByTagName("li");
	for(var i=0;i<num;i++){
		loginWidth += parseInt(li[i].offsetWidth);
	}
	document.getElementById("login-box").style.width=loginWidth+30+"px";
	document.getElementById("login-box").style.marginTop = 0+"px";
}


function Base64() {
	 
	// private property
	_keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
 
	// public method for encoding
	this.encode = function (input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;
		input = _utf8_encode(input);
		while (i < input.length) {
			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);
			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;
			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}
			output = output +
			_keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
			_keyStr.charAt(enc3) + _keyStr.charAt(enc4);
		}
		return output;
	}
 
	// public method for decoding
	this.decode = function (input) {
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;
		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
		while (i < input.length) {
			enc1 = _keyStr.indexOf(input.charAt(i++));
			enc2 = _keyStr.indexOf(input.charAt(i++));
			enc3 = _keyStr.indexOf(input.charAt(i++));
			enc4 = _keyStr.indexOf(input.charAt(i++));
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
			output = output + String.fromCharCode(chr1);
			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}
		}
		output = _utf8_decode(output);
		return output;
	}
 
	// private method for UTF-8 encoding
	_utf8_encode = function (string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
		for (var n = 0; n < string.length; n++) {
			var c = string.charCodeAt(n);
			if (c < 128) {
				utftext += String.fromCharCode(c);
			} else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			} else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
		return utftext;
	}
 
	// private method for UTF-8 decoding
	_utf8_decode = function (utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
		while ( i < utftext.length ) {
			c = utftext.charCodeAt(i);
			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			} else if((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			} else {
				c2 = utftext.charCodeAt(i+1);
				c3 = utftext.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
		}
		return string;
	}
}
 
