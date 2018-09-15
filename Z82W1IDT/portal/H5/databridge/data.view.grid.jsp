<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@ include file="/portal/share/common/lib.jsp"%>
<%
	ViewHtmlBean htmlBean = new ViewHtmlBean();
	htmlBean.setHttpRequest(request);
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<% out.print(htmlBean.toHTMLText4Grid()); %>
<input type="hidden" name="_isPagination" value='<s:property value="%{_isPagination}"/>' />
<input type="hidden" name="_isShowTotalRow" value='<s:property value="%{_isShowTotalRow}"/>' />
<input type="hidden" name="_currpage" value='<s:property value="datas.pageNo"/>' />
<input type="hidden" name="_rowcount" value='<s:property value="totalRowText" />' />
<input type="hidden" name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
<input type="hidden" name="_pageCount" value='<s:property value="datas.pageCount"/>' />
</o:MultiLanguage>