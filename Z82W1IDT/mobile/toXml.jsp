<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ include file="/common/tags.jsp"%>
<o:MultiLanguage>
<%String toXml = (String) session.getAttribute("toXml");if (toXml == null) out.write(""); else out.write(toXml);%>
</o:MultiLanguage>