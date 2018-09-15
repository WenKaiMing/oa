<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.work.action.WorkHtmlUtil"%>
<%
WorkHtmlUtil workHtmlUtil = new WorkHtmlUtil(request);
request.setAttribute("workHtmlUtil", workHtmlUtil);
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Work]*}</title>
<!-- 兼容ie6半透明 -->
<script src='<s:url value='/portal/share/script/iepngfix_tilebg.js' />'></script>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/BillDefiHelper.js"/>'></script>

<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var actionMode = '<s:property value="params.getParameterAsString(\'actionMode\')"/>';
</script>
<script src="<s:url value="/portal/share/dynaform/work/work.js"/>"></script>
<script type="text/javascript">
	jQuery(document).ready(function () {
		// 当为弹出框时，调整当前窗口
		OBPM.dialog.resize(900,550);
		window.setTimeout("",0);
		window.status="Page is loaded";

		var _moduleid = document.getElementsByName("_moduleId")[0].value;
		var flowdef = document.getElementById("showFlowId").value;
		changeFlow(_moduleid,flowdef);
	});

	function changeFlow(moduleId, flowdef){
		BillDefiHelper.getBillDefiVOByModules(moduleId, function(map) {
			var elem = document.getElementById('_flowId');
			DWRUtil.removeAllOptions(elem.id);
			DWRUtil.addOptions(elem.id, map);

			if(flowdef){
				DWRUtil.setValue(elem.id, flowdef);
			}
		});
	}
</script>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
<style>
.tab {width:68px;height:22px;}
.navigateTable table{border-collapse: collapse;}
</style>
</head>
<body style="overflow: hidden; margin-top:0px;margin-left:0px;" class="body-front">
<s:form name="formList" method="post" theme="simple" action="/portal/dynaform/work/workList.action">		
		<input type="hidden" name="_processType"
			value='<s:property value="params.getParameterAsString('_processType')"/>' />
		<input type="hidden" name="_actorId"
			value='<s:property value="params.getParameterAsString('_actorId')"/>' />
		<input type="hidden" name="_isRead"
			value='<s:property value="params.getParameterAsString('_isRead')"/>' />
		<s:if test="#parameters.domain != null">
			<s:hidden name="domain" value="%{#parameters.domain}" />
		</s:if>
		<s:else>
			<s:hidden name="domain" value="%{#session.FRONT_USER.domainid}" />
		</s:else>
		<s:if test="#parameters.application != null">
			<s:hidden id="applicationid" name="application" value="%{#parameters.application}" />
		</s:if>	
		<input type="hidden" name="showFlowId" id="showFlowId" value='<s:property value="params.getParameterAsString('_flowId')"/>' />
<div id="container" style="border: 1px solid #dddddd;margin-bottom: 10px;">
<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="navigateTable" class="navigateTable">
	<table class="table_noborder" style="width:100%">		
		<tr height="22px">
			<td align="left">
			<table cellspacing="0" cellpadding="0" style="width:100%">
				<tr>
					<td style="border-bottom:1px solid #dddddd;width:5px;">&nbsp;</td>					
					<td class="tab"><input type="button" id="btnProcessing" name="btnProcessing" class="btcaption"
						onclick="doList('processing')" value="{*[core.dynaform.work.label.processing]*}" /></td>
					<td class="tab"><input type="button" id="btnProcessed" name="btnProcessed" class="btcaption"
						onclick="doList('processed')" value="{*[core.dynaform.work.label.processed]*}" /></td>
					<td class="tab"><input type="button" id="btnAll" name="btnAll" class="btcaption"
						onclick="doList('all')" value="{*[all]*}" /></td>
					<td class="tab"><input type="button" id="btnCirculator_ing" name="btnCirculator_ing" class="btcaption"
						onclick="doCirculatorList('0')" value="{*[core.dynaform.work.label.to.read]*}" /></td>
					<td class="tab"><input type="button" id="btnCirculator_ed" name="btnCirculator_ed" class="btcaption"
						onclick="doCirculatorList('1')" value="{*[core.dynaform.work.label.readed]*}" /></td>
					<td style="border-bottom:1px solid #dddddd;width:100%">&nbsp;</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</div>
