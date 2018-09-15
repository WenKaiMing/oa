<%@ include file="/km/disk/head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html><o:MultiLanguage>
<head>
<title></title>
<!-- 兼容ie6半透明 -->
<script src='<s:url value='/portal/share/script/iepngfix_tilebg.js' />'></script>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src="<s:url value="/script/list.js"/>"></script>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
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
	document.getElementById("fileName").value = '';
}

function adjustPage(){
	var bodyH=document.body.clientHeight;//jQuery("body").height();
	jQuery("#container").width(jQuery("body").width());
	jQuery("#container").height(bodyH-10);
	var navigateTableH=jQuery("#navigateTable").height();
	var activityTableH=jQuery("#activityTable").height();
	var searchTableH = jQuery("#searchFormTable").height();
	var pageTableH=jQuery("#pageTable").height();
	jQuery("#contentTable").height(bodyH-navigateTableH-searchTableH-pageTableH-37);
}
function init(){
	 adjustPage();
}

jQuery(window).load(function(){
	init();
}).resize(function(){
	adjustPage();
});
</script>
</head>
<body style="overflow: hidden;" class="body-front">
<s:form name="formList" method="post" theme="simple" action="/km/logs/queryBy.action">
		<input type="hidden" name="operationtype" value="<s:property value="params.getParameterAsString('operationtype')"/>">
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
		<s:hidden name="application" value="%{#parameters.application}" />
		<input type="hidden" name="_pageCount"
			value='<s:property value="datas.pageCount"/>' />

<div id="container" style="margin-bottom: 10px;">
<%@include file="/common/msg.jsp"%>
<div id="searchFormTable" class="searchFormTable" style="width:100%;border-bottom: 1px solid #dddddd;">
	<table>
		<tr>
			<td>{*[cn.myapps.km.disk.file_name]*}:&nbsp;<input type="text" name="fileName" id="fileName" size="20" value='<s:property value="params.getParameterAsString('fileName')"/>'></input></td>
			<td nowrap="nowrap">
				<div class="button-cmd">
					<div class="btn_left"></div>
					<div class="btn_mid">
						<a class="queryicon icon16" href="###" onclick="document.getElementsByName('_currpage')[0].value=1;document.forms[0].submit();">{*[Query]*}
						</a>
					</div>
					<div class="btn_right"></div>
				</div>
			</td>
			<td nowrap="nowrap">
				<div class="button-cmd">
					<div class="btn_left"></div>
					<div class="btn_mid">
						<a href="javascript:cl();" class="reseticon icon16" >{*[Reset]*}</a>
					</div>
					<div class="btn_right"></div>
				</div>
			</td>
		</tr>
	</table>	
	
</div> 
 <div id="contentTable" class="contentTable">
<s:bean name="cn.myapps.util.Security" id="security" />
	<table class="table_noborder" style="width:100%"  cellspacing="0" cellpadding="0">
		<tr class="dtable-header" style="background:#f3f3f3;">
			<td class="column-head-fresh" width="100px">{*[cn.myapps.km.disk.file_name]*}</td>
			<td class="column-head-fresh" width="50px">{*[cn.myapps.km.logs.creator]*}</td>
			<td class="column-head-fresh" width="100px">{*[cn.myapps.km.logs.operating_content]*}</td>
			<td class="column-head-fresh" width="120px">{*[cn.myapps.km.logs.operation_date]*}</td>
			<td class="column-head-fresh" width="50px">{*[cn.myapps.km.logs.views]*}</td>
			<td class="column-head-fresh" width="50px">{*[cn.myapps.km.logs.downloads]*}</td>
			<td class="column-head-fresh" width="50px">{*[cn.myapps.km.logs.favorites]*}</td>
					
		</tr>
		<s:iterator value="datas.datas" id="status">
				<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
					<td class="column-head-fresh" width="100px"><s:property value="fileName" /></td>
					<td class="column-head-fresh" width="50px"><s:property value="creator" /></td>
					<td class="column-head-fresh" width="100px">
					<s:if test="#parameters.operationtype[0] == 'SHARE'&&#status.operationContent!=null">{*[cn.myapps.km.logs.share_to]*}<s:property value="operationContent" /></s:if>
					<s:if test="#parameters.operationtype[0] == 'SHARE'&&#status.operationContent==null">{*[cn.myapps.km.disk.public_share]*}<s:property value="operationContent" /></s:if>
					<s:if test="#parameters.operationtype[0] == 'RECOMMEND'">{*[cn.myapps.km.logs.recommend_to]*}<s:property value="operationContent" /></s:if>
					<s:if test="#parameters.operationtype[0] == 'FAVORITE'">{*[cn.myapps.km.disk.favorite]*}<s:property value="operationContent" /></s:if>
					<s:if test="#parameters.operationtype[0] == 'VIEW'">{*[cn.myapps.km.logs.read]*}<s:property value="operationContent" /></s:if>
					<s:if test="#parameters.operationtype[0] == 'DOWNLOAD'">{*[cn.myapps.km.disk.download]*}<s:property value="operationContent" /></s:if>
					</td>
					<td class="column-head-fresh" width="120px"><s:date name="#status.operationDate" /></td>
					<td class="column-head-fresh" width="50px"><s:property value="views" /></td>
					<td class="column-head-fresh" width="50px"><s:property value="downloads" /></td>
					<td class="column-head-fresh" width="50px"><s:property value="favorites" /></td>
				</tr>
		</s:iterator>
	</table>
</div>	
<!-- 分页导航(page navigate) -->
<div class="page-nav" id="pageTable" style="position: absolute;bottom:1px;width:100%;" >
	<div class="page_btn">
	<s:if test="datas.pageCount > 1">
    	<span>	
		<s:if test="datas.pageNo  > 1">		
			<a class="first page icon16" href='javascript:showFirstPage()'></a>
			<a class="pre page icon16" href='javascript:showPreviousPage()'></a>
		</s:if>
		<s:else>
			<a class="first_d page icon16"></a>
			<a class="pre_d page icon16"></a>	
		</s:else>
		<div class="pagetxt page">
			<span>
				<s:property value='datas.pageNo' />/<s:property value='datas.pageCount' />{*[cn.myapps.km.disk.page]*}					
			</span>
		</div>							
		<s:if test="datas.pageNo < datas.pageCount">		
			<a class="next page icon16" href='javascript:showNextPage()'></a>
			<a class="last page icon16" href='javascript:showLastPage()'></a>				
		</s:if> 
		<s:else>
			<a class="next_d page icon16"></a>
			<a class="last_d page icon16"></a>					
		</s:else>		
		</span>
	</s:if>
	{*[TotalRows]*}:(<s:property value="datas.rowCount" />)
	</div>
</div>
</s:form>
</body>
</o:MultiLanguage></html>
