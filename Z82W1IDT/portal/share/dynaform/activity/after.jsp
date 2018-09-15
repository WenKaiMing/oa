<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.DocumentProcessBean" %>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page buffer="16kb" %> 

<%@page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%>
<%@page import="cn.myapps.util.Security"%><script type="text/javascript">
	function doAlert(msg, backURL, openType){
		alert(msg);
		if(backURL && backURL != '' && backURL != 'null'){
			document.forms[0].action=backURL;
			document.forms[0].submit();
		}
	}

	function ev_close(){
		var  view_id = '<%=request.getParameter("view_id")%>';
		if(parent){
		    var sub_divid  =parent.document.getElementById('sub_divid');
			var doc_obj = parent.document.getElementById(view_id);
			if (doc_obj) { // 本区域返回
				doc_obj.src= sub_divid.value;
				parent.ev_reloadParent();
				return;
			}
			
			if(parent.frames['main_iframe']){
				var viewiFrame = parent.frames['main_iframe'].frames['detail'].frames[view_id];
				if(viewiFrame){
					try{
					 	viewiFrame.ev_reload()
					 	hidden();
					}catch(ex){}
				}else{
				  parent.close();
				  parent.parentWindow.ev_reload();
				}
			}else{
			  OBPM.dialog.doExit();
			}
		} else {
			OBPM.dialog.doExit();
		}
	}
	//显示软件下拉为可点击状态
	function hidden(){
	      var windowTop = window.top;
	      windowTop.document.getElementById('PopWindows').style.display='none';
	   	  windowTop.document.getElementById('PopWindows').style.display='none';
		  windowTop.document.getElementById('closeWindow_DIV').style.display='none';
		  var doc = windowTop.parent.frames['main_iframe'];
		  var oSelectList = doc.document.getElementsByTagName("SELECT");
		  if (oSelectList.length > 0) {
				for (var i = 0; i < oSelectList.length; i++) {
					oSelectList[i].disabled = false;
		         }
		   }
	}
	function ev_saveAndClose() {
		if (parent && parent.parentWindow) {
			parent.parentWindow.ev_reload();
		}else{
		    var  view_id = '<%=request.getParameter("view_id")%>';
		}
		ev_close();
	}
	
</script>

<form method='post' name='temp' action=''>
<%! 
public boolean isHasBackURL(String backURL) {
	return (backURL != null && !backURL.equals("null") && backURL.trim().length() > 0);
}
%>

