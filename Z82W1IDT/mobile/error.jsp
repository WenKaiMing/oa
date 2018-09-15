<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%><%@ page import="java.util.Collection"%>
<%@ page import="java.util.Iterator"%><%@ page import="java.util.Map"%>
<o:MultiLanguage>
	<%
			StringBuffer xml = new StringBuffer();
			xml.append("[ERROR]");
			Map map = (Map) request.getAttribute("fieldErrors");
			if (map != null) {
				Collection cols = (Collection) map.get("SystemError");
				if (cols != null && !cols.isEmpty()) {
					for (Iterator its = cols.iterator(); its.hasNext();) {
						String error = (String) its.next();
						error = error == null ? "" : error;
						error = error.split("JavaScriptRunning")[0];
						xml.append("*" + error.replaceAll("<br>", "") + ";");
					}
				}
			}
			out.write(xml.toString());
	%>
</o:MultiLanguage>