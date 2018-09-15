<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">

function ev_domian(){
	showloading();
	var url = contextPath+"/core/sysconfig/domainSynchronousToGke.action";
	jQuery.post(url,function(){//表单提交方式 
	   }).complete(function(x){//提交成功回调 
		   	jQuery("#loaddiv").css("display","none");
	   		var message = "";
	   		if(x.responseText == "SUCCESS"){
	   			jQuery("#department_btn").css("display","");
	   			message = "{*[Synchronize.successful]*}";
	   		}else if(x.responseText.indexOf("ERROR") >= 0 ){
	   			message = x.responseText.replace("ERROR","{*[Synchronize.fail]*}");
	   		}else{
	   			message = x.responseText;
	   		}
	   		
			alert(message);
			
	   }).error(function(x){//提交失败回调
		   alert(x.statusText);
	   });
	}

function ev_department(){
	showloading();
	var url = contextPath+"/core/sysconfig/departmentSynchronousToGke.action";
	jQuery.post(url,function(){
	   }).complete(function(x){
		   	jQuery("#loaddiv").css("display","none");
		   	var message = "";
	   		if(x.responseText == "SUCCESS"){
	   			jQuery("#user_btn").css("display","");
	   			message = "{*[Synchronize.successful]*}";
	   		}else if(x.responseText.indexOf("ERROR") >= 0 ){
	   			message = x.responseText.replace("ERROR","{*[Synchronize.fail]*}");
	   		}else{
	   			message = x.responseText;
	   		}
	   		
			alert(message);
	   }).error(function(x){
		   alert(x.statusText);
	   });
}

function ev_user(){
	showloading();
	var url = contextPath+"/core/sysconfig/userSynchronousToGke.action";
	jQuery.post(url,function(){
	   }).complete(function(x){
		   	jQuery("#loaddiv").css("display","none");
		   	if(x.responseText == "SUCCESS"){
	   			message = "{*[Synchronize.successful]*}";
	   		}else if(x.responseText.indexOf("ERROR") >= 0 ){
	   			message = x.responseText.replace("ERROR","{*[Synchronize.fail]*}");
	   		}else{
	   			message = x.responseText;
	   		}
	   		
			alert(message);
	   }).error(function(x){
		   alert(x.statusText);
	   });
}

function ev_clean(){
	if (confirm("{*[cn.myapps.core.sysconfig.im.confirm_clear_data]*}?")) {
		showloading();
    	var url = contextPath+"/core/sysconfig/cleanDataToGke.action";
    	jQuery.post(url,function(){
    	   }).complete(function(x){
    		   	jQuery("#loaddiv").css("display","none");
    			alert(x.responseText);
    	   }).error(function(x){
    		   alert(x.statusText);
    	   });
    }
}


function showloading(){    
    var loaddiv;    
   if(loaddiv=document.getElementById("loaddiv")){    
        loaddiv.style.display = "block";    
    }else{    
        loaddiv = document.createElement("DIV");    
        loaddiv.id="loaddiv";    
        loaddiv.style.position = "absolute";    
        loaddiv.style.zIndex = 1000;    
        loaddiv.style.display="";    
        loaddiv.style.left = 0;    
        loaddiv.style.top   = 0;    
        loaddiv.style.border = "1px solid gray";  
        loaddiv.style.background = "#ffffff";
        loaddiv.style.padding = "5";    
    }    
       
    var scrollTop=0;    
   if(top.document.documentElement && top.document.documentElement.scrollTop){    
        scrollTop = top.document.documentElement.scrollTop;    
    }else if(document.body){    
        scrollTop = top.document.body.scrollTop;    
    }    
       
    var scrollWid = document.body.scrollWidth/2-50;    
       
    loaddiv.style.left = scrollWid+"px";    
    loaddiv.style.top   = (scrollTop + 5)+"px" ;    
       
    loaddiv.innerHTML = "<img src='<s:url value="/resource/imgnew/loading.gif"/>'><b><font size='3'>{*[cn.myapps.core.sysconfig.im.synchronous_data]*}...</font></b>";    
  	document.body.appendChild(loaddiv);    
} 

function setHref(s){
	var ip = document.getElementById("ip").value;
	var port = document.getElementById("port").value;
	var url = "http://"+ip+":"+port+"/admin/login";
	window.open(url);
}

function disabledElement(){
	var imConfigopen = document.getElementsByName("imConfig.open");
	if(imConfigopen){
		if(imConfigopen[0].checked){
			var elements = jQuery("#imContent *");
			makeFieldAbleOrNot(elements, false);
		}else{
			var elements = jQuery("#imContent *");
			makeFieldAbleOrNot(elements, true);
		}
	}
}

function makeFieldAbleOrNot(elements, able) {
	if (elements) {
		for (var i = 0; i < elements.length; i++) {
			var element = elements[i];
			if (element.disabled == !able) {
				element.disabled = able;
			}
		}
	}
}

jQuery(document).ready(function(){
	disabledElement();
});
</script>
<body>
<fieldset >
<legend>GKE</legend>
<table>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.km.invocation]*}：</td>
		<td><s:checkbox name="imConfig.open" onclick="disabledElement();" theme="simple"/></td>
	</tr>
</table>
</fieldset>
<fieldset >
<legend>GKE{*[Configuration]*}</legend>
<div id="imContent">
<div style="float:right;">
	<button type="button" id="gkeBackstage" class="button-image" onclick="setHref(this)" title="GKE{*[cn.myapps.core.sysconfig.im.manage_backstage]*}"><img border="0" src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> GKE{*[cn.myapps.core.sysconfig.im.manage_backstage]*}</button>
	<button type="button" id="domain_btn" title="{*[cn.myapps.core.sysconfig.im.synchronization_domain]*}" class="button-image" onClick="ev_domian()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> {*[cn.myapps.core.sysconfig.im.synchronization_domain]*}</button>
	<button type="button" id="department_btn" title="{*[cn.myapps.core.sysconfig.im.synchronization_department]*}"  style="display:none;" class="button-image" onClick="ev_department()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> {*[cn.myapps.core.sysconfig.im.synchronization_department]*}</button>
	<button type="button" id="user_btn" title="{*[cn.myapps.core.sysconfig.im.synchronization_user]*}" class="button-image"  style="display:none;" onClick="ev_user()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> {*[cn.myapps.core.sysconfig.im.synchronization_user]*}</button>
	<button type="button" id="cleanData" title="{*[Clear]*}" class="button-image" style="display:none;" onClick="ev_clean()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> 清空数据</button>
</div>
<table class="table_noborder id1">
	<tr>
		<td>Server-IP：</td>
		<td>Server-Port：</td>
	</tr>
	<tr>
		<td><s:textfield id="ip" name="imConfig.ip" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:textfield id="port" name="imConfig.port" cssClass="input-cmd" theme="simple" onblur=""/></td>
	</tr>
	<tr>
		<td>Server-{*[cn.myapps.core.sysconfig.ldap.user_loginno]*}：</td>
		<td>Server-{*[cn.myapps.core.sysconfig.ldap.user_login_password]*}：</td>
	</tr>
	<tr>
		<td><s:textfield name="imConfig.loginno" cssClass="input-cmd" theme="simple" onblur=""/></td>
		<td><s:password name="imConfig.password" cssClass="input-cmd" theme="simple" onblur="" showPassword="true"/></td>
	</tr>
</table>
</div>
</fieldset>
</body>
</html>