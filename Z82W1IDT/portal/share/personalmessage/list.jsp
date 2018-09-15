<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="cn.myapps.core.personalmessage.action.PersonalMessageHelper"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="cn.myapps.constans.Web"%>
<%
	String operation = (String) request.getAttribute("operation");
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<s:bean name="cn.myapps.core.personalmessage.action.PersonalMessageHelper"  id="pmh" />
<%
PersonalMessageHelper pmh = new PersonalMessageHelper();
WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
ParamsTable params = ParamsTable.convertHTTP(request);
request.setAttribute("smsCount", pmh.countMessage(user.getId()));
request.setAttribute("smsIsReadCount", pmh.countIsReadMessage(user.getId()));
%>
<title>{*[cn.myapps.core.personalmessage.tab.title.inbox]*}</title>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script type="text/javascript">
	var contextPath = '<%=request.getContextPath()%>';
	var selectTab = '<%=params.getParameter("selectTab")%>';
</script>
<!-- 兼容ie6半透明 -->
<script src='<s:url value='/portal/share/script/iepngfix_tilebg.js' />'></script>
<script src="<s:url value="/portal/share/script/personalmessage.js"/>"></script>
<link rel="stylesheet"
		href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
<style>
#contentTable {overflow-y:auto; overflow-x:hidden;border-top:1px solid #dddddd;}
#navigateTable {width:100%;}
.tab {width:68px;height:22px;}
.butttoncmd{float:left;width:auto;}
.navigateTable table{border-collapse: collapse;}
</style>

<script type="text/javascript">
	function doRemove(action){
		if(jQuery("input[name=_selects]:checked").size() <= 0){
			alert("{*[select_one_at_least]*}");
			return;
		}
		document.forms[0].action = action;
		document.forms[0].submit();
	}
	jQuery(document).ready(function(){
		var recipientsW = jQuery(".recipients").width();
		if(recipientsW != null){
			jQuery(".recipientsDiv").css("width",recipientsW+"px");
		}
	});
</script>
</head>
<body style="overflow: hidden; margin-top:0px; margin-left:0px;" class="body-front">
<s:form name="formList" method="post" theme="simple" action="">
<%@include file="/common/basic.jsp" %>
<input type="hidden" id='isInbox' name="isInbox" value='<%=request.getAttribute("isInbox")%>' />
<input type="hidden" id='isOutbox' name="isOutbox" value='<%=request.getAttribute("isOutbox")%>' />
<input type="hidden" id='isTrash' name="isTrash" value='<%=request.getAttribute("isTrash")%>' />
<div id="container" style="border: 1px solid #dddddd;margin-bottom: 10px;">
<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<div id="navigateTable" class="navigateTable">
	<table class="act_table" style="width:100%">		
		<tr>		
			<td style="width: 95%;">
				<div class="butttoncmd">
				<table style="width:150px;">
					<tr>
						<td>
						<%
							if (operation.equals("outbox")) {
						%>
						<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid"><a
							href="<s:url action="new"/>?domain=<%=request.getParameter("domain")%>">{*[New]*}
						</a></div>
						<div class="btn_right"></div>
						</div>
						<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid"><a href="###"
							onclick="doRemove('<s:url action="totrash"/>')">{*[Delete]*}
						</a></div>
						<div class="btn_right"></div>
						</div>
						<%
							} else if (operation.equals("inbox")) {
						%>
						<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid"><a href="###"
							onclick="doRemove('<s:url action="totrash"/>')">{*[Delete]*}
						</a></div>
						<div class="btn_right"></div>
						</div>
						<%
							} else if (operation.equals("trash")) {
						%>
						<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid"><a href="###"
							onclick="doRemove('<s:url action="retracement"/>')">{*[Retracement]*}
						</a></div>
						<div class="btn_right"></div>
						</div>
						<div class="button-cmd">
						<div class="btn_left"></div>
						<div class="btn_mid"><a href="###"
							onclick="doRemove('<s:url action="delete"/>')">{*[Delete]*}
						</a></div>
						<div class="btn_right"></div>
						</div>
						<%
							}
						%>
						</td>
					</tr>
				</table>
				</div>
			</td>
		</tr>
		<tr height="22px">
			<td align="left">
			<table cellspacing="0" cellpadding="0" style="width:100%">
				<tr>
					<td style="border-bottom:1px solid #dddddd;width:5px;">&nbsp;</td>					
					<td class="tab"><input type="button" id="btnInbox" name="btnInbox" class="btcaption"
						onclick="change(this)" value="{*[cn.myapps.core.personalmessage.tab.title.inbox]*}" /></td>
					<td class="tab"><input type="button" id="btnOutbox" name="btnOutbox" class="btcaption"
						onclick="change(this)" value="{*[cn.myapps.core.personalmessage.tab.title.outbox]*}" /></td>
					<td class="tab"><input type="button" id="btnTrash" name="btnTrash" class="btcaption"
						onclick="change(this)" value="{*[Trash]*}" /></td>						
					<td style="border-bottom:1px solid #dddddd;">&nbsp;</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</div>
