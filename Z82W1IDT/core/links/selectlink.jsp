<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage>
<head>
<title>{*[Links]*}</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function doSelect(id,name,type){
	var link=new Object();
	link.id=id;
	link.name=name;
	link.type=type;
	OBPM.dialog.doReturn(link);
}

function doEmpty(){
	var link = new Object();
    link.id = "";
    OBPM.dialog.doReturn(link);
}

function doNew(){
	document.forms[0].action='<s:url action="new2"/>';
	document.forms[0].submit();
}

function editLink(url){
	if(url!=""){
		var sm_name = document.getElementsByName("sm_name")[0].value;
		var s_type = document.getElementById("s_type").value;
		window.location.href=url + "&sm_name=" + sm_name + "&s_type=" + s_type;
	}
}

function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="deleteByselectList"/>';
    	listform.submit();
    }
}

jQuery(document).ready(function(){
	window.top.toThisHelpPage("application_info_generalTools_links_list");
});

</script>
</head>
<body class="body-back">
<s:form name="formList" action="selectlink" method="post" theme="simple">
<%@include file="/common/list.jsp"%>	
<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">

<table cellpadding="0" cellspacing="0" style="width:100%">
	<tr>
		<td class="nav-s-td">{*[cn.myapps.core.dynaform.links.list]*}</td>
		<td class="nav-s-td">
			<table width="240px" align="right" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td width="50" valign="top" align="right">
						<button type="button" class="button-image" onClick="doNew()">
							<img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
					</td>
					
					<td width="50" valign="top" align="right">
						<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
					</td>
				
					<td width="50" valign="top" align="right">
						<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();">
							<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Cancel]*}</button>
					</td>
					
					<td width="50" valign="top" align="right">
						<button type="button" class="button-image" onClick="doEmpty()">
							<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Clear]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0">
	<tr>
		<td width="35%">
		{*[Name]*}:
		<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>'
				 />
		</td>
		<td width="25%">
		{*[Type]*}:
		<s:select name="s_type" id="s_type" value="#parameters['s_type']" theme="simple" emptyOption="true" list="#{'00':'{*[Form]*}','01':'{*[View]*}','03':'{*[cn.myapps.core.dynaform.links.excel_import]*}','05':'{*[cn.myapps.core.dynaform.links.customize_links_internal]*}','06':'{*[cn.myapps.core.dynaform.links.customize_links_External]*}','08':'{*[cn.myapps.core.resource.email_links]*}'}"/>
		</td>
		<td class="head-text">
			<input class="button-cmd" type="submit"  value="{*[Query]*}" />
			<input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()" />
		</td>
	</tr>
</table>

<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table border="0" width="100%" align="center" cellpadding="2" cellspacing="2">
		<tr >
			<th class="column-head" scope="col" width="30px"><o:OrderTag field="name" css="ordertag"></o:OrderTag></th>
			<th class="column-head" scope="col"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></th>
			<th class="column-head" scope="col"><o:OrderTag field="type" css="ordertag">{*[Type]*}</o:OrderTag></th>
			<th class="column-head" scope="col"><o:OrderTag field="description" css="ordertag">{*[Description]*}</o:OrderTag></th>
			<th class="column-head" scope="col"><o:OrderTag field="type" css="ordertag">{*[Activity]*}</o:OrderTag></th>
		</tr>
		<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
				<td class="table-td"><input type="checkbox" name="_selects" value="<s:property value="id" />"></td>
				<td>
					<a href="javascript:doSelect('<s:property value="id" />','<s:property value="name" />','<s:property value="type" />')">
						<s:property value="name" />
					</a>
				</td>
				<td>
					<a href="javascript:doSelect('<s:property value="id" />','<s:property value="name" />','<s:property value="type" />')">
						<s:if test="type==0">{*[Form]*}</s:if>
						<s:elseif test="type==1">{*[View]*}</s:elseif>
						<s:elseif test="type==2">{*[cn.myapps.core.dynaform.links.report]*}</s:elseif>
						<s:elseif test="type==3">{*[cn.myapps.core.dynaform.links.excel_import]*}</s:elseif>
						<s:elseif test="type==4">{*[Action]*}</s:elseif>
						<s:elseif test="type==5">{*[cn.myapps.core.dynaform.links.customize_links_internal]*}</s:elseif>
						<s:elseif test="type==6">{*[cn.myapps.core.dynaform.links.customize_links_External]*}</s:elseif>
						<s:elseif test="type==7">{*[Script]*}</s:elseif>
						<s:elseif test="type==8">{*[cn.myapps.core.dynaform.links.email_links]*}</s:elseif>
						<s:elseif test="type==9">{*[cn.myapps.core.dynaform.links.customize_report]*}</s:elseif>
					</a>
				</td>
				<td>
					<a href="javascript:doSelect('<s:property value="id" />','<s:property value="name" />','<s:property value="type" />')">
						<s:property value="description" />
					</a>
				</td>
				<td width="50px">
					<button type="button" onclick="editLink('<s:url value="edit2.action"><s:param name="id" value="id"/><s:param name="_currpage" value="datas.pageNo" /><s:param name="_pagelines" value="datas.linesPerPage" /><s:param name="_rowcount" value="datas.rowCount" /><s:param name="application" value="#parameters.application" /><s:param name="tab" value="1" /><s:param name="selected" value="%{'btnLinks'}" /></s:url>')" type="button">{*[Edit]*}</button>
				</td>
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
