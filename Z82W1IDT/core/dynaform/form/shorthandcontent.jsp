<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page buffer="50kb"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormAction" id="fa" />
<s:bean name="cn.myapps.core.dynaform.activity.action.ActivityUtil" id="au" />
<html>
<o:MultiLanguage>
<head>
<title>{*[Form]*}</title>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ActivityUtil.js"/>'></script>
<script src='<s:url value="/script/generic.js"/>'></script>
<script>
var sContentPath = '<s:url value="/"/>';
var mdlid = '<%= request.getParameter("s_module")%>';
var fn4 = 'flowlist';
var def1 = '5';
var def4='';
 ActivityUtil.crateOnActionFlow(fn4,def1,mdlid,def4,function(str) {var func=eval(str);func.call()});
function dealwithProcess()
{
 
  def4 = document.all('flowlist').value;
  if (def4==''||def4=='undefined'||def4==null){def4 = '<s:property value="flowlist"/>'};
  var isbindlen = document.all('_isbind').length;
  var flag ='0';
  for(var i=0 ;i<isbindlen;i++)
  { 
   if(document.all('_isbind')[i].checked&&document.all('_isbind')[i].value=='true')
    {
      flag ='1';
      document.all('disFlow').style.display='';
      ActivityUtil.crateOnActionFlow(fn4,def1,mdlid,def4,function(str) {var func=eval(str);func.call()});
    }
   }   
    if(flag=='0')
    {
      document.all('disFlow').style.display='none';
    }
}


function changePage(sign)
{
  if(sign=='2')
  {
    document.all('formpage').style.display = 'none';
    document.all('workflowpage').style.display ='none';
    document.all('viewpage').style.display= '';
  }else if(sign=='3')
  {
    document.all('formpage').style.display = 'none';
    document.all('workflowpage').style.display ='';
    document.all('viewpage').style.display= 'none';
  }else if(sign=='1')
  {
    document.all('formpage').style.display = '';
    document.all('workflowpage').style.display ='none';
    document.all('viewpage').style.display= 'none';
  }
}

