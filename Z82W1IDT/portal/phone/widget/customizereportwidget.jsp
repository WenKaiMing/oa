<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<%String id = request.getParameter("id"); %>
<%String name = request.getParameter("widgetTitle"); %>
<html>
<body>
	<div class="report_head" style="position: relative;margin-bottom:0;">
		<p style="text-align:center;line-height: 25px;font-size: 18px;font-weight: 600;color: #4F4F4F;margin-bottom:0;"><%=name%></p>
		<a style="position: absolute;right: 10px;top: 0;line-height: 25px;" href="javascript:void(0);" class=refreshReport title="刷新" _id="<%=id%>" name="<%=name%>"><img src="./resource/images/action-refresh.png" style="margin-top:5px;"/></a>
	</div>
	<div id="ec<%=id%>"  name="<%=name%>" class="widgetId" style="height:250px;border:0px solid #ccc;padding:0px 2px;text-align:center;"></div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	var cid = '<s:property value="#request.widget.actionContent"/>';
	$("#ec<%=id%>").attr("cid",cid);
});
</script>
</html>
</o:MultiLanguage>
