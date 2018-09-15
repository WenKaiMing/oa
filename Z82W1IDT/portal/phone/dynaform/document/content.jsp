<%@page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.dynaform.document.html.DocumentHtmlBean"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.workflow.engine.StateMachineHelper"%>
<%@ page import="cn.myapps.core.dynaform.document.action.DocumentHelper"%>
<%@ page import="cn.myapps.core.workflow.storage.runtime.ejb.NodeRT" %>
<%@ page import="cn.myapps.core.workflow.engine.StateMachine" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.workflow.FlowState"%>
<%@ page import="cn.myapps.core.workflow.FlowType"%>
<%@ page import="cn.myapps.core.workflow.element.*"%>
<%@ page import="cn.myapps.core.workflow.storage.definition.ejb.*"%>
<%@ page import="cn.myapps.util.ProcessFactory" %>
<%@page import="cn.myapps.util.StringUtil"%>
<%@include file="/portal/share/common/lib.jsp"%>
<s:bean name="cn.myapps.core.privilege.operation.action.OperationHelper" id="oh" />
<s:url id="backURL" value="/portal/dispatch/closeTab.jsp" >
	<s:param name="application" value="#parameters.application" />
</s:url>
<s:url id="viewDocURL" action="view" namespace="/portal/dynaform/document"></s:url>
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
	
	Boolean showWaterMark = dochtmlBean.getShowWaterMark();
    
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
	Form _form = dochtmlBean.getForm();
	String _title = _form.getDiscription();
	_title = _title.trim();
	if("".equals(_title)){
		_title = _form.getName();
	}
%>
<title title="form"><%=_title%></title>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<script>
var isCloseDialog = '<%=request.getParameter("isCloseDialog")%>';
var WebUser = {
		id:'<%=webUser.getId()%>',
		name:'<%=webUser.getName()%>',
		loginNo:'<%=webUser.getLoginno()%>',
		domainId:'<%=webUser.getDomainid()%>'
};

var queryString = "<%=request.getQueryString()%>";
var contentId = '<s:property value="content.id" />';	//Signatures4Judge()
var typeName = '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
var urlValue = '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}">'+
	'<s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';	//showPromptMsg()
var docidR = '<%=request.getParameter("_docid") %>';	//email_transpond()
var formidR = '<%=request.getParameter("_formid") %>';	//email_transpond()
var super_node_fieldNameR = '<s:property value="#parameters.super_node_fieldName"/>';	//Initialization4Node()
var nodeR = '<s:property value="#parameters.node"/>';	//Initialization4Node()
var escapeR = '<s:property value="#moreDocURL" escape="false"/>';	//doMoreDocR()
var viewDocUrl = '<s:property value="#viewDocURL" escape="false"/>'; //viewDoc()
var backUrl = '<s:property value="#backURL" escape="false"/>';	//viewDoc()
var watermark = {
		show : <%=show%>,
		content : '<%=content%>'
	};
</script>
<div class="fix_top_panel" style="position: fixed;width:100%;z-index: 5">
<!--流程历史 -->
<div class="weui_panel" id="flowhis_panel" style="display: none;">
	<div class="table text-center" id="flowhis_panel_content"></div>
</div>
<div class="tab-box swiper-container" style="position: relative;z-index: 5">
	<div class="segmented-control reimburse swiper-wrapper" id="form_tab" style="display: none;overflow: initial;"></div>
</div>

</div>

<div class="tab-box-height" style="background:#fff"></div>

