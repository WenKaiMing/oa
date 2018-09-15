<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.work.action.WorkHtmlUtil"%>
<%
	String skinType = (String)request.getSession().getAttribute("SKINTYPE");
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Proxy]*}</title>
<!-- 兼容ie6半透明 -->
<script src='<s:url value='/portal/share/script/iepngfix_tilebg.js' />'></script>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<!-- 滚动条 -->
<script src='<s:url value='/portal/share/script/jquery.slimscroll.min.js' />'></script>	
<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var skinType='<%=skinType%>';
</script>

<link rel="stylesheet" href="<s:url value='/portal/share/css/setting-up.css'/>" type="text/css">
<!--<link rel="stylesheet"
		href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />-->
<style>
#contentTable {overflow-y:auto; overflow-x:hidden;}
#navigateTable {height:27px;width:100%;}
.tab {width:68px;height:22px;}
body{margin:0;padding:0;}
.searchinput{float:left;width:250px;;padding-right:10px;}
</style>

<script type="text/javascript">

function cl(){
	document.getElementById("_flowName").value=""; 
}

function doNew(title){
	var url = contextPath
	+ '/portal/workflow/runtime/proxy/new.action?application=<s:property value="%{#parameters.application}" />';
	var showtitle = title;
	if (showtitle == null || showtitle == "") {
	showtitle = "Undefind";
	}
	var icons;
	var _path;
	if(skinType == "H5"){
		icons = "icons_1";
		_path = "../H5/resource/component/artDialog"
	}else{
		icons = "";
		_path = "";
	}
	OBPM.dialog.show({
	width : 550,
	height : 400,
	url : url,
	icon:icons,
	path: _path,
	args : {
	},
	title : showtitle,
	close : function(result) {
		var rtn = result;
		if (rtn) {
			document.forms[0].action = contextPath +'/portal/workflow/runtime/proxy/list.action';
			document.forms[0].submit();
		}
	}
	});
}

function doRemove(){
	if(jQuery("input[name=_selects]:checked").size() <= 0){
		alert("{*[select_one_at_least]*}");
		return;
	}
	document.forms[0].action = contextPath +'/portal/workflow/runtime/proxy/remove.action';
	document.forms[0].submit();
}

function doEdit(id,title){
	var url = contextPath
	+ '/portal/workflow/runtime/proxy/view.action?id='+ id+'&application=<s:property value="%{#parameters.application}" />';
	var showtitle = title;
	if (showtitle == null || showtitle == "") {
	showtitle = "Undefind";
	}
	OBPM.dialog.show({
	width : 600,
	height : 500,
	url : url,
	args : {
	},
	title : showtitle,
	close : function(result) {
		var rtn = result;
		if (rtn) {
			document.forms[0].action = contextPath +'/portal/workflow/runtime/proxy/list.action';
			document.forms[0].submit();
		}
	}
	});
}

function adjustPage(){
	var bodyH=document.body.clientHeight;//jQuery("body").height();
	jQuery("#container").width(jQuery("body").width());
	jQuery("#container").height(bodyH-10);
	var navigateTableH=jQuery("#navigateTable").height();
	var activityTableH=jQuery("#activityTable").height();
	var searchTableH = jQuery("#searchFormTable").height();
	var pageTableH=jQuery("#pageTable").height();
	jQuery("#contentTable").height(bodyH-navigateTableH-searchTableH-pageTableH-81);
}
function contentTableScroll(){
	var scrollHeight = jQuery("#contentTable").height();
	$("#contentTable").slimscroll({
		height: scrollHeight,
		color:'#333'
	});
}

function init(){
	//initTab();
	 adjustPage();
	 editHover();
	 contentTableScroll();//新建代理流程人员滚动
}
function resetAll(){
	document.getElementsByName("_flowName")[0].value ='';
}
function editHover(){
	$(".editHover").hover(
			  function () {
				    $(this).find("img").attr("src",contextPath+"/resource/imgv2/front/main/listedit-hover.gif");
				  },
				  function () {
					  $(this).find("img").attr("src",contextPath+"/resource/imgv2/front/main/listedit.gif");
				  }
		);
}
jQuery(window).load(function(){
	init();
}).resize(function(){
	adjustPage();
});
</script>
</head>
<body style="overflow: hidden;" class="body-front">
<s:form name="formList" method="post" theme="simple" action="/portal/workflow/runtime/proxy/list.action">
		<s:url id="backURL" action="/portal/workflow/proxy/list.action" >
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="_pagelines" value="datas.linesPerPage" />
		<s:param name="_flowId" value="params.getParameterAsString('_flowId')" />
		</s:url>
		<input type="hidden" name="_currpage"
			value='<s:property value="datas.pageNo"/>' />
		<input type="hidden" name="_pagelines"
			value='<s:property value="datas.linesPerPage"/>' />
		<input type="hidden" name="_rowcount"
			value='<s:property value="datas.rowCount"/>' />
		<input type="hidden" name="_processType"
			value='<s:property value="params.getParameterAsString('_processType')"/>' />
		<input type="hidden" name="_actorId"
			value='<s:property value="params.getParameterAsString('_actorId')"/>' />
		<s:if test="#parameters.domain != null">
			<s:hidden name="domain" value="%{#parameters.domain}" />
		</s:if>
		<s:else>
			<s:hidden name="domain" value="%{#session.FRONT_USER.domainid}" />
		</s:else>
		<s:hidden name="application" value="%{#parameters.application}" />
		<input type="hidden" name="_backURL"
			value="<%=request.getAttribute("backURL")%>" />
		<input type="hidden" name="_pageCount"
			value='<s:property value="datas.pageCount"/>' />

