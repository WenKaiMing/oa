<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%><%@page
	import="java.util.Collection"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<o:MultiLanguage>
	<%
		String xml = "[ERROR]{*[Errors]*}:";
			Map map = (Map) request.getAttribute("fieldErrors");
			if (map != null) {
				Collection cols = (Collection) map.get("SystemError");
				if (cols != null) {
					for (Iterator its = cols.iterator(); its.hasNext();) {
						xml += "*" + its.next() + ";";
					}
				}
			}
			out.write(xml);
	%>
</o:MultiLanguage>