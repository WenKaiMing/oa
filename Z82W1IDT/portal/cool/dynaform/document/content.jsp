<%@ page language="java" contentType="text/html; charset=UTF-8"
	errorPage="/portal/share/error.jsp"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.dynaform.document.html.DocumentHtmlBean"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;">
	<head>
	<%@include file="/portal/share/common/js_base.jsp"%>
	<%@include file="/portal/share/common/js_component.jsp"%>
		<!--[if !IE]><!-->
		<link rel="stylesheet" href="<s:url value='/portal/share/css/if-not-ie.css'/>" type="text/css" />
		<!--<![endif]-->
		<title><%=dochtmlBean.getForm().getDiscription()%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="renderer" content="webkit|ie-comp|ie-stand">
		<!-- 表单样式 -->
		<link rel="stylesheet" href="<o:Url value='/dynaform/document/css/document.css'/>" type="text/css" />
		<link rel="stylesheet" href="<o:Url value='/dynaform/view/css/displayView.css'/>" type="text/css">
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
		<script src='<o:Url value="/resource/document/obpm.ui.js"/>'></script>
		
		<script type="text/javascript">
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
				dy_lock();		//显示loading层
				initFormCommon();	//表单公用的初始化方法
				$("#contentTable").Isignature();
				adjustDocumentLayout4form();	//调整相关文档布局
				if(jQuery("input[name='content.stateid']").val().length>0){
					jQuery(".flowbtn").show();
				}
				self.setInterval("connect2Server()",30000);
				dy_unlock();		//隐藏loading层
			});
			jQuery(window).resize(function(){
				adjustDocumentLayout4form();//调整相关文档布局
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
		<style>
.listDataTable {
  font-family: Arial, Vendera;
  font-size: 12px;
  z-index: 100;
  border: 1px;
  border-collapse: collapse;
  border-spacing: 1px;
  width: 100%;
  border-top: 1px solid #99BBE8;
  border-left: 1px solid #99BBE8;
}
.listDataTh {
  background-color: #e5edf8;
  height: 24px;
  text-align: center;
  vertical-align: middle;
  z-index: 100;
  overflow: hidden;
  text-overflow: ellipsis;
}
.listDataTable td {
  border-bottom: 1px solid #b4ccee;
  border-right: 1px solid #b4ccee;
}
.listDataThFirstTd {
  font-family: Arial, Vendera, sans-serif;
  height: 24px;
  text-align: center;
  vertical-align: middle;
  width: 22px;
  z-index: 100;
}
</style>
	</head>
	<s:if test="parentid != null && parentid != ''">
		<body style="padding: 0; margin: 0;height:100%;overflow:auto;">
	</s:if>
	<s:else>
		<body class="body-front front-bgcolor1" style="padding:0; margin:0;height:100%;overflow:auto;">
	</s:else>
		<!-- 2011.1.8 因后台执行两次“执行后脚本”而关闭此标签 -->
		<!-- ww:property value="#request.dochtmlBean.doActAfterActionScript()" escape="false"/  -->
		<!-- 遮挡层 -->
		<div id="loadingDivBack" style="position: absolute; z-index: 50; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.1;">
			<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
				<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
			</div>
		</div>
		
		<div id="doc_divid">
			<s:form id='document_content' name='document_content' action="save" method="post" theme="simple">
				<div id="container" class="front-scroll-hidden" style="width: 100%\9;height:100%\9;">
					<input type="hidden" id="dwzUnbind" value="" />
					<input type="hidden" id="printerid" value="<%=printerid%>" />
					<input type="hidden" id="printerWfid" value="<%=printerWfid%>" />
					<input type="hidden" id="handleUrl" name="handleUrl" value="" />
					<s:hidden name="_templateForm" value="%{#parameters._templateForm}" />
					<input type="hidden" id="_flowType" name="_flowType" value="80" />
					<input type="hidden" id="_currid" name="_currid" value="<%=nodeId %>" />
					<div id="install" style="display: none">
						<a id="hreftest" href="<s:url value='/portal/share/component/signature/iSignatureHTML.zip'/>">
							<font color="red"><b>&nbsp;&nbsp;&nbsp;点击下载金格iSignature电子签章HTML版软件</b></font>
						</a>
					</div>
					<!-- 电子签章 --> 
					<s:if test="#request.dochtmlBean.isSignatureExist()">
						<%@include file="/portal/share/dynaform/document/signatureobject.jsp"%>
					</s:if> 
					<s:if test="#request.dochtmlBean.getActivitiesSize()>0">
						<div id="activityTable" style="width: 100%;">
							<table class="table_noborder">
								<tr>
									<td id="actTd">
										<table id="oLayer" class="table_noborder" style="position: relative;">
											<s:if test="parentid != null && parentid != ''">
												<tr id="act" class="front-table-act2">
											</s:if>
											<s:else>
												<tr id="act" class="front-table-act front-table-full-width">
											</s:else>
												<td style="width:100%;">
													<div class="formActBtn">
														<s:property value="#request.dochtmlBean.getActBtnHTML()" escape="false" />
													</div>
												</td>
												
												<td id="processorHtml">
													<!-- 当前审批人列表 -->
													<% String proStr = StateMachineHelper.toProcessorHtml4OldSkin(doc, webUser);
													if(!"".equals(proStr)){%>
													<div class="processor">
														<b><%=proStr%></b>
													</div>
													<%} %>
												</td>
										
												<td id="flowStateHtml">
													<!-- 当前流程状态 -->	
													<%String flowStr = StateMachineHelper.toFlowStateHtml(doc);
													if(!"".equals(flowStr)){
													%>
													<div class="flowstate" onmouseover="showFlowState('flowstate');">
														<b><%=flowStr%></b>									
													</div>
													<%} %>
												</td>
													<td class="flowbtn" style="display: none;">
														<div class="button-cmd">
															<div class="btn_left"></div>
																<div class="btn_mid">
																	<a class="flowicon icon16"  href="###" id='button_act' title='{*[Workflow_Diagram]*}' onclick="ev_viewFlow('{*[Workflow_Diagram]*}')">{*[Diagram]*}
																	</a>
																</div>
															<div class="btn_right"></div>
														</div>
													</td>
													<td class="flowbtn" style="display: none;">
														<div class="button-cmd">
															<div class="btn_left"></div>
																<div class="btn_mid">
																	<a class="flowicon icon16"  href="###" onclick="ev_viewHistory('{*[Workflow_History]*}')" id='button_act' title='{*[History]*}'>{*[History]*}
																	</a>
																</div>
															<div class="btn_right"></div>
														</div>	
													</td>
													<!-- 流程节点样式修改 ：三个皮肤，国际化-->
													<!-- 
													<td id="current-processing-node-td">
														<% NodeRT node = (NodeRT)request.getAttribute("_targetNodeRT");
														if(node !=null){%>
														<div class="current-processing-node-text">
															<div class="formFlowCls currentNode" title="当前审批节点:"><span><%=node.getName()%></span></div>
														</div>
														<%} %> 
													</td>
													-->
											</tr>
												<tr>
													<td style="border-top: 1px solid #eee;" colspan="5">
														<%@include file="/portal/share/workflow/runtime/flowProcessPanel.jsp"%>
													</td>
												</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
					</s:if>
					<div id="contentTable" class="front-scroll-auto front-boder front-bgcolor3" style="border-right: 0px; border-left: 0px; width: 100%; *position:relative;/**上传控件的文件不随滚动条滚动兼容ie6、ie7**/">
						<%@include file="/portal/share/common/msg.jsp"%>
						<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
							<%@include file="/portal/share/common/msgbox/msg.jsp"%>
						</s:if>
						<table class="front-table-full-width front-bgcolor2" id="toAll" style="z-index: 1;">
							<tr>
								<td width="100%" valign="top" colspan="3" id="_formHtml">
									<%
										out.print(dochtmlBean.getFormHTML());
									%>
								</td>
							</tr>
						</table>
						<input type="hidden" name="_flowid" id="_flowid" value="<%=dochtmlBean.getFlowId()%>" />
							<%
								if (dochtmlBean.getDoc().getState() != null) {
												DocumentHelper dh = new DocumentHelper();
							%>
						<table class="front-table-full-width front-bgcolor2" style="z-index: 1;">
							<s:hidden id="auditorList" name="content.auditorList" />
							<s:hidden id="isSubDoc" name="isSubDoc" value="true" />
						</table>
						<%
							}
						%>
					</div>
					<%@include file="/common/page.jsp"%> 
					<s:token name="document.token" /> <s:hidden name="content.applicationid" />
					<s:hidden name="content.stateid" /> <input type="hidden" name="flowid" id="flowid" value="<%=dochtmlBean.getFlowId()%>" />
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
					<s:if test="%{#parameters.parentid} !=null && %{#parameters.parentid} !=''">
                          <s:hidden name="parentid"  value="%{#parameters.parentid}" />
                    </s:if>
                    <s:else>
                           <input type="hidden" name="parentid"  value="<%=(doc.getParentid()!=null)?doc.getParentid():"" %>"/>
                    </s:else>
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
					<!-- end system field  -->
				</div>
			</s:form>
		</div>
		<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script>
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