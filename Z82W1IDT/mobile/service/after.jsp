<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ include file="/common/tags.jsp"%>

<%@page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%><o:MultiLanguage>
<%!public boolean isHasBackURL(String backURL) {
		return (backURL != null && !backURL.equals("null") && backURL.trim()
				.length() > 0);
	}%>

<%
	Document doc = (Document) request.getAttribute("content");
	WebUser webUser = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	Activity act = (Activity) request.getAttribute("ACTIVITY_INSTNACE");
	
	ParamsTable params = ParamsTable.convertHTTP(request);
	IRunner runner = null;

	if (act == null) {
		return;
	} else {
		runner = JavaScriptFactory.getInstance(params
				.getSessionid(), act.getApplicationid());
		runner.initBSFManager(doc, params, webUser, new ArrayList<ValidateMessage>());
	}

	if ((act.getAfterActionScript()) != null
			&& (act.getAfterActionScript()).trim().length() > 0) {
		StringBuffer label = new StringBuffer();
		label.append("Activity Action").append(act.getId()).append(
				"." + act.getName()).append("afterActionScript");

		//Run the script
		Object result = runner.run(label.toString(), act
				.getAfterActionScript());

		if (result != null) {
			if (result instanceof JsMessage) {
				request.setAttribute("message", result);
				RequestDispatcher dispatcher = request
						.getRequestDispatcher(act.getBackAction());
				dispatcher.forward(request, response);
				return;
			} else if (result instanceof String
					&& ((String) result).trim().length() > 0) {
				out
						.println("<textarea name='msg' id='msg' style='display:none'>"
								+ result + "</textarea>");
				out
						.println("<script>alert(document.getElementById('msg').value);window.history.back();</script>");
				return;
			}
		}
	}
	boolean isRedirect = false;

	int type = act.getType();
	String _viewid = request.getParameter("_viewid");
	String closeScript = "ERROR";
	String actionUrl = act.getAfterAction();

	if (type == ActivityType.CLOSE_WINDOW
			|| type == ActivityType.SAVE_BACK
			|| type == ActivityType.DOCUMENT_BACK
			|| type == ActivityType.WORKFLOW_PROCESS) {
		if (isHasBackURL(_viewid)) {
			isRedirect = true;
			actionUrl = "/mobile/view/displayView.action?_viewid="
					+ _viewid;
		} else {
			out.println(closeScript);
			return;
		}
	}
	if (isRedirect) {
		response.sendRedirect(actionUrl);
	} else {
		RequestDispatcher dispatcher = ((HttpServletRequest) request)
				.getSession().getServletContext().getRequestDispatcher(
						actionUrl);
		dispatcher.forward(request, response);
	}
%>
</o:MultiLanguage>
