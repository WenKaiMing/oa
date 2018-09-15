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
	String jsessionid = request.getSession().getId();
	String mHttpUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();

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
	%>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="/portal/H5/resource/common/include_form_css.jsp" %>
		<title><%=(StringUtil.isBlank(dochtmlBean.getForm().getDiscription())? dochtmlBean.getForm().getName():dochtmlBean.getForm().getDiscription())%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
			<jsp:param name="styleid" value="<%= dochtmlBean.getStyleRepositoryId()%>" />
		</jsp:include>
		
		<script src="<o:Url value='/resource/js/jquery-1.11.3.min.js'/>"></script>
		<%@include file="/portal/H5/resource/common/include_form_js.jsp" %>
		<script type="text/javascript">
			var watermark = {
				show : <%=show%>,
				content : '<%=content%>'
			};
			var WebUser = {
					id:'<%=webUser.getId()%>',
					name:'<%=webUser.getName()%>',
					loginNo:'<%=webUser.getLoginno()%>',
					domainId:'<%=webUser.getDomainid()%>'
				};
			var contextPath = '<%=contextPath%>';
			var jsessionid = '<%=jsessionid%>';
			var mHttpUrl = '<%=mHttpUrl%>';
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
			
			//设置dom高度
			var setContentHeight_Count = 0;
			function setContentHeight(){
				//由于share中的document.js重构弹出层大小使用settimeout(300),暂时添加settimeout(1000)
					var winH = $(window).height();
					var activityTableH = $("#activityTable").outerHeight();
					var $contentTable = $("#_contentTable");
					var contentH = winH - activityTableH - 30;
					if(contentH<300){
						if(setContentHeight_Count <= 20){
							setTimeout(function() {
								setContentHeight_Count++;
								setContentHeight();
							},500);
						}
					}
				
					$contentTable.height(contentH)
					
					Common.Util.renderScroll($contentTable,{});
			};
			
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

				

				if(jQuery("input[name='content.stateid']").val().length>0){
					jQuery(".flowbtn").show();
				}
				self.setInterval("connect2Server()",30000);

				setTimeout(function() {
					setContentHeight();
				},1000);

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
			            texts : [watermark.content] //水印文字,[]数组形式
			        })
				};
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
	<body class="bgcolor-white">	
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
			<input type="hidden" id="contextPath" name="contextPath" value="<%=contextPath%>">
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
	        	<div id="activityTable" class="activity-box">
			        <table id="oLayer" class="table_noborder" style="position: relative">
						<s:if test="parentid != null && parentid != ''">
							<tr id="act" class="front-table-act2">
						</s:if>
						<s:else>
							<tr id="act" class="front-table-act front-table-full-width">
						</s:else>
							<td style="width:100%;" class="formActBtn">
	            				<s:property value="#request.dochtmlBean.getActBtnHTML()" escape="false" />
							</td>

							<!-- 流程节点样式修改 ：三个皮肤，国际化-->
							<td id="current-processing-node-td">
								<div id="flow-panel">
									<div class="flow-status">流程状态
										<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>
									</div>
									<div class="flow-history">
										<img class="flow-history-icon" src="<o:Url value="/resource/images/icon_workflow_history.png"/>" >流程历史
									</div>
									<div id="flow-status-panel" style="display:none">
										<% String proStr = StateMachineHelper.toProcessorHtml(doc, webUser);
											if(!"".equals(proStr)){%>
											<textarea id='flow-json' style="display:none"><%=proStr%></textarea>
										<%} %>
										<div class="flow-status-head">
											<div class="flow-status-head-item pull-left">处理人</div>
											<div class="flow-status-head-item pull-right">流程节点</div>
										</div>
										<div class="flow-status-body">
											<div class="panel-group flow-state-panel" id="flow-Collapse" role="tablist" aria-multiselectable="true">	  
											</div>
										</div>
										<div></div>
									</div>
								</div>
							</td>
						</tr>
					</table>
		        </div>
		        <div id="activity-box-space"></div>
		        <div style="width: 100%;background: #fff;z-index: 20000000;">
		        <%@include file="flowProcessPanel.jsp"%></div> 
			
			</s:if>
			
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
    	<div class="clearfix"></div>
		</s:form>
		
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
		
		<%@include file="./content-tmlp.jsp"%>
	</body>
</html>
</o:MultiLanguage>