<s:if test="params.getParameterAsString('actionMode')=='circulator'">
	<input type="hidden" name="_backURL" value="<%=request.getContextPath()%>/portal/workflow/storage/runtime/workList.action?_actorId=<s:property value='params.getParameterAsString("_actorId")'/>&actionMode=<s:property value='params.getParameterAsString("actionMode")'/>&_processType=<s:property value='params.getParameterAsString("_processType")'/>&_isRead=<s:property value='params.getParameterAsString("_isRead")'/>&application=<%=request.getAttribute("application") %>" />
	<div id="searchFormTable2" class="front-scroll-hidden front-bgcolor2" style="padding:0px;">
	<table class="front-table-full-width" style="width:auto;">
		<tr>
		<!-- 输出查询表单HTML --> 		
		 <td>&nbsp;{*[Subject]*}:&nbsp;<input type="text" name="_subject4Circulator" id="_subject4Circulator" size="10" value='<s:property value="params.getParameterAsString('_subject4Circulator')"/>'></input></td>    
		<!-- 是否显示查询表单按钮 -->
		<td style="width: 150px;">
			<table>
				<tr>
					<td nowrap="nowrap">				
					<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid">
							<a class="queryicon icon16" href="###" onclick="doQuery('circulator');">{*[Query]*}
							</a>
						</div>
						<div class="btn_right"></div>
					</div>
					</td>
					<td nowrap="nowrap">
					<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid">
							<a class="reseticon icon16" onclick="doReset('circulator');">{*[Reset]*}
							</a>
						</div>
						<div class="btn_right"></div>
					</div>			
					</td>					
				</tr>
			</table>
		</td>
		</tr>
	</table>
</div>
</s:if>
<s:if test="params.getParameterAsString('actionMode')=='work'">
<s:url id="backURL" action="workList.action" >
		<s:param name="_processType" value="params.getParameterAsString('_processType')" />
		<s:param name="_currpage" value="workDatas.pageNo"/>
		<s:param name="_pagelines" value="workDatas.linesPerPage" />
		<s:param name="_flowId" value="params.getParameterAsString('_flowId')" />
		<s:param name="_actorId" value="params.getParameterAsString('_actorId')" />
		<s:param name="application" value="#parameters.application" />
		<s:param name="actionMode" value="#parameters.actionMode" />
</s:url>
<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
<!-- 
<input type="hidden" name="_backURL"
	value='<s:property value="backURL"/>' />
-->
<input type="hidden" name="_currpage"
	value='<s:property value="workDatas.pageNo"/>' />
<input type="hidden" name="_pagelines"
	value='<s:property value="workDatas.linesPerPage"/>' />
<input type="hidden" name="_rowcount"
	value='<s:property value="workDatas.rowCount"/>' />
<div id="searchFormTable" class="front-scroll-hidden front-bgcolor2" style="padding:0px;">
	<table class="front-table-full-width" style="width:auto;">
		<tr>
		<!-- 输出查询表单HTML --> 		
		 <td>&nbsp;{*[Subject]*}:&nbsp;<input type="text" name="_subject" id="_subject" size="10" value='<s:property value="params.getParameterAsString('_subject')"/>'></input></td>    
		 <td>&nbsp;{*[Module]*}{*[Name]*}:&nbsp;<s:select name="_moduleId" list="#request.workHtmlUtil.getModuleMap()" onchange="changeFlow(this.value)"/></td>   
		 <td>&nbsp;{*[Flow]*}{*[Name]*}:&nbsp;<s:select name="_flowId" id="_flowId" list="#request.workHtmlUtil.getFlowMap()" /></td>
		<!-- 是否显示查询表单按钮 -->
		<td style="width: 150px;">
			<table>
				<tr>
					<td nowrap="nowrap">				
					<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid">
							<a class="queryicon icon16" href="###" onclick="doQuery('work');">{*[Query]*}
							</a>
						</div>
						<div class="btn_right"></div>
					</div>
					</td>
					<td nowrap="nowrap">
					<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid">
							<a class="reseticon icon16" onclick="doReset('work');">{*[Reset]*}
							</a>
						</div>
						<div class="btn_right"></div>
					</div>			
					</td>					
				</tr>
			</table>
		</td>
		</tr>
	</table>
</div>
</s:if> 
 
<div id="contentTable" style="background-color: white;">
<s:bean name="cn.myapps.util.Security" id="security" />
	<table  width="100%" border=0 cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
