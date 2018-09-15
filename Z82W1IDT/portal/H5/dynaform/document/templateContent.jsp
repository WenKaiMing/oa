<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.dynaform.document.html.DocumentHtmlBean"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page import="cn.myapps.core.workflow.engine.StateMachineHelper"%>
<%@ page import="cn.myapps.core.dynaform.document.action.DocumentHelper"%>
<%@ page import="cn.myapps.core.workflow.storage.runtime.ejb.NodeRT" %>
<%@ page import="cn.myapps.core.workflow.engine.StateMachine" %>
<%@ page import="cn.myapps.core.workflow.storage.runtime.ejb.NodeRT" %>
<%@include file="/portal/share/common/lib.jsp"%>
<s:bean name="cn.myapps.core.privilege.operation.action.OperationHelper" id="oh" />
	<s:url id="backURL" value="/portal/dispatch/closeTab.jsp" >
		<s:param name="application" value="#parameters.application" />
	</s:url>
	<s:url id="viewDocURL" action="view" namespace="/portal/dynaform/document">
	</s:url>
	
	<s:url id="moreDocURL" action="moreDoc" namespace="/portal/dynaform/document">
		<s:param name="application" value="#parameters.application" />
		<s:param name="summaryCfgId" value="%{#parameters.summaryCfgId}" />
	</s:url>
<%
	String contextPath = request.getContextPath();

	Document doc = (Document) request.getAttribute("content");
	String nodeValue = (String) request.getParameter("node");
	String superior_node_fieldName = (String) request
			.getParameter("super_node_fieldName");
	if (nodeValue != null && superior_node_fieldName != null) {
		doc.addStringItem(superior_node_fieldName, nodeValue);
	}
	WebUser webUser = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	
	if("true".equals(request.getAttribute("_isPreview"))){
		webUser = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_PREVIEW_USER);
	}

	DocumentHtmlBean dochtmlBean = new DocumentHtmlBean();
	dochtmlBean.setHttpRequest(request);
	dochtmlBean.setHttpResponse(response);
	dochtmlBean.setWebUser(webUser);
	request.setAttribute("dochtmlBean", dochtmlBean);
	
	String nodeId = "";
	if (doc.getStateid() != null && doc.getStateid().length()>0) {
		String defaultNodeId = (String)request.getAttribute("_targetNode");
		if(defaultNodeId !=null && defaultNodeId.length()>0){ 
			nodeId = defaultNodeId;
		}else{
			NodeRT nodert = StateMachine.getCurrUserNodeRT(doc, webUser,defaultNodeId);
			if(nodert != null){
				nodeId = nodert.getNodeid();
			}
		}
	}
	//use in signatureobject.jsp
	String view_id = request.getParameter("_viewid");
	String mDoCommandUrl = dochtmlBean.getMDoCommandUrl();
	
	dochtmlBean.isOpenAble(view_id, contextPath);

    Form form = dochtmlBean.getForm();
    Boolean showWaterMark = form.getShowWaterMark();
    String waterMarkScript = form.getWaterMarkScript();

    boolean show = showWaterMark != null ? showWaterMark : false;
    String content = dochtmlBean.getWaterMark();
    content = content != null ? content : "";
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<%
		String printerid = null;
			String printerWfid = null;
			Activity flexPrintAct = dochtmlBean.getFlexPrintAct();
			Activity flexPrintWFHAct = dochtmlBean.getFlexPrintWFHAct();
			if (flexPrintAct != null) {
				printerid = flexPrintAct.getOnActionPrint();
			}
			if (flexPrintWFHAct != null) {
				printerWfid = flexPrintWFHAct.getOnActionPrint();
			}
	%>
<!DOCTYPE html>
<html>
	<head>
	<%@include file="/portal/H5/resource/common/js_base.jsp" %>
	<%@include file="/portal/H5/resource/common/js_component.jsp" %>
		<link rel="stylesheet" href="<s:url value='/portal/H5/resource/css/form.css'/>" type="text/css" />
