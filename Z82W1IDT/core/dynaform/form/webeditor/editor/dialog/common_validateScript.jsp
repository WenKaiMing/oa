<%@ page pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.validate.repository.action.ValidateRepositoryHelper"%>
<o:MultiLanguage>
	<table>
		<%
			String applicationid = request.getParameter("application");
		    ValidateRepositoryHelper vrhpler = new ValidateRepositoryHelper();
			Map sysMap = vrhpler.get_SysValidateScripts();
			for (Iterator iter = sysMap.keySet().iterator(); iter.hasNext();) {
				Object id = (Object) iter.next();
				String name = (String) sysMap.get(id);
		%><tr>
			<td style="white-space: nowrap;"><input type="checkbox" name="validateLibs"
				value="<%=(String)id %>" /><span class="tipsStyle"><%=name%></span></td>
		</tr>
		<%
			}
			Map map = vrhpler.get_ValidateScriptsLib(applicationid);
			for (Iterator iter = map.keySet().iterator(); iter.hasNext();) {
				Object id = (Object) iter.next();
				String name = (String) map.get(id);
		%><tr>
			<td><input type="checkbox" name="validateLibs"
				value="<%=(String)id %>" /><%=name%></td>
		</tr>
		<%
			}
		%>
	</table>
</o:MultiLanguage>