<div id="form_continer">
	<span data-id="item1mobile" class="control-content active">
		<div data-role="page" class="jqm-demos jqm-home" id="formContent">
			
			
			<div class="card_app" id="card_app">
			
				<div id="_formHtml" class="contact-form">
  					<%
					out.print(dochtmlBean.getFormHTML());
				%>
				</div>
			</div>
			<div data-role="content" class="ui-content">
				<!-- 参数 -->
				<section id="formParams" name="formParams" style="display:none;">
					<input type="hidden" id="dwzUnbind" value="" />
					<input type="hidden" id="printerid" value="<%=printerid%>" />
					<input type="hidden" id="printerWfid" value="<%=printerWfid%>" />
					<input type="hidden" id="handleUrl" name="handleUrl" value="" />
					<s:hidden name="_templateForm" value="%{#parameters._templateForm}" />
					<input type="hidden" id="_flowType" name="_flowType" value="80" />
					<input type="hidden" id="_currid" name="_currid" value="<%=nodeId %>" />
					<input type="hidden" name="_flowid" id="_flowid" value="<%=dochtmlBean.getFlowId()%>" />
						<%
							if (dochtmlBean.getDoc().getState() != null) {
											DocumentHelper dh = new DocumentHelper();
						%>
						<s:hidden id="auditorList" name="content.auditorList" />
						<s:hidden id="isSubDoc" name="isSubDoc" value="true" />
					<%
						}
					%>
					<%@include file="/common/page.jsp"%>
					<s:token name="document.token" />
					<s:hidden name="content.applicationid" />
					<s:hidden name="content.stateid" />
					<input type="hidden" name="flowid" id="flowid" value="<%=dochtmlBean.getFlowId()%>" />
					<s:if test="#request.dochtmlBean.getParams().getParameterAsArray('view_id')[0] !=null && #request.dochtmlBean.getParams().getParameterAsArray('view_id')[0] !=''">
						<input type="hidden" id="view_id" name="view_id" value='<s:property value="params.getParameterAsArray('view_id')[0]" />' />
					</s:if> 
					<s:else>
						<s:hidden id="_viewid" value="%{#parameters._viewid}" />
						<s:hidden id="view_id" name="view_id" value="%{#parameters._viewid}" />
					</s:else> 
					<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" /> <!-- 隐藏属性 --> 
					<input type="hidden" id="sub_divid" />
					<s:hidden name="signatureExist" id="signatureExist" value="%{#request.dochtmlBean.isSignatureExist()}"></s:hidden>
					<s:hidden name="isComplete" id="isComplete" value="%{#request.dochtmlBean.isFlowComplete()}"></s:hidden>
					<s:hidden name="formid" id="formid" value="%{#parameters._formid}"></s:hidden>
					<input type="hidden" name="applicationid" id="applicationid" value="<%=doc.getApplicationid()%>" />
					<s:hidden name="mGetDocumentUrl" id="mGetDocumentUrl" value="%{#request.dochtmlBean.getMGetDocumentUrl()}"></s:hidden>
					<input type="hidden" name="mLoginname" id="mLoginname" value="<%=webUser.getLoginno()%>" />
					<s:hidden id="openType" name="openType" value="%{#parameters.openType}" />
					<s:hidden id="operation" name="operation" value="%{#parameters.operation}" /> 
					<s:if test="#parameters._docid!=null && #parameters._docid!=''">
						<s:hidden name="_docid" id="_docid" value="%{#parameters._docid}" />
					</s:if>
					<s:else>
						<input type="hidden" name="_docid" id="_docid" value="<%=doc.getId() %>" />
					</s:else>
					<s:hidden name="isRelate" value="%{#parameters.isRelate[0]}" />
					<s:hidden name="_formid" id="_formid" value="%{#parameters._formid}" />
					<s:hidden name="isStartFlow" value="true" />
					<s:hidden name="domainid" value="%{#parameters.domain}" /> <!-- 当前表单对应的菜单编号 -->
					<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
					
					<!-- for calendar_view -->
					<s:hidden name="currentDate" value="%{#parameters.currentDate}" />
					<s:hidden name="content.versions" id="content.versions" />
					<s:hidden name="content.mappingId" />
					<s:hidden name="parentid" value="%{#parameters.parentid}" />
			 		<s:hidden id="_backURL" name="_backURL" value="%{#parameters._backURL[0]}" />
					<s:hidden name="divid" value="%{#parameters.divid}" />
					<s:hidden name="tabid" id="tabid" value="" />
					<input type="hidden" name="defVal" /> <!-- 树形视图参数 -->
					<s:hidden id="treedocid" name="treedocid" value="%{#parameters.treedocid}" /> <!-- 内嵌视图参数 -->
					<s:hidden id="isinner" name="isinner" value="%{#parameters.isinner}" />
					<s:hidden id="isedit" name="isedit" value="%{#parameters.isedit[0]}"/>
					
					<!-- begin system field -->
					<s:hidden name="content.authorDeptIndex" />
					<s:hidden name="content.stateInt" />
					<s:hidden name="content.istmp" />
					<s:hidden name="content.lastmodified" />
					<s:hidden name="content.auditdate" />
					<s:hidden name="content.author.id" />
					
					<s:hidden name="content.created">
						<s:param name="value">
							<s:date name="content.created"/>
						</s:param>
					</s:hidden>
					<s:hidden name="content.stateLabel" />
					<s:hidden name="content.initiator" />
					<s:hidden name="content.audituser" />
					<s:hidden name="content.authorId" />
					<s:hidden name="content.lastFlowOperation" />
					<s:hidden name="content.sign" />
					<s:if test="%{#request._targetNodeRT}"><s:hidden name="targetNodeRT_id" value="%{#request._targetNodeRT.id}"/></s:if>
					<s:if test="%{#request._targetNodeRT}"><s:hidden name="targetNodeRT_name" value="%{#request._targetNodeRT.name}"/></s:if>
				</section>
				<!-- end system field  -->
			</div>
			
		</div>
	</span>
	<div id="div_button_box" class="card_space_fix zindex10">
		<table>
      			<tr class="formActBtn">
				<s:if test="#request.dochtmlBean.getActivitiesSize()>0">
					<s:property value="#request.dochtmlBean.getActBtnHTML()" escape="false" />
				</s:if>
			</tr>
		</table>
	</div>
</div>

