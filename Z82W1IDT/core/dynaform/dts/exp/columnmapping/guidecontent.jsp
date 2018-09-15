<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><o:MultiLanguage>
<head>
<title>{*[{*[Column Guidecontent]*}]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">

<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script> 
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
         if(source.options(i).selected==true)
		 {
            var Opt=document.createElement("option");
			Opt.value=source.options(i).value
			Opt.text=source.options(i).text
			var k=0;
			for(var j=0;j<target.length;j++)
			{
			    if(source.options(i).value==target.options(j).value)
				{
				   k=1
				}

			}
				if(k==0)
			    {
			        target.options.add(Opt);
				    k=0
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
    var stringType=document.getElementById("stringType");
    var stringTypeopt  =stringType.getElementsByTagName("option");
      
       var sTypeitems=new Array();
       for(var i=0;i<stringTypeopt.length;i++){
         var current =stringTypeopt[i];
         sTypeitems+=current.value+";";
       }
    thisform.all.stringfieldnames.value=sTypeitems;
       
    var decimalType=document.getElementById("decimalType");
    var decimalTypeopt  =decimalType.getElementsByTagName("option");
      
       var dTypeitems=new Array();
       for(var i=0;i<decimalTypeopt.length;i++){
         var current =decimalTypeopt[i];
         dTypeitems+=current.value+";";
       }
      thisform.all.decimalfieldnames.value=dTypeitems;
      
    var dataType=document.getElementById("dataType");
    var dataTypeopt  =dataType.getElementsByTagName("option");
      
       var dateTypeitems=new Array();
       for(var i=0;i<dataTypeopt.length;i++){
         var current =dataTypeopt[i];
         dateTypeitems+=current.value+";";
       }
      thisform.all.datafieldnames.value=dateTypeitems;
                 
       thisform.action = action;
	   thisform.submit();
     
}
</script> 
</head>
<body>
<s:form name="thisform" action="savecolumns" method="post">
<s:bean name="cn.myapps.core.dynaform.view.action.ColumnHelper" id="helper" />
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="formHelper" >
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>

<%@include file="/common/page.jsp"%>
<s:hidden name="mappingid"/>
<s:hidden name='mode' value="%{#parameters.mode}" />
<s:hidden name="s_mappingConfig" value="%{#parameters.mappingid}"/>
<s:hidden name="content.type" value="COLUMNMAPPING_TYPE_FIELD"/>
<s:hidden name="stringfieldnames" />
<s:hidden name="decimalfieldnames" />
<s:hidden name="datafieldnames" />
<s:if test="hasFieldErrors()">
	<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
	<s:iterator value="fieldErrors">
		*<s:property value="value[0]" />;
	</s:iterator> </span>
</s:if>
 <div>
	   <table>
	
	   <tr id="moid"><td class="commFont">Module:</td><td><s:select  theme="simple" label="Module" name="_moduleid" list="{}" /></td></tr>
	   <tr><td class="commFont">Form:</td><td><s:select   theme="simple" label="Form" name="_formid" list="{}" /></td></tr>
	  	</table>
</div>
 
<table><tr> <td  class="tdLabel"> <div align="center"> <label class="label">　{*[Fields]*}</label>　　 
<select  name="fieldName" size="23" multiple style="width:12em" ondblclick="addItem(document.all.fieldName,document.all.fields)"> 

</select> 
</div></td> 
<td bgcolor="#FFFFFF">
   <p>
   <table align="center"  border='0'>
       <tr>
          <td>
              <div>
                 <label class="label">{*[String Type]*} </label>
			     <img src="<s:url value="/resource/image/relation2.gif"/>" alt="{*[String Type]*}">
			     
			  </div>
          </td>
       </tr>
       <tr>
          <td>
              <button type="button" class="button-image" onClick="addItem(document.all.fieldName,document.all.stringfields)"><img src="<s:url value="/resource/image/right2.gif"/>" alt="{*[add item]*}"></button>
			  
          </td>
       </tr>
       <tr>
          <td>
               <button type="button" class="button-image" onClick="delItem(document.all.fieldName,document.all.stringfields)"><img src="<s:url value="/resource/image/left2.gif"/>" alt="{*[delete item]*}"></button>
			 
          </td>
       </tr>
   </table>
   </p>
   <p>
    <table align="center"  border='0'>
           <tr>
          <td>
              <div>
                 <label class="label">{*[Decimal Type]*} </label>
			     <img src="<s:url value="/resource/image/relation2.gif"/>" alt="{*[Decimal Type]*}">
			     
			  </div>
          </td>
       </tr>
       <tr>
          <td>
              <button type="button" class="button-image" onClick="addItem(document.all.fieldName,document.all.decimalfields)"><img src="<s:url value="/resource/image/right2.gif"/>" alt="{*[add item]*}"></button>
			  
          </td>
       </tr>
       <tr>
          <td>
               <button type="button" class="button-image" onClick="delItem(document.all.fieldName,document.all.decimalfields)"><img src="<s:url value="/resource/image/left2.gif"/>" alt="{*[delete item]*}"></button>
			 
          </td>
       </tr>
   </table>
 </p>
 <p>
   <table align="center" border='0'>
             <tr>
          <td>
              <div>
                 <label class="label">{*[Date Type]*} </label>
			     <img src="<s:url value="/resource/image/relation2.gif"/>" alt="{*[Date Type]*}">
			  </div>
          </td>
       </tr>
       <tr>
          <td>
              <button type="button" class="button-image" onClick="addItem(document.all.fieldName,document.all.datafields)"><img src="<s:url value="/resource/image/right2.gif"/>" alt="{*[add item]*}"></button>
			  
          </td>
       </tr>
       <tr>
          <td>
               <button type="button" class="button-image" onClick="delItem(document.all.fieldName,document.all.datafields)"><img src="<s:url value="/resource/image/left2.gif"/>" alt="{*[delete item]*}"></button>
			 
          </td>
       </tr>
   </table>
   </p>
</td> 
<td  class="tdLabel"> <div align="center"><label class="label">{*[toName]*} </label>
 <p>
 
 <select id="stringType" name="stringfields" size="6" multiple style="width:12em" ondblClick="delItem(document.all.fieldName,document.all.stringfields)"> 
</select> 
</p>
<p>
<select id="decimalType" name="decimalfields" size="6" multiple style="width:12em" ondblClick="delItem(document.all.fieldName,document.all.decimalfields)"> 
</select> 
</p>
<p>
<select id="dataType" name="datafields" size="6" multiple style="width:12em" ondblClick="delItem(document.all.fieldName,document.all.datafields)"> 
</select> 
</p>
</div></td></tr></table>  
<table width="100%">
   <tr>
	   <td class="commFont" align="center">
			<button type="button"
				 class="button-image" onClick="ev_OK('savecolumns.action');">{*[Confirm]*}</button>
			&nbsp;
			<button type="button" class="button-image" onClick="if(parent){parent.close();}else{window.close();}">{*[Cancel]*}</button>
		</td>
	</tr>
</table>
</s:form>
</body>
<script>
  ev_select('_moduleid','_formid','fieldName');
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
   fnv = '<s:property value="fieldName"/>';
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
FormHelper.creatFormfieldsByApplicationAndModule(formName,'<s:property value="#parameters.application"/>',mv,fv,fnv,function(str) {var func=eval(str);func.call()});

}
</script>
</o:MultiLanguage></html>