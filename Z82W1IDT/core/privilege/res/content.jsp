<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@include file="/common/tags.jsp"%>
<%@ include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[Resources]*}{*[Info]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
</head>
<script>
var contextPath='<%= request.getContextPath() %>';
	function ev_onload() {
		<s:if test="content.type==0">
			document.getElementsByName("content.type")[0].value="0";
	    </s:if>
		<s:elseif test="content.type==1">
			document.getElementsByName("content.type")[0].value="1";
		</s:elseif>
		<s:elseif test="content.type==2">
			document.getElementsByName("content.type")[0].value="2";
	     </s:elseif>
		<s:elseif test="content.type==3">
			document.getElementsByName("content.type")[0].value="3";
		</s:elseif>
		<s:elseif test="content.type==4">
			document.getElementsByName("content.type")[0].value="4";
		</s:elseif>
		<s:elseif test="content.type==-1">
			document.getElementsByName("content.type")[0].value="-1";
		</s:elseif>
		
		inittab();
		
	}

	function checkSpace(obj) {
		var regex = /[^\w\u4e00-\u9fa5^(^)^（^）]/g;
		obj.value = obj.value.replace(regex, '');
	}

	function showTree(){
		var type = document.getElementsByName("content.type")[0].value;
		if(type==""||type=="-1"||type==null||type==-1){
			alert("{*[please.select]*}{*[Type]*}");
		}else{
			resources('1',type);
		}
	}
	
	function resources(id,type){
		var applicationid=document.getElementsByName("content.applicationid")[0].value;
		var url = contextPath + '/core/privilege/res/jquerytree.jsp?id='
		+ id+'&type='+type+'&applicationid='+applicationid;
		var oField = document.getElementsByName("content.name")[0];
		//var value= uploadshowframe('select resources', url);
		OBPM.dialog.show({
				opener:window.parent,
				width: 800,
				height: 500,
				url: url,
				args: {},
				title: '{*[Select]*}{*[Resources]*}',
				close: function(value) {
					window.top.toThisHelpPage("application_info_generalTools_resources_info");
					if(value == null || value == 'undefined' || value == ''){
			
					}else{
						if(value=='clear'){
							oField.value='';
						}else{
							oField.value=value;
						}
					}
				}
		});
	}
	
	jQuery(document).ready(function(){
		ev_onload();
		window.top.toThisHelpPage("application_info_generalTools_resources_info");
	});
</script>
<body id="application_info_generalTools_resources_info" class="contentBody">
<s:form action="save" method="post" theme="simple">
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr style="height:27px;">
				<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
				<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr>
			<td class="nav-s-td" align="right">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="saveAndNew"></s:url>';forms[0].submit();"><img
								src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="save"></s:url>';forms[0].submit();"><img
								src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
								src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
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
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/page.jsp"%>
		<table class="table_noborder id1">
			<s:textfield name="tab" cssStyle="display:none;" value="1" />
			<s:textfield name="selected" cssStyle="display:none;" value="%{'btnResources'}" />
			<s:hidden name="content.applicationid" value="%{#parameters.application}" />
		    <tr>
				<td class="commFont" align="left" >{*[Type]*}:</td></tr><tr>
				<td>
				<s:select name="content.type" 
				 list="#{'-1':'{*[please.select]*}', '0':'{*[View]*}', '1':'{*[Form]*}', '2':'{*[menu]*}', '3':'{*[FormField]*}', '4':'{*[Folder]*}'}"   
				 cssClass="input-cmd" theme="simple"/>
				    
				</td>
			</tr>	
			<tr>
				<td class="commFont" align="left" >{*[Name]*}:</td></tr><tr>
				<td>
					<s:textfield cssClass="input-cmd"  label="{*[Name]*}" name="content.name" cssStyle="width:250px;"/>
					<button type="button" onclick="showTree()"><img border=0 alt="{*[Resources]*}" src="<s:url value="/resource/imgnew/act/plugin.png"/>"/></button>
				</td>
			</tr>
			<tr>
				<td class="commFont" align="left" >{*[Caption]*}:</td></tr><tr>
				<td>
					<s:textarea cssClass="input-cmd"  label="{*[Caption]*}" name="content.caption" cssStyle="width:280px" rows="4"/>
				</td>
			</tr>
			<tr>
				<td class="commFont" align="left" >{*[Description]*}:</td></tr><tr>
				<td>
					<s:textarea cssClass="input-cmd"  label="{*[Description]*}" name="content.description" cssStyle="width:280px" rows="4"/>
				</td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
