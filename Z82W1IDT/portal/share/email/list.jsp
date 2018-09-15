<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage><%@page import="cn.myapps.core.email.folder.action.EmailFolderHelper"%>
<%@page import="cn.myapps.core.email.util.Constants"%>
<%@ include file="/portal/share/common/head.jsp"%>
	<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script>
<script type="text/javascript">
jQuery(function(){
	if(window.parent.parent.document.getElementById("application")){
		var applicationid=window.parent.parent.document.getElementById("application").value;
		jQuery("#application").val(applicationid);
	}
});
var contextPath = '<%=request.getContextPath()%>';
	jQuery(document).ready(function() {
		jQuery("#checkAll").click(function() {
			if (jQuery(this).attr("checked")) { // 全选 
					jQuery("input[type='checkbox']").each(function() {
						jQuery(this).attr("checked", true);
						jQuery('#oTableCOUNT0 tbody tr').addClass('selected');
					});
				} else { // 取消全选 
					jQuery("input[type='checkbox']").each(function() {
						jQuery(this).attr("checked", false);
						if (jQuery('#oTableCOUNT0 tbody tr').hasClass('selected')) {
							jQuery('#oTableCOUNT0 tbody tr').removeClass('selected');
						}
					});
				}
			});
		jQuery('#oTableCOUNT0 tbody tr:even').addClass('odd');
		jQuery('#oTableCOUNT0 tbody tr').hover(function() {
			jQuery(this).addClass('highlight');
		}, function() {
			jQuery(this).removeClass('highlight');
		});
		
		// 如果复选框默认情况下是选择的，变色.
		jQuery('#oTableCOUNT0 input[type="checkbox"]:checked').parents('tr').addClass('selected');
		// 复选框
		jQuery('.Ibx_Td_Chkbx').click(function() {
			//var flag = jQuery(this).find('input[type="checkbox"]').attr('checked');
			if (jQuery(this).parent().hasClass('selected')) {
				jQuery(this).parent().removeClass('selected');
				jQuery(this).find('input[type="checkbox"]').removeAttr('checked');
			} else {
				jQuery(this).parent().addClass('selected');
				jQuery(this).find('input[type="checkbox"]').attr('checked', 'checked');
			}
		});

		jQuery("#oH4Check a").click(function() {
			var type = jQuery(this).attr("type");
			if (type == "all") {
				jQuery("input[type='checkbox']").each(function() {
					jQuery(this).attr("checked", true);
					jQuery('#oTableCOUNT0 tbody tr').addClass('selected');
				});
			} else if (type == "unread") {
				jQuery("input[type='checkbox']").each(function() {
					var tr = jQuery((jQuery(this).parent()).parent());
					var id = tr.attr("id");
					if (id == "trUnread") {
						jQuery(this).attr("checked", true);
						tr.addClass('selected');
					} else {
						jQuery(this).attr("checked", false);
						tr.removeClass('selected');
					}
				});
			} else if (type == "read") {
				jQuery("input[type='checkbox']").each(function() {
					var tr = jQuery((jQuery(this).parent()).parent());
					var id = tr.attr("id");
					if (id == "trRead") {
						jQuery(this).attr("checked", true);
						tr.addClass('selected');
					} else {
						jQuery(this).attr("checked", false);
						tr.removeClass('selected');
					}
				});
			} else if (type == "reverse") {
				var flag = true;
				jQuery("input[type='checkbox']").each(function() {
					var id = jQuery(this).attr("id");
					if (jQuery(this).attr("checked")) {
						jQuery(this).attr("checked", false);
						if (id != "checkAll") {
							flag = false;
						}
						(jQuery(this).parent()).parent().removeClass('selected');
					} else {
						jQuery(this).attr("checked", true);
						(jQuery(this).parent()).parent().addClass('selected');
					}
				});
				if (flag) {
					jQuery("#checkAll").attr("checked", true);
				} else {
					jQuery("#checkAll").attr("checked", false);
				}
				(jQuery("#checkAll").parent()).parent().removeClass('selected');
			} else if (type == "no") {
				jQuery("input[type='checkbox']").each(function() {
					jQuery(this).attr("checked", false);
					(jQuery(this).parent()).parent().removeClass('selected');
				});
			}
		});

		jQuery("#drafts").click(function(){
			var check = jQuery("input:checked").length;
			if (check == 0) {
				alert("{*[core.email.select.move]*}");
			} else {
				var url = "<s:url value='/portal/email/torecy.action'/>";
				submitContent(url);
			}
		});
		jQuery("#delete").click(function(){
			var check = jQuery("input:checked").length;
			if (check == 0) {
				alert("{*[core.email.select.delete]*}");
			} else {
				var bool = confirm("{*[core.email.deleted.confrim]*}");
				if (bool) {
					var url = "<s:url value='/portal/email/delete.action'/>";
					submitContent(url);
				}
			}
		});

		jQuery(".gTitle a").click(function(){
			var url = "<s:url value='/portal/email/list.action'/>";
			jQuery("#unreadid").attr("value", true);
			submitContent(url);
		});

		function submitContent(url) {
			window.parent.showLoading();
			jQuery.ajax({
				type: "POST",
				cache: false,
				url: url,
				data: decodeURIComponent(jQuery('#oFormMessage').serialize()),
				success:function(result) {
					jQuery("body").empty();
					jQuery("body").append(result);
					window.parent.hideLoading();
				},
				error: function(result) {
					window.parent.hideLoading();
					alert("{*[core.email.failure]*}");
				}
			});
		}
		jQuery(".Txt span a").each(function() {
			jQuery(this).click(function(){
				var page = 1;
				var id = this.id;
				if (id == "first") {
					page = 1;
				} else if (id == "prev") {
					page = <s:property value="datas.pageNo" /> - 1;
				} else if (id == "next") {
					page = <s:property value="datas.pageNo" /> + 1;
				} else if (id == "end") {
					page = <s:property value="datas.pageCount" />;
				}
				showPage(page);
			});
		});
		
		function showPage(page) {
			var from=document.getElementById("from").value;
			var to=document.getElementById("to").value;
			document.getElementsByName("_currpage")[0].value = page;
			var url = "<s:url value='/portal/email/list.action'/>";
			url+="?folderid=<%=request.getParameter("folderid")%>"+ "&type=0"+"&_currpage="+page;
			if(from=='true'){
				var sm_from=document.getElementById("sm_from").value;
				var sm_subject=document.getElementById("sm_subject").value;
				var startdate=document.getElementById("startdate").value;
				var enddate=document.getElementById("enddate").value;
				var departmentId=document.getElementById("departmentId").value;
				if(sm_from!=null&&sm_from!=""){
					url += "&sm_from="+sm_from;
					}
				if(sm_subject!=null&&sm_subject!=""){
					url += "&sm_subject="+sm_subject;
					}
				if(startdate!=null&&startdate!=""){
					url += "&startdate="+startdate;
					}
				if(enddate!=null&&enddate!=""){
					url += "&enddate="+enddate;
					}
				if(departmentId!=null&&departmentId!=""){
					url += "&departmentId="+departmentId;
					}
				}
			if(to=='true'){
				var sm_to=document.getElementById("sm_to").value;
				var sm_subject=document.getElementById("sm_subject").value;
				var startdate=document.getElementById("startdate").value;
				var enddate=document.getElementById("enddate").value;
				if(sm_to!=null&&sm_to!=""){
					url += "&sm_to="+sm_to;
					}
				if(sm_subject!=null&&sm_subject!=""){
					url += "&sm_subject="+sm_subject;
					}
				if(startdate!=null&&startdate!=""){
					url += "&startdate="+startdate;
					}
				if(enddate!=null&&enddate!=""){
					url += "&enddate="+enddate;
					}
				}
			var f= document.createElement('form');
			 f.action = url;
			 f.method = 'post';
			 document.body.appendChild(f);
			 f.submit();
		}

		function getFormValueByName(name) {
			jQuery("input").each(function(){
				if (this.name != null && this.name == name) {
					return this.value;
				}
			});
			return null;
		}
		function getFormObjectByName(name) {
			var result = null;
			jQuery("input").each(function(){
				if (this.name != null && this.name == name) {
					result = this;
				}
			});
			return result;
		}
		function setFormValueByName(name, value) {
			jQuery("input").each(function(){
				if (this.name != null && this.name == name) {
					this.value = value;
				}
			});
		}
		jQuery('#moveid1').change(function(){
			// alert(jQuery(this).children('option:selected').text());  //弹出select的值
			moveTo(jQuery(this).children('option:selected').val());
			jQuery("#df1").attr("selected", true);
		});
		jQuery('#moveid2').change(function(){
			// alert(jQuery(this).children('option:selected').text());  //弹出select的值
			moveTo(jQuery(this).children('option:selected').val());
			jQuery("#df2").attr("selected", true);
		});

		function moveTo(folderid) {
			if (folderid == "") { return; }
			var from = jQuery('#folderid_hi').val();
			var check = jQuery("input:checked").length;
			if (check == 0) {
				alert("{*[core.email.select.move]*}");
			} else {
				var check = jQuery("input:checked").length;
				if (from == folderid) {
					alert("{*[core.email.nomove]*}");
				} else {
					var url = "<s:url value='/portal/email/moveto.action'/>?toid=" + folderid;
					submitContent(url);
				}
			}
		}

		jQuery('#mark1').change(function(){
			mark(jQuery(this).children('option:selected').val());
			jQuery("#dm1").attr("selected", true);
		});
		jQuery('#mark2').change(function(){
			mark(jQuery(this).children('option:selected').val());
			jQuery("#dm2").attr("selected", true);
		});

		function mark(mark) {
			if (mark == "") { return; }
			var check = jQuery("input:checked").length;
			if (check == 0) {
				alert("{*[core.email.select.mark]*}");
			} else {
				var url = "<s:url value='/portal/email/mark.action'/>?mark=" + mark;
				submitContent(url);
			}
		}
	});
	window.onload = function() {
		var currFolder = document.getElementById("folderid_hi").value;
		var lis = parent.document.getElementsByTagName("li");//左侧菜单
		for (i = 0; i < lis.length; i++) {
			lis[i].style.background = '';
			if (lis[i].id == currFolder) {
				lis[i].style.background = 'url(<s:url value='/portal/share/email/images/f3-2.png'/>)';
			}
		}
		window.parent.hideLoading();
	};
	function view(emailid, folderid) {
		window.parent.showLoading();
		var viewUrl = "<s:url value='/portal/email/view.action'/>?id=" + emailid + "&folderid=" + folderid + "&_currpage=<s:property value="datas.pageNo"/>&_pagelines=<s:property value="datas.linesPerPage"/>";
		window.location.href = viewUrl;
	}
	function emailList(sm_from,sm_to,sm_subject,startdate,enddate,departmentId){
		var targetUrl = "";
		if((startdate != null && startdate != "") && (enddate == null || enddate == "")){
			alert("{*[core.email.enddate]*}");
			return false;
			}
		if((startdate == null || startdate == "") && (enddate != null && enddate != "")){
			alert("{*[core.email.startdate]*}");
			return false;
		}
		if(startdate != null && startdate != "" && enddate != null && enddate != ""){
			targetUrl += "&startdate="+encodeURI(startdate);
			targetUrl += "&enddate="+encodeURI(enddate);
		}
		if(departmentId != null && departmentId != ""){
			targetUrl += "&departmentId="+departmentId;
		}
		var page = contextPath+"/portal/email/list.action?folderid=<%=request.getParameter("folderid")%>"+ "&type=0"+targetUrl;
		 var f= document.createElement('form');
		 f.action = page;
		 f.method = 'post';
		 document.body.appendChild(f);
		 if(sm_subject != null && sm_subject != ""){
			 var temp=document.createElement('input');
			 temp.type= 'hidden';
			 temp.value=sm_subject; 
			 temp.name='sm_subject';
			 f.appendChild(temp);
			}
		 if(sm_from != null && sm_from != ""){
			 var temp1=document.createElement('input');
			 temp1.type= 'hidden';
			 temp1.value=sm_from; 
			 temp1.name='sm_from';
			 f.appendChild(temp1);
			}if(sm_to != null && sm_to != ""){
				 var temp2=document.createElement('input');
				 temp2.type= 'hidden';
				 temp2.value=sm_to; 
				 temp2.name='sm_to';
				 f.appendChild(temp2);
				}
		 f.submit();
	}

	function resetAll(){
		jQuery('#sm_from,#sm_to,#sm_subject,#startdate,#enddate').val('');
		jQuery("#departmentId").get(0).selectedIndex=0;
	}
	function agentStart(){
		WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'',maxDate:'2050-12-30',skin:'whyGreen'});
	}
	function agentEnd(){
		var time = jQuery("#startdate").val();
		WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:time,maxDate:'2050-12-30',skin:'whyGreen'});
	}

	function readChange(val){
		document.forms[0].action = '<s:url value="/portal/email/list.action?type=0" />';
		document.forms[0].submit();
	}

	function selectUsers(id,name,emailAccount){
		var settings={"valueField":id,"textField":name,"showUserEmailAccount":emailAccount};
		showUserSelectNoFlow("",settings,"");
	}
