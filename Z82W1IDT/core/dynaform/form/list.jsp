<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<o:MultiLanguage>
<HTML>

<head>
<title>{*[Form]*}{*[List]*}</title>

<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script>
     wx = '600px';
	 wy = '400px';
function CreateForm(){
      var url="<s:url value='new.action'><s:param name='_currpage' value='datas.pageNo' /><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name='_rowcount' value='datas.rowCount' /><s:param name='s_module' value='#parameters.s_module'/><s:param name='s_application' value='#parameters.application'/></s:url>";
      var id=showframe("Form",url);
	  var formurl="<s:url action='edit'><s:param name='_currpage' value='datas.pageNo' /><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name='_rowcount' value='datas.rowCount' /><s:param name='s_application' value='#parameters.application'/><s:param name='s_module' value='#parameters.s_module'/></s:url>";
	  if(id!=null){
		formurl += '&id=' +id;
		window.location.replace(formurl);
	  }

}

function doDelete(){
	var listform = document.forms["formList"];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	if(confirm("{*[cn.myapps.core.dynaform.form.delete_current_form]*}?"))
		 {
			 listform.action='<s:url action="delete"/>';
		     listform.submit();
		 }
    }
}
function adjustDataIteratorSize() {
	var containerHeight = document.body.clientHeight-50;
	var container = document.getElementById("main");
	container.style.height = containerHeight + 'px';
}	
jQuery(document).ready(function(){
	cssListTable();
	adjustDataIteratorSize();
	window.top.toThisHelpPage("application_module_form_list");
});
</script>
</head>
<body id="application_module_form_list" class="body-back">
<s:actionerror />
<s:form name="formList" action="list" method="post" theme="simple">
<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">
<%@include file="/common/list.jsp"%>

<table cellpadding="0" cellspacing="0" style="width:100%">
	<tr>
		<td class="nav-s-td">{*[Form]*}{*[List]*}</td>
		<td class="nav-s-td" align="right">
		<table  width="120" border=0 cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top">
					<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
				</td>
				<td valign="top">
					<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
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
<div id="main" style="overflow-y:auto;overflow-x:hidden;"> 
	<div id="searchFormTable">
	<table class="table_noborder">
		<tr>
			<td class="head-text">
			{*[Name]*}:
			<input class="input-cmd" type="text" name="sm_name"
				value='<s:property value="#parameters['sm_name']"/>' size="10" />
			<input class="button-cmd" type="submit"  value="{*[Query]*}" />
			<input class="button-cmd" type="button" value="{*[Reset]*}"
				onclick="resetQuery()" />
			</td>
		</tr>
	</table>
	</div>
  <div id="contentTable" style="margin: 0;padding: 0;">
	  <table class="table_noborder">
	   	<tr>
	   		<td class="column-head2" scope="col"><input type="checkbox" onclick="selectAll(this.checked)"></td>
	   		<td class="column-head"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></td>
			<td class="column-head" ><o:OrderTag field="type" css="ordertag">{*[Type]*}</o:OrderTag></td>
			<td class="column-head" ><o:OrderTag field="discription" css="ordertag">{*[Description]*}</o:OrderTag></td>
		</tr>
	    <s:iterator value="datas.datas" status="index">
				<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id" />"></td>
					<td ><a
						href="<s:url action="edit"><s:param name="_currpage" value="datas.pageNo" />
					<s:param name="_pagelines" value="datas.linesPerPage" />
					<s:param name="_rowcount" value="datas.rowCount" />
					<s:param name="application" value='#parameters.application'/>	
					<s:param name="s_module" value='#parameters.s_module'/>
					<s:param name="id" value="id"/>
					<s:param name="orderno" value="orderno"/>
					<s:param name="sm_name" value="#parameters.sm_name"/>
					</s:url>">
					<s:property value="name" /></a></td>
					<td>{*[<s:property value="typeName" />]*}</td>
					<td><s:property value="discription" /></td>
				
				</tr>
			</s:iterator>
		</table>
	</div>
	<table class="table_noborder">
	  <tr>
	    <td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag"/></td>
	  </tr>
	</table>
</div>
</s:form>
</body>

</html>
</o:MultiLanguage>