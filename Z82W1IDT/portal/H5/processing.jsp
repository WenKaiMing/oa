<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingProcessBean"%>
<%@page import="cn.myapps.base.dao.DataPackage"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resource/css/bootstrap.min.css" />
<link rel="stylesheet" href="resource/css/myapp.css" />
<link rel="stylesheet" href="resource/css/other.css" />
<link rel="stylesheet" href="resource/css/fc.css" />
<link rel="stylesheet" href="<o:Url value='/resource/script/jquery.pagination/jquery.pagination.css'/>" />

<script type="text/javascript">
var front_nocontent = '{*[front.workflowcenter.nocontent]*}';
</script>
<script src="resource/js/jquery-1.11.3.min.js"></script>
<script src="resource/script/bootstrap.min.js"></script>
<script src="resource/script/jquery.slimscroll.min.js"></script>
<script src="resource/script/common.js"></script>
<script src="resource/script/fc.core.js"></script>
<script src="resource/script/fc.util.js"></script>
<script src="resource/script/fc.service.js"></script>
<script src="./resource/script/template.js"></script>
<script src="<o:Url value='/resource/script/jquery.pagination/jquery.pagination.js'/>"></script>

<script type="text/javascript" src="<o:Url value='/resource/component/artDialog/jquery.artDialog.source.js?skin=aries'/>"></script>
<script type="text/javascript" src="<o:Url value='/resource/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<o:Url value='/resource/component/artDialog/obpm-jquery-bridge.js'/>"></script>

<script type="text/javascript">
<%
WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
String domainid=webUser.getDomainid();
String id = webUser.getId();
String name = webUser.getName();
%>
template.config("escape",false);	//设置模板是否编码输出变量的 HTML 字符
var contextPath = '<%=request.getContextPath()%>';
var appId = '<%=request.getParameter("appId")%>';
var flowCenter = {
		multilingual : {}
	};
	flowCenter.multilingual["Subject"] = "{*[Subject]*}";
	flowCenter.multilingual["State"] = "{*[State]*}";
	flowCenter.multilingual["Current_Processor"] = "{*[Current_Processor]*}";
	flowCenter.multilingual["flow.last_time"] = "{*[flow.last_time]*}";
	flowCenter.multilingual["Activity"] = "{*[Activity]*}";
	flowCenter.multilingual["total"] = "{*[front.total]*}";
var USER = {
		id : '<%= id%>',
		name : '<%= name%>',
		domainId : '<%= domainid%>'
	}; 
$(function() {
	//关闭缓存
	$.ajaxSetup({cache:false});
	var flowgroupHeight = $(".flowCenter-menu").height();
	$("#flowAccordion").slimscroll({
		height:flowgroupHeight
	});
	var flowCenterTbodyHeight  = $(".flowCenter-content").outerHeight()-$(".flowCenterSearch").outerHeight();
	$("#flowCenterTable").slimscroll({
		height:flowCenterTbodyHeight
	});
	FC.Core.handle.init();
	$("#appList div").on("refresh",function(){
		FC.Core.handle.refresh();
	});
});
</script>
</head>
<body>
<!-- 遮挡层 -->
<div id="loadingMask" class="obpm-mask_transparent">
    <div class="obpm-loading">
        <img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
    </div>
</div>
<!-- 输出软件ids，重构使用 -->
<div id="appList" style="display:none" _type="pending" _actionType="Processed">
	<%
	WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	ApplicationHelper ah = new ApplicationHelper();
	Collection<ApplicationVO> apps = ah.getListByWebUser(user);
	String _currpage = request.getParameter("_currpage");
	
	for (ApplicationVO applicationVO : apps) {
		String applicationId = applicationVO.getId();

		out.println("<div refreshId='" + applicationId + "' _appId='" + applicationId + "' _appName='" + applicationVO.getName() + "'></div>");
	}
	%>