<s:if test="params.getParameterAsString('actionMode')=='work'">
	<input type="hidden" name="_pageCount"
			value='<s:property value="workDatas.pageCount"/>' />
		<tr class="dtable-header">
			<td class="column-head" width="">{*[Subject]*}</td>
			<td class="column-head" width="">{*[Flow]*}{*[Name]*}</td>
			<td class="column-head" width="150px;">{*[core.workflow.storage.runtime.intervention.firstProcessTime]*}</td>
			<td class="column-head" width="">{*[StateLabel]*}</td>
			<td class="column-head" width="">{*[AuditorNames]*}</td>
			<td class="column-head" width="250px">{*[Activity]*}</td>
			<!-- 
			<td class="column-head">查看</td> -->
			</tr>
		<s:iterator value="workDatas.datas" status="rowStatus">
		<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
		<s:set name="work" id="work" scope="page" />
			<td><s:property value="subject" />&nbsp;</td>
			<td ><s:property value="flowName" /></td>
			<td ><s:date name="firstProcessTime" format="yyyy-MM-dd HH:mm:ss" /></td>
			<td ><s:property value="stateLabel" /></td>
			<td ><s:property value="auditorNames" /></td>
			<td ><!-- 操作按钮  start --> <!-- Icons -->
				<a href="###" onclick="viewDoc('<s:property value="docId"/>', '<s:property value="formId"/>', 'false')" title="{*[core.dynaform.work.label.host]*}">
					<img src="<s:url value='/resource/imgv2/front/main/host.gif'/>" style="border:0px;" alt="{*[core.dynaform.work.label.host]*}"/>{*[core.dynaform.work.label.host]*}</a>&nbsp;&nbsp; 
				<s:if test="auditorList.indexOf(params.getParameterAsString('_actorId'))>0 " >
					<a href="###" onclick="showFlowSelect('<s:property value="flowId"/>','<s:property value="docId"/>','{*[core.dynaform.work.label.doFlow]*}')" title="{*[core.dynaform.work.label.doFlow]*}">
						<img src="<s:url value='/resource/imgv2/front/main/flow_switch.gif'/>" style="border:0px;" alt="{*[core.dynaform.work.label.doFlow]*}" />{*[core.dynaform.work.label.doFlow]*}</a>&nbsp;&nbsp;
					<a href="###" onclick="commissionedWork('<s:property value="docId"/>','<s:property value="subject"/>','<s:property value="stateLabel"/>','{*[core.dynaform.work.label.entrust]*}','<s:property value="applicationId"/>')" title="{*[core.dynaform.work.label.entrust]*}">
						<img src="<s:url value='/resource/imgv2/front/main/entrust.gif'/>" style="border:0px;" alt="{*[core.dynaform.work.label.entrust]*}" />{*[core.dynaform.work.label.entrust]*}</a>&nbsp;&nbsp;
				</s:if>
				
			<%-- 	<s:if test="auditorList.indexOf(params.getParameterAsString('_actorId'))>0 " >
					<a href="###" onclick="removeWork('<s:property value="docId"/>','你确定要删除这条记录?')" title="删除">
						<img src="<s:url value='/resource/imgv2/front/main/delete.gif'/>" style="border:0px;" alt="删除" />删除</a>&nbsp;&nbsp;
				</s:if> --%>
				<!-- 操作按钮  end -->
			</td>
			</tr>
		</s:iterator>
</s:if>		
<s:if test="params.getParameterAsString('actionMode')=='circulator'">
<input type="hidden" name="_currpage"
	value='<s:property value="datas.pageNo"/>' />
<input type="hidden" name="_pagelines"
	value='<s:property value="datas.linesPerPage"/>' />
<input type="hidden" name="_rowcount"
	value='<s:property value="datas.rowCount"/>' />
