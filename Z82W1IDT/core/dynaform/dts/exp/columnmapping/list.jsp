<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script language="JavaScript" type="text/javascript">
	function ev_load() {
		//if (formList.viewid.value=='') {
		//	document.all.toolbar.style.display = 'none';
		//}
	}
</script>
<script language="JavaScript">
  function CreateMapColumns(){
      var url="<s:url value='newcolumns.action'><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name='_rowcount' value='datas.rowCount' /><s:param name='id' value='id'/><s:param name='mappingid' value='mappingid'/></s:url>'>";
       wx = '450px';
	   wy = '520px';
	   showframe("Column",url);
	 document.location.reload();
	}
</script>
<title>{*[Column List]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<body onload="ev_load()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<s:form name="formList" action="list" method="post">
<s:hidden name="mappingid"/>
<s:hidden name="_applicationid" value="%{#parameters.application}"/>
<s:hidden name="_moduleid" value="%{#parameters.s_module}"/>
<s:hidden name="mode" value="%{#parameters.mode}"/>
<s:hidden name="s_mappingConfig" value="%{#parameters.mappingid}"/>
<%@include file="/common/list.jsp"%>
<table width="98%" >
		<tr>
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="130" class="text-label">{*[ColumnMapping]*}</td>
			<td>
			<table width="100%" border=1 cellpadding="0" cellspacing="0" class="line-position" ><tr >
			<td></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
				</td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="button-image" onClick="CreateMapColumns();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[NewColumnMappingGuide]*}</button>
				</td>
				<td class="line-position2" width="70" valign="top">
				<button type="button" class="button-image" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</td>
			</tr></table>
			</td>
		</tr>
	</table>
<table>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table class="list-table" border="0" cellpadding="2" cellspacing="0"
		width="100%">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="fromName"
				css="ordertag">{*[FromName]*}</o:OrderTag></td>
			</tr>
	<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
  	 	<td class="table-td">
  	 	<input type="checkbox" name="_selects" value='<s:property value="id"/>'/></td>
  	 	<td><a href='<s:url value="edit.action">
  	 	       <s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="id" value="id"/>
  	 			<s:param name="mappingid" value="mappingid"/>
			 </s:url>'>
  	 		<s:property value="toName"/></a>
  	 				
  	 				 </td>
 		</tr>
    </s:iterator>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
		</tr>
	</table>
</body>
</s:form>
</o:MultiLanguage></html>