function viewcheck()
{
   var flag ='';
   if(document.all('viewname').value=='')
   {flag= 'Please enter the viewname!'};
   if(document.all('description').value=='')
   {flag= flag+'plealse enter the description'};
   if(flag=='')return '';
   else return flag ;
}
</script>
<title>Register result</title>
<script>
</script>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0 onload="dealwithProcess()">
<table border=0 width=98% height=80% valign='top'cellpadding="0" cellspacing="0"  >
	<s:form action="save" method="post" theme="simple">
 <%@include file="/common/page.jsp"%>
 <s:hidden name='content.version'></s:hidden>
 			<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper"
				id="vh">
				<s:param name="moduleid" value="#parameters.s_module" />
			</s:bean>
 <s:hidden name="_resourceid" />
		<input type="hidden" name="applicationid" value="<s:property value='#session.APPLICATION'/>">
		<input type="hidden" name="s_application" value="<s:property value='#session.APPLICATION'/>">
		<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">
		<input type="hidden" name="moduleid" value="<s:property value='#parameters.s_module'/>">
      <s:if test="hasFieldErrors()">
	<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
	<s:iterator value="fieldErrors">
		*<s:property value="value[0]" />;
	</s:iterator> </span>
    </s:if>
		<tr valign="top"  >
			<td colspan="6"  valign="top"  >
			 <div id="formpage" valign="top"  >
				<table width='100%' valign="top"  >
				<tr>
				<td colspan="2">
                 <table width="98%" class="list-table" valign="top" >
	                <tr class="list-toolbar">
		               <td width="10" class="image-label"><img
			                src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		               <td width="3"></td>
		             <td width="70" class="text-label">{*[Form]*}</td>
		            <td>
		             <table width="100%" border=1 cellpadding="0" cellspacing="0" 
			             class="line-position" valign="top">
			           <tr >
				     <td></td>
				    <td class="line-position2" width="70" valign="top">
				     </td>
			       </tr>
		        </table>
		        </td>
	            </tr>
            </table>
            </td>
				</tr>
					<tr  >
					<td class="commFont"  >{*[Name]*}:</td><td align="left"><s:textfield cssClass="input-cmd"  name="content.name" theme="simple"/></td>
						
						</tr>
						<tr>
						<td class="commFont" >{*[Type]*}:</td><td align="left"><s:select name="content.type" list="_FORMTYPE" theme="simple" /></td>		
						</tr>
						<tr>
						<td class="commFont"  >{*[Operator]*}:</td><td align="left"><s:checkboxlist  name="_formact" list="_FORMACLIST" theme="simple"/></td>
					</tr>
						<tr>
						<td  class="commFont" >{*[CreateField]*}:</td><td align="left"><input type="radio" name="disField" value="ture" />Yes  <input type="radio" name="disField" value="false" checked="ture"/>No</td>
										
					</tr>
					<tr>
						<td  class="commFont" >{*[Example]*}:</td><td align="left"> Test1:<s:textfield cssClass="input-cmd"  name="test" readonly="true" theme="simple"/>   Test2:<s:textfield cssClass="input-cmd"  name="test2" readonly="true" theme="simple"/></td>
					</tr>				
				</table>
				<table>
			<tr align="center">
			 <td ><button type="button" width="80px" onClick="if(document.all('content.name').value==''){alert('Please enter the form name!');return false;};changePage(2)">{*[Next]*}</button></td>
			<td> <button type="button"  width="80px" onClick="if(document.all('content.name').value==''){alert('Please enter the form name!');return false;};forms[0].action='<s:url action="saveShortHand"></s:url>';forms[0].submit();">{*[Complete]*}</button></td>
			<td> <button type="button"  width="80px" onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();">{*[Cancel]*}</button>
			 </td>
			</tr>
			</table>
				</div> 
			</td>
				
      </tr>
      	<tr  valign="top" >
        <td valign="top" colspan="4"  >
         <div  valign="top" id="viewpage" style="display:none" > 
				<table width='100%'  valign="top" cellpadding="0" cellspacing="0" >
                <tr>
				<td colspan="2">
                 <table width="98%" class="list-table" valign="top"  >
	                <tr class="list-toolbar">
		               <td width="10" class="image-label"><img
			                src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		               <td width="3"></td>
		             <td width="70" class="text-label">{*[View]*}</td>
		            <td>
		             <table width="100%" border=1 cellpadding="0" cellspacing="0"
			             class="line-position" valign="top">
			           <tr >
				     <td></td>
				     <td class="line-position2" width="60" valign="top">
				    <!--  <button type="button" class="back-class"
					    onClick="changePage(1)">{*[Return]*}</button> -->
				      </td>
				    <td class="line-position2" width="70" valign="top">
				   <!-- <button type="button" class="back-class"
					  onClick="if(viewcheck()==''){changePage(3); }else{alert(viewcheck());return false;}">{*[Next]*}</button> -->
				     </td>
			       </tr>
		        </table>
		        </td>
		        </tr>
		        </table>
	            </tr>
           <tr><td class="commFont">{*[Name]*}:</td><td align="left"><s:textfield cssClass="input-cmd" theme="simple" name="viewname" /></td></tr>
           <tr><td class="commFont">{*[Description]*}:</td><td align="left"><s:textfield cssClass="input-cmd" theme="simple" name="description" /></td></tr>
		   <tr><td class="commFont">{*[Superior]*}:</td><td align="left"><s:select cssClass="input-cmd" theme="simple" name="superiorid" list="#vh.get_MenuTree(#session.APPLICATION)" /></td></tr>
		   <tr><td class="commFont">{*[Open type]*}:</td><td align="left"><s:select label="{*[Open type]*}" name="opentype"  theme="simple" list="_OPENTYPE" /></td></tr>
			<tr><td class="commFont">{*[Operator]*}:</td><td align="left"><s:checkboxlist  name="_viewact" list="_VIEWACLIST" theme="simple"/></td></tr>
           </table>
           <table>
			<tr align="center">
			 <td><button type="button" 
					    onClick="changePage(1)">{*[Return]*}</button></td>
			<td> <button type="button" onClick="if(viewcheck()==''){changePage(3); }else{alert(viewcheck());return false;}">{*[Next]*}</button> </td>
			 <td><button type="button"  width="80px" onClick="if(viewcheck()==''){ }else{alert(viewcheck());return false;};forms[0].action='<s:url action="saveShortHand"></s:url>';forms[0].submit();">{*[Complete]*}</button></td>
			<td> <button type="button"  width="80px" onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();">{*[Cancel]*}</button>
			 </td>
			</tr>
			</table>
            </div> 
           </td>
      </tr>
            	<tr valign="top"  >
        <td colspan="4"  valign="top" >
        <div id="workflowpage" valign="top" style="display:none" >
				<table width='100%'  cellpadding="0" cellspacing="0">
				<tr>
				<td colspan="2">
                 <table width="98%" class="list-table" >
	                <tr class="list-toolbar">
		               <td width="10" class="image-label"><img
			                src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		               <td width="3"></td>
		             <td width="70" class="text-label">{*[workflow]*}</td>
		            <td>
		             <table width="100%" border=1 cellpadding="0"  cellspacing="0"
			             class="line-position">
			           <tr >
				     <td></td>
				     <td class="line-position2" width="60" valign="top">
				    <!--  <button type="button" class="back-class"
					    onClick="changePage(2)">{*[Return]*}</button> -->
				      </td>
				    <td class="line-position2" width="70" valign="top">
				  <!--  <button type="button" class="back-class"
					  onClick="if(document.all('workflowname').value==''){alert('Please enter the workflowname!');return false;};forms[0].action='<s:url action="saveShortHand"></s:url>';forms[0].submit();">{*[Complete]*}</button>
				     --></td>
			       </tr>
		        </table>
		        </td>
	            </tr>
	            </table>
	            </td>
           <tr><td class="commFont">{*[Name]*}:</td><td align="left"><s:textfield cssClass="input-cmd" theme="simple" name="workflowname" /></td></tr>
           <tr><td class="commFont">{*[Bind the form]*}:</td><td align="left"><input type="radio" name="_isbind" onclick  ="dealwithProcess()" value="true" />Yes  <input type="radio" name="_isbind" value="false" onclick  ="dealwithProcess()" checked="ture"/>No</td></tr>
           <tr id="disFlow"><td class="commFont" ></td><td align="left"><input type="radio" name="_bindto"  value="true" />The created form  <input type="radio" name="_bindto" value="false" checked="ture"/>{*[Select existed form]*}<s:select label="{*[Type]*}" name="flowlist" list="{}" theme="simple" /></td></tr>
			</table>
			<table>
			<tr align="center">
			 <td>
			 <button type="button" 
					    onClick="changePage(2)">{*[Return]*}</button></td>
			 <td><button type="button" onClick="if(document.all('workflowname').value==''){alert('Please enter the workflowname!');return false;};forms[0].action='<s:url action="saveShortHand"></s:url>';forms[0].submit();">{*[Complete]*}</button></td>
			 <td><button type="button"  width="80px" onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();">{*[Cancel]*}</button>
			 </td>
			</tr>
			</table>
			</div>
			</td>
      </tr>
	</s:form>
</table>
</body>
</o:MultiLanguage>
</html>
