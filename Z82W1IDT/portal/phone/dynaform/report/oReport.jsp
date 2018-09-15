<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%String formId = request.getParameter("id"); %>
<%String applicatioId = request.getParameter("application"); %>
<title>自定义报表</title>
<div class="menuReport">
	<div class="report_head">
		<p class="report_title"></p>
		<a href="javascript:void(0);" class="refreshMenuReport" title="刷新">
			<img src="./resource/images/action-refresh.png">
		</a>
	</div>
	<div class="report_body" id="" _formId="<%= formId%>" _applicatioId="<%= applicatioId%>" _type="customizeReport" style="width:100%;height:250px;"></div>
</div>


