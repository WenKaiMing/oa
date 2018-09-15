<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<o:MultiLanguage>
	<head>
	<meta http-equiv=content-type content="text/html; charset=UTF-8">
	<s:bean name="cn.myapps.core.department.action.DepartmentHelper" id="dh">
		<s:param name="domainid" value="%{#parameters.domainid}" />
	</s:bean>
	
	<link rel="stylesheet" href="../css/dialog.css" type="text/css">
	<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
	<script src='<s:url value="/dwr/interface/RoleUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/RoleHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/DepartmentHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
	<script type="text/javascript">
	var applicationId = '<%= request.getParameter("application")%>';
	var domainid = '<%= request.getParameter("domainid")%>';
	var oldAttr = window.dialogArguments;
	
	// 初始化用户列表
	function ev_init(sourceFieldId, targetFieldId, defValues){
		UserUtil.getUserOptionsByDomain(domainid, function(options){
			addOptions(sourceFieldId, options);
			
			var oSource = document.getElementById(sourceFieldId);
			var oTarget = document.getElementById(targetFieldId); 
			//addItem(oSource, oTarget);
			initItem(oSource, oTarget, defValues);
		})
	}
	
	function addOptions(relatedFieldId, options, defValues){
		var el = document.getElementById(relatedFieldId);
		if(relatedFieldId){
			DWRUtil.removeAllOptions(relatedFieldId);
			DWRUtil.addOptions(relatedFieldId, options);
			if (defValues) {
				DWRUtil.setValue(relatedFieldId, defValues);
			}
			if (el.onchange && typeof(el.onchange) == "function") {
				el.onchange();
			}
		}
	}
	
	function addUserOptions(fn1,fn2,id){
	   var value = document.getElementById(id).value;
	   RoleUtil.createUserOptions(fn1,fn2,value,function(str) {var func=eval(str);func.call()});
	}
	function addOptionAll(fn1,fn2,values){
	   //alert(values);
	   // var value = document.getElementById(id).value;
	   if(values=='department'){
	    	DepartmentHelper.getDepartmentAll(domainid,fn1,fn2,function(str) {var func=eval(str);func.call()});
	   }else if(values=='roles'){
	     	RoleUtil.createRolesOptions(fn1,fn2,applicationId,function(str) {var func=eval(str);func.call()});
	   }
	   else if(values=='user'){
	      	var doc = document.getElementById('contentlist');
		    doc.style.display='';
	   }
	}
	window.onload = function(){
		var currNodeId = '<s:property value="%{#parameters._currid}" />';
		var auditorListStr = oldAttr.value;
	  	var defValues = [];
	   	if (auditorListStr) {
	   		var map = jQuery.parseJSON(auditorListStr);
	   		if (map[currNodeId]) {
	   			defValues = map[currNodeId];
	   		}
	   	}
	   	ev_init('userSelect', 'selectid', defValues);
    }
    
    function moveup(){   
	var s =   document.all.fields;   
  	var v =   new   Array();   
    for(var i=0;i<s.length-1;i++){   
	        if(!   s.options[i].selected   &&   s.options[i+1].selected){   
	            v.value   =   s.options[i].value;   
	            v.text   =   s.options[i].text;   
	            v.selected   =   s.options[i].selected;   
	            s.options[i].value   =   s.options[i+1].value;   
	            s.options[i].text   =   s.options[i+1].text;   
	            s.options[i].selected   =   s.options[i+1].selected;   
	            s.options[i+1].value   =   v.value;   
	            s.options[i+1].text   =   v.text;   
	            s.options[i+1].selected   =   v.selected;   
	        }   
	    }   
	} 

	function movedown(){   
	    var s = document.all.fields;
	    var v = new Array();   
	    for(var i = s.length-1; i > 0; i--){   
	        if(!s.options[i].selected && s.options[i-1].selected){   
	            v.value = s.options[i].value;   
	            v.text = s.options[i].text;   
	            v.selected = s.options[i].selected;   
	            s.options[i].value = s.options[i-1].value;   
	            s.options[i].text = s.options[i-1].text;   
	            s.options[i].selected = s.options[i-1].selected;   
	            s.options[i-1].value = v.value;   
	            s.options[i-1].text = v.text;   
	            s.options[i-1].selected = v.selected;   
	        }   
	    }   
	}
	
	function initItem(source, target, defValues) {
		for (var j=0; j<defValues.length; j++) {
			for(var i=0; i<source.length; i++){
				if (defValues[j] == source.options(i).value) {
					var opt = document.createElement("option");
					opt.value = source.options(i).value;
					opt.text = source.options(i).text;
					target.options.add(opt);
				}
			}
		}
	}  
	    
	function addItem(source,target){ 
		for(var i=0;i<source.length;i++){	 
			if(source.options(i).selected==true){
				var Opt=document.createElement("option");
				Opt.value=source.options(i).value;
				Opt.text=source.options(i).text;
				var k=0;
				for(var j=0;j<target.length;j++){
				    if(source.options(i).value==target.options(j).value){
					   k=1;
					}
				}
				if(k==0){
				    target.options.add(Opt);
					k=0;
				}
			}	
		}
	} 
	
	function delItem(source,target){ 
		for(var x = target.length-1;x >= 0;x--){ 
			var opt = target.options[x]; 
			if (opt.selected){ 
			 target.options[x] = null; 
			} 
		} 
	} 
	
	function ev_cancel(){
	    window.close();
	}
	function ev_ok(){
	     var currNodeId = '<s:property value="%{#parameters._currid}" />';
	     var rtn = new Array();
	     var p = 0;
	    
	     var selectlist = document.getElementById("selectid");
	     for(var i =0; i < selectlist.length ;i++){ 
		 	rtn.push(selectlist[i].value);
		 } 
	     
	     var auditorListStr = oldAttr.value;
	     if (auditorListStr) {
		    var map = jQuery.parseJSON(auditorListStr);
		    map[currNodeId] = rtn;
		    oldAttr.value = jQuery.json2Str(map,true);
	     }
	     
	     //window.returnValue = rtn.toString();
  		 window.close();
	}
	</script>
	</head>
	<body>
	<s:form name="temp" method="post" theme="simple">
		<table border=0 cellpadding=3 cellspacing=2 class="content" align="center">
		    	<tr>
		       		<td colspan="3"><label class="label"> {*[List]*}</label></td>
			        <td></td>
			        <td><label class="label">{*[AuditorNames]*} </label> </td>
			    </tr>
				<tr>
					<td height="60" class="tdLabel" colspan="3">
					<!-- left multi select -->
					<div align="center"> 
						<select id="userSelect" name="fieldName" size="15" multiple style="width:10em"
							ondblclick="addItem(document.all.fieldName,document.all.fields)">
						</select>
					</div>
					</td>
					<td bgcolor="#FFFFFF">

					<p align="center">
					<button type="button" class="button-image" onClick="moveup()"><img
						src="<s:url value="/resource/image/up2.gif"/>"
						alt="{*[Move_Up]*}"></button>
					</p>
					<p align="center">
					<button type="button" class="button-image"
						onClick="addItem(document.all.fieldName,document.all.fields)"><img
						src="<s:url value="/resource/image/right2.gif"/>"
						alt="{*[Add]*}{*[Item]*}"></button>
					</p>
					<p align="center">

					<button type="button" class="button-image"
						onClick="delItem(document.all.fieldName,document.all.fields)"><img
						src="<s:url value="/resource/image/left2.gif"/>"
						alt="{*[Delete]*}{*[Item]*}"></button>

					</p>
					<p align="center">

					<button type="button" class="button-image" onClick="movedown()"><img
						src="<s:url value="/resource/image/down2.gif"/>"
						alt="{*[Move_Down]*}"></button>

					</p>
					</td>
					<td height="60" class="tdLabel">
					<!-- right multi select -->
					<div align="center">
						<select id="selectid" name="fields" size="15" multiple style="width:10em"
							ondblClick="delItem(document.all.fieldName,document.all.fields)">
						</select>
					</div>
					</td>
				</tr>
	           <tr>
			<tr>
				<td align="center" colspan="3">
					<input type="button" value="{*[OK]*}" onclick="ev_ok()">
				</TD>
				<TD colspan="3">
					<input type="button" value="{*[Cancel]*}" onclick="ev_cancel()">
				</td>
			</tr>
		</table>
	</s:form>
	</BODY>
</o:MultiLanguage>
</HTML>