<div id="contentTable" style="background-color: white;">
			<% 
				if(operation.equals("inbox")){
			%>
			<table border=0 cellpadding="0" cellspacing="0">
				<tr class="dtable-header">
					<td id="noReadId" class="" width="68px">
					<a href="###" onclick="noRead()">{*[NoRead]*}(<s:property value="#request.smsCount" />)</a>
					</td>
					<td id="alreadyReadId" class="" width="68px">
					<input id="_smsCount" type="hidden" value='<s:property value="#request.smsCount" />' />
					<a href="###" onclick="alreadyRead()">{*[IsRead]*}(<s:property value="#request.smsIsReadCount" />)</a>
					</td>
				</tr>
			</table>
			<% 
				}
			%>
	<table  width="100%" border=0 cellpadding="0" cellspacing="0">
		<tr class="dtable-header">
			<td class="column-head2"><input type="checkbox" onclick="selectAll(this.checked)"></td>
			<%
				if (!operation.equals("outbox")) {
			%>
			<td class="column-head" width="23%">{*[Title]*}</td>
			<td class="column-head" width="45%">{*[Content]*}</td>
			<td class="column-head" width="10%">{*[Sender]*}</td>
			<td class="column-head" width="10%">{*[Type]*}</td>
			<td class="column-head" width="12%">{*[cn.myapps.core.personalmessage.attr.receive_date]*}</td>
			<%
				} else {
			%>
			<td class="column-head" width="23%">{*[Title]*}</td>
			<td class="column-head" width="35%">{*[Content]*}</td>
			<td class="column-head" width="20%">{*[Receiver]*}</td>	
			<td class="column-head" width="10%">{*[Type]*}</td>
			<td class="column-head" width="12%">{*[cn.myapps.core.personalmessage.attr.send_date]*}</td>		
			<%
							}
						%>
			<!-- 
			<td class="column-head">查看</td> -->
			</tr>
		<s:iterator value="datas.datas" status="index" id="personalMsg">
		<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
			<td class="table-td"><input type="checkbox" name="_selects" value="<s:property value="id"/>"></td>
			<%
				if (!operation.equals("outbox")) {
			%>
			<td>
				<s:if test="read">
					<img src="<s:url value='/resource/imgnew/sm_read.gif'/>" title="已读" /></s:if>
				<s:else>
					<img src="<s:url value='/resource/imgnew/sm_newrc.gif'/>" title="未读" /></s:else>
				
				<s:if test = "id == null">
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="body.id" />','', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:if test="#personalMsg.body.title == '已送出通知'">
							{*[cn.myapps.core.workflow.notification.sended]*}
						</s:if>
						<s:elseif test="#personalMsg.body.title == '待办通知'">
							{*[cn.myapps.core.workflow.notification.pending]*}
						</s:elseif>
						<s:elseif test="#personalMsg.body.title == '待办超期通知'">
							{*[cn.myapps.core.workflow.notification.pending.overdue]*}
						</s:elseif>
						<s:elseif test="#personalMsg.body.title == '回退通知'">
							{*[cn.myapps.core.workflow.notification.rollback]*}
						</s:elseif>
						<s:else>
							<s:property value="body.title" />&nbsp;
						</s:else>
					</a>
				</s:if>
				<s:else>
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="id" />','<s:property value="read" />', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:if test="#personalMsg.body.title == '已送出通知'">
							{*[cn.myapps.core.workflow.notification.sended]*}
						</s:if>
						<s:elseif test="#personalMsg.body.title == '待办通知'">
							{*[cn.myapps.core.workflow.notification.pending]*}
						</s:elseif>
						<s:elseif test="#personalMsg.body.title == '待办超期通知'">
							{*[cn.myapps.core.workflow.notification.pending.overdue]*}
						</s:elseif>
						<s:elseif test="#personalMsg.body.title == '回退通知'">
							{*[cn.myapps.core.workflow.notification.rollback]*}
						</s:elseif>
						<s:else>
							<s:property value="body.title" />&nbsp;
						</s:else>
					</a>
				</s:else>
			</td>
			<td>
				<s:if test = "id == null">
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="body.id" />','', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:property value="#pmh.regexHtml(body.content)" />&nbsp;
					</a>
				</s:if>
				<s:else>
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="id" />','<s:property value="read" />', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:property value="#pmh.regexHtml(body.content)" />&nbsp;
					</a>
				</s:else>
			</td>
			<td>
				<s:if test = "id == null">
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="body.id" />','', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:if test="senderId == null || senderId == ''">
						{*[System]*}
						</s:if>
						<s:else>
						<s:property value="#pmh.findUserNameById(senderId)" />&nbsp;
						</s:else>
					</a>
				</s:if>
				<s:else>
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="id" />','<s:property value="read" />', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:if test="senderId == null || senderId == ''">
						{*[System]*}
						</s:if>
						<s:else>
						<s:property value="#pmh.findUserNameById(senderId)" />&nbsp;
						</s:else>
					</a>
				</s:else>
			</td>
			<%
				} else {
			%>
			<td>
				<img src="<s:url value='/resource/imgnew/sm_read.gif'/>" />
				<s:if test = "id == null">
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="body.id" />','', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:if test="#personalMsg.body.title == '已送出通知'">
							{*[cn.myapps.core.workflow.notification.sended]*}
						</s:if>
						<s:elseif test="#personalMsg.body.title == '待办通知'">
							{*[cn.myapps.core.workflow.notification.pending]*}
						</s:elseif>
						<s:elseif test="#personalMsg.body.title == '待办超期通知'">
							{*[cn.myapps.core.workflow.notification.pending.overdue]*}
						</s:elseif>
						<s:elseif test="#personalMsg.body.title == '回退通知'">
							{*[cn.myapps.core.workflow.notification.rollback]*}
						</s:elseif>
						<s:else>
							<s:property value="body.title" />&nbsp;
						</s:else>
					</a>
				</s:if>
				<s:else>
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="id" />','<s:property value="read" />', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:if test="#personalMsg.body.title == '已送出通知'">
							{*[cn.myapps.core.workflow.notification.sended]*}
						</s:if>
						<s:elseif test="#personalMsg.body.title == '待办通知'">
							{*[cn.myapps.core.workflow.notification.pending]*}
						</s:elseif>
						<s:elseif test="#personalMsg.body.title == '待办超期通知'">
							{*[cn.myapps.core.workflow.notification.pending.overdue]*}
						</s:elseif>
						<s:elseif test="#personalMsg.body.title == '回退通知'">
							{*[cn.myapps.core.workflow.notification.rollback]*}
						</s:elseif>
						<s:else>
							<s:property value="body.title" />&nbsp;
						</s:else>
					</a>
				</s:else>
			</td>
			<td>
				<s:if test = "id == null">
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="body.id" />','', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:property value="#pmh.regexHtml(body.content)" />&nbsp;
					</a>
				</s:if>
				<s:else>
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="id" />','<s:property value="read" />', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:property value="#pmh.regexHtml(body.content)" />&nbsp;
					</a>
				</s:else>
			</td>
			<td class="recipients">
				<s:if test = "id == null">
					<div class="recipientsDiv" title="<s:property value="#pmh.findUserNamesByMsgIds(receiverId)" />" style="width:10px; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
						<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="body.id" />','', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:property value="#pmh.findUserNamesByMsgIds(receiverId)" />&nbsp;
						</a>
					</div>
				</s:if>
				<s:else>
					<div class="recipientsDiv" title="<s:property value="#pmh.findUserNamesByMsgIds(receiverId)" />" style="width:10px; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
						<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="id" />','<s:property value="read" />', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:property value="#pmh.findUserNamesByMsgIds(receiverId)" />&nbsp;
						</a>
					</div>
				</s:else>
			</td>
			<%
				}
			%>
			<td>
				<s:if test = "id == null">
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="body.id" />','', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:property value="#pmh.findDisplayText(type)" />&nbsp;
					</a>
				</s:if>
				<s:else>
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="id" />','<s:property value="read" />', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:property value="#pmh.findDisplayText(type)" />&nbsp;
					</a>
				</s:else>
			</td>
			<td>
				<s:if test = "id == null">
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="body.id" />','', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:date name="sendDate" format="yyyy-MM-dd HH:mm:ss" />&nbsp;
					</a>
				</s:if>
				<s:else>
					<a href="javascript:showMessageDetals('<s:property value="datas.pageNo" />','<s:property value="datas.linesPerPage" />','<s:property value="datas.rowCount" />','<s:property value="#parameters.application" />','<s:property value="id" />','<s:property value="read" />', '<s:property value="body.title" />', '<s:property value="#pmh.findDisplayText(type)" />')">
						<s:date name="sendDate" format="yyyy-MM-dd HH:mm:ss" />&nbsp;
					</a>
				</s:else>
			</td>
			</tr>
		</s:iterator>
	</table>
