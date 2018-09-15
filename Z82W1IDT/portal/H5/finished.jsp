<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingProcessBean"%>
<%@page import="cn.myapps.base.dao.DataPackage"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="java.text.SimpleDateFormat"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>{*[front.flowcenter.history]*}</title>
<link rel="stylesheet" href="resource/css/bootstrap.min.css" />
<link rel="stylesheet" href="resource/css/myapp.css" />
<link rel="stylesheet" href="resource/css/other.css" />
<link rel="stylesheet" href="<o:Url value='/resource/script/jquery.pagination/jquery.pagination.css'/>" />
<link rel="stylesheet" href="./resource/jquery/obpm.paging.css">

<script type="text/javascript">
var front_nocontent = '{*[front.workflowcenter.nocontent]*}';
</script>
<script src="resource/js/jquery-1.11.3.min.js"></script> 
<script src="resource/script/bootstrap.min.js"></script>
<script type="text/javascript" src="./resource/jquery-ui-1.11.1.custom/jquery-ui.min.js"></script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script> 
<script src="<o:Url value='/resource/script/jquery.pagination/jquery.pagination.js'/>"></script>
<script type="text/javascript" src="./resource/jquery/obpm.paging.js"></script>
<script type="text/javascript" src="./resource/script/template.js"></script>
<script src="./resource/script/flowCenter.js"></script>
<script src="resource/script/common.js"></script>
<script id="appLabelTmpl" type="text/html">
	<!-- app label -->
	<li role="presentation" style="display:none;">
		<a href="#{{appId}}" aria-controls="{{appId}}" role="tab" data-toggle="tab">{{appName}}</a><span>{{_rowcount}}</span>
	</li>
</script>
<script id="appContentTmpl" type="text/html">
		<div class="con-tab swiper-container" role="tabpanel">
			<!-- flowname label -->
			<ul class="con-nav nav nav-tabs swiper-wrapper font12 flowLabel" role="tablist" name="flowLabel" id="flowLabel">
				<li class="swiper-slide" role="presentation">
					<a href="#li-{{appId}}" aria-controls="li-{{appId}}" role="tab" data-toggle="tab">{*[front.workflowcenter.All]*}</a>
				</li>
				{{each flowLists as flows}}
				<li class="swiper-slide" role="presentation">
					<a href="#{{flows.flowName}}" aria-controls="{{flows.flowName}}" role="tab" data-toggle="tab">{{flows.flowName}}<span>{{flows.flowcount}}</span></a>
				</li>
				{{/each}}
			</ul>
			<div class="tab-content" id="tab-content">
				<!-- all -->
				<div role="tabpanel" class="tab-pane" id="li-{{appId}}">
					<ul>
						{{each lis }}
						<li class="widgetItem list-con" id="{{$value.tabDocID}}" _url="{{$value.tabUrl}}" _isRead="{{$value.tabIsRead}}">
							<div class="tabLiFace">
								{{$value.tabAvatar}}
							</div>
							<div class="tabLiCon">
								<div class="tabLiConBox">
									<div class="tabLiConA text-left">
										<span class="tabLiCon-text">[{{$value.tabName}}] {{$value.tabCon}}</span>
									</div>
									<div class="tabLiConB">
										<div class="tabLiTagLeft">
											<span class="tabLiCon-auditornames" _initiator="{{$value.tabInitiator}}" _initiatorId="{{$value.tabInitiatorID}}">{{$value.tabDept}}{{$value.tabInitiator}}</span>
											<span class="tabLiCon-lastprocesstime timeago" title="{{$value.tabTime}}">{{$value.tabTime}}</span>
										</div>
										<div class="tabLiTagRight text-right">
											<span class="tabLiCon-status" title="{{$value.tabState}}">{{$value.tabState}}</span>
										</div>
									</div>
								</div>
							</div>
						</li>
						{{/each}}
					</ul>
					<div id="pagination-panel"></div>
				</div>
				<!-- flowname -->
				{{each flowLists as flows}}
				<div role="tabpanel" class="tab-pane" id="{{flows.flowName}}">
					<ul>
						{{each lis }}
						{{if flows.flowName==$value.tabName }}
						<li class="widgetItem list-con" id="{{$value.tabDocID}}" _url="{{$value.tabUrl}}" _isRead="{{$value.tabIsRead}}">
							<div class="tabLiFace">
								{{$value.tabAvatar}}
							</div>
							<div class="tabLiCon">
								<div class="tabLiConBox">
									<div class="tabLiConA text-left">
										<span class="tabLiCon-text">[{{$value.tabName}}] {{$value.tabCon}}</span>
									</div>
									<div class="tabLiConB">
										<div class="tabLiTagLeft">
											<span class="tabLiCon-auditornames" _initiator="{{$value.tabInitiator}}" _initiatorId="{{$value.tabInitiatorID}}">{{$value.tabDept}}{{$value.tabInitiator}}</span>
											<span class="tabLiCon-lastprocesstime timeago" title="{{$value.tabTime}}">{{$value.tabTime}}</span>
										</div>
										<div class="tabLiTagRight text-right">
											<span class="tabLiCon-status" title="{{$value.tabState}}">{{$value.tabState}}</span>
										</div>
									</div>
								</div>
							</div>
						</li>
						{{/if}}
						{{/each}}
					</ul>
				</div>
				{{/each}}
			</div>
		</div>
</script>
<script type="text/javascript">
template.config("escape",false);	//设置模板是否编码输出变量的 HTML 字符
var contextPath = '<%=request.getContextPath()%>';
var flowCenter = {
	multilingual : {}
};
flowCenter.multilingual["total"] = "{*[front.total]*}";
$(function() {
	//关闭缓存
	$.ajaxSetup({cache:false});
	FC.init();
});
</script>
</head>
<body>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="applicationHelper" />
<!-- 遮挡层 -->
<div id="loadingMask" class="obpm-mask_transparent">
    <div class="obpm-loading">
        <img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
    </div>
</div>
<!-- 输出软件ids，重构使用 -->
<div id="appList" style="display:none" _type="finished">
	<%
	WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	ApplicationHelper ah = new ApplicationHelper();
	Collection<ApplicationVO> apps = ah.getListByWebUser(user);
	String _currpage = request.getParameter("_currpage");
	
	for (ApplicationVO applicationVO : apps) {
		String applicationId = applicationVO.getId();

		out.println("<div _appId='" + applicationId + "' _appName='" + applicationVO.getName() + "'></div>");
	}
	%>
</div>
<!-- 重构后显示内容 -->
<div class="content-box" id="content-box" style="height:100%;">
	<div class="toCreate" role="tabpanel" style="position:relative;">
		<!-- app label -->
		<ul class="app-nav nav nav-tabs" role="tablist" id="appLabel" style="display:none;">
		</ul>
		<div class="finishedSearch">
        	<div id="myStartBtn" class="myStartBtn">
        		<input type="checkbox" name="myStart" value="1"/>
  				<span>{*[front.i.started]*}</span>
  			</div>
  			<div class="input-group textSear">
                <input type="text" name="_subject" id="_subject" autocomplete="off" value="<s:property value="#parameters._subject"/>"
                	 class="form-control" placeholder="{*[front.please.input.search.content]*}">
                <div class="input-group-btn">
                    <button type="button" id="searchBtn" class="btn btn-myapp">{*[Query]*}</button>
                </div>
            </div>
         </div>
		<div class="app-content tab-content" id="appContent">
		</div>
	</div>
</div>
</body>
</html>
</o:MultiLanguage>