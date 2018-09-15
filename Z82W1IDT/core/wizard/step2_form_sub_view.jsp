<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", -1);
%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="content.moduleid" />
</s:bean>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[Module]*}</title>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">
	<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}

.STYLE3 {
	color: #000000
}
-->
</style>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/StringUtil.js"/>'></script>
	</head>

	<script>
function ev_init() {
	var str="<s:property value="content.f_fieldsdescription_sub" />";
	if(str.length>0){
    var obj=RelStr(str);
	    if(obj!=null){
	    	if(obj.length>0){
		        var field=document.all.fieldName;
			    for(var i=0;i<obj.length;i++){
			    	var Opt=document.createElement("option");
					Opt.value=obj[i].fieldname;
					Opt.text=obj[i].fieldname;
					field.options.add(Opt);
			    }
	      	}
		}
	}
}

	// 增加element options
	function addOptions(elemName, options) {
		var elems = document.getElementsByName(elemName);
		for (var i=0; i<elems.length; i++) {
			var defVal = elems[i].value;
			DWRUtil.removeAllOptions(elems[i].id);
			DWRUtil.addOptions(elems[i].id, options);
			DWRUtil.setValue(elems[i].id, defVal);
		}
	}
</script>
	<script> 
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
    
function addItem(source,target){ 
	for(var i=0;i<source.length;i++){	 
		if(source.options[i].selected==true){
			var Opt=document.createElement("option");
			Opt.value=source.options[i].value;
			Opt.text=source.options[i].text;
			var k=0;
			for(var j=0;j<target.length;j++){
			    if(source.options[i].value==target.options[j].value){
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
function ev_OK(action){
	var v_activitys = document.all("content.f_subForm_viewActivitys");
    var i = 0;
    
    while(i<v_activitys.length){
		if(v_activitys[i].value=="2" ){
        	v_activitys[i].disabled = "";
        }
        i++;
    }
	var selid = document.getElementById("selectid");
	var opt = selid.getElementsByTagName("option");
	if(opt.length<=0){
  		alert("{*[page.column.empty]*}"); 
  	}else{
   		var items=new Array();
   		for(i=0;i<opt.length;i++){
     		var current =opt[i];
     		items += current.value+";";
   		}
   		document.getElementById("save_content_f_subForm_viewColumns").value=items;
   		document.getElementById("save_content_selectFields_sub").value=createJSONStr();
   
   		document.forms[0].action = action;
		document.forms[0].submit();
   	}
}

function RelStr(str){
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	} else {
		return new Array();
	}
}

function createJSONStr() {
	var fields=  document.all.fields;
	var str = '[';
	if(fields.length>0){
		 for (var i=0;i<fields.length;i++) {
			if (fields.options[i].value != '') {
				str += '{'
				str += '"text"' +':\''+fields.options[i].text+'\',';
				str += '"value"' +':\''+fields.options[i].value+'\'';
				str += '},';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
	}
	str += ']';

	return str;
}

function initfields(){
	var str = document.all("content.selectFields_sub").value;
	if(str.length>0){
		var obj=RelStr(str);
	
		if(obj!=null){
			if(obj.length>0){
				var field=document.all.fields;
				for(var i=0;i<obj.length;i++){
		        	var Opt=document.createElement("option");
					Opt.value=obj[i].value;
					Opt.text=obj[i].text;
					field.options.add(Opt);
		     	}
	       	}
   		}
	}
}

function ev_inits(){
	//ev_init();
	initfields();
}

</script>
	<body onload="ev_inits()">

	<s:form action="save" method="post">
		<s:hidden name="content.f_formId_sub" />
		<s:hidden name="content.f_subForm_viewColumns" />
		<s:hidden name="content.selectFields_sub" />

		<%@include file="/common/page.jsp"%>
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<table width="99%">
			<tr style="height: 100px;">
				<td><%@include file="wizard_guide.jsp"%>
				</td>
				<td rowspan="2" style="width: 200px;"><s:include
					value="wizard_common.jsp">
					<s:param name="step" value="28" />
				</s:include></td>
			</tr>
			<tr style="height: 400px; vertical-align: top;">
				<td style="text-align: center;">
				<table class="marAuto">
					<tr>
						<td><label class="label"> {*[Fields]*}</label></td>
						<td></td>
						<td><label class="label">{*[Columns]*} </label></td>
					</tr>
					<tr>
						<td height="60" class="tdLabel">
						<div align="center"><select name="fieldName" size="15"
							multiple="multiple" style="width: 10em"
							ondblclick="addItem(document.all.fieldName,document.all.fields)">

						</select></div>
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
						<div align="center"><select id="selectid" name="fields"
							size="15" multiple="multiple" style="width: 10em"
							ondblClick="delItem(document.all.fieldName,document.all.fields)">
						</select></div>
						</td>
					</tr>
					<tr>
						<td class="commFont">{*[Activity]*}:</td>
						<td align="center" class="commFont"><br>
						<input type="checkbox" disabled="disabled" checked="checked"
							name="content.f_subForm_viewActivitys" value="2" />{*[Create]*}
						<input type="checkbox" name="content.f_subForm_viewActivitys"
							value="3" />{*[Delete]*}</td>
					</tr>
				</table>
				<table width="100%">
					<tr>
						<td class="commFont" align="center">
						<button type="button"
							onClick="forms[0].action='<s:url action="toStep2StyleSub"></s:url>';forms[0].submit();">{*[Back]*}</button>
						&nbsp;
						<button type="button" onClick="ev_OK('toSubFormSuccess.action');">{*[Next]*}</button>
						</td>
					</tr>
				</table>
				<br />
				<table style="margin: auto;">
					<tr>
						<td>*{*[page.wizard.step2.subview.description1]*}</td>
					</tr>
				</table>

				</td>
			</tr>
		</table>
	</s:form>
	<script>
ev_init('content.f_formId_sub','fieldName');
</script>
	</body>
</o:MultiLanguage>
</html>
