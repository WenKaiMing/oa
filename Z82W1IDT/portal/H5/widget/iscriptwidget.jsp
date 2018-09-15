<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<div>
<o:MultiLanguage>
<div style="height:<s:property value='#request.widget.height'/>px">
	<s:property escape="false" value="#request.data"/>
</div>
</o:MultiLanguage>
</div>