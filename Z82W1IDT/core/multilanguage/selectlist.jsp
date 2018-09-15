<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.multilanguage.action.MultiLanguageHelper"%>
 <s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<title>{*[MultiLanguages]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src="<s:url value="/script/list.js"/>"></script>
<script src="<s:url value='/script/help.js'/>"></script>
<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="selectdelete"/>';
    	listform.submit();
    }
}


function doSelect(label){
	OBPM.dialog.doReturn(label);
}
jQuery(document).ready(function(){
	//inittab();
	cssListTable();
	if(typeof(window.top.toThisHelpPage) == "function"){
		window.top.toThisHelpPage("domain_multiLanguages_list");
	}
});
</script>
</head>
<body id="domain_multiLanguages_list" class="listbody">
<div>
<s:form theme="simple" name="formList" action="selectlist" method="post">
	<%@include file="/common/list.jsp"%>
	<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">
	<!-- applicationid for new-->
	<input type="hidden" name="applicationid" value="<s:property value='#parameters.id'/>">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr class="nav-s-td" >
		<td class="nav-s-td" align="right">
			<table class="table_noborder">
				<tr><td>
					<div style="text-align: right;min-width:280px">
						<img style="vertical-align: middle;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" id="delete_Language" title="{*[Delete]*}{*[Language]*}" class="justForHelp button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
						<button type="button" class="button-image" onClick="OBPM.dialog.doReturn('');">
							<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Cancel]*}
						</button>
					</div>
				</td></tr>
			</table>
		</td>
	</tr>
</table>
	<div id="main">
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[Search]*}{*[Language]*}">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Label]*}:	<input class="input-cmd" type="text" name="sm_label" value='<s:property value="#parameters['sm_label']" />' size="18" />
					{*[Text]*}：	<input class="input-cmd" type="text" name="sm_text" value='<s:property value="#parameters['sm_text']"  />' size="18" />
					{*[Type]*}：<s:select label="{*[Type]*}" name="sm_type" theme="simple" list="#mh.getTypeList()" emptyOption="true" />
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
				</td></tr>
			</table>
		</div>
		
		<div id="contentTable">	
		 	<table class="table_noborder">
			   	<tr>
			   		<td class="column-head2" scope="col"><input type="checkbox" onclick="selectAll(this.checked)"></td>
			   		<td class="column-head"><o:OrderTag field="label" css="ordertag">{*[Label]*}</o:OrderTag></td>
					<td class="column-head"><o:OrderTag field="text" css="ordertag">{*[Text]*}</o:OrderTag></td>
					<td class="column-head"><o:OrderTag field="type" css="ordertag">{*[Type]*}</o:OrderTag></td>
					<td class="column-head">{*[Edit]*}</td>
				</tr>
				<s:iterator value="datas.datas" status="index">
						<tr>
				   	 	<td class="table-td">
			  	 	<input type="checkbox" name="_selects" value='<s:property value="id"/>'/></td>
			  	 	<td><a href="javascript:doSelect('<s:property value="label" />')" />
			  	 			<s:property value="label" />
			  	 		</a></td>
			 			<td>
			 				<s:property value="text" />
			 			</td>
			 			<td>
			 				<s:set id="type" name="type"/>
			  	 			<% 
			  	 			int type = ((Integer)request.getAttribute("type")).intValue();
			  	 			String name = new MultiLanguageHelper().getTypeName(type);
			  	 			out.print(name);
			  	 			%>
			 			</td>
			 			<td>
			 				<a href='<s:url value="selectedit.action">
			 						<s:param name="id" value="id"/>
			  	 					<s:param name="applicationid" value='#parameters.id'/>
			  	 					<s:param name="_currpage" value="datas.pageNo" />
									<s:param name="_pagelines" value="datas.linesPerPage" />
									<s:param name="_rowcount" value="datas.rowCount" />
									<s:param name="domain" value='#parameters.domain'/>
			  	 					<s:param name="s_module" value='#parameters.s_module'/>
			  	 					<s:param name="application" value='#parameters.application'/>
			  	 					<s:param name="sm_label" value="#parameters.sm_label"/>
			  	 					<s:param name="sm_text" value="#parameters.sm_text"/>
			  	 					<s:param name="sm_type" value="#parameters.sm_type"/>
			 				</s:url>'><span class="button-image">{*[Edit]*}</span></a>
			 			</td>
			 		</tr>
			   </s:iterator>
		</table>
		</div>

		<table class="table_noborder">
			<tr>
		    	<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
		  	</tr>
		</table>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>