</div>
<!-- 重构后显示内容 -->
	<div class="flowCenter-box" id="flowCenter-box" style="height:100%;overflow:hidden;">
		<div class="flowCenter-menu">
			<div class="soft-group" id="flowAccordion" role="tablist" aria-multiselectable="true"></div>
		</div>
		<div class="flowCenter-content">
			<div class="flowCenterSearch">
				<div class="show-flow-end search-boot-switch">
					<span class="flowEnd">未完结的</span>
					<div class="switchIcon" title="仅显示未完结的流程">
						<label>
							<input type="checkbox" class="ios-switch green showEndInput"><div>
								<div>
								</div>
							</div>
						</label>
					</div>
				</div>
				<span id="myStartBtn" class="myStartBtn">
	        		<input type="checkbox" name="myStart" value="1">
	  				<span>{*[front.i.started]*}</span>
	  			</span>
				<span>
					<input type="text" class="flowtitle" id="flowtitle" placeholder="主题">
				</span>
				<span id="_divid">
					<input type="hidden" id="initiator" iscommonfilter="false" name="用户选择框" value="" fieldtype="UserField">
					<textarea class="form-control" type="text" readonly="" style="vertical-align: bottom;width: auto;height: 34px;display: inherit;margin-right:4px;" isrefreshonchanged="true" id="initiator_text" filetype="userfield" fieldtype="UserField" name="用户选择框_text" isuserfield="true" displaytype="2" readonlyshowvalonly="true" nohidden="true" title="nice" placeholder="申请人"></textarea>
					<span class="btn btn-default" id="selectUser" style="margin-right:4px;" title="选择用户">添加 </span>
					<span class="btn btn-default" id="clearUser"  style="margin-right:4px;" title="清除"> 清除 </span>
				</span>
				<button class="btn btn-search"><img src="./resource/images/sousuo.png"/>搜索</button>
			</div>
			<div class="fixedTdHead">
				<table class="flowCenter-table" style="width:100%;table-layout: fixed;">
					<tr class="head">
						    <td class="initiator"><span>申请人</span></td>
							<td><span>主题</span></td>
							<td class="lastHandleTime"><span>最后处理时间</span></td>
							<td class="operation"><span>动作</span></td>
							<td class="status"><span>状态</span></td>
					</tr>
				</table>
			</div>
			<div class="flowCenterTable" id="flowCenterTable">
				<table class="flowCenter-table" style="width:100%;table-layout: fixed;">
					<thead>
						<tr class="head">
						    <td class="initiator"><span>申请人</span></td>
							<td><span>主题</span></td>
							<td class="lastHandleTime"><span>最后处理时间</span></td>
							<td class="operation"><span>动作</span></td>
							<td class="status"><span>状态</span></td>
						</tr>
					</thead>
					<tbody class="tbody" id="flowCenter-tbody">
						
					</tbody>
				</table>
				<div id="pagination-panel"></div>
				<div id="content-space"><table height="100%" width="100%" border="0"><tr><td align="center" valign="middle"><div class="content-space-pic iconfont-h5">&#xe050;</div><div class="content-space-txt text-center">没有查询到数据</div></td></tr></table></div>
			</div>
		</div>
	</div>

<script type="text/html" id="tempFlowAccordion">
	{{each app as value}}
	<div class="panel">
		<div class="soft-heading" role="tab" appId="{{value.id}}" flowId="">
			<h4 class="soft-title">
						
			<a role="button" data-toggle="collapse" data-parent="#flowAccordion" href="#{{value.id}}" aria-expanded="true" aria-controls="{{value.id}}">
				<span class="titleSpan">{{value.name}}</span>
				<span class="sum" title="已完结:{{value.endnum}}">{{value.num}}</span>
			</a>
			</h4>
		</div>
		<div class="flow-collapse collapse" role="tabpanel">
			<ul class="list-group">
				{{each value.processedFlowList as flowList}}
				<li  appId="{{value.id}}" flowId="{{flowList.id}}"><a title="{{flowList.name}}">{{flowList.name}}</a><span class="sum">{{flowList.num}}</span></li>
				{{/each}}
			</ul>
		</div>
	</div>
	{{/each}}
</script>
<script type="text/html" id="tempAppList">
	{{each app as value}}
	<li appId="{{value.id}}">
		<a>{{value.name}}</a>
		<span class="sum">{{value.num}}</span>
	</li>
	{{/each}}
</script>
<script type="text/html" id="tempFlowGroup">
	{{each group as value}}
	<li flowId="{{value.id}}"><a title="{{value.name}}">{{value.name}}</a><span class="sum">{{value.num}}</span></li>
	{{/each}}
</script>
<script type="text/html" id="tempTbody_tr">
	{{each list as value}}
	<tr class="tbody_tr" _url={{value._url}} id="{{value.docId}}">
		<td>
			<div class="tdFace">
				{{value.avatar}}
			</div>
			<div class="dept_name"><span class="dept">{{value.initiatorDept}}</span><span class="name">{{value.initiator}}</span></div>
		</td>
		<td><span class="title" title='{{value.subject}}'>{{value.subject}}</span></td>
		<td style="text-align:center;"><span>{{value.timeAgo}}</span></td>
		<td style="text-align:center;"><span class="{{if value.lastFlowOperation == '81'}}backSpaceCol{{/if}}">{{value._flowOperation}}</span></td>
		<td style="text-align:center;"><span class="status">{{value.stateLabel}}</span></td>
	</tr>
	{{/each}}
</script>
</body>
</html>
</o:MultiLanguage>