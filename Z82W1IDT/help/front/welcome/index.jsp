<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3{*[myapps.homepage.default.title]*}</title>
<%@include file="/common/tags.jsp"%>
<style type="text/css">
<!--
.STYLE2 {
	font-size: 14px;
	font-weight: bold;
	color: #3764a0;
}

.STYLE3 {
	font-size: 12px;
}

a:link {
	color: #5784c0;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #5784c0;
}
a:hover {
	text-decoration: none;
	color: #0099FF;
}
a:active {
	text-decoration: none;
	color: #000000;
}

body {
	background-position: right bottom;
	background-repeat: no-repeat;
	background-color: #fffff8;
	margin: 20px;
	background-image: url(<s:url value='/resource/template/background.gif'/>);
}

img {
	border-width: 0;
	border: 0;
	border-bottom: 0px;
	bottom: 0px;
}

.table-tr-onchange {
	background-color: #fbefda;
	border-right: 0px solid #b4ccee;
	border-bottom: 0px solid #b4ccee;
}

.table-tr-onchange td{
	border-right: 0px solid #b4ccee;
	border-bottom: 0px solid #b4ccee;
}

.table-tr td {
	border-right: 0px solid #b4ccee;
	border-bottom: 0px solid #b4ccee;
}
-->
</style>
</head>

<body>
<table border="0" height="98%">
	<tr>
		<td colspan="2"
			style="font-size: 28px; color: #15428b; font-weight: bold;"><img
			src="<s:url value='/resource/template/backgroundPop.gif' />"
			width="33" height="50" /> {*[myapps.homepage.default.title]*}？</td>
	</tr>
	<tr>
		<td>
			<table>
				<tr height="100"  onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
					<td><a href="<s:url value='/help/front/template/index_superadmin.jsp'/>">
						<img alt="{*[SuperAdmin]*}" src="<s:url value='/resource/template/index_superadmin.gif'/>"></img>
						</a>
					</td>
					<td width="500">
						<a href="<s:url value='/help/front/template/index_superadmin.jsp'/>">
							<span class="STYLE2">{*[SuperAdmin]*}</span><br /><br />
							<span class="STYLE3">{*[myapps.homepage.default.superAdmin.description]*}。</span>
						</a>
						<a href="<s:url value='/help/front/template/index_domain.jsp'/>"></a>
					</td>
				</tr>
				<tr height="100" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
					<td>
						<a href="<s:url value='/help/front/template/index_developers.jsp'/>">
							<img alt="{*[Developer]*}" src="<s:url value='/resource/template/index_developers.gif' />"></img>
						</a>
					</td>
					<td width="500">
						<a href="<s:url value='/help/front/template/index_developers.jsp'/>">
							<span class="STYLE2">{*[Developer]*}</span><br /><br />
							<span class="STYLE3">{*[myapps.homepage.default.developer.description]*}。</span>
						</a>
					</td>		
				</tr>
				<tr height="100" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
					<td>
						<a href="<s:url value='/help/front/template/index_domain.jsp'/>">
							<img alt="{*[DomainAdmin]*}" src="<s:url value='/resource/template/index_domain.gif' />"></img>
						</a>
					</td>
					<td width="500">
						<a href="<s:url value='/help/front/template/index_domain.jsp'/>">
							<span class="STYLE2">{*[DomainAdmin]*}</span><br /><br />
							<span class="STYLE3">{*[myapps.homepage.default.domainAdmin.description]*}。</span>
						</a>
					</td>
				</tr>
			</table>
		</td>
		<td>
			<table>
				<tr height="100" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
					<td>
						<a href="<s:url value='/help/front/template/index_users.jsp'/>">
							<img src="<s:url value='/resource/template/index_users.gif'/>"></img>
						</a>
					</td>
					<td width="500">
						<a href="<s:url value='/help/front/template/index_users.jsp'/>">
							<span class="STYLE2">{*[myapps.homepage.default.user]*}</span><br /><br />
							<span class="STYLE3">{*[myapps.homepage.default.user.description]*}。</span>
						</a>
					</td>
				</tr>
				<tr height="100" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
					<td>
						<a href="<s:url value='/help/front/template/index_guide.jsp'/>">
							<img src="<s:url value='/resource/template/index_guide.gif'/>"></img>
						</a>
					</td>
					<td width="500">
						<a href="<s:url value='/help/front/template/index_guide.jsp'/>">
							<span class="STYLE2">{*[Wizard]*}</span><br /><br />
							<span class="STYLE3">{*[myapps.homepage.default.wizard.description]*}。</span>
						</a>
					</td>
				</tr>
				<tr height="100" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
					<td>
						<a href="<s:url value='/help/front/template/index_createiscript.jsp'/>">
							<img src="<s:url value='/resource/template/index_iScript.gif'/>"></img>
						</a>
					</td>
					<td width="500">
						<a href="<s:url value='/help/front/template/index_createiscript.jsp'/>">
							<span class="STYLE2">{*[myapps.homepage.default.iScript]*}</span><br /><br />
							<span class="STYLE3">{*[myapps.homepage.default.iScript.description]*}。
							</span>
						</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</o:MultiLanguage>
</html>
