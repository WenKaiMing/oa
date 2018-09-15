<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.fieldextends.action.FieldExtendsHelper" id="fh" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<o:MultiLanguage>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.core.domain.fieldextends.extends.menu]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src="<s:url value="/script/list.js"/>"></script>
	<script type="text/javascript">
			function doNew(){
				var listform = document.getElementById("fieldListForm");
				var action = '<s:url value='/core/fieldextends/new.action'/>';
				listform.action = action;
				listform.submit();
			}

			function doView(fid){
				var listform = document.getElementById("fieldListForm");
				//var action = '<s:url value='/core/fieldextends/.action'/>?id=' + fid;
				//listform.action = action;
				listform.submit();
			}

			function chkCtrlCheck(){
				var chks = jQuery("#fieldListForm").find("input:checkbox");
				
				if(jQuery("#chkCtrl").attr("checked")){
					jQuery.each(chks,function(i,chk){
						jQuery(chk).attr("checked",true);
					});
				}else{
					jQuery.each(chks,function(i,chk){
						jQuery(chk).attr("checked",false);
					});
				}
			}
			function query() {
				var listform = document.getElementById("fieldListForm");
				//var action = '<s:url value="/core/fieldextends/query.action" />';
				//listform.action = action;
				listform.submit();
			}
			function resetAll() {
				var type = document.getElementById("id_type");
				type.value = "";
				var table = document.getElementById("id_forTable");
				table.value = "";
			}
			jQuery(document).ready(function(){
				cssListTable();
				window.top.toThisHelpPage("domain_fieldextends_list");
			});
	</script>
</head>

<body id="domain_fieldextends_list" class="listbody">
<div class="ui-layout-center">
<form id="fieldListForm" method="post" action="list.action">
	<%@include file="/common/basic.jsp"%> <!-- 工具条 -->
	
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.fieldextends.extends.menu]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="doNew()"><img	src="<s:url value='/resource/imgnew/act/act_2.gif' />" />{*[New]*}</button>
					<button type="button" class="button-image" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();""><img src="<s:url value='/resource/imgnew/act/act_3.gif' />">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table>
	<div id="main">
		<!-- 信息提示 --> 
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.domain.fieldextends.extends.title.search_field]*}">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Type]*}:	<s:select cssClass="input-cmd" theme="simple" value="#parameters['sm_type']" id="id_type" name="sm_type" list="#fh.getTypesMap()" emptyOption="true" /> 
					{*[cn.myapps.core.domain.fieldextends.extends.forTable]*}:	<s:select cssClass="input-cmd" theme="simple" value="#parameters['sm_forTable']" id="id_forTable" name="sm_forTable" list="#fh.getForTableMap()" emptyOption="true" />
					<input class="button-cmd" type="button" value="{*[Query]*}"	onclick="query()" />
					<input class="button-cmd" type="button"	value="{*[Reset]*}" onclick="resetAll()" />
				<tr><td>
			</table>
		</div>
		
		<!-- 扩展字段列表 -->
		<div id="contentTable">
		<table class="table_noborder">
			<tr>
				<td class="column-head2"><input type="checkbox" id="chkCtrl"
					onclick="chkCtrlCheck()"></td>
				<td class="column-head">{*[cn.myapps.core.domain.fieldextends.extends.name]*}</td>
				<td class="column-head">{*[cn.myapps.core.domain.fieldextends.extends.label]*}</td>
				<td class="column-head">{*[Type]*}</td>
				<td class="column-head">{*[cn.myapps.core.domain.fieldextends.extends.enabel]*}</td>
				<td class="column-head">{*[cn.myapps.core.domain.fieldextends.extends.forTable]*}</td>
			</tr>
	
			<s:iterator value="datas.datas" status="status">
				<%-- 初始化行样式 --%>
				<s:if test="#status.odd == true">
					<s:set name="className" value="'table-text'" />
				</s:if>
				<s:else>
					<s:set name="className" value="'table-text2'" />
				</s:else>
	
				<%-- 初始化模块名 --%>
				<s:if test="forTable == 'tableUser'">
					<s:set name="templateName"
						value="'{*[cn.myapps.core.domain.fieldextends.extends.user]*}'" />
				</s:if>
				<s:elseif test="forTable == 'tableDept'">
					<s:set name="templateName"
						value="'{*[cn.myapps.core.domain.fieldextends.extends.dept]*}'" />
				</s:elseif>
	
				<%-- 初始化类型 --%>
				<s:if test="type == 'string'">
					<s:set name="typeName" value="'{*[String]*}'" />
				</s:if>
				<s:elseif test="type == 'date'">
					<s:set name="typeName" value="'{*[Date]*}'" />
				</s:elseif>
				<s:elseif test="type == 'clob'">
					<s:set name="typeName" value="'{*[cn.myapps.core.domain.fieldextends.extends.type.clob]*}'" />
				</s:elseif>
	
				<tr class="<s:property value='#className'/>">
					<td align="center"><input type="checkbox"
						name="fieldNameAndIds"
						value="<s:property value='fid'/>-<s:property value='name'/>-<s:property value='forTable'/>"></td>
					<td align="left"><a
						href='<s:url action="view"><s:param name="fieldExtends.fid" value="fid"/>
								<s:param name="domain" value="%{#parameters.domain}"/>
								<s:param name="_currpage" value="datas.pageNo" />
								<s:param name="_pagelines" value="datas.linesPerPage" />
								<s:param name="_rowcount" value="datas.rowCount" />
								</s:url>'><s:property
						value='name' /></a></td>
					<td align="left">
						<a
						href='<s:url action="view"><s:param name="fieldExtends.fid" value="fid"/>
								<s:param name="domain" value="%{#parameters.domain}"/>
								<s:param name="_currpage" value="datas.pageNo" />
								<s:param name="_pagelines" value="datas.linesPerPage" />
								<s:param name="_rowcount" value="datas.rowCount" />
								</s:url>'><s:property value='label' /></a>
					</td>
					<td align="left"><s:property value='#typeName' /></td>
					<td align="left"><s:property value='enabel' /></td>
					<td align="left"><s:property value='#templateName' /></td>
				</tr>
			</s:iterator>
		</table>
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation
					dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
</form>
</div>
</body>
</html>
</o:MultiLanguage>