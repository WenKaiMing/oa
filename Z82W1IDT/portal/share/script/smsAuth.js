function showTips(obj,tips) {
	var tipsArea = document.getElementById("tipsArea");
	//obj.style.border = "1px; solid #016BC9";
	var style = "font-size:12px; color:blue;";
	tipsArea.innerHTML = "&nbsp;";
	tipsArea.innerHTML = "<div style='" + style + "'>" + tips + "</div>"; 
}

function disableTips(obj) {
	//obj.style.border = "1px solid #999999";
	var tipsArea = document.getElementById("tipsArea");
	tipsArea.innerHTML = "&nbsp;";
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

window.onresize = function() {
	//reSize();
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