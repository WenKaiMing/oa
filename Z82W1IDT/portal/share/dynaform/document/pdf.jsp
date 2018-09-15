
<%@page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%><%@page import="cn.myapps.util.cache.MemoryCacheUtil"%>
<%@page import="cn.myapps.util.pdf.PdfUtil"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.DocumentProcess"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.DocumentProcessBean"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page import="cn.myapps.core.dynaform.form.action.FormHelper"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%		
		String contextPath = request.getContextPath(); 
		String currURL = request.getRequestURL().toString();
		boolean isEdit = true;
		WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		
		ParamsTable params = ParamsTable.convertHTTP(request);
		String formid = request.getParameter("_formid");
		Form form = FormHelper.get_FormById(formid);
		if (form == null) {
			throw new Exception("{*[core.form.notexist]*}");
		}
			
		if (currURL.indexOf("new.action") > 0
				|| currURL.indexOf("edit.action") > 0
				|| currURL.indexOf("save.action") > 0) {
			isEdit = true;
		}
		String id = request.getParameter("content.id");
		DocumentProcess docProcess = new DocumentProcessBean(form.getApplicationid());
		Document doc = (Document) MemoryCacheUtil.getFromPrivateSpace(id, webUser);
		if (doc == null) {
			 doc = (Document)docProcess.doView(id);
		}
		
		IRunner runner = JavaScriptFactory.getInstance(params.getSessionid(), form.getApplicationid());
		runner.initBSFManager(doc,  params,	webUser, new ArrayList<ValidateMessage>());
		
		String html = form.toPdfHtml(doc, params, webUser, new ArrayList<ValidateMessage>());
		response.setContentType("application/pdf; charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(form.getName(), "UTF-8") + ".pdf");
		PdfUtil.htmlToPDF(html, response.getOutputStream());
%>
