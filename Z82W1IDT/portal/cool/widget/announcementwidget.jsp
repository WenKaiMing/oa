<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<div class="widgetContent" _type="announcement">
	<s:iterator value="#request.data" status="index">
		<s:url id="viewDocURL" action="readFromWidget"
			namespace="/portal/widget">
			<s:param name="id" value="id" />
		</s:url>
		<li class='widgetItem' id='<s:property
				value="id"/>'
			_isread='<s:property value="read" />'				
			_url='
				<s:url action="showMsg" namespace="/portal/widget"><s:param name="id" value="id" /><s:param name="read" value="read" /></s:url>&_backURL=<o:Url value='/closeTab.jsp'/>？refreshId=<s:property value="id"/>'
		>
			<s:property value="body.title" />
		</li>
	</s:iterator>
	</div>
</o:MultiLanguage>