<input type="hidden" name="_pageCount"
		value='<s:property value="datas.pageCount"/>' />
		<tr class="dtable-header">
			<td class="column-head" width="">{*[Subject]*}</td>
			<td class="column-head" width="">{*[core.dynaform.work.label.Processor]*}</td>
			<td class="column-head" width="">{*[core.dynaform.work.label.copy.time]*}</td>
			<td class="column-head" width="">{*[State]*}</td>
			<td class="column-head" width="">{*[core.dynaform.work.label.read.time]*}</td>
			</tr>
		<s:iterator value="datas.datas" status="rowStatus">
		<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
			<td>
				<a href="#" onclick="viewDoc('<s:property value="docId"/>', '<s:property value="formId"/>', 'false')" ><s:property value="summary" /></a>
			</td>
			<td ><a href="#" onclick="viewDoc('<s:property value="docId"/>', '<s:property value="formId"/>', 'false')" ><s:property value="name" /></a></td>
			<td ><a href="#" onclick="viewDoc('<s:property value="docId"/>', '<s:property value="formId"/>', 'false')" ><s:date name="ccTime" format="yy-MM-dd hh:mm:ss"></s:date></a></td>
			<td ><a href="#" onclick="viewDoc('<s:property value="docId"/>', '<s:property value="formId"/>', 'false')" >
			<s:if test="read">{*[core.dynaform.work.label.readed]*}</s:if>
			<s:elseif test="!read">{*[core.dynaform.work.label.to.read]*}</s:elseif>
			</a>
			</td>
			<s:if test="read">
			<td ><a href="#" onclick="viewDoc('<s:property value="docId"/>', '<s:property value="formId"/>', 'false')" ><s:date name="readTime" format="yy-MM-dd hh:mm:ss"></s:date></a></td>
			</s:if>
			<s:elseif test="!read">
			<td ><a href="#" onclick="viewDoc('<s:property value="docId"/>', '<s:property value="formId"/>', 'false')" > -- -- -- -- -- </a></td>
			</s:elseif>
			</tr>
		</s:iterator>
</s:if>	
</table>
</div>
<!-- 分页导航(page navigate) -->
<div id="pageTable"  class="front-scroll-hidden page-nav" style="position: absolute;bottom:1px;width:100%;">
<s:if test="params.getParameterAsString('actionMode')=='work'">	
	<div class="page_btn">
		<s:if test="workDatas.pageCount > 1">
    	<span>	
			<s:if test="workDatas.pageNo  > 1">
				<a class="first page icon16" href='javascript:showFirstPage()'></a>
				<a class="pre page icon16" href='javascript:showPreviousPage()'></a>
			</s:if>
			<s:else>
				<a class="first_d page icon16"></a>
				<a class="pre_d page icon16"></a>
			</s:else>
			<div class="pagetxt page">
				<span>
					<s:property value='workDatas.pageNo' />/<s:property value='workDatas.pageCount' />{*[Page]*}
				</span>
				<s:if test="workDatas.pageCount > 1">
					<span>
						<input type="text" name="_jumppage" class="img_go" onclick='javascript:jumpPage(listAction);' style="border:1px solid #dddddd"/>								
					</span>
				</s:if>
			</div>
			<s:if test="workDatas.pageNo < workDatas.pageCount">		
				<a class="next page icon16" href='javascript:showNextPage(null, listAction)'></a>
				<a class="last page icon16" href='javascript:showLastPage(null, listAction)'></a>				
			</s:if> 
			<s:else>
				<a class="next_d page icon16"></a>
				<a class="last_d page icon16"></a>					
			</s:else>
		</span>
		</s:if>
	{*[TotalRows]*}:(<s:property value="workDatas.rowCount" />)
</div>	
	
</s:if>
<s:if test="params.getParameterAsString('actionMode')=='circulator'">
	<div class="page_btn">
		<s:if test="datas.pageCount > 1">
    	<span>	
			<s:if test="datas.pageNo  > 1">
				<a class="first page icon16" href='javascript:showCirculatorFirstPage(null, listAction)'></a>
				<a class="pre page icon16" href='javascript:showCirculatorPreviousPage(null, listAction)'></a>
			</s:if>
			<s:else>
				<a class="first_d page icon16"></a>
				<a class="pre_d page icon16"></a>
			</s:else>		
			<div class="pagetxt page">
				<span>
					<s:property value='datas.pageNo' />/<s:property value='datas.pageCount' />{*[Page]*}
				</span>
				<s:if test="datas.pageCount > 1">
					<span>
						<input type="text" name="_jumppage" class="img_go" onclick='javascript:jumpPageCirculator();' style="border:1px solid #dddddd"/>								
					</span>
				</s:if>
			</div>
			<s:if test="datas.pageNo < datas.pageCount">
				<a class="next page icon16" href='javascript:showCirculatorNextPage(null, listAction)'></a>
				<a class="last page icon16" href='javascript:showCirculatorLastPage(null, listAction)'></a>				
			</s:if>
			<s:else>
				<a class="next_d page icon16"></a>
				<a class="last_d page icon16"></a>
			</s:else>
		</span>
		</s:if>
		{*[TotalRows]*}:(<s:property value="datas.rowCount" />)
	</div>
</s:if>
</div>
<!-- 分页导航结束(end of page navigate) -->
</div>
</s:form>
</body>
</o:MultiLanguage></html>
