<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<html><o:MultiLanguage>
<head>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<title>{*[Helpers]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
</head>
<body leftmargin="25" align="left">

<s:form name="formList" action="list" method="post">
	<%@include file="/common/list.jsp"%>
	<table width="98%">
		<tr>
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="70" class="text-label">{*[Helper]*}</td>
			<td>
			<table width="100%" border=1 cellpadding="0" cellspacing="0"
				class="line-position">
				<tr>
					<td></td>
					<td class="line-position2" width="60" valign="top">
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
					</td>
					<td class="line-position2" width="70" valign="top">
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="delete"/>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
<%@include file="/common/msg.jsp"%>	
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<table>
		<tr>
			<td class="head-text">{*[Title]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_title"
				value='<s:property value="#parameters['sm_title']" />' size="10" /></td>
			<td class="head-text">{*[MappintUrl]*}:</td>
			<td><input cssClass="input-cmd" theme="simple" value='<s:property value="#parameters['sm_url']" />'
		      name="sm_url"/>
	      </td>
	      <td class="head-text">{*[Content]*}：</td>
			<td><input cssClass="input-cmd" theme="simple" value='<s:property value="#parameters['sm_context']" />'
		      name="sm_context"/>
	      </td>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" /></td>
		<tr>
	</table>
	<table class="list-table" border="0" cellpadding="2" cellspacing="0"
		width="100%">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="title"
				css="ordertag">{*[Title]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="url"
				css="ordertag">{*[MappingUrl]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="context"
				css="ordertag">{*[Content]*}</o:OrderTag></td>
		</tr>
		<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
			<td class="table-td"><input type="checkbox" name="_selects"
				value="<s:property value="id"/>"></td>
			<td><a
				href="javascript:document.forms[0].action='<s:url action="edit">
				<s:param name="id" value="id"/></s:url>';
				document.forms[0].submit();">
				<s:property value="title" /></a></td>
			<td><s:property value="url" /></td>
				<td><s:property value="context.length()>20?context.substring(0,20):context" /></td>
			</tr>
		</s:iterator>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
				css="linktag" /></td>
		</tr>
	</table>
	<div>
</s:form>
<script>
</script>
</body>
</o:MultiLanguage></html>