</div>		
<!-- 分页导航(page navigate) -->
<div class="page-nav" id="pageTable" style="position: absolute;bottom:1px;width:100%;" >
	<div class="page_btn">
	<s:if test="datas.pageCount > 1">
    	<span>	
		<s:if test="datas.pageNo  > 1">		
			<a class="first page icon16" href='javascript:showFirstPage()'></a>
			<a class="pre page icon16" href='javascript:showPreviousPage()'></a>
		</s:if>
		<s:else>
			<a class="first_d page icon16"></a>
			<a class="pre_d page icon16"></a>	
		</s:else>
		<div class="pagetxt page">
			<span>
				<s:property value='datas.pageNo' />/<s:property value='datas.pageCount' />{*[Page]*}						
			</span>
		</div>							
		<s:if test="datas.pageNo < datas.pageCount">		
			<a class="next page icon16" href='javascript:showNextPage()'></a>
			<a class="last page icon16" href='javascript:showLastPage()'></a>				
		</s:if> 
		<s:else>
			<a class="next_d page icon16"></a>
			<a class="last_d page icon16"></a>					
		</s:else>		
		</span>
	</s:if>
	{*[TotalRows]*}:(<s:property value="datas.rowCount" />)
	</div>
</div>
<!-- 分页导航结束(end of page navigate) -->
</div>
</s:form>
</body>
</o:MultiLanguage>