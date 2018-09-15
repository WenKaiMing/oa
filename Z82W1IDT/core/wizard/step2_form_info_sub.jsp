<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[Module]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
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

function ev_init() {
	var btnNext = jQuery("#btnNext");
	//btnNext.disabled = true;
}
	function on_submit(){
    	var f_activitys = document.all("content.f_activitys_sub");
    	var i = 0;
    
   	while(i<f_activitys.length){
   		if(f_activitys[i].value=="5" ||f_activitys[i].value=="4" ){
        	f_activitys[i].disabled = "";
		}
		i++;
    }

    
}

	function doNext() {
		document.forms[0].action='<s:url action="toStep2FieldSub"></s:url>';
		on_submit();
		document.forms[0].submit();
	}

	function validate() {
		var formname = document.getElementById("formname").value;
		var display = document.getElementById("formDisplay");
		if (formname == "") {
			display.innerHTML = "<font color='red'>请输入表单的名字</font>";
		}
		else {
			display.innerHTML = "<font color='blue'>正在验证名字是否可用，请稍候</font>";
			validateFormName(formname, display);
		}
	}
	String.prototype.trim = function() { return this.replace(/(^\s*)|(\s*$)/g,""); };
	function validateFormName (e,htmlcontext) {
		 var objxmlHttp = createXmlHttpRequestObject();
		 var message = "";
		 var isUsed = false;
		    objxmlHttp.open("post",'<s:url action="validateFormname"></s:url>',true);
		    objxmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		    objxmlHttp.onreadystatechange = function () {
		        if(objxmlHttp.readyState == 4 && (objxmlHttp.status == 200 || objxmlHttp.status == 304)) {
		        	var result = objxmlHttp.responseText;
		        	result = result.trim();
		            if (result == 'no') {
						message = "<font color='blue'>该名字可以使用</font>";
						doNext();
			        } else if(result == 'db2') {
						message = "<font color='red'>在使用DB2数据库时表单名字只能为数字，字母及下划线</font>";
				    }
			         else {
						message = "<font color='red'>该名字已经被占用</font>";
				    }    
		            htmlcontext.innerHTML = message;
			 	}
		    }
		    objxmlHttp.send("submit=%CD%E6%C0%DB%C1%CB%A3%AC%BB%D8%BC%D2%A3%A1&formname="+e + "&application=" + '<s:property value="#parameters.application" />' + "&mainformname=" + '<s:property value="content.f_name" />');
		    return isUsed;
	}

	function createXmlHttpRequestObject() { 
		var xmlHttp; 
		if(window.ActiveXObject){ 
			try{ 
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); 
			} catch (e) { 
				xmlHttp = false; 
			}
		} 
		else{
			try{
				xmlHttp = new XMLHttpRequest(); 
			}catch(e){ 
				xmlHttp = false;
			} 
		} 
		if (!xmlHttp){ 
			alert("Error creating the XMLHttpRequest object."); 
		}else{ 
			return xmlHttp; 
		} 
	} 
  
function checkSpace(obj) {
	obj.value = obj.value.replace(/[^\w\u4e00-\u9fa5]/g,'');
} 

</script>
<body onload="ev_init()">
<s:form action="save" method="post">
	 <s:hidden name="content.f_formid_sub" />
	 <s:hidden name="content.version_sub" />

<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%> 
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<s:hidden name="content.f_formid" />
	<s:hidden name="content.version" />
	<table width="99%">
		<tr style="height:100px;">
			<td>
				<%@include file="wizard_guide.jsp" %>
			</td>
			<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="25"/></s:include></td>
		</tr>
		<tr style="height:400px; vertical-align: top;">
			<td style="text-align: center;">
			<input type="hidden" name="formType" value="<s:property value='#parameters.formType'/>">
 			<table class="marAuto">
				<tr>
					<td class="commFont">{*[Name]*}:</td>
					<td><s:textfield id="formname" cssStyle="width:300px" size="50" onblur="checkSpace(this);" cssClass="input-cmd" name="content.f_name_sub" theme="simple"/></td>
					<td style="width:200px;"><div id="formDisplay"></div></td>
				</tr>
       			<tr>
	       			<td class="commFont">{*[Description]*}:</td>
	       			<td><s:textarea cssStyle="width:300px" cols="50"  rows="4" cssClass="input-cmd"  theme="simple" name="content.f_description_sub" /></td>
	       			<td>&nbsp;</td>	
	       		</tr>
        		<tr><td class="commFont">{*[Activity]*}:</td><td colspan="2" class="commFont">
        			<input type="checkbox"   disabled="disabled" name="content.f_activitys_sub" value="34" checked="checked" />{*[Save]*} 
			        <input type="checkbox"   name="content.f_activitys_sub" value="8" />{*[Close]*}
			        <input type="checkbox"   name="content.f_activitys_sub" value="42" />{*[Save&New]*}
			        <input type="checkbox"   name="content.f_activitys_sub" value="9" />{*[Save&Close]*}</td>
				</tr>
        		<tr><td valign="top" colspan="3" align="center">
        			<button type="button" onClick="forms[0].action='<s:url action="toStep2Style"></s:url>';forms[0].submit();">{*[Back]*}</button> &nbsp;
       				<button type="button" id="btnNext" onClick="validate()">{*[Next]*}</button>
       				</td>
       			</tr>
			</table><br/>
				<table width="80%">
					<tr>
						<td>
							*{*[page.wizard.step2.info.subdescription1]*}
						</td>
					</tr>
	</table>
			</td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
