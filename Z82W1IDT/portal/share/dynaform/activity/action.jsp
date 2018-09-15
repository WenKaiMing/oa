<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  errorPage="/portal/share/error.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page buffer="16kb" %> 

<%@page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%><script type="text/javascript">
	function doAlert(msg){
		alert(msg);
		//OBPM.dialog.doExit();  2011/5/13 由于表单里的子视图弹出编辑时 按钮的保存前脚本返回字符串后会关闭当前窗体而注销 by happy
		window.history.back();
	}

	
</script>
<%
	Document doc = (Document)request.getAttribute("content");
	Activity act = (Activity) request.getAttribute("ACTIVITY_INSTNACE");

	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);

	ParamsTable params = ParamsTable.convertHTTP(request);


	
	if ((act.getBeforeActionScript()) != null
		&& (act.getBeforeActionScript()).trim().length() > 0 && act.getType() != ActivityType.DISPATCHER && act.getType() != ActivityType.PRINT_VIEW
		&& act.getType() != ActivityType.PRINT && act.getType() != ActivityType.PRINT_WITHFLOWHIS
		&& act.getType() != ActivityType.FLEX_PRINT && act.getType() != ActivityType.EXPTOPDF && act.getType() != ActivityType.START_WORKFLOW
		&& act.getType() != ActivityType.WORKFLOW_PROCESS 
		&& act.getType() != ActivityType.DOCUMENT_CREATE && act.getType() != ActivityType.FILE_DOWNLOAD && act.getType() != ActivityType.PRINT_VIEW) {
		Object result = null;
		try{
			result = act.runBeforeActionScript(doc,params,webUser);
		}catch(Throwable e){
			
		}
		if (result != null){
			if (result instanceof String && ((String)result).trim().length() > 0) {
				result = new JsMessage(JsMessage.TYPE_ALERT,(String)result);
				//out.println("<textarea name='msg' id='msg' style='display:none'>"+result+"</textarea>");
				//out.println("<script>doAlert(document.getElementById('msg').value);</script>");
				//return;
			}
			if(result instanceof JsMessage){
				request.setAttribute("message", result);
				new OBPMDispatcher().forward(act.getBackAction(),request, response);
				return;
			}
		}
	}
	
	//流程开启按钮脚本处理模式
	if(act.getType()==ActivityType.START_WORKFLOW && act.getEditMode()==1){
		Object result = null;
		try{
			result = act.runStartFlowScript(doc,params,webUser);
		}catch(Throwable e){
			e.printStackTrace();
		}
		request.setAttribute("selectFlow", result);
	}
	
	boolean isRedirect = false;
	
	String actionUrl = act.getActionUrl();
	
	if (isRedirect) {
		new OBPMDispatcher().sendRedirect(actionUrl,request, response);
	} else {
		new OBPMDispatcher().forward(actionUrl,request, response);
	}
	
	if (act.getType() == ActivityType.FILE_DOWNLOAD){
		throw new Exception("");
	}
	
%>