<%-- 		<title><%=(StringUtil.isBlank(dochtmlBean.getForm().getDiscription())? dochtmlBean.getForm().getName():dochtmlBean.getForm().getDiscription())%></title>
 --%>		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!-- 表单样式 -->
		<link rel="stylesheet" href="<o:Url value='/resource/css/base.css'/>" type="text/css" />
		<link rel="stylesheet" href="<o:Url value='/resource/css/documentModule.css'/>" type="text/css" />
		<link rel="stylesheet" href="<o:Url value='/dynaform/document/css/document.css'/>" type="text/css" />
		<!-- 样式库样式 -->
		<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
			<jsp:param name="styleid" value="<%= dochtmlBean.getStyleRepositoryId()%>" />
		</jsp:include>
		
		<!-- 图片滑动控件样式 -->
		<link rel="stylesheet" href="<s:url value='/portal/share/css/slider.css' />" type="text/css" />
		<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
		<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
		<script src='<s:url value="/dwr/interface/StateMachineUtil.js"/>'></script>
		<script src='<s:url value="/portal/share/script/unload.js"/>'></script>
		<script src='<s:url value="/portal/share/component/showHistoryRecord/obpm.showHistoryRecord.js"/>'></script>
		<script src='<s:url value="/portal/share/component/pending/obpm.pending.js"/>'></script>
		<script src='<s:url value="/portal/share/script/document/document.js"/>'></script>
		<script type='text/javascript' src='<s:url value="/dwr/interface/RoleUtil.js"/>'></script>
		<script src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
		<script src='<o:Url value="/resource/js/obpm.ui.js"/>'></script>
		
		
		<script type="text/javascript">
			var watermark = {
				show : <%=show%>,
				content : '<%=content%>'
			}
			var WebUser = {
					id:'<%=webUser.getId()%>',
					name:'<%=webUser.getName()%>',
					loginNo:'<%=webUser.getLoginno()%>',
					domainId:'<%=webUser.getDomainid()%>'
				};
			var contextPath = '<%=contextPath%>';
			var queryString = "<%=request.getQueryString()%>";
			var contentId = '<s:property value="content.id" />';	//Signatures4Judge()
			var typeName = '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
			var urlValue = '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}">'+
				'<s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';	//showPromptMsg()
			var application = '<%=request.getParameter("application")%>';	//email_transpond(),viewDoc()
			var docidR = '<%=request.getParameter("_docid") %>';	//email_transpond()
			var formidR = '<%=request.getParameter("_formid") %>';	//email_transpond()
			var super_node_fieldNameR = '<s:property value="#parameters.super_node_fieldName"/>';	//Initialization4Node()
			var nodeR = '<s:property value="#parameters.node"/>';	//Initialization4Node()
			var escapeR = '<s:property value="#moreDocURL" escape="false"/>';	//doMoreDocR()
			var viewDocUrl = '<s:property value="#viewDocURL" escape="false"/>'; //viewDoc()
			var backUrl = '<s:property value="#backURL" escape="false"/>';	//viewDoc()
			var closeStr = '{*[Close]*}';	//showHistoryRecord
			var HistoryRecord ='{*[History]*}{*[Record]*}';	//showHistoryRecord
			
			jQuery(document).ready(function(){
				setTimeout(function(){
					var tab = $(window.parent.document).find("li.navbar-tabs-item.selected .nav-title");
					if(tab && "..."==tab.text()){
						var title = $("title").text()
						tab.text(title);
					}
				}, 10);
				showLoading();		//显示loading层
				initFormCommon();	//表单公用的初始化方法
				$("#_contentTable").Isignature();

				self.setInterval("connect2Server()",30000);
				
				Common.Util.renderScroll($("body"),{horizrailenabled: false});
				
				hideLoading();		//隐藏loading层

				$('.form_date').datetimepicker({
			        language:  'zh-CN',
			        weekStart: 1,
			        todayBtn:  1,
					autoclose: 1,
					todayHighlight: 1,
					startView: 2,
					minView: 2,
					forceParse: 0
			    });
				if(watermark.show){
					$("body").watermark({
			            texts : [watermark.content], //水印文字,[]数组形式
			        })
				}
			});

			/*与服务端保持连接*/
			function connect2Server(){ 
				jQuery.ajax({	
					type: 'post',
					//async:false,
					url : '<s:url action="connect" namespace="/portal/dynaform/document" />',
					dataType : 'text',
					data : {id:'<s:property value="content.id" />'},
					//data: //jQuery("#document_content").serialize(),
					success:function(result) {
						//alert(result);
					},
					error: function(x) {
						
					}
				});
			}
		</script>
	</head>
	<body>
	<!-- 2011.1.8 因后台执行两次“执行后脚本”而关闭此标签 -->
	<!-- ww:property value="#request.dochtmlBean.doActAfterActionScript()" escape="false"/  -->
	<!-- 遮挡层 -->
	<div id="loadingMask" class="obpm-mask_transparent">
	    <div class="obpm-loading">
	        <img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
	    </div>
	</div>
	<div id="refresh-loadingDivBack" style="position: fixed; z-index: 110; top: 10px; right: 10px; filter: alpha(opacity = 0.5); opacity: 0.5; display:none;">
		<div>
			<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
		</div>
	</div>
		
	<div id="form-content">
	<div id="doc_divid">
		<s:form id='document_content' name='document_content' action="save" method="post" theme="simple">
			<div id="container" class="oa_right">
	        <div id="_contentTable" class="formTable">
				<%@include file="../../resource/common/msg.jsp"%>
				<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
				<%@include file="/portal/share/common/msgbox/msg.jsp"%>
				</s:if>
				<div id="toAll">
				<div id="_formHtml">
				<%
					out.print(dochtmlBean.getFormHTML());
				%>
				</div>
				</div>
				</div>
					<%@include file="/common/page.jsp"%> 
		</s:form>
				<s:token name="document.token" /> <s:hidden name="content.applicationid" />
				<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" /> <!-- 隐藏属性 --> 
				<s:hidden id="operation" name="operation" value="%{#parameters.operation}" /> 
				<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
			 	<s:hidden id="_backURL" name="_backURL" value="%{#parameters._backURL[0]}" />
	</div>
</div>
		<div id="overDiv" style="position: absolute; visibility: hiden; z-index: 1;"></div>
		<div ID="suggestDiv" STYLE="display: none">
			<select ID="suggestBox" STYLE="display: none" multiple></select>
		</div>
		<div style="position: absolute;" id="messageDiv"></div>
		<div style="position: absolute;" id="tipDiv" onmouseout="clearData();"></div>
		<div id="closeWindow_DIV" class="black_overlay"></div>
		<div id="PopWindows" class="white_content">
				<div id="dheader" class="dheader">
					<div id="dheader_title" class="title">{*[]*}</div>
					<div id="close" class="close">
						<img align="middle" style="border: 0px; cursor: pointer;" onClick="closeParentDiv()" id="closeImg" title="{*[Close]*}" src="<o:Url value='/resource/document/close.gif'/>" />
					</div>
				</div>
				<div id="dbody" class="dbody"></div>
		</div>
	</body>
</html>
</o:MultiLanguage>