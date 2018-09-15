<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
   	// 初始化HtmlBean
	ViewHtmlBean htmlBean = new ViewHtmlBean();
    htmlBean.setHttpRequest(request);
    WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
    htmlBean.setWebUser(webUser);
    String name = request.getParameter("widgetTitle");
    request.setAttribute("htmlBean", htmlBean);
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

<!--  正确的做法，应该在输出的table数据结构中，带上applicationid（因为非常重要，而且必然会用到），而不是由JSP自行获取
而Table中，标题应该用TH作为标识，这样在渲染的时候，可以更为简洁
-->
<section class="widgetContent itemContent" _type="view" _viewid="<s:property value='#request.content.id'/>" _applicationId="<s:property value='#request.content.applicationid'/>" _height="<s:property value='#request.widget.height'/>">
	<header><%=name %></header>
	<article>
	<%
		out.print(htmlBean.toHTMLText());
	%>
	</article>
</section>
</o:MultiLanguage>