<%
	Document doc = (Document)request.getAttribute("content");
	Activity act = (Activity) request.getAttribute("ACTIVITY_INSTNACE");
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String applicationid = request.getParameter(Web.REQUEST_ATTRIBUTE_APPLICATION);
	
	ParamsTable params = ParamsTable.convertHTTP(request);
	
	if (act == null) {
		if(request.getParameter("_isJump")!=null){
			if(request.getParameter("_isJump").equals("1")){
				act = new Activity();
				act.setType(ActivityType.DOCUMENT_CREATE);
			}
		
		}else
			return;
		
	}
	
	boolean hasFieldErrors = request.getAttribute("fieldErrors")!=null && !((Map)request.getAttribute("fieldErrors")).isEmpty()? true : false;
	if(hasFieldErrors){
		if(!act.getFieldErrorsAction().equals(act.getAfterAction())){
			new OBPMDispatcher().forward(act.getFieldErrorsAction(),request, response);
			return;
		}
	}
	
	String backURL =  request.getParameter("_backURL");
	if (!StringUtil.isBlank(backURL) && !"isJumpToForm".equals(backURL)){
		
		if((request.getContextPath()+"/help/welcome/index.jsp").equals(backURL)){
			backURL = request.getContextPath()+"/help/front/welcome/index.jsp";
		}
		if("/portal/dispatch/homepage.jsp".equals(backURL)){
			backURL = request.getContextPath()+"/portal/dispatch/homepage.jsp?application="+request.getParameter(Web.REQUEST_ATTRIBUTE_APPLICATION);
		}
		
		
		String operation = request.getParameter("operation");
		if (!StringUtil.isBlank(operation)) {
			if(backURL.indexOf("?")>=0){
				backURL += "&operation=" + operation;
			}else{
				backURL += "?operation=" + operation;
			}
		}
		
		//for calendar_view
		String currentDate = (String) params.getParameter("currentDate");
		if (!StringUtil.isBlank(currentDate)) {
			if(backURL.indexOf("?")>=0){
				backURL += "&currentDate="+currentDate;
			}else{
				backURL += "?currentDate="+currentDate;
			}
		}
		
		if(backURL.trim().length()>0 && backURL.indexOf("?application=")<0 && backURL.indexOf("&application=")<0){
			if(backURL.indexOf("?")>=0){
				backURL += "&application="+request.getParameter(Web.REQUEST_ATTRIBUTE_APPLICATION);
			}else{
				backURL += "?application="+request.getParameter(Web.REQUEST_ATTRIBUTE_APPLICATION);
			}
		}
		
	}
	
	Object result = null;
	if ((act.getAfterActionScript()) != null && (act.getAfterActionScript()).trim().length() > 0) {
		try{
			result = act.runAfterActionScript(doc,params,webUser);	
		}catch(Throwable e){
			e.printStackTrace();
		}
		if (result != null) {
			if(act.getType() == ActivityType.DISPATCHER){//跳转页面按钮特殊处理
				result = new JsMessage(JsMessage.TYPE_ALERT,(String)result);
			}
			if(act.getType() == ActivityType.NOTHING){
				backURL = "";
			}
			if (result instanceof String && ((String)result).trim().length() > 0) {
				result = new JsMessage(JsMessage.TYPE_ALERT,(String)result);
			}
			if(result instanceof JsMessage){
				request.setAttribute("message", result);
			}
		}
		
		//更新上下文的DOC
		DocumentProcessBean process = new DocumentProcessBean(applicationid);
		Document _doc = (Document)process.doView(doc.getId());
		request.setAttribute("content", _doc);
	}


	boolean isRedirect = false;
	
	int type = act.getType();
	String openType = request.getParameter("openType");
	String closeScript = "";
	if(result != null && result instanceof JsMessage){
		closeScript = "<script>doAlert('" + ((JsMessage)result).getContent() + "');ev_close();</script>";
	}else{
		closeScript = "<script>ev_close();</script>";
	}
	String actionUrl = act.getAfterAction();
	
	if((type == ActivityType.DOCUMENT_BACK || type==ActivityType.WORKFLOW_PROCESS || type == ActivityType.SAVE_BACK) 
			&& "isJumpToForm".equals(backURL)){
		if(result != null && result instanceof JsMessage){
			out.println("<script>doAlert('" + ((JsMessage)result).getContent() + "');OBPM.dialog.doExit();</script>");
			return;
		}
		out.println("<script>OBPM.dialog.doExit();</script>");
		return;
	}
	if (type == ActivityType.CLOSE_WINDOW) {
		if(openType==null||openType==""){
			if(result != null && result instanceof JsMessage){
				out.println("<script>doAlert('" + ((JsMessage)result).getContent() + "');OBPM.dialog.doExit();document.forms[0].action='"+backURL+"';	document.forms[0].submit();</script>");
				return;
			}
			out.println("<script>OBPM.dialog.doExit();document.forms[0].action='"+backURL+"';	document.forms[0].submit();</script>");
			return;
		}
		out.println(closeScript);
		return;
	} else if (type == ActivityType.SAVE_CLOSE_WINDOW){
		if(openType==null||openType==""){
			if(result != null && result instanceof JsMessage){
				out.println("<script>doAlert('" + ((JsMessage)result).getContent() + "');OBPM.dialog.doExit();document.forms[0].action='"+backURL+"';	document.forms[0].submit();</script>");
				return;
			}
			out.println("<script>OBPM.dialog.doExit();document.forms[0].action='"+backURL+"';	document.forms[0].submit();</script>");
			return;
		}
		out.println(closeScript);
		return;
	} else {
		if (type == ActivityType.SAVE_BACK || type == ActivityType.DOCUMENT_BACK) {
			if (!StringUtil.isBlank(openType) && (new Integer(openType).intValue() == View.OPEN_TYPE_POP 
					|| new Integer(openType).intValue() == View.OPEN_TYPE_DIV)) {
				out.println(closeScript);
				return;
			}
			if( (type == ActivityType.DOCUMENT_BACK || type == ActivityType.SAVE_BACK ) && "".equals(backURL)){
				backURL = request.getContextPath() + "/portal/dispatch/closeTab.jsp?application=" + applicationid;
			}
			if (isHasBackURL(backURL)) {
				if(backURL.indexOf("dialogClose") == 0){
					actionUrl = "/core/sysconfig/desktop/closeWindow.jsp";
					new OBPMDispatcher().sendRedirect(request.getContextPath()+actionUrl,request, response);
					return;
				}else{
					isRedirect = true;
					actionUrl = backURL;
					//修正重定向request中message对象被清除，前台保存返回不弹提示问题
					if (result != null && result instanceof JsMessage) {
						if (actionUrl.indexOf("?") > 0) {
							actionUrl += "&message.type=" + ((JsMessage)result).getType();
							
						} else {
							actionUrl += "?message.type=" + ((JsMessage)result).getType();
						}
						actionUrl += "&message.content=" + Security.bytesToHexString(((JsMessage)result).getContent().getBytes());
					}
				}
			} else {
				out.println(closeScript);
				return;
			}
		} else if (type==ActivityType.WORKFLOW_PROCESS){
			if(backURL.indexOf("dialogClose") == 0){
				actionUrl = "/core/sysconfig/desktop/closeWindow.jsp";
			}else{
				if (!StringUtil.isBlank(openType) && (new Integer(openType).intValue() == View.OPEN_TYPE_POP 
						|| new Integer(openType).intValue() == View.OPEN_TYPE_DIV) && request.getAttribute("_closeDialog") ==null) {
					out.println(closeScript);
					return;
				}
				if(isHasBackURL(backURL) && backURL.indexOf("/portal/dispatch/homepage.jsp") > 0){
					//跳转到后台配置的首页
					isRedirect = true;
					actionUrl = backURL;
				}
			}
		}
		if (isRedirect) {
			StringBuffer queryString = new StringBuffer();
			if(actionUrl.indexOf("?")>=0){
				queryString.append("&isRelate="+request.getParameter("isRelate"));
			}else{
				queryString.append("?isRelate="+request.getParameter("isRelate"));
			}
			if(actionUrl.indexOf("isRelate") >1){
				new OBPMDispatcher().sendRedirect(actionUrl,request, response);
			}else{
				new OBPMDispatcher().sendRedirect(actionUrl+queryString.toString(),request, response);
			}
		}else if(type ==ActivityType.FLEX_PRINT || type ==ActivityType.FLEX_PRINT_WITHFLOWHIS){
			StringBuffer queryString = new StringBuffer();
			queryString.append("?id="+request.getParameter("_printerid"));
			queryString.append("&_docid="+request.getParameter("_docid"));
			queryString.append("&_formid="+request.getParameter("_formid"));
			queryString.append("&_flowid="+request.getParameter("_flowid"));
			if (result != null && result instanceof JsMessage) {
				queryString.append( "&message.type=" + ((JsMessage)result).getType());
				queryString.append( "&message.content=" + Security.bytesToHexString(((JsMessage)result).getContent().getBytes()));
				//queryString.append( "&message.content=" +((JsMessage)result).getContent());
			}
			new OBPMDispatcher().sendRedirect(request.getContextPath()+actionUrl+queryString.toString(),request, response);
		}else{
			new OBPMDispatcher().forward(actionUrl,request, response);
		}
	}
%>
</form>
