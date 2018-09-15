<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<div class="widgetContent" _type="announcement">
	<table class="viewTable" moduletype="viewList" style="table-layout: fixed;width: 100%;">
		<tr class="header widgetItem">
			<td style="font-weight: bold;">标题</td>
			<td style="font-weight: bold;width:70px;">发布日期</td>
		</tr>
		<s:iterator value="#request.data" status="index">
			<s:url id="viewDocURL" action="readFromWidget" namespace="/portal/widget">
				<s:param name="id" value="id" />
			</s:url>
			<tr class="header widgetItem" id='<s:property value="id"/>' title="消息中心" _isread='<s:property value="read" />' 
				_url='<s:url value="/message/message.jsp"/>?messageId=<s:property value="id"/>' style="padding: 3px 5px;">
				<td title="<s:property value="title" />" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
					<s:property value="title" />
				</td>
				<td style="width:70px;"><s:property value="%{getText('{0,date,yyyy-MM-dd }',{createTime})}"/></td>
			</tr>
		</s:iterator>
	</table>
</div>
</o:MultiLanguage>
