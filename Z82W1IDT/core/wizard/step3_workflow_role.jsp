<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[Module]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script src='<s:url value="/script/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/WizardUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/SequenceUtil.js"/>'></script>

<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}
.STYLE3 {color: #000000}
-->
</style>
</head>

<script>
   //function typeChange(type) { //workflow type
   //var obj;
   //  for (var i=1;i<4;i++){
   //	obj=document.all("workflow0"+i);
   //	obj.style.display="none";
   //	  }
   //	obj=document.all("workflow"+type);
   //	obj.style.display="";
//}]
 function typeChange(type) { //workflow type
    var obj;
	for (var i=1;i<4;i++){
		obj=document.getElementById("workflow0"+i);
		obj.style.display="none";
	}
	switch (type) {
		case '01':
		  document.getElementById("workflow01").style.display="";
		  break;
		case '02':
			document.getElementById("workflow02").style.display="";
			break;
		case '03':
			document.getElementById("workflow03").style.display="";
			break;
		default:
			document.getElementById("workflow01").style.display="";
			break;
	}
}//function end

function doNewRole() {
	var url = '<s:url value="/core/role/create.action"><s:param name="application" value="#parameters.application" /><s:param name="_pagelines" value="10" /></s:url>';

	OBPM.dialog.show({
		opener:window.parent,
		width: 600,
		height: 400,
		url: url,
		args: {},
		title: '{*[Add]*}{*[Role]*}',
		close: function(rtn) {
			return;
		}
	});
}

function ev_init() {
	
	var type="<s:property value='content.w_flowType'/>"; 
	var w_content ="<s:property value='content.w_content'/>";
	if(w_content){
		var subString = w_content.substring(1,w_content.length-1);
		var content = subString.split(",");
		var t1 = content[0];
		var t2 = content[1];
		initName(t1,type);
		initRole(t2,type);
	}
	typeChange(type);
}//function end
function initName(t1,type){
	if(t1){
		t1 = t1.substring(1,t1.length-1);
	 	var b = t1.split(";");
	 	switch (type) {
	 		case "01":
			for(var i=0;i<3;i++){
					if(document.getElementById("normalname"+i).value=='' || document.getElementById("normalname"+i).value==null){
						document.getElementById("normalname"+i).value = b[i];
				    }
				}
				break;
			case "02":
				for(var i=0;i<4;i++){
					if(document.getElementById("branchname"+i).value.length==0|| document.getElementById("branchname"+i).value==""){
						document.getElementById("branchname"+i).value = b[i];
						if(document.getElementById("branchname"+i).value=='undefined'){
							document.getElementById("branchname"+i).value='';
						}
			       	}
				}
				break;
			
			case "03":
				for(var i=0;i<4;i++){
					if(document.getElementById("integratename"+i).value.length==0|| document.getElementById("integratename"+i).value==""){
						document.getElementById("integratename"+i).value = b[i];
						if(document.getElementById("integratename"+i).value=='undefined'){
							document.getElementById("integratename"+i).value='';
						}
					}
				}
				break;
	 		}
	}
}
function parseRoles(namelist){
    var rolelists = "";
    var roleLis = "";
    if(namelist!=null){
      var rolelist = namelist.substring(1,namelist.length-1);
      var roles  = rolelist.split(";");
      for(var i=0; i< roles.length; i++){
            var role = roles[i];
            var rr = role.split("|");
            if(rr[1] == 'undefined' || rr[1] == null){
            }else{
            	roleLis += rr[1] + ";";
            	rolelists =roleLis.substring(0,roleLis.length-1);
            }
      }
   }
   return rolelists;
}
function initRole(t1,type){
	if(t1){
	 	var b = t1.split(" ");
	 		switch (type) {
			case "01":
				for(var i=0;i<3;i++){
			    	if(document.getElementById("normalrole"+i).value==''|| document.getElementById("normalrole"+i).value==null){
				    //	alert(parseRoles(b[i]));
			    		document.getElementById("normalrole"+i).value =b[i];
			    		document.getElementsByName("normalrole"+i+"_1")[0].value =parseRoles(document.getElementById("normalrole"+i).value);
			       	}
				}
		 		break;
			case "02":
				for(var i=0;i<4;i++){
			       	if(document.getElementById("branchrole"+i).value.length==0|| document.getElementById("branchrole"+i).value==""){
			       		document.getElementById("branchrole"+i).value = b[i];
			       		document.getElementsByName("branchrole"+i+"_1")[0].value = parseRoles(document.getElementById("branchrole"+i).value);
			       	}
				}
				break;
			case "03":
				for(var i=0;i<4;i++){
					if(document.getElementById("integraterole"+i).value.length==0|| document.getElementById("integraterole"+i).value==""){
						document.getElementById("integraterole"+i).value =b[i];
						document.getElementsByName("integraterole"+i+"_1")[0].value = parseRoles(document.getElementById("integraterole"+i).value);
				    }
				}
				break;
			}		
	}
}
function selectField(actionName, field,fieldToShow, multiselect){

	var url = contextPath + '/core/role/'+ actionName +'.action?application=' + '<s:property value="%{#parameters.application}" />';
	//if (field != '' && field != null) {
	//	url = url + '&field=' + field;
	//}
	
	var oField = document.getElementById('namelist');
	
	//var rtn = window.showModalDialog(url, field, "dialogHeight:400px; dialogWidth:300px; status:no;");
	//alert(rtn);
	OBPM.dialog.show({
			opener:window.parent,
			width: 500,
			height: 400,
			url: url,
			args: {'oField':field},
			title: '{*[Select]*}{*[Roles]*}',
			close: function(rtn) {
				if (rtn == undefined) return;
				var rtnArray = rtn.split(",");
				
				if (rtnArray == null || rtnArray == 'undefined') {
				}
				else if (rtnArray == '') {
					field.value = '';
				}
				else {
					if(multiselect){
						field.value = '';

						var nameArray = '';
						//去掉重复
						var array = new Array(rtnArray.length);
						var count = 0;
						for (var n = 0; n < rtnArray.length; n++) {
							var flag = false;
							for (var m = 0; m < rtnArray.length; m++) {
							
								if (array[m] != rtnArray[n]) {
									if (m + 1 == rtnArray.length) {
										flag = true;
									}
									continue;
								}
								else {
									break;
								}
							}				
							if (flag) {
								array[count] = rtnArray[n];
								count++;
							}
						}
						
						// 数组复制
						var newArray = array.slice(0 , count); 
						for (var i=0; i < newArray.length; i++) {
							var t = newArray[i];
							field.value += t + ';';
						}
					} else {
						var t = rtn;
						field.value = t + ";";
					}
				}
				
				if (field.value == '') {
				}
				else {
					field.value = "(" + field.value + ")";
				}

				fieldToShow.value = getRoleNames(field.value);
			}
	});
	
}

function getRoleNames(str) {
	str = str.substring(1, str.length-1);
	var aArray = str.split(";");
	var nameArray = "";
	for (var i = 0; i < aArray.length; i++) {
		if (aArray[i] != "") {
			var bArray = aArray[i].split("|");
			nameArray += bArray[1] + ",";
		}
	}

	if (nameArray.length > 0) {
		nameArray = nameArray.substring(0, nameArray.length - 1);
	}
	return nameArray;
}

function createNamestr(name){
    var str="";
       if(name!="" && name.length>0){
		        str=name+";";
		 }
    return str;
}//function end

function createRolestr(role){
	var str="";
	if(role!="" && role.length>0){
		str=role+" ";
	}
    return str;
}//function end

function createNodeIdStr(nodeId) {
	var str = "";
	if (nodeId != "" && nodeId.length>0) {
		str = nodeId + ";";
	}
	return str;
}//function end

function getNodeId() {
  		var nodeid = "";
  		DWREngine.setAsync(false);
		SequenceUtil.getSequence(function(id) {
			nodeid = id;
		});
	return nodeid;
}//function end

function ev_next(){
   
	var names="";
	var roles="";
	var nodeIds = "";
	var type="<s:property value='content.w_flowType'/>";

	switch (type) {
		case "01":
			for(var i=0;i<3;i++){
		    	if(document.getElementById("normalname"+i).value.length==0|| document.getElementById("normalname"+i).value==""){
		        alert("{*[page.name.notexist]*}!");
		        return ;
		    	}
		    	if(document.getElementById("normalrole"+i).value.length==0|| document.getElementById("normalrole"+i).value==""){
		       		alert("{*[page.role.notexist]*}!");
		         	return ;
		       	}
		    names+=createNamestr(document.getElementById("normalname"+i).value);
		    roles+=createRolestr(document.getElementById("normalrole"+i).value);
			nodeIds+=createNodeIdStr(getNodeId());
			}
	 		break;
		
		case "02":
			for(var i=0;i<4;i++){
				if(document.getElementById("branchname"+i).value.length==0|| document.getElementById("branchname"+i).value==""){
		    	    alert("{*[page.name.notexist]*}!");
		        	return ;
		       	}
		       	if(document.getElementById("branchrole"+i).value.length==0|| document.getElementById("branchrole"+i).value==""){
		        	alert("{*[page.role.notexist]*}!");
		         	return ;
		       	}
			names+=createNamestr(document.getElementById("branchname"+i).value);
		    roles+=createRolestr(document.getElementById("branchrole"+i).value);
			}
			break;
		
		case "03":
			for(var i=0;i<4;i++){
				if(document.getElementById("integratename"+i).value.length==0|| document.getElementById("integratename"+i).value==""){
		        	alert("{*[page.name.notexist]*}!");
		        return ;
				}
				if(document.getElementById("integraterole"+i).value.length==0|| document.getElementById("integraterole"+i).value==""){
		        	alert('{*[page.role.notexist]*}!');
		        return ;
		    	}
			names+=createNamestr(document.getElementById("integratename"+i).value);
		    roles+=createRolestr(document.getElementById("integraterole"+i).value);
			}
			break;
	}		
	if(names.length>0){
		names=names.substring(0,names.length-1);
	}
	if(roles.length>0){
		roles=roles.substring(0,roles.length-1);
	}
	if(document.getElementById('content.w_content')!=null){
		document.getElementById('content.w_content').value = "['" + names + "','" + roles + "','" + type + "','"+ nodeIds +"']";
	}else{
		document.getElementById('tostep2forminfo_content_w_content').value = "['" + names + "','" + roles + "','" + type + "','"+ nodeIds +"']";
	}	
	document.forms[0].action = '<s:url action="toWorkflowConfirm"></s:url>';
	document.forms[0].submit();
}//function end

function createWorkflowStr(names,roles,type){
    var str = '';
	DWREngine.setAsync(false);
	WizardUtil.getCreateworkflow(names,roles,type,function(workflowStr) {
		str = workflowStr;
	});
	return str;
}//function end

function checkSpace(obj) {
	obj.value = obj.value.replace(/[^\w\u4e00-\u9fa5]/g,'');
} 
</script>

<body onload="ev_init()">
<s:form action="tostep2forminfo" method="post" name="tmp">
<s:hidden name="content.w_content"/>
<s:hidden name="content.w_workflowid" />
<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%> 
   	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table width="99%">
	<tr style="height:100px;">
		<td>
			<%@include file="wizard_guide.jsp" %>
		</td>
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="33"/></s:include></td>
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
		<table width="100%" class="marAuto">
			<tr id="workflow01">
	        	<td>
	         		<table border="0" align="center" width="100%">
			         	<tr>
			         		<td align="center" colspan="6"><img src="<s:url value="/resource/image/workflow01.gif"/>"></td>
			         	</tr>
			         	<tr>
					        <td style="background-color:#d4d4d4" rowspan="2">1</td><td class="commFont">{*[Name]*}:<input type="text" id="normalname0" name="normalname0" onblur="checkSpace(this)" size="15"/></td>
					        <td style="background-color:#d4d4d4" rowspan="2">2</td><td class="commFont">{*[Name]*}:<input type="text" id="normalname1" name="normalname1" onblur="checkSpace(this)" size="15"/></td>
					        <td style="background-color:#d4d4d4" rowspan="2">3</td><td class="commFont">{*[Name]*}:<input type="text" id="normalname2" name="normalname2" onblur="checkSpace(this)" size="15"/></td>
			         	</tr>
			         	<tr>
							<td class="commFont">{*[Role]*}:<input type="text" class="input" size="15" name="normalrole0_1" value="" disabled="true"> <input class="button-cmd" onclick="selectField('rolelist', document.all.normalrole0,document.all.normalrole0_1,true)"  alt="{*[Add Role]*}" type="button" value="..." /><br/><a href="javascript:doNewRole()">{*[Create]*} {*[Role]*}</a></td>
							<td class="commFont">{*[Role]*}:<input type="text" class="input" size="15" name="normalrole1_1" value="" disabled="true"> <input class="button-cmd" onclick="selectField('rolelist', document.all.normalrole1,document.all.normalrole1_1,true)"  alt="{*[Add Role]*}" type="button" value="..." /></td>
							<td class="commFont">{*[Role]*}:<input type="text" class="input" size="15" name="normalrole2_1" value="" disabled="true"> <input class="button-cmd" onclick="selectField('rolelist', document.all.normalrole2,document.all.normalrole2_1,true)"  alt="{*[Add Role]*}" type="button" value="..." /></td>
			         	</tr>
			         	<tr style="display:none;">
							<td class="commFont"><input type="text" class="input" id="normalrole0" name="normalrole0" disabled="disabled"></td>
							<td class="commFont"><input type="text" class="input" id="normalrole1" name="normalrole1" disabled="disabled"></td>
							<td class="commFont"><input type="text" class="input" id="normalrole2" name="normalrole2" disabled="disabled"></td>
			         	</tr>
	            	</table>
				</td>
			</tr>
			<tr id="workflow02">
	      		<td>
	         		<table border="0" width="100%">
			          	<tr>
			          		<td align="center" colspan="8"><img src="<s:url value="/resource/image/workflow02.gif"/>"></td>
			          	</tr>
			          	<tr>
				         	<td style="background-color:#d4d4d4" rowspan="2">1</td><td class="commFont">{*[Name]*}:<input type="text" id="branchname0" name="branchname0" onblur="checkSpace(this)"  size="10"/></td>
				         	<td style="background-color:#d4d4d4" rowspan="2">2</td><td class="commFont">{*[Name]*}:<input type="text" id="branchname1" name="branchname1" onblur="checkSpace(this)"  size="10"/></td>
				         	<td style="background-color:#d4d4d4" rowspan="2">3</td><td class="commFont">{*[Name]*}:<input type="text" id="branchname2" name="branchname2" onblur="checkSpace(this)" size="10"/></td>
				         	<td style="background-color:#d4d4d4" rowspan="2">4</td><td class="commFont">{*[Name]*}:<input type="text" id="branchname3" name="branchname3" onblur="checkSpace(this)" size="10"/></td>
			         	</tr>
			         	<tr>
				         	<td class="commFont">{*[Role]*}:<input type="text" class="input" size="10" name="branchrole0_1" value="" disabled="disabled"> <input class="button-cmd" onclick="selectField('rolelist', document.all.branchrole0,document.all.branchrole0_1,true)" alt="{*[Add Role]*}" type="button" value="..." /><br/><a href="javascript:doNewRole()">{*[Create]*} {*[Role]*}</a></td>
				         	<td class="commFont">{*[Role]*}:<input type="text" class="input" size="10" name="branchrole1_1" value="" disabled="disabled"> <input class="button-cmd" onclick="selectField('rolelist', document.all.branchrole1,document.all.branchrole1_1,true)" alt="{*[Add Role]*}" type="button" value="..." /></td>
				         	<td class="commFont">{*[Role]*}:<input type="text" class="input" size="10" name="branchrole2_1" value="" disabled="disabled"> <input class="button-cmd" onclick="selectField('rolelist', document.all.branchrole2,document.all.branchrole2_1,true)" alt="{*[Add Role]*}" type="button" value="..." /></td>
				         	<td class="commFont">{*[Role]*}:<input type="text" class="input" size="10" name="branchrole3_1" value="" disabled="disabled"> <input class="button-cmd" onclick="selectField('rolelist', document.all.branchrole3,document.all.branchrole3_1,true)" alt="{*[Add Role]*}" type="button" value="..." /></td>
			         	</tr>
			         	<tr style="display:none;">
				         	<td class="commFont"><input type="text" class="input" size="10" id="branchrole0" name="branchrole0" value="" disabled="disabled"></td>
				         	<td class="commFont"><input type="text" class="input" size="10" id="branchrole1" name="branchrole1" value="" disabled="disabled"></td>
				         	<td class="commFont"><input type="text" class="input" size="10" id="branchrole2" name="branchrole2" value="" disabled="disabled"></td>
				         	<td class="commFont"><input type="text" class="input" size="10" id="branchrole3" name="branchrole3" value="" disabled="disabled"></td>
			         	</tr>
	            	</table>
	      		</td>
	    	</tr>
	     	<tr id="workflow03">
	      		<td>
	         		<table border="0" width="100%">
						<tr>
							<td align="center" colspan="8"><img src="<s:url value='/resource/image/workflow03.gif'/>"></td>
						</tr>
						<tr>
							<td style="background-color:#d4d4d4" rowspan="2">1</td><td class="commFont">{*[Name]*}:<input type="text" id="integratename0" name="integratename0" onblur="checkSpace(this)"  size="10"/></td>
							<td style="background-color:#d4d4d4" rowspan="2">2</td><td class="commFont">{*[Name]*}:<input type="text" id="integratename1" name="integratename1" onblur="checkSpace(this)" size="10"/></td>
							<td style="background-color:#d4d4d4" rowspan="2">3</td><td class="commFont">{*[Name]*}:<input type="text" id="integratename2" name="integratename2" onblur="checkSpace(this)" size="10"/></td>
							<td style="background-color:#d4d4d4" rowspan="2">4</td><td class="commFont">{*[Name]*}:<input type="text" id="integratename3" name="integratename3" onblur="checkSpace(this)" size="10"/></td>
						</tr>
						<tr>
							<td class="commFont">{*[Role]*}:<input type="text" class="input" size="10" name="integraterole0_1" value="" disabled="disabled"> <input class="button-cmd" onclick="selectField('rolelist', document.all.integraterole0,document.all.integraterole0_1,true)" type="button" alt="{*[Add Role]*}" value="..." /><br/><a href="javascript:doNewRole()">{*[Create]*} {*[Role]*}</a></td>
							<td class="commFont">{*[Role]*}:<input type="text" class="input" size="10" name="integraterole1_1" value="" disabled="disabled"> <input class="button-cmd" onclick="selectField('rolelist', document.all.integraterole1,document.all.integraterole1_1,true)" type="button" alt="{*[Add Role]*}" value="..." /></td>
							<td class="commFont">{*[Role]*}:<input type="text" class="input" size="10" name="integraterole2_1" value="" disabled="disabled"> <input class="button-cmd" onclick="selectField('rolelist', document.all.integraterole2,document.all.integraterole2_1,true)" type="button" alt="{*[Add Role]*}" value="..." /></td>
							<td class="commFont">{*[Role]*}:<input type="text" class="input" size="10" name="integraterole3_1" value="" disabled="disabled"> <input class="button-cmd" onclick="selectField('rolelist', document.all.integraterole3,document.all.integraterole3_1,true)" type="button" alt="{*[Add Role]*}" value="..." /></td>
						</tr>
						<tr style="display:none;">
							<td class="commFont"><input type="text" class="input" size="10" id="integraterole0" name="integraterole0" value="" disabled="disabled"></td>
							<td class="commFont"><input type="text" class="input" size="10" id="integraterole1" name="integraterole1" value="" disabled="disabled"></td>
							<td class="commFont"><input type="text" class="input" size="10" id="integraterole2" name="integraterole2" value="" disabled="disabled"></td>
							<td class="commFont"><input type="text" class="input" size="10" id="integraterole3" name="integraterole3" value="" disabled="disabled"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center">
					<button type="button" onClick="forms[0].action='<s:url action="toworkflowtype"></s:url>';forms[0].submit();">{*[Back]*}</button>&nbsp;
					<button type="button" onClick="ev_next();">{*[Next]*}</button>
				</td>
			</tr>
		</table><br/>
		<table width="100%">
			<tr>
				<td align="center">
					*{*[page.wizard.step3.role.description1]*}
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
