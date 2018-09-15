<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<title>{*[CommonInfo]*}{*[List]*}</title>
</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
<s:form name="formList" action="list" method="post">
<%@include file="/common/list.jsp"%>
<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">
<table width="98%" class="list-table">
		<tr >
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="100" class="text-label">{*[CommonInfo]*}</td>
			<td>
			<table width="100%" border=1 cellpadding="0" cellspacing="0" class="line-position" ><tr><td ></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="workflow-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
				</td>
				<td  class="line-position2" width="70" valign="top">
				<button type="button" class="workflow-image" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</td>
			</tr></table>
			</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
	<%@include file="/portal/share/common/msgbox/msg.jsp"%>
	</s:if>
<table>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td class="head-text">{*[Type]*}</td>
			<td><input class="input-cmd" type="text" name="sm_type" value='<s:property value="#parameters['sm_type']" />'
				 /></td>
			<td class="head-text">{*[Code]*}</td>
			<td><input class="input-cmd" type="text" name="sm_code" value='<s:property value="#parameters['sm_code']" />'
				 /></td>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()"/></td>
		<tr>
	</table>	

 <table width="100%" class="list-table">
   	<tr class="column-head" scope="col">
   		<td class="column-head2" width="30"><input type="checkbox" onclick="selectAll(this.checked)"></td>
   		<td class="column-head"><o:OrderTag field="type" css="ordertag">{*[Type]*}</o:OrderTag></td>
		<td class="column-head"><o:OrderTag field="code" css="ordertag">{*[Code]*}</o:OrderTag></td>
		<td class="column-head"><o:OrderTag field="value" css="ordertag">{*[Value]*}</o:OrderTag></td>
		<td class="column-head"><o:OrderTag field="orderNo" css="ordertag">{*[OrderNo]*}</o:OrderTag></td>
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
  	 					<s:param name="id" value="id"/>
  	 					<s:param name="_currpage" value="datas.pageNo" />
						<s:param name="_pagelines" value="datas.linesPerPage" />
						<s:param name="_rowcount" value="datas.rowCount" />
  	 					<s:param name="s_module" value='#parameters.s_module'/>
  	 				 </s:url>'>
  	 			<s:property value="type" />
  	 		</a></td>
 			<td>
 				<s:property value="code" />
 			</td>
 			<td>
 				<s:property value="value" />
 			</td>
 			<td>
 				<s:property value="orderNo" />
 			</td>
 		</tr>
    </s:iterator>
</table>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag"/></td>
  </tr>
</table>
</body>
</s:form>
</o:MultiLanguage></html>