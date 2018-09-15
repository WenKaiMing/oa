<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String cmd = request.getParameter("cmd");
	String label = request.getParameter("label");
	if (cmd != null && cmd.trim().length() > 0 && label != null
			&& label.trim().length() > 0) {
		RuntimeInfo r = Moniter.getRunningInfo(label);
		if (r != null && r.getCurrThread() != null) {
			Thread t = r.getCurrThread();
			if (cmd.equalsIgnoreCase("STOP")) {
		t.stop();
		Moniter.unRegistRunningInfo(label);
			} else if (cmd.equalsIgnoreCase("PAUSE")) {
		t.suspend();
		Moniter.unRegistRunningInfo(label);
			} else if (cmd.equalsIgnoreCase("RESUME")) {
		t.resume();
		Moniter.unRegistRunningInfo(label);
			}
		}
	}
%>
<html><o:MultiLanguage>
<head>
<title>{*[RunningState]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
</head>

<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>

<table align='center'>
	<tr align='left'>
		<td colspan=5>Script Running State:</td>
	</tr>
	<tr bgcolor='#AAAAAA'>
		<td>Script Label</td>
		<td>Cost Time</td>
		<td colspan=3>OPTs</td>
	</tr>
	<%
		Collection runningInfos = Moniter.getRunningInfos().values();
		for (Iterator iter = runningInfos.iterator(); iter.hasNext();) {
			RuntimeInfo rt = (RuntimeInfo) iter.next();
			out
			.write("<tr bgcolor='#EEEEEE'><td>"
					+ rt.getLabel()
					+ "</td><td>"
					+ (System.currentTimeMillis() - rt
					.getRecentlyStartTime())
					+ "</td>"
					+ "<td><input type='button' value='Stop' onclick='window.location=\"viewStates.jsp?cmd=stop&label="
					+ rt.getLabel() + "\"'/></td>"
					+ "<td><input type='button' value='Pause' onclick='window.location=\"viewStates.jsp?cmd=pause&label="
					+ rt.getLabel() + "\"'/></td>"
					+ "<td><input type='button' value='Resume' onclick='window.location=\"viewStates.jsp?cmd=resume&label="
					+ rt.getLabel() + "\"'/></td>"
					+ "</tr>");
		}
	%>

	<tr align='left'>
		<td colspan=5>History Runned Script:</td>
	</tr>
	<tr bgcolor='#AAAAAA'>
		<td>Script Label</td>
		<td>Running Count</td>
		<td>Cost Time(AVG)</td>
		<td>Cost Time(Rct)</td>
		<td>Cost Time(Ttl)</td>
	</tr>
	<%
		Collection runnedInfos = Moniter.getRunnedInfos().values();
		for (Iterator iter = runnedInfos.iterator(); iter.hasNext();) {
			RuntimeInfo rt = (RuntimeInfo) iter.next();
			out.write("<tr bgcolor='#EEEEEE'><td>" + rt.getLabel()
			+ "</td><td>" + (rt.getRunningCount()) + "</td><td>"
			+ (rt.getAverageCostTime()) + "</td><td>"
			+ (rt.getTotalCostTime()) + "</td><td>"
			+ (rt.getRecentlyCostTime()) + "</td></tr>");
		}
	%>
</table>

</body>
</o:MultiLanguage></html>
