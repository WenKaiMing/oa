<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head><title>{*[{*[Column info]*}]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css"></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url id="url" value='/resourse/main.css'/>"/>
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src="<s:url value='/script/util.js'/>"></script>
<body >
<script>
function ev_onchange(val) {
	document.getElementById('appid').style.display='';
	document.getElementById('fftrid').style.display='';
	document.getElementById('vsid').style.display='';
   	if (val=='COLUMNMAPPING_TYPE_FIELD'){
		document.getElementById('vsid').style.display='none';
		
	}
	else if (val=='COLUMNMEPPING_TYPE_SCRIPT') {
	  	document.getElementById('appid').style.display='none';
		document.getElementById('fftrid').style.display='none';
	}
}

function swichLength()
{

  if(document.getElementById('content.toType').value=="Date")
  {
      document.getElementById('disLength').style.display='none';
      document.getElementById('disPrecision').style.display ='none';
  }else if(document.getElementById('content.toType').value=="DECIMAL"){
     document.getElementById('disLength').style.display = '';
     document.getElementById('disPrecision').style.display = '';
     
  } else if(document.getElementById('content.toType').value=="VARCHAR"){
      document.getElementById('disLength').style.display='';
      document.getElementById('disPrecision').style.display ='none';
  }
}
</script>
<s:form name="columnform" action="save" method="post">
<s:bean name="cn.myapps.core.dynaform.view.action.ColumnHelper" id="helper" />
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="formHelper" >
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>

<%@include file="/common/page.jsp"%>
<s:hidden name="mappingid"/>
<s:hidden name='mode' value="%{#parameters.mode}" />
<s:hidden name="s_mappingConfig" value="%{#parameters.mappingid}"/>
<table width="98%" >
		<tr>
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="90" class="text-label">{*[ColumnMapping]*}</td>
			<td>
			<table width="100%" border=1 cellpadding="0" cellspacing="0" class="line-position" ><tr><td ></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="button-image" onClick="forms[0].action='<s:url action="save"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				<td class="line-position2" width="70" valign="top">
				<button type="button" class="button-image" onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr></table>
			</td>
		</tr>
	</table>
		<s:if test="hasFieldErrors()">
	<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
	<s:iterator value="fieldErrors">
		*<s:property value="value[0]" />;
	</s:iterator> </span>
</s:if>
<table>
	<tr><td class="commFont">Type:</td><td> &nbsp;&nbsp;<s:radio  name="content.type" theme="simple" list="_COLMAPTYPE" onclick="ev_onchange(this.value)" /></td></tr>
	<tr>
	<td colspan="2">
	 <div id="appid" >
	   <table>
	
	   <tr id="moid"><td class="commFont">Module:</td><td><s:select  theme="simple" label="Module" name="_moduleid" list="{}" /></td></tr>
	   <tr><td class="commFont">Form:</td><td><s:select   theme="simple" label="Form" name="_formid" list="{}" /></td></tr>
	  	</table></div>
	  	</td>
	  	</tr>
	<tr id='fftrid' >
	    <td class="commFont">{*[Field]*}:</td>
		<td>
			&nbsp;&nbsp;<s:select label="Field" name="content.fromName" list="{}" emptyOption="true" theme="simple" />
		</td>
	</tr>
	<tr id="vsid" style="display:none"><td class="commFont">{*[Vaule script]*}:</td>
		<td>
			&nbsp;&nbsp;<s:textarea  cssClass="input-cmd" label="{*[Vaule script]*}" name="content.valuescript" cols="40" rows="5" theme="simple"/>
		</td></tr>
	<tr>
	    <td class="commFont">{*[ToName]*}:</td><td>&nbsp;&nbsp;<s:textfield  cssClass="input-cmd" theme="simple" name="content.toName" /></td>
	    </tr>	
	    <tr><td class="commFont">ToType:</td><td>&nbsp;&nbsp;<s:select theme="simple" onchange="swichLength()" name="content.toType" list="_TOTYPE" emptyOption="true" /></td></tr>
	    <tr id="disLength"><td class="commFont">{*[Length]*}:</td><td >&nbsp;&nbsp;<s:textfield cssClass="input-cmd"  name="content.length" theme="simple"/></td></tr>
	   <tr id="disPrecision" style="display:none"><td class="commFont">{*[Precision]*}:</td><td >&nbsp;&nbsp;<s:textfield cssClass="input-cmd"  name="content.precision" theme="simple"/></td></tr>
    </table>	    
</s:form>

</body>
<script>
//ev_init('content.formid','content.fromName');
swichLength();
var tempvalue='';
  for (var i=0;i<document.forms[0].elements.length;i++){  
		var e=document.forms[0].elements[i];		
		if ((e.type=='radio')&&e.checked){  
				 tempvalue = e.value;
			}	 
			
  		}
  if(tempvalue!=''&&tempvalue=='COLUMNMEPPING_TYPE_SCRIPT')
  {
       document.getElementById('vsid').style.display='';
	   document.getElementById('fftrid').style.display='none';
		document.getElementById('appid').style.display='none';
  }
  ev_select('_moduleid','_formid','content.fromName');
    function ev_select(module,form,formName)
{


var mv = document.getElementById(module).value;
var fv = document.getElementById(form).value;
var fnv = document.getElementById(formName).value;
var mode = '<s:property value="#parameters.mode" />';
if (mode == 'module'){
	document.getElementById('moid').style.display='none';
}

if (document.getElementById(form).value=='') {
	fv = '<s:property value="_formid"/>'
}
if (document.getElementById(module).value=='') {
	mv = '<s:property value="_moduleid"/>';
}
if(document.getElementById(formName).value=='')
{
   fnv = '<s:property value="content.fromName"/>';
}

else if (document.getElementById(module).value==''){
 	mv = 'none';
	fv = 'none';
	fnv = 'none';
}

var func = new Function("ev_select('"+module+"','"+form+"','"+formName+"')");
document.getElementById(module).onchange = func;
document.getElementById(form).onchange = func;

ApplicationUtil.creatModule(module,'<s:property value="#parameters.application"/>',mv,function(str) {var func=eval(str);func.call()}); 
ApplicationUtil.creatForm(form,'<s:property value="#parameters.application"/>',mv,fv,function(str) {var func=eval(str);func.call()});
FormHelper.creatFormfieldOptionsWithDocProp(formName, fv, fnv,function(str) {var func=eval(str);func.call()});

}
  </script>
</o:MultiLanguage></html>
