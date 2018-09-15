<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script language="JavaScript" type="text/javascript">
	function ev_load() {
		var ExportDocsNum='<s:property value="ExportDocsNum"/>';
		if(ExportDocsNum!=null&&ExportDocsNum!='') alert("Derive "+'<s:property value="ExportDocsNum"/>'+" data altogether");
	}
</script>
<title>{*[Column List]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<s:if test="hasFieldErrors()">
	<span class="errorMessage"><br>
	<s:iterator value="fieldErrors">
	<script>
		window.setTimeout("alert('* '+'<s:property value="value[0]" />,Can not to delete')",200);
		</script>
	</s:iterator> </span>
</s:if>	
</head>
<body onload="ev_load()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<s:form name="formList" action="list" method="post">
<s:hidden name="mappingid"/>
<s:hidden name="s_mappingConfig" value="%{#parameters.mappingid}"/>
<s:hidden name="_moduleid" value ="%{#parameters.s_module}"/>
<s:hidden name="s_module" value ="%{#parameters.s_module}"/>
<s:hidden name="mode" value = "%{#parameters.mode}"/>
<%@include file="/common/list.jsp"%>
   <table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
          <tr>
            <td width="12"><img src='<s:url value="/resource/img/hen01.gif"/>' width="12" height="28" /></td>
            <td width="12" height="28" background='<s:url value="/resource/img/hen02.gif"/>'><img src='<s:url value="/resource/img/dian.gif"/>' width="12" height="12" /></td>
            <td align="right" background='<s:url value="/resource/img/hen02.gif"/>'><table width="320" border="0" cellspacing="0" cellpadding="0">
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
                <td width="6" align="left"><img src='<s:url value="/resource/img/hen03b.gif"/>' width="6" height="28" /></td>
                <td width="23" align="left">
                <button type="button"  class="backbutton-class" height="20px" onClick="forms[0].action='<s:url action="exportAllDocument"></s:url>';forms[0].submit();"> <img src='<s:url value="/resource/img/new.gif"/>'/></button>
                </td>
                <td width="47" align="left" style="font-size:14px;">{*[AllExport]*}</td>
                <td width="6" align="left"><img src='<s:url value="/resource/img/hen03b.gif"/>' width="6" height="28" /></td>
                <td width="23" align="left">
                <button type="button"  class="backbutton-class" height="20px" onClick="forms[0].action='<s:url action="IncrementExportDocument"></s:url>';forms[0].submit();"> <img src='<s:url value="/resource/img/new.gif"/>'/></button>
                </td>
                <td width="47" align="left" style="font-size:14px;">{*[IncrementExport]*}</td>
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
<table border="0" width="99%" theme="simple" align="center" cellpadding="2" cellspacing="0"
		width="100%">
		<tr>
			<td class="column-head" scope="col" width="28"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[Name]*}</o:OrderTag></td>
			</tr>
	<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text2">
			</s:if>
			<s:else>
				<tr class="table-text">
			</s:else>
  	 	<td class="table-td">
  	 	<input type="checkbox" name="_selects" value='<s:property value="id"/>'/></td>
  	 	<td><a href='<s:url value="edit.action">
  	 	       <s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="_moduleid" value="%{#parameters.s_module}" />
				<s:param name="mode" value="%{#parameters.mode}" />
				<s:param name="id" value="id"/>
  	 				 </s:url>'>
  	 		<s:property value="name"/></a>
  	 				
  	 				 </td>
 		</tr>
    </s:iterator>
</table>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
		</tr>
	</table>
</body>
</s:form>
</o:MultiLanguage></html>