<div id="container">
<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<div style="margin-bottom:10px;overflow:hidden;">
	<table width="100%;">
		<tr width="100%;">
			<td>
				<div id="activityTable" class="activityTable" style="width:200px;">
					<a href="###" class="sett-form-control-inline btn-primary" onclick="doNew('{*[core.workflow.storage.runtime.proxy.new]*}')">{*[New]*}</a>
					<a href="###" class="sett-form-control-inline btn-danger" name='button_act' title='{*[Delete]*}' onclick="doRemove()">{*[Delete]*}</a>
						
				</div>
			</td>
			<td style="text-align:right;" align= "right ">
				<div id="searchFormTable" class="searchFormTable listsearch">
					<!-- 输出查询表单HTML --> 
					<table style="position:relative;">
						<tr>
							<td nowrap="nowrap" style="vertical-align: middle;">{*[cn.myapps.core.workflow.name]*}:</td>
							<td><input type="text" class="sett-form-control-inline" name="_flowName" id="_flowName" size="20" value='<s:property value="params.getParameterAsString('_flowName')"/>'></input></td>
							<td nowrap="nowrap" style="vertical-align: middle;">
								<a class="btn icon17" href="###" onclick="document.getElementsByName('_currpage')[0].value=1;document.forms[0].submit();">{*[Query]*}</a>
							</td>
							<td nowrap="nowrap" style="vertical-align: middle;">
								<a class="btn icon18" onclick="cl()">{*[Reset]*}</a>
							</td>
						</tr>
					</table>	
					
				</div>
			</td>
		</tr>
	</table>
</div>
<div style="border:1px solid #f5f5f5;border-radius:4px;-moz-border-radius: 4px; -webkit-border-radius: 4px;">
 <div id="contentTable" class="contentTable">
<s:bean name="cn.myapps.util.Security" id="security" />
	<table class="table_noborder" style="width:100%"  cellspacing="0" cellpadding="0">
		<tr class="dtable-header list-header" style="background:#f3f3f3;">
			<td class="column-head-fresh" width="20px"><input type="checkbox" onclick="selectAll(this.checked)"></td>
			<td class="column-head-fresh" width="20%">{*[cn.myapps.core.workflow.name]*}</td>
			<td class="column-head-fresh" width="13%">代理方式</td>
			<td class="column-head-fresh" width="20%">{*[Description]*}</td>
			<td class="column-head-fresh" width="">{*[core.workflow.storage.runtime.proxy.authorize]*}</td>
			<td class="column-head-fresh" width="50px">{*[State]*}</td>
			<td class="column-head-fresh" width="100px">{*[Activity]*}</td>				
		</tr>
		<s:iterator value="datas.datas" status="rowStatus">
		<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
		<s:set name="bean" id="bean" scope="page" />
			<td ><input type="checkbox" name="_selects" value="<s:property value="id"/>"></td>
			<td ><s:if test="flowName =='' || flowName == null ">所有流程</s:if>
				<s:else><s:property value="flowName" /></s:else></td>
			<td ><s:if test="proxyMode==0">指定流程代理</s:if>
				  <s:elseif test="proxyMode==1">所有流程代理</s:elseif></td>
			<td ><s:property value="description" /></td>
			<td ><s:property value="agentsName" /></td>
			<td ><s:if test="state==0">{*[core.workflow.storage.runtime.proxy.disable]*}</s:if>
				<s:elseif test="state==1">{*[core.workflow.storage.runtime.proxy.activation]*}</s:elseif></td>
			<td align="center"><!-- 操作按钮  start --> <!-- Icons -->
				<a href="###" class="editHover" onclick="doEdit('<s:property value="id"/>','{*[core.workflow.storage.runtime.proxy.new]*}')" title="{*[Edit]*}">
					<img src="<s:url value='/resource/imgv2/front/main/listedit.gif'/>" style="border:0px;" alt="{*[Edit]*}"/></a>&nbsp;&nbsp; 
			</td>
			</tr>
		</s:iterator>
	</table>
</div>	
<!-- 分页导航(page navigate) -->

<div class=" table_pagenav" id="pageTable" style="padding-top:15px;padding-bottom: 15px;">
	<div class="page_btn">
		<s:if test="datas.pageCount > 1">
	    	<span>	
				<s:if test="datas.pageNo  > 1">		
					<a class="first page" href='javascript:showFirstPage()'><<</a>
					<a class="pre page" href='javascript:showPreviousPage()'><</a>
				</s:if>
				<s:else>
					<a class="first_d page"><<</a>
					<a class="pre_d page"><</a>	
				</s:else>
				<div class="pagetxt page">
					<span>
						<s:property value='datas.pageNo' />/<s:property value='datas.pageCount' />{*[Page]*}						
					</span>
				</div>							
				<s:if test="datas.pageNo < datas.pageCount">		
					<a class="next page" href='javascript:showNextPage()'>></a>
					<a class="last page" href='javascript:showLastPage()'>>></a>				
				</s:if> 
				<s:else>
					<a class="next_d page">></a>
					<a class="last_d page">>></a>					
				</s:else>		
			</span>
		</s:if>
		{*[TotalRows]*}:(<s:property value="datas.rowCount" />)
	</div>
</div></div>
</s:form>
</body>
</o:MultiLanguage></html>
