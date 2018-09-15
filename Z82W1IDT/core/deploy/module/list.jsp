<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.deploy.customized_module]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
</head>
<body>
<table width="100%"  class="list-table" >
		<tr class="list-toolbar">
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="140" class="text-label">{*[cn.myapps.core.deploy.module.customized_module]*}</td>
			<td>
			<table width="100%" border=1 cellpadding="0" cellspacing="0" class="line-position" ><tr><td ></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="back-class" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
				</td>
				<td class="line-position2" width="70" valign="top">
				<button type="button" class="back-class" onClick="forms[0].action='<s:url action="delete"/>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</td>
			</tr></table>
			</td>
		</tr>
	</table>
<table>

<s:form name="formList" action="list" method="post">
<%@include file="/common/list.jsp"%>	
<%@include file="/common/msg.jsp"%>	
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table class="list-table" border="0" cellpadding="2" cellspacing="0"
		width="100%">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[cn.myapps.core.deploy.module.module_name]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag field="pathname"
				css="ordertag">{*[cn.myapps.core.deploy.module.path]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag field="description"
				css="ordertag">{*[Description]*}</o:OrderTag></td>
			</tr>
      <s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
			<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id" />"></td>
				<td ><a
					href="<s:url action="edit">
					<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
					<s:param name="id" value="id"/></s:url>"><s:property
					value="name" /></a></td>
					<td><s:property value="pathname" /></td>
			<td><s:property value="description" /></td>
			</tr>
		</s:iterator>
	</table>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
