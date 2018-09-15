<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="java.util.Collection"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cn.myapps.util.json.JsonUtil"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage" %>

<form method='post' name='temp' action=''>
<%! 
public boolean isForwardURL(String url) {
	url = url.toLowerCase();
	return !(url.indexOf("http") != -1 || url.indexOf("https") != -1|| url.indexOf("www.") != -1);
}

public boolean isHasBackURL(String url) {
	return (url != null && !url.equals("null") && url.trim().length() > 0 && url.indexOf("_backURL") != -1);
}
%>
<%
	Document doc = (Document)request.getAttribute("content");
	Activity act = (Activity) request.getAttribute("ACTIVITY_INSTNACE");
	StringBuffer url = new StringBuffer();
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	ParamsTable params = ParamsTable.convertHTTP(request);
	IRunner runner = JavaScriptFactory.getInstance(params.getSessionid(), params.getParameterAsString("application"));
	runner.initBSFManager(doc, params, webUser, new ArrayList<ValidateMessage>());
	
	if ((act.getDispatcherUrl()) != null
			&& (act.getDispatcherUrl()).trim().length() > 0) {
			
			StringBuffer label = new StringBuffer();
			label.append(" Activity(").append(act.getId()).append(")." + act.getName()).append(".dispatcherUrlScript");
			Object result = runner.run(label.toString(), act.getDispatcherUrl());
			
			if (result != null){
				url.append(result);
			}
	}
	if(url != null && url.length() > 0){
		if(act.getDispatcherParams() != null && act.getDispatcherParams() != ""){
			Collection<Object> col = JsonUtil.toCollection(act.getDispatcherParams(),JSONObject.class);
			for(Iterator<Object> iterator = (Iterator<Object>) col.iterator();iterator.hasNext();){
				JSONObject object = JSONObject.fromObject(iterator.next());
				if (url.toString().indexOf("?") > -1) {
					url.append("&");
				} else {
					url.append("?");
				}
				url.append(object.get("paramKey")).append("=").append(object.get("paramValue"));
			}
		}
	}
	String backURL =  request.getParameter("_backURL");
	String targetUrl = url.toString();

	if(isForwardURL(targetUrl)){
		try{
			if(!isHasBackURL(targetUrl) && !StringUtil.isBlank(backURL)){
				if (targetUrl.indexOf("?") > -1) {
					targetUrl += "&";
				} else {
					targetUrl += "?";
				}
				targetUrl = targetUrl + "_backURL=" + StringUtil.URLEncode(backURL,"UTF-8");
			}
			new OBPMDispatcher().forward(targetUrl,request, response);
		}catch(Exception e){
			e.printStackTrace();
		}
	}else {
		try{
			/**
			String formData = request.getParameter("formData");
			if(!StringUtil.isBlank(formData)){
				if (targetUrl.indexOf("?") > -1) {
					targetUrl += "&";
				} else {
					targetUrl += "?";
				}
				targetUrl += formData;
			}
			**/
			if(!isHasBackURL(targetUrl) && !StringUtil.isBlank(backURL)){
				if (targetUrl.indexOf("?") > -1) {
					targetUrl += "&";
				} else {
					targetUrl += "?";
				}
				targetUrl = targetUrl + "_backURL=" + StringUtil.URLEncode(backURL,"UTF-8");
			}
			if(targetUrl.startsWith("http://") || targetUrl.startsWith("https://")){
				new OBPMDispatcher().sendRedirect(targetUrl,request,response);
			}else{
				new OBPMDispatcher().sendRedirect(request.getScheme()+"://" + targetUrl,request,response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
%>
</form>