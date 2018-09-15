<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

	<s:set name="USER" value="#session['FRONT_USER']" />

	<s:iterator value="datas.datas" status="index">

		<s:url id="viewDocURL" action="view"
			namespace="/portal/dynaform/document">
			<s:param name="_formid" value="formid" />
			<s:param name="_docid" value="docId" />
			<s:param name="application" value="applicationid" />
		</s:url>
		<li class='widgetItem' id='<s:property
				value="id"/>'
			_isread='<s:property value="%{isRead(#USER)}" />'				
			_url='<s:property value="#viewDocURL" escape="false"/>&_backURL=<o:Url value='/closeTab.jsp'/>'><s:property
				value="summary" /></li>
	</s:iterator>
	<span id="total" _total="<s:property value='datas.rowCount'/>" />
</o:MultiLanguage>