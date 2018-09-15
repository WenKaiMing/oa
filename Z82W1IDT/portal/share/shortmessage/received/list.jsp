<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>"
		type="text/css" />
	<title>{*[ReceivedMessage]*}</title>
	<script src="<s:url value="/portal/share/script/list.js"/>"></script>
	<script type="text/javascript">
	function ev_delete(){
		var _selects = document.getElementsByName("_selects");
		var falg = false;
		for(var i=0;i<_selects.length;i++){
			var select = _selects[i];
			if(select.checked){
				falg =true;
				break;
			}
		}
		if(falg){
			document.forms[0].action='<s:url action="delete"/>';
			document.forms[0].submit();
		}else{
			alert("请选择需要删除的数据");
		}
	}
	
	</script>
	</head>
<body style="overflow:hidden;margin-left:0px;margin-top:5px; margin-right:5px;" class="body-front">
<div id="container">
	<s:form name="formList" action="list" method="post" theme="simple">
		<%@include file="/common/list.jsp"%>
		<s:hidden name="sm_parent" value="%{#parameters.sm_parent}" />
<div id="activityTable">
<table class="act_table" width="100%" border=0 cellpadding="0" cellspacing="0">
		<tr>
			<td>
<span class="button-document"><a href="###" onclick="ev_delete();"><span><img src="<s:url value="/resource/imgv2/front/act/act_3.gif"/>">{*[Delete]*}</span></a></span>				
			</td>
		</tr>
	</table>
</div>
<div id="dataTable">	
<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<table class="display_view-table" border="0" cellpadding="0" cellspacing="0"
			width="100%">
			<tr class="dtable-header">
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col"><o:OrderTag field="status"
					css="ordertag">{*[Status]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag field="content"
					css="ordertag">{*[Content]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag
					field="receiver" css="ordertag">{*[Sender]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag
					field="receiverDate" css="ordertag">{*[ReceivedDate]*}</o:OrderTag></td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<s:if test="#index.odd == true">
					<tr class="table-text">
				</s:if>
				<s:else>
					<tr class="table-text2">
				</s:else>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id"/>"></td>
				<td><s:if test="status==1">
					<img src="<s:url value="/resource/imgnew/sm_read.gif"/>"
						alt="{*[read]*}" />
				</s:if> <s:else>
					<img src="<s:url value="/resource/imgnew/sm_newrc.gif"/>"
						alt="{*[unread]*}" />
				</s:else></td>
				<td><a
					href='<s:url action="view">
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="application" value="#parameters.application" />
				<s:param name="sm_parent" value="%{#parameters.sm_parent}"/>
				<s:param name="id" value="id"/></s:url>'>
				<s:property value="content" /></a></td>
				<td><a
					href='<s:url action="view">
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="application" value="#parameters.application" />
				<s:param name="sm_parent" value="%{#parameters.sm_parent}"/>
				<s:param name="id" value="id"/></s:url>'>
				<s:property value="sender" /></a></td>
				<td><a
					href='<s:url action="view">
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="application" value="#parameters.application" />
				<s:param name="sm_parent" value="%{#parameters.sm_parent}"/>
				<s:param name="id" value="id"/></s:url>'>
				<s:property value="receiveDate" /></a></td>
				</tr>
			</s:iterator>
		</table>
		</div>
		<div id="pageTable" style="visibility: hidden;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="page-nav"><td>
			<s:if test="_isPagination == 'true'">
				<s:if test="datas.pageNo  > 1">
					<a href='javascript:showFirstPage()'><img src="<o:Url value='/resource/imgv2/front/main/pg_first.gif' />" alt="{*[FirstPage]*}"></a>&nbsp;
					<a href='javascript:showPreviousPage()'><img src="<o:Url value='/resource/imgv2/front/main/pg_previous.gif' />" alt="{*[PrevPage]*}"></a>&nbsp;
				</s:if>
				<s:else>
					<img src="<o:Url value='/resource/imgv2/front/main/pg_first_d.gif' />" alt="{*[FirstPage]*}">&nbsp;
					<img src="<o:Url value='/resource/imgv2/front/main/pg_previous_d.gif' />" alt="{*[PrevPage]*}">&nbsp;
				</s:else>
				<img src="<o:Url value='/resource/imgv2/front/main/act_seperate.gif' />"/>&nbsp;
				{*[Page]*} <s:property value='datas.pageNo' /> of <s:property value='datas.pageCount' />
				<img src="<o:Url value='/resource/imgv2/front/main/act_seperate.gif' />"/>&nbsp;
				<s:if test="datas.pageNo < datas.pageCount">
					<a href='javascript:showNextPage()'><img src="<o:Url value='/resource/imgv2/front/main/pg_next.gif' />" alt="{*[NextPage]*}"></a>&nbsp;
					<a href='javascript:showLastPage()'><img src="<o:Url value='/resource/imgv2/front/main/pg_last.gif' />" alt="{*[EndPage]*}"></a>&nbsp;
				</s:if>
				<s:else>
					<img src="<o:Url value='/resource/imgv2/front/main/pg_next_d.gif' />" alt="{*[NextPage]*}">&nbsp;
					<img src="<o:Url value='/resource/imgv2/front/main/pg_last_d.gif' />" alt="{*[EndPage]*}">&nbsp;
				</s:else>
				<img src="<o:Url value='/resource/imgv2/front/main/act_seperate.gif' />"/>&nbsp;
			</s:if>
			<s:if test="_isShowTotalRow == 'true'">
				<td align="right">{*[TotalRows]*}:(<s:property value="totalRowText" />)</td>
			</s:if>
		</td></tr>
	</table>
	</div>
	</s:form>
	</div>
	</body>
</o:MultiLanguage>
</html>
