<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

<div class="widgetContent" _type="link" _applicationId="<s:property value='#request.widget.applicationid'/>">
<s:property value='#request.widget.actionContent' escape="false"/>
</div>
</o:MultiLanguage>
