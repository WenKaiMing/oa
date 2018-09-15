<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<% 
	String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.usergroup.submit.contacts]*}</title>
<link rel="stylesheet" href="<s:url value='/portal/share/css/setting-up.css'/>" type="text/css">
<style>
#contentTable {overflow-y:auto; overflow-x:hidden;}
#navigateTable {height:27px;width:100%;}
.tab {width:68px;height:22px;}
body{margin:0;padding:0;}
.searchinput{float:left;width:250px;;padding-right:10px;}
</style>
<script type="text/javascript" src="<s:url value='/dwr/engine.js'/>"></script>
<script type="text/javascript" src="<s:url value='/dwr/util.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery.slimscroll.min.js' />"></script>
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script type="text/javascript">

	function removeUser(){
		 var listform = document.getElementById("formList");
		    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
		    	listform.action='<s:url action="remove"/>';
		    	listform.submit();
		    }
	}


	function doaddtogroup(){
		var _selects = "";
		jQuery("input[name='_selects']:checked").each(function(){
			_selects += jQuery(this).val() + ";";
		});
		if(_selects.length>1){
			_selects = _selects.substring(0, _selects.length-1);
		}else {
			alert("{*[cn.myapps.core.usergroup.must.selectone]*}");
			return;
		}
		var url = contextPath + '/portal/share/user/contacts/addtogroup.jsp?_selects=' + _selects;
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 400,
			height: 300,
			url: url,
			args: {},
			title: '{*[cn.myapps.core.usergroup.addtogroup]*}',
			close: function(rtn) {
				location.reload();
			}
		});
	}
	
	function cl(){
		document.getElementById("sm_name").value = '';
	}
	
	function adjustListDiv(){
		var iframeH = jQuery("body",parent.document).find("#userlistframe").height();
		var tbH = jQuery(".table_noborder").height();
		var searchFormH = jQuery("#searchFormTable").height();
		var pageNavH = jQuery(".table_noborder").height();
		jQuery("#contentTable").height(iframeH - tbH - searchFormH - pageNavH - 70);
	}
	function contentTableScroll(){
		var scrollHeight = jQuery("#contentTable").height();
		$("#contentTable").slimscroll({
			height: scrollHeight,
			color:'#333'
		});
	}
	jQuery(document).ready(function(){
		adjustListDiv(); //调整显示通讯录列表的div高度
		contentTableScroll();//通讯录列表滚动
	});

	jQuery(window).resize(function(){
		adjustListDiv(); //调整显示通讯录列表的div高度
	});
</script>
</head>
<body id="domain_user_list" class="listbody" style="overflow: auto;">
<div>
<s:form name="formList" id="formList" action="list" method="post" theme="simple">
<s:hidden name="userGroupId" id="userGroupId" value="%{#request.userGroupId}"></s:hidden>
	<!-- <table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.usergroup.submit.contacts]*}</div>
			</td>
			</tr>
	</table> -->
	<div id="main" >	
		<%@include file="/common/basic.jsp" %>
		<%@include file="/portal/share/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" style="margin:0 12px;">
			<table class="table_noborder" style="width:100%;" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					    <table border="0" style="width:100%;" cellspacing="0" cellpadding="0">
					      <tr style="width:100%;" >
					      	<td nowrap="nowrap"  >
								<a href="javascript:doaddtogroup();" class="btn btn-primary" style="color:#fff;">{*[cn.myapps.core.usergroup.addtogroup]*}</a>
								<s:if test="#request.userGroupId != 'all'&&#request.userGroupId != null">
									<a class="btn btn-danger" name="removeButton" id="removeButton" onClick="removeUser()">
										{*[cn.myapps.core.usergroup.remove]*}
									</a>
								</s:if>
							</td>
							<td nowrap="nowrap" width="384px">
								<table>
									<tr>
										<td nowrap="nowrap" style="vertical-align: middle;">{*[cn.myapps.core.usergroup.user_name]*}:</td>
										<td nowrap="nowrap" style="vertical-align: middle;"><input pid="searchFormTable" title="{*[cn.myapps.core.user.by_name]*}" class="justForHelp input-cmd sett-form-control-inline" type="text" name="sm_name"	id="sm_name" value='<s:property value="params.getParameterAsString('sm_name')" />' size="10" style="width:200px;"/></td>
										<td nowrap="nowrap" style="vertical-align: middle;"><a class="btn icon17" title="{*[Query]*}" href="###" onclick="document.getElementsByName('_currpage')[0].value=1;document.forms[0].submit();">{*[Query]*}</a></td>
										<td nowrap="nowrap" style="vertical-align: middle;"><a class="btn icon18" href="javascript:cl();" title="{*[Reset]*}">{*[Reset]*}</a></td>
									</tr>
								</table>
							</td>
					      </tr>
					    </table>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 用户列表 -->
		<div style="margin:0 12px;border:1px solid #f5f5f5;border-radius:4px;-moz-border-radius: 4px; -webkit-border-radius: 4px;">
		<div id="contentTable" class="contentTable">
		<table class="table_noborder" style="width:100%;"  cellspacing="0" cellpadding="0">
			<tr class="dtable-header" style="background:#f5f5f5;">
				<td class="column-head-fresh" width="20px"><input type="checkbox" onclick="selectAll(this.checked)"></td>
				<td class="column-head-fresh" width="20%">{*[cn.myapps.core.usergroup.user_name]*}</td>
				<td class="column-head-fresh" width="20%">{*[Mobile]*}</td>
				<td class="column-head-fresh" width="">{*[Email]*}</td>
			</tr>
			<s:iterator value="datas.datas" status="index" id="uservo">
				<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id"/>"></td>
				<td><s:property value="name" /></td>
				<td><s:property value="%{telephonePublic?telephone:''}"/></td>
				<td><s:property value="%{emailPublic?email:''}" /></td>
				</tr>
			</s:iterator>
		</table>
		
		</div>
		<div class="table_pagenav" style="margin:0 12px;">
			<table class="table_noborder">
				<tr>
					<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
						css="linktag" /></td>
				</tr>
			</table>
		</div></div>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