</script>
<style>
<!--
table {
	table-layout: fixed;
}
tr {
	overflow: hidden;
}
td {
	overflow: hidden;
}
td a {
	text-decoration: none;
	hide-focus: expression(this.hideFocus=true); /* for ie 5+ */
	outline: none; /* for firefox 1.5 + */
	/*去除点击虚线框*/  
}
.contentTd {
	font-size: 12px;
	color: #99cccc;
}
-->
</style><s:bean id="helper" name="cn.myapps.core.email.email.action.EmailHelper" />
<form id="oFormMessage" action="" method="post"><s:bean id="folderHelper" name="cn.myapps.core.email.folder.action.EmailFolderHelper" />
	<%@include file="/common/basic.jsp" %>
	<input type="hidden" name="unread" id="unreadid" value='<s:property value="#parameters.unread"/>' />
	<input type="hidden" name="folderid" id="folderid_hi" value='<s:property value="#request.folder.id"/>' />
	<s:hidden id="application" name="application" value="" />
	<input type="hidden" id="from" value="<s:property value="#helper.isShowInboxFrom(#request.folder.id, #session.FRONT_USER)"/>" />
	<input type="hidden" id="to" value="<s:property value="#helper.isShowSenderFrom(#request.folder.id, #session.FRONT_USER)"/>" />
	<div class="ContentWp">
		<div class="content" style="background: #ffffff;">
			<div class="gTitle">
				<span><b><s:property value="#request.folder.displayName" /></b>&nbsp;&nbsp;({*[core.email.tatol.one]*}&nbsp;<b id="oTotal"><s:property value="datas.rowCount" /></b>&nbsp;{*[core.email.feng]*} <!-- 
				<s:if test="#helper.isShowUnreadCount(#request.folder.id, #session.FRONT_USER)">，{*[core.email.other.label]*}&nbsp;<A title="{*[core.email.unread]*}" href="javascript:void(0);">{*[core.email.unread]*}</A>&nbsp;<b class="fnt_Red" id="oTotalUnRead"><s:property value="#helper.getUnreadMessageCount(#request.folder.id, #session.FRONT_USER)" /></b>&nbsp;{*[core.email.feng]*}</s:if> -->)</span>
			</div>

			<div class="bar" style="">
				<div style="float: left;">
					<input type="button" value="{*[Delete]*}" id="drafts" /> <input type="button" value="{*[core.email.deleted]*}" id="delete"/>
				<!-- <input class="Btn BtnNml" type="button" value="举报垃圾邮件"/> -->
				<select class="Sel" id="mark1">
					<option value="" selected="selected" id="dm1">{*[core.email.mark.label]*}...</option>
					<option value="0">&nbsp;&nbsp;{*[core.email.unread]*}</option>
					<option value="1">&nbsp;&nbsp;{*[core.email.read]*}</option>
				</select> <select class="Sel" id="moveid1">
					<option value="" selected="selected" id="df1">{*[core.email.move.label]*}...</option>
					<s:iterator value="#folderHelper.getMoveSystemFolders(#session.FRONT_USER)" status="index">
					<option value="<s:property value="id"/>">&nbsp;&nbsp;<s:property value="displayName"/></option>
					</s:iterator>
					<s:if test="#folderHelper.havePersonalEmailFolder(#session.FRONT_USER)"><option value="">&nbsp;&nbsp;----------</option>
					<s:iterator value="#folderHelper.getPersonalEmailFolders(#session.FRONT_USER)" status="index">
					<option value="<s:property value="id"/>">&nbsp;&nbsp;<s:property value="displayName"/></option>
					</s:iterator></s:if>
				</select>
				<s:select id="readstate" name="readstate" list="#{'':'{*[All]*}', 'read':'{*[IsRead]*}', 'unread':'{*[NoRead]*}'}" theme="simple" onchange="readChange()"/>
				</div>
				<div class="Extra"  style="float: right;">
					<span class="Txt" style="padding-top: 8px;">
						<s:property value="datas.pageNo" />&nbsp;/&nbsp;<s:property value="datas.pageCount" />{*[page]*}&nbsp;&nbsp;
						<s:if test="datas.pageNo == 1"><span class="Unable">{*[FirstPage]*}</span>&nbsp;&nbsp;</s:if>
						<s:else><span><a href="javascript:void(0);" id="first">{*[FirstPage]*}</a></span>&nbsp;&nbsp;</s:else>
						<s:if test="datas.pageNo < 2"><span class="Unable">{*[PrevPage]*}</span>&nbsp;&nbsp;</s:if>
						<s:else><span><a href="javascript:void(0);" id="prev">{*[PrevPage]*}</a></span>&nbsp;&nbsp;</s:else>
						<s:if test="datas.pageNo == datas.pageCount || datas.pageCount == 0"><span class="Unable">{*[NextPage]*}</span>&nbsp;&nbsp;</s:if>
						<s:else><span><a href="javascript:void(0);" id="next">{*[NextPage]*}</a></span>&nbsp;&nbsp;</s:else>
						<s:if test="datas.pageNo == datas.pageCount || datas.pageCount == 0"><span class="Unable">{*[EndPage]*}</span>&nbsp;&nbsp;</s:if>
						<s:else><span><a href="javascript:void(0);" id="end">{*[EndPage]*}</a></span>&nbsp;&nbsp;</s:else>
					</span>
				</div>
				<div style="clear:both;height:0px;line-height:0px;"></div>
			</div>
			<s:if test="#helper.isShowSenderFromTo(#request.folder.id, #session.FRONT_USER)">		
	<div class="moduleSpace" style="margin-top:2px;">
	  <table border="0" style="width: 100%;background: #EEF0F2;">
		<tr>
			<s:if test="#helper.isShowInboxFrom(#request.folder.id, #session.FRONT_USER)">
			<td class="" style="width:195px;">{*[core.email.from]*}:
		   <input pid="searchFormTable" class="justForHelp input-cmd" type="text" id="sm_from" value='<s:property value="params.getParameterAsString('sm_from')" />' size="10" />  
					<input type="button" value="{*[Choose]*}" onclick="selectUsers(jQuery('#receiverid').attr('id'),jQuery('#receivername').attr('id'),jQuery('#sm_from').attr('id'))" style="height:24px; " title="{*[Choose]*}{*[User]*}"/>
					<input type="hidden"  id="receiverid" name="receiverid" />
					<input type="hidden"  id="receivername" name="receivername" />
		    </td>
		    </s:if>
		    <s:if test="#helper.isShowSenderFrom(#request.folder.id, #session.FRONT_USER)">
			<td class="" style="width:195px;">{*[core.email.to]*}:
		    <input pid="searchFormTable" class="justForHelp input-cmd" type="text" id="sm_to" value='<s:property value="params.getParameterAsString('sm_to')" />' size="10" />  
		    <input type="button" value="{*[Choose]*}" onclick="selectUsers(jQuery('#receiverid').attr('id'),jQuery('#receivername').attr('id'),jQuery('#sm_to').attr('id'))" style="height:24px; " title="{*[Choose]*}{*[User]*}"/>
					<input type="hidden"  id="receiverid" name="receiverid" />
					<input type="hidden"  id="receivername" name="receivername" />
		    </td>
		    </s:if>
			<td class="" style="width:135px;">{*[Subject]*}:
		    <input pid="searchFormTable" class="justForHelp input-cmd" type="text" id="sm_subject" value='<s:property value="params.getParameterAsString('sm_subject')" />' size="10" />  
		    </td>	   
		    <td class="" style="width:260px;">{*[Date]*}:
		    	<input pid="searchFormTable"  onfocus="agentStart();" class='Wdate' type="text" id="startdate" value='<s:property value="params.getParameterAsString('startdate')" />' size="10" />
		    	{*[cn.myapps.core.dynaform.form.webeditor.label.to]*}
		    	<input pid="searchFormTable"  onfocus="agentEnd();"  limit='true' class='Wdate' type="text" id="enddate" value='<s:property value="params.getParameterAsString('enddate')" />' size="10" />
			</td>
		    <td>
				<input id="search_btn" pid="searchFormTable"  class="justForHelp button-cmd" type="button" onclick="emailList(jQuery('#sm_from').attr('value'),jQuery('#sm_to').attr('value'),jQuery('#sm_subject').attr('value'),jQuery('#startdate').attr('value'),jQuery('#enddate').attr('value'),jQuery('#departmentId').attr('value'));" value="{*[Query]*}" />
			</td>	      
		 </tr>
		  <s:if test="#helper.isShowInboxFrom(#request.folder.id, #session.FRONT_USER)">
		 <tr>
			<td class="" colspan="3">{*[core.email.fromdep]*}:
    			<select id="departmentId" name="departmentId" style="width: 152">
    			<option value=""></option>
    			<s:iterator value="departments">
   					<option value="<s:property value="id"/>" <s:if test='id==params.getParameterAsString("departmentId")'> selected="selected" </s:if>><s:property value="name"/></option>
   				</s:iterator>
   				</select>
    		</td>
    		<td>
				<input id="reset_btn" pid="searchFormTable"  class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll()" />
    		</td>
		 </tr>
		 </s:if>
		</table>
	</div>
	</s:if>
			<div class="Ibx_Main_Wp" style="width: 100%; margin-right: 1px; padding-top: 10px; float: left;">
				<div class="Ibx_Lst_dWp dWpOpen" style="background: #ffffff;" style="width: 100%;">
					<table class="Ibx_gTable Ibx_gTable_Con" id="oTableCOUNT0" border="0" cellspacing="0" style="width: 100%;">
						<thead style="">
							<tr>
								<th class="line_style" style="width: 3%" align="center">
									<input id="checkAll" title="{*[core.email.check]*} " type="checkbox"/></th>
								<th class="Th_Read_Icon" style="width: 3%" valign="top" title="{*[core.email.type]*}" align="center">
									<img src="<s:url value="/portal/share/email/images/email_icon_read.png"/>" style="padding-top: 6px;"/></th>
								<s:if test="#helper.isShowSender(#request.folder.id, #session.FRONT_USER)"><th class=Th_From style="width: 20%">{*[core.email.from]*}</th></s:if>
								<s:else><th class="Th_From" style="width: 20%">{*[core.email.to]*}</th></s:else>
								<th class="Th_Subject" style="width: 40%">{*[Subject]*}</th>
								<s:if test="#helper.isShowSenderFrom(#request.folder.id, #session.FRONT_USER)"><th class="Th_Date" style="width: 20%">{*[core.email.senddate]*}</th></s:if>
								<s:elseif test="#helper.isShowDrafts(#request.folder.id, #session.FRONT_USER)"><th class="Th_Date" style="width: 20%">{*[core.email.draftsdate]*}</th></s:elseif>
								<s:else><th class="Th_Date" style="width: 20%">{*[core.email.receviedate]*}</th></s:else>
								<th class="Th_icoATCM" style="width: 4%" valign="top" title="{*[core.email.att.mark]*}" align="center">
									<img src="<s:url value="/portal/share/email/images/attachment.png"/>" style="padding-top: 6px;"/></th>
								<th class="Th_Subject" style="width: 10%">{*[core.email.attchment.size]*}</th>
							</tr>
						</thead>
						<tbody>
							<s:if test="datas.rowCount <= 0"><tr>
								<th colspan="7" align="center"><h4>{*[core.email.null]*}</h4></th>
							</tr></s:if><s:else>
							<s:iterator value="datas.datas" status="index">
							<s:if test="read"><tr id="trRead">
								<td class="Td_sy" style="width: 3%" align="center">
									<input type="checkbox" value="<s:property value="id"/>" name="_selects" /></td>
								<td class="Td_Read_Icon" style="width: 3%" align="center" title="{*[core.email.read]*}"><img src="<s:url value="/portal/share/email/images/read.png"/>" style="padding-top: -2px;"/></td>
    							<td class="Td_From" style="width: 20%">
    								<s:if test="#helper.isShowSender(#request.folder.id, #session.FRONT_USER)"><a href="javascript:view('<s:property value="id"/>', '<s:property value="emailFolder.id"/>');"><s:property value="emailBody.from" />&nbsp;</A></s:if>
									<s:else><a href="javascript:view('<s:property value="id"/>', '<s:property value="emailFolder.id"/>');"><s:property value="emailBody.to" />&nbsp;</a></s:else>
    							</td>
								<td class="Td_Subject" style="width: 50%;">
									<a href="javascript:view('<s:property value="id"/>', '<s:property value="emailFolder.id"/>');"><s:property value="emailBody.subject" />&nbsp;&nbsp;&nbsp;
									<!-- <span class="contentTd">&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#helper.getShortContent(emailBody.content)" /></span> -->
									<s:if test="msgLevel==1">
										<span style="color:#FF9900;">{*[core.email.msglevel.important]*}</span>
									</s:if>
									<s:elseif test="msgLevel==2">
										<span style="color:#FF0000;">{*[core.email.msglevel.veryImportant]*}</span>
									</s:elseif>
									</a>
								</td>
    							<td class="Td_Date" style="width: 10%">
    								<s:date name="emailBody.sendDate" format="yyyy-MM-dd HH:mm:ss" />&nbsp;</td>
   								<td class="Td_icoATCM" style="width: 4%" valign="top" align="center"><s:if test="emailBody.isMultipart()"><img src="<s:url value="/portal/share/email/images/attachment.png"/>"  title="{*[Attachment]*}" style="padding-top: 6px;"/></s:if></td>
   								<td class="Td_Date" style="width: 10%">&nbsp; <s:property value="emailBody.getAttachmentsTotalSize()"/></td>
   							</tr></s:if><s:else>
   							<tr class="I_Mark0 I_UnRd" id="trUnread">
								<td class="Td_sy" style="width: 3%" align="center">
									<input type="checkbox" value="<s:property value="id"/>" name="_selects" /></td>
								<td class="Td_Unread_Icon" style="width: 3%" align="center" title="{*[core.email.unread]*}"><img src="<s:url value="/portal/share/email/images/unread.png"/>" style="padding-top: 0px;"/></td>
    							<td class="Td_From" style="width: 20%">
    								<s:if test="#helper.isShowSender(#request.folder.id, #session.FRONT_USER)"><a href="javascript:view('<s:property value="id"/>', '<s:property value="emailFolder.id"/>');"><s:property value="emailBody.from" />&nbsp;</A></s:if>
									<s:else><a href="javascript:view('<s:property value="id"/>', '<s:property value="emailFolder.id"/>');"><s:property value="emailBody.to" />&nbsp;</a></s:else>
    							</td>
								<td class="Td_Subject" style="width: 50%">
									<a href="javascript:view('<s:property value="id"/>', '<s:property value="emailFolder.id"/>');"><s:property value="emailBody.subject" />&nbsp;
									<!-- <span class="contentTd">&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="#helper.getShortContent(emailBody.content)" /></span> -->
									<s:if test="msgLevel==1">
										<span style="color:#FF9900;">{*[core.email.msglevel.important]*}</span>
									</s:if>
									<s:elseif test="msgLevel==2">
										<span style="color:#FF0000;">{*[core.email.msglevel.veryImportant]*}</span>
									</s:elseif>
									</a>
								</td>
    							<td class="Td_Date" style="width: 10%">
    								<s:date name="emailBody.sendDate" format="yyyy-MM-dd HH:mm:ss" />&nbsp;</td>
   			 					<td class="Td_icoATCM" style="width: 4%" valign="top" align="center">
   			 						<s:if test="emailBody.isMultipart()"><img src="<s:url value="/portal/share/email/images/attachment.png"/>"  title="{*[Attachment]*}" style="padding-top: 6px;"/></s:if></td>
   			 					<td class="Td_Date" style="width: 10%">&nbsp; <s:property value="emailBody.getAttachmentsTotalSize()"/></td>
   							</tr>
   							</s:else>
   							</s:iterator></s:else>
   						</tbody>
					</table>

					<H4 class="Ibx_Lst_bExtra" id="oH4Check">{*[Choose]*}：<A href="javascript:void(0);" type=all>{*[cn.myapps.core.email.attr.all_checked]*}</A>&nbsp;-&nbsp;<A
						href="javascript:void(0);" type="unread">{*[core.email.unread]*}</A>&nbsp;-&nbsp;<A href="javascript:void(0);" type=read>{*[core.email.read]*}</A>&nbsp;-&nbsp;<A
						href="javascript:void(0);" type="reverse">{*[core.email.fanxuan]*}</A>&nbsp;-&nbsp;<A href="javascript:void(0);" type=no>{*[core.email.chose.no]*}</A></H4>
				</div>
			</div>
		</div>
	</div>
</form></o:MultiLanguage>