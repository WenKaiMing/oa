<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<head>
<title>{*[ImageLibs]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0 >
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="ApplicationHelper" />
<script>
</script>
<s:actionerror />
<s:form name="formList" action="list" method="post">
<%@include file="/common/list.jsp"%>
<s:hidden name="_moduleid" value="%{#parameters.s_module}" />
<s:hidden name="s_module" value="%{#parameters.s_module}" />

<s:hidden name="mode" value="%{#parameters.mode}" />

   <table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
          <tr>
            <td width="12"><img src='<s:url value="/resource/img/hen01.gif"/>' width="12" height="28" /></td>
            <td width="12" height="28" background='<s:url value="/resource/img/hen02.gif"/>'><img src='<s:url value="/resource/img/dian.gif"/>' width="12" height="12" /></td>
            <td align="right" background='<s:url value="/resource/img/hen02.gif"/>'><table width="160" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="7" align="left"><img src='<s:url value="/resource/img/hen03.gif"/>' width="6" height="28" /></td>
                <td width="26" align="left">
                <button type="button" class="backbutton-class" height="20px" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src='<s:url value="/resource/img/new.gif"/>' width="18" height="20" /></button>
                </td>
                <td width="47" align="left" style="font-size:14px;">{*[New]*}</td>
                <td width="6" align="left"><img src='<s:url value="/resource/img/hen03b.gif"/>' width="6" height="28" /></td>
                <td width="23" align="left">
                <button type="button"  class="backbutton-class" height="20px" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();"> <img src='<s:url value="/resource/img/delete.gif"/>'/></button>
               
                </td>
                <td width="47" align="left" style="font-size:14px;">{*[Delete]*}</td>
              </tr>
            </table></td>
            <td width="8"><img src='<s:url value="/resource/img/hen05.gif"/>' width="8" height="28" /></td>
          </tr>
        </table>	
 <div class="datalist">
 <%@include file="/common/msg.jsp"%>	
 <s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
 <table border="0" width="99%" theme="simple" align="center"  id="dspQuery">
		<tr>
			<td></td>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>'
				size="10" /></td>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()"/></td>
		<tr>
	</table>
	

<table  border="0" cellpadding="2" cellspacing="0" align="center" 
		width="99%">
		<tr>
			<td class="column-head" scope="col" width="28"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[Name]*}</o:OrderTag></td>
			
			<td class="column-head" scope="col"><o:OrderTag field="content"
				css="ordertag">{*[Image]*}</o:OrderTag></td>

		</tr>

		<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text2">
			</s:if>
			<s:else>
				<tr class="table-text">
			</s:else>
			<td class="table-td"><input type="checkbox" name="_selects"
				value="<s:property value="id" />"></td>
			<td ><a
				href="<s:url action="edit"><s:param name="id" value="id"/>
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="mode" value="#parameters.mode" />
			     <s:param name="_moduleid" value="#parameters.s_module" />
				</s:url>">
			<s:property value="name" /></a></td>
			<td><s:property value="content" /></td>
			</tr>
		</s:iterator>
	</table>
	</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
				css="linktag" /></td>
		</tr>
	</table>
</s:form>

</body>
<script>
   if(document.getElementById('mode').value=='module'||document.getElementById('mode').value=='application')
   {
     document.getElementById('dspQuery').style.display ='none';
   }

</script>
</html>
