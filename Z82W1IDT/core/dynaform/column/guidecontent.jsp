<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><o:MultiLanguage>
<head><title>{*[Column]*} {*[Guidecontent]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<style>
#save_success  {font-size:14px; color:#23571d; background-color: #9bffa3; padding:5px; height:100%}
</style>
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script src='<s:url value="column.js"/>'></script>
<script language="JavaScript">

jQuery(function(){
	//-aimar-阻止<button type="button">的默认行为，因为在ff下点击<from>表单中的<button type="button">会默认提交表单
	jQuery("button").click(function(e){e.preventDefault();});
});

var args = OBPM.dialog.getArgs();
var parentObj = args['parentObj'];
function ev_init(fn1,fn2) {
	
	var def1 = document.getElementsByName(fn1)[0].value;
	var def2 = document.getElementsByName(fn2)[0].value;

	if (document.getElementsByName(fn1)[0].value==''){def1 = '<s:property value="content.formid"/>'}
	if (document.getElementsByName(fn2)[0].value==''){def2 = '<s:property value="fieldName"/>'}
	if(document.getElementsByName(fn1)[0].value=='')
		def2='none';

	var func = new Function("ev_init('"+fn1+"','"+fn2+"')");

	document.getElementsByName(fn1)[0].onchange = func;
	FormHelper.creatFormfieldOptionsByguide(fn2,def1,def2,function(str) {var func=eval(str);func.call()});
}

 function moveup()   {   
    var  s   =   document.all.fields;   
    var v   =   new   Array();   
      for(var i=0;i<s.length-1;i++)   {   
          if(!   s.options[i].selected   &&   s.options[i+1].selected)   {   
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

function   movedown()   {   
      var s   =   document.all.fields;   
      var v   =   new   Array();   
      for(var i=s.length-1;i>0;i--)   {   
          if(!   s.options[i].selected   &&   s.options[i-1].selected)   {   
              v.value   =   s.options[i].value;   
              v.text   =   s.options[i].text;   
              v.selected   =   s.options[i].selected;   
              s.options[i].value   =   s.options[i-1].value;   
              s.options[i].text   =   s.options[i-1].text;   
              s.options[i].selected   =   s.options[i-1].selected;   
              s.options[i-1].value   =   v.value;   
              s.options[i-1].text   =   v.text;   
              s.options[i-1].selected   =   v.selected;   
          }   
      }   
  }  
    

function addItem(source,target){ 
   for(var i=0;i<source.length;i++)
	 {	 
         if(source.options[i].selected==true)
		 {
            var Opt=document.createElement("option");
			Opt.value=source.options[i].value;
			Opt.text=source.options[i].text;
			var k=0;
			for(var j=0;j<target.length;j++)
			{
			    if(source.options[i].value==target.options[j].value)
				{
				   k=1;
				}

			}
				if(k==0)
			    {
			        target.options.add(Opt);
				    k=0;
			    }

		}	
     }
} 
function delItem(source,target){ 
	for(var x=target.length-1;x>=0;x--){ 
		var opt = target.options[x]; 
		if (opt.selected){ 
		 target.options[x] = null; 
		} 
	} 
} 
function ev_OK(action){
    var selid= document.getElementById("selectid");
   	var fields=  document.all.fields;
    var opt  = selid.getElementsByTagName("option");
      if(opt.length<=0){
       alert("column is emty");
      }else{
       var items=new Array();
       for(i=0;i<opt.length;i++){
         var current =opt[i];
         items+=current.value+";";
       }
       thisform.all.fieldnames.value=items
       thisform.action = action;
	   thisform.submit();
    }
}

function doSave() {
	var selid = document.getElementById("selectid");
	if (selid && selid.options) {
		for (var i=0; i<selid.options.length; i++) {
			var fieldName = selid.options[i].value;	
			var newColumn = new Column();
			DWRUtil.getValues(newColumn);
			newColumn.name = fieldName;
			newColumn.fieldName = fieldName;
			doCreate(newColumn);
		}
		jQuery("#save_success").css("display","");
		jQuery("#btn_confirm").attr("disabled","true");
		parentObj.columnProcess.refreshList(columnCache);
		OBPM.dialog.doReturn();
	} else {
		alert("column is empty");
	}
}

window.onload = function(){
	columnCache = parentObj.columnCache;
	window.top.toThisHelpPage("application_module_view_info_wizard_column_info");
}
</script> 
</head>
<body style="margin:0px;">

<s:form name="thisform" action="savecolumns" method="post">
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="formHelper" >
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>

<s:hidden name="application" value="%{#parameters.application}"/>
<s:hidden name="content.id" /> 
<s:hidden name="content.sortId" />
<s:hidden name="moduleid" value="%{#parameters.moduleid}"/>
<s:hidden id="parentView" name="viewid"  value="%{#parameters.viewid}"/>
<s:hidden name="fieldnames" />
<s:hidden id="type" name="content.type" value="COLUMN_TYPE_FIELD"/>

<table width="100%">
	<tr valign="top">
		<td><div id="save_success" style="display:none">列信息已经保存</div></td>
		<td align="right">
			<table border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td width="70" valign="top">
						<button type="button" id="btn_confirm" class="button-class" onClick="doSave()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<td width="60" valign="top">
						<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();">
							<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Cancel]*}
						</button>
					</td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">
		&nbsp;
		</td>
	</tr>
</table>
<%@include file="/common/msg.jsp"%>	
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table>
   <tr id='fntrid'>
	    <td class="tdLabel"><label for="save_content_formid" class="label">{*[Form]*}:</label></td>
		<td>
			<s:select  label="Form" id="formid" name="content.formid" list="#formHelper.get_relateFormById(#parameters.targetFormId)" listKey="id"
				listValue="name" emptyOption="false" theme="simple"/>
		</td>
	</tr>
</table>
 
<table><tr> <td height="66" class="tdLabel"> <div align="center"> <label class="label">{*[Fields]*}</label>
<select name="fieldName" size="18" multiple="multiple" style="width:12em" ondblclick="addItem(document.all.fieldName,document.all.fields)"> 

</select> 
</div></td> 
<td bgcolor="#FFFFFF">

<p align="center"> 
<button type="button" class="button-image" onClick="moveup()"><img src="<s:url value="/resource/image/up2.gif"/>" alt="{*[Move_Up]*}" ></button>
</p> 
<p align="center"> 
<button type="button" class="button-image" onClick="addItem(document.all.fieldName,document.all.fields)"><img src="<s:url value="/resource/image/right2.gif"/>" alt="{*[add item]*}"></button>
</p> 
<p align="center"> 

<button type="button" class="button-image" onClick="delItem(document.all.fieldName,document.all.fields)"><img src="<s:url value="/resource/image/left2.gif"/>" alt="{*[delete item]*}"></button>

</p>
<p align="center"> 

<button type="button" class="button-image" onClick="movedown()"><img src="<s:url value="/resource/image/down2.gif"/>" alt="{*[Move_Down]*}"></button>

</p>
</td> 
<td height="66" class="tdLabel"> <div align="center"><label class="label">{*[Columns]*} </label>
 <select id="selectid" name="fields" size="18" multiple="multiple" style="width:12em" ondblClick="delItem(document.all.fieldName,document.all.fields)"> 
</select> 

</div></td></tr></table>  

</s:form>
</body>
<script>
ev_init('content.formid','fieldName');
</script>
</o:MultiLanguage></html>