<!--BEGIN 催办流程面板-->
<div class="flowReminderDiv" id="flowReminderDiv"
	style="display: none;">
	<div class="weui_mask" style="z-index: 15"
		onclick="jQuery(this).parent().hide();")></div>
	<div class="weui_dialog" style="z-index: 25">
		<div class="weui_dialog_hd">
			<strong class="weui_dialog_title">{*[cn.myapps.core.dynaform.document.reminder]*}</strong>
		</div>
		<div class="weui_dialog_bd">
			<span class="pull-left"></span> <span class="pull-right"></span>
		</div>
		<div class="weui_dialog_bd">
			<input name="_reminderContent" class="flowReminder_content"
				type="text" maxlength="140" style="margin-bottom:0;"></input>
		</div>
		<div class="weui_dialog_ft">
			<a class="weui_btn_dialog default flowReminder_cancel">{*[cn.myapps.core.dynaform.document.reminder.cancel]*}</a>
			<a class="weui_btn_dialog primary flowReminder_submit">{*[cn.myapps.core.dynaform.document.reminder]*}</a>
		</div>
	</div>
</div>
<!--END 催办流程面板-->

<!--BEGIN toast-->
<div id="toast" style="display: none;">
	<div class="weui_mask_transparent"></div>
	<div class="weui_toast">
		<i class="weui_icon_toast"></i>
		<p class="weui_toast_content">{*[cn.myapps.core.dynaform.document.reminder.sended]*}</p>
	</div>
</div>
<!--end toast-->

<!-- 流程提交面板--start -->
<div role="main" class="ui-content" id="page_flowPro" style="display:none;">
<div class="page flow-submit" data-title="提交">
	<s:token name="token"/>
	<div class="page__bd">
		<div class="flow-submit__panel">
	        <div id="flow-submit__node-box"></div>
	        
	        <div class="weui-cells__title"></div>
			<div class="weui-cells weui-cells_form">
				<div class="weui-cell">
					<div class="weui-cell__bd">
						<textarea class="weui-textarea" name="_attitude" placeholder="说点什么吧"></textarea>
					</div>
				</div>
				<div class="weui-cell weui-cell_access flow-submit__proposal flow-submit__proposal_0left" >
					<div class="weui-cell__bd">
						<span>常用意见</span>
						<i class="fa fa-chevron-down pull-right"></i>
					</div>
				</div>
				<div class="flow-submit__proposal-box" style="display:none"></div>
			</div>
 			<div class="weui-cells__title"></div>
			<div class="weui-cells">
	            <div class="weui-cell weui-flex">
	            	<span class="weui-flex__item">手写签批</span>
	            	<div class="flow-submit__write-refresh">
	            		<i class="fa fa-refresh" onclick="$sigdiv.jSignature('clear');"></i>
	            	</div>
	            </div>
	            
	            
	            
	            <div class="con">
					<div class="pen"><div id="signature" style="margin-top:15px;"></div></div>
					<div class="clearfix"></div>
					<s:hidden name="_signature" />
					<s:hidden id="submitTo" name="submitTo" value="%{#parameters.submitTo}"></s:hidden>
					<s:hidden id="_subFlowApproverInfo" name="_subFlowApproverInfo"
						value="%{#parameters._subFlowApproverInfo}"></s:hidden>
					<s:hidden id="_circulatorInfo" name="_circulatorInfo" value=""></s:hidden>
					<s:hidden id="_subFlowApproverInfoAll" name="_subFlowApproverInfoAll"
						value=""></s:hidden>
					<input type="hidden" id="input_hidden_id"/>
				</div>
	        </div>
			<div class="weui-cells__title"></div>
		
		</div>
		
		<div id="div_button_place" class="flow-submit__btn page__bd_spacing">
			<div></div>
			<div></div>
		</div>
	</div>
</div>
</div>
<!-- 流程提交面板--end -->
<!--查看流程历史模态框  -->
<div role="main" class="ui-content" id="viewHistory" style="display:none;">
	<header class="bar bar-nav">
		<a class="icon icon-close pull-right" id="btn-modal-close"></a>
		<h1 class="title">流程历史</h1>
	</header>
	<div class="historyCon" style="background-color:#ebebeb;">
		<div class="card_space" id="flowhis_modal_content">
		</div>
	</div>
</div>
<script>
	if(watermark.show){
		var curPage = ajaxPage.getCurPage();
		curPage.find("#_formHtml").watermark({
	        texts : [watermark.content] //水印文字,[]数组形式
	    })
	};
	var HAS_SUBFORM = false;

	showLoadingToast();
	
	initFormCommon();	//表单公用的初始化方法
	flowInit();			//流程初始化
	flowBtn();			//流程相关按钮渲染

	setTimeout(function(){
		hideLoadingToast();
	},1000)
	
	/**
	if(jQuery("input[name='content.stateid']").val().length>0){
		jQuery(".flowbtn").show();
	}
	**/
	//表单被手机键盘挡住输入框解决方法
	/**
	var ih=window.innerHeight;  
	$(window).resize(function(event) { 
	   if (window.innerHeight<ih) {
	    	$("#_formHtml").css({'margin-top':$("#div_button_box").height()});  
	    }else{  
	    	$("#_formHtml").css({'margin-top':'0'});  
	    };
	}); 
	**/
	//解决ios input/textarea+fixed不兼容
	/**
	var u = navigator.userAgent, app = navigator.appVersion;
	var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
	if(isiOS){
		$("#div_button_box").css("position","static");
		$(".blank").css("height","0px");
	}**/
</script>
	
</html>
</o:MultiLanguage>