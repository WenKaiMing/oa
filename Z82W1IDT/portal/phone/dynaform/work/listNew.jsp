<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<s:set name="USER" value="#session['FRONT_USER']" />

<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<s:iterator value="workDatas.datas" status="rowStatus">
		<s:url id="viewDocURL" action="view"
			namespace="/portal/dynaform/document">
			<s:param name="_formid" value="formId" />
			<s:param name="_docid" value="docId" />
			<s:param name="application" value="applicationId" />
		</s:url>
	
		<s:set name="work" id="work" scope="page" />
		<li _docId='<s:property value="docId" />'
			_flowName='<s:property value="flowName" />'
			_url='<s:property value="#viewDocURL" escape="false"/>'
			_lastProcessTime='<s:date name="lastProcessTime" format="yyyy-MM-dd HH:mm" />'
			_stateLabel='<s:property value="stateLabel" />'
			_initiator='<s:property value="initiator" />'
			_initiatorId='<s:property value="initiatorId" />'
			_initiatorDept='<s:property value="initiatorDept" />'
			_initiatorDeptId='<s:property value="initiatorDeptId" />'			
			_auditorNames='<s:property value="auditorNames" />'
			_isdeletable='<s:property value="%{isDeletable(#USER)}" />'
			_applicationId='<s:property value="applicationId" />'
			_isRead='<s:property value="read" />'
			_auditorIds='<s:property value="auditorList" />'><s:property value="subject" />
		</li> 
	</s:iterator>
	
	
	<div id="paging" _pageNow="<s:property value="workDatas.pageNo" />" _totalRows="<s:property value="workDatas.rowCount" />" _linesPerPage="<s:property value="workDatas.linesPerPage" />"></div>
</o:MultiLanguage>