<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%
	String contextPath = request.getContextPath();
%>

<html>
<o:MultiLanguage>
	<head>
	<title>{*[cn.myapps.core.sysconfig.content.system_config_info]*}</title>
	<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>' type="text/css" />
	<script type="text/javascript">
	function ev_switchpage(id_no) {
		for(var i=1;i<10;i++) {
			if(i == id_no){
			    var tab = document.getElementById("tab" + i);
			    var span_tab = document.getElementById("span_tab"+i);
			    if(tab != null && tab != undefined) {
                    document.getElementById("tab" + i).style.display = "";
				}

                if(span_tab != null && span_tab != undefined) {
                    document.getElementById("span_tab"+i).className="btcaption-s-selected";
                }
				showHelp(id_no);
				jQuery("#_tabcount").attr("value", id_no);
			} else {
                var tab = document.getElementById("tab" + i);
                var span_tab = document.getElementById("span_tab"+i);
                if(tab != null && tab != undefined) {
                    document.getElementById("tab" + i).style.display = "none";
                }
                if(span_tab != null && span_tab != undefined) {
                    document.getElementById("span_tab"+i).className="btcaption";
                }
			}
		}
	}
	function showHelp(count) {
		if (count == 1) {
			window.top.toThisHelpPage("sysconfig_auth_info");
		} else if (count == 2) {
			window.top.toThisHelpPage("sysconfig_ldap_info");
		} else if (count == 3) {
			window.top.toThisHelpPage("sysconfig_email_info");
		}else if (count == 4) {
			window.top.toThisHelpPage("sysconfig_IM_info");
		}else if (count == 5) {
			window.top.toThisHelpPage("sysconfig_version_info");
		}else if (count == 6) {
			window.top.toThisHelpPage("sysconfig_userMassageConfig_info");
		}else if (count == 7) {
			window.top.toThisHelpPage("sysconfig_cache_data_manager_info");
		}else if (count == 8) {
			window.top.toThisHelpPage("sysconfig_HX_IM_info");
		}
	}
	function ev_export() {
		var forms = document.getElementsByTagName("form");
		forms[0].action = '<s:url value="/core/sysconfig/export.action"/>';
		forms[0].submit();
	}
	function ev_import() {
		var url = contextPath + "/core/sysconfig/imp/import.jsp";
		OBPM.dialog.show({
				opener:window.parent.parent,
				width: 600,
				height: 400,
				url: url,
				args: {},
				title: '{*[Import]*}',
				close: function(rtn) {
					if(rtn == 'refresh'){
						ev_refresh();
					}
				}
		});
	}
	function ev_refresh() {
		var forms = document.getElementsByTagName("form");
		forms[0].action = '<s:url value="/core/sysconfig/config.action"/>';
		forms[0].submit();
	}
	function ev_save() {
		var forms = document.getElementsByTagName("form");
		makeIMFieldAble();
		makeAllFieldAble(forms[0].elements);
		forms[0].action = '<s:url value="/core/sysconfig/save.action"/>';
		var usbkeyRangeIps = document.getElementsByName("authConfig.usbkeyRangeIps")[0];
		var usbkeyRangeIpsStr = buildMappingJsonStr();
		usbkeyRangeIps.value = usbkeyRangeIpsStr;
		forms[0].submit();
	}
	function makeAllFieldAble(elements) {
		if (!elements) {
			elements = document.getElementsByTagName("form")[0].elements;
		}
		for (var i = 0; i < elements.length; i++) {
			var element = elements[i];
			if (element.disabled == true) {
				element.disabled = false;
			}
		}
	}
	function makeIMFieldAble(){
		var elements = jQuery("#imContent *");
		makeFieldAbleOrNot(elements, false);
	}
	function ev_exit() {
		var forms = document.getElementsByTagName("form");
		forms[0].action = '<s:url value="/admin/detail.jsp"/>';
		forms[0].submit();
	}
	jQuery(document).ready(function(){
		jQuery(window).resize(function(){
			setHeightOfbodyDiv();
		});
		setHeightOfbodyDiv();
		ev_switchpage(jQuery("#_tabcount").val());
	});
	
	function setHeightOfbodyDiv(){
		var bodyHeight = parent.window.document.body.clientHeight;
		bodyHeight -= 100;
		jQuery("#bodyDiv").css("height",bodyHeight);
	}
	</script>
	</head>
	<body style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style = "margin: 0px; padding: 0px;">
		<tr>
			<td align="left">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="nav-s-td">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr>
							<td style="padding-left: 10px;">
							<div id="sec_tab1">
							<span class="listContent" style="margin-right: 5px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 72px;word-wrap: normal;">
								<span type="button" style="overflow: hidden;text-overflow: ellipsis;width: 72px;"
									id="span_tab1" name="spantab1" class=btcaption
									onClick="ev_switchpage(1)" value="{*[cn.myapps.core.sysconfig.content.auth_config]*}" title="{*[cn.myapps.core.sysconfig.content.auth_config]*}">
									{*[cn.myapps.core.sysconfig.content.auth_config]*}
								</span>
							</span>
							<span  class="listContent nav-seperate"><img
								src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
							</span>
							<span  class="listContent">
								<span type="button" style="margin-right: 5px;margin-left: 5px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 65px;word-wrap: normal;"
									id="span_tab2" name="spantab2" class="btcaption"
									onclick="ev_switchpage(2)" value="{*[cn.myapps.core.sysconfig.content.LDAP_config]*}" title="{*[cn.myapps.core.sysconfig.content.LDAP_config]*}">
									{*[cn.myapps.core.sysconfig.content.LDAP_config]*}
								</span>
							</span>
							<span  class="listContent nav-seperate"><img
								src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
							</span>
							<span class="listContent" style="margin-right: 5px;margin-left: 5px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 48px;word-wrap: normal;">
								<span type="button" style="overflow: hidden;text-overflow: ellipsis;width: 48px;"
									id="span_tab3" name="spantab3" class="btcaption"
									onClick="ev_switchpage(3)" value="{*[cn.myapps.core.sysconfig.content.email_config]*}" title="{*[cn.myapps.core.sysconfig.content.email_config]*}">
									{*[cn.myapps.core.sysconfig.content.email_config]*}
								</span>
							</span>
							<span  class="listContent nav-seperate" style="margin-right: 5px;"><img
								src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
							</span>
							<span class="listContent" style="margin-right: 5px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 40px;word-wrap: normal;">
								<span type="button" style="overflow: hidden;text-overflow: ellipsis;width: 36px;"
									id="span_tab4" name="spantab4" class="btcaption"
									onClick="ev_switchpage(4)" value="{*[cn.myapps.core.sysconfig.content.im_Configuration]*}" title="{*[cn.myapps.core.sysconfig.content.im_Configuration]*}">
									{*[cn.myapps.core.sysconfig.content.im_Configuration]*}
								</span>
							</span>
							<span  class="listContent nav-seperate" style="margin-right: 5px;"><img
								src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
							</span>
							<span class="listContent" style="margin-right: 5px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 48px;word-wrap: normal;">
								<span type="button" style="overflow: hidden;text-overflow: ellipsis;width: 48px;"
									id="span_tab5" name="spantab5" class="btcaption"
									onClick="ev_switchpage(5)" value="{*[cn.myapps.core.sysconfig.content.version_manage]*}" title="{*[cn.myapps.core.sysconfig.content.version_manage]*}">
									{*[cn.myapps.core.sysconfig.content.version_manage]*}
								</span>
							</span>
							<span  class="listContent nav-seperate" style="margin-right: 5px;"><img
								src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
							</span>
							<span class="listContent" style="margin-right: 5px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 72px;word-wrap: normal;">
								<span type="button" style="overflow: hidden;text-overflow: ellipsis;width: 72px;"
									id="span_tab6" name="spantab6" class="btcaption"
									onClick="ev_switchpage(6)" value="{*[cn.myapps.core.sysconfig.content.user_massage_config]*}" title="{*[cn.myapps.core.sysconfig.content.user_massage_config]*}">
									{*[cn.myapps.core.sysconfig.content.user_massage_config]*}
								</span>
							</span>
							<span  class="listContent nav-seperate" style="margin-right: 5px;"><img
								src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
							</span>
							<span class="listContent" style="margin-right: 5px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 84px;word-wrap: normal;">
								<span type="button" style="overflow: hidden;text-overflow: ellipsis;width: 84px;"
									id="span_tab7" name="spantab7" class="btcaption"
									onClick="ev_switchpage(7)" value="{*[cn.myapps.core.sysconfig.content.cache_data_manager]*}" title="{*[cn.myapps.core.sysconfig.content.cache_data_manager]*}">
									{*[cn.myapps.core.sysconfig.content.cache_data_manager]*}
								</span>
							</span>
							<span  class="listContent nav-seperate" style="margin-right: 5px;"><img
								src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
							</span>
							<span class="listContent" style="margin-right: 5px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 64px;word-wrap: normal;">
								<span type="button" style="overflow: hidden;text-overflow: ellipsis;width: 84px;"
									id="span_tab8" name="spantab8" class="btcaption"
									onClick="ev_switchpage(8)" value="{*[cn.myapps.core.sysconfig.content.hx_config]*}" title="{*[cn.myapps.core.sysconfig.content.hx_config]*}">
									{*[cn.myapps.core.sysconfig.content.hx_config]*}
								</span>
							</span>
							</div>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
			<td class="nav-s-td" align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="left">
							<button type="button" id="ref_btn" style="width:70" class="button-image" onClick="ev_refresh()">
							<img src="<s:url value="/resource/imgnew/act/reset.gif"/>" align="top"> {*[Refresh]*}</button>
						</td>
						<td align="left">
							<button type="button" id="exp_btn" style="width:70" class="button-image" onClick="ev_export()">
							<img src="<s:url value="/resource/imgnew/act/act_11.gif"/>" align="top"> {*[Export]*}</button>
						</td>
						<td align="left">
							<button type="button" id="imp_btn" style="width:70" class="button-image" onClick="ev_import()">
							<img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" align="top"> {*[Import]*}</button>
						</td>
						<td align="left">
							<button type="button" id="save_btn" style="width:70" class="button-image" onClick="ev_save()">
							<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" align="top"> {*[Save]*}</button>
						</td>
						<td align="left">
							<button type="button" class="button-image" style="width:60" onClick="ev_exit()">
							<img align="top" src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<form action="" method="post" style="margin:0px;">
	<div id="bodyDiv" style="overflow: auto; height:95%;position: relative;">
		<div id = "tab1" style="padding:10px;display: none;">
			<%@include file="authConfig.jsp" %>
		</div>
		<div id = "tab2" style="padding:10px; display: none">
			<%@include file="ldap.jsp" %>
		</div>
		<div id = "tab3" style="padding:10px; display: none">
			<%@include file="email.jsp" %>
		</div>
		<div id = "tab4" style="padding:10px; display: none">
			<%@include file="im.jsp" %>
		</div>
		<div id = "tab5" style="margin:10px; display: none">
			<%@include file="checkout.jsp" %>
		</div>
		<div id = "tab6" style="margin:10px; display: none">
			<%@include file="loginConfig.jsp" %>
		</div>
		<div id = "tab7" style="margin:10px; display: none">
			<%@include file="clearCacheAndData.jsp" %>
		</div>
		<div id = "tab8" style="margin:10px; display: none">
			<%@include file="hxim.jsp" %>
		</div>
	</div>	
	<s:hidden id="_tabcount" name="_tabcount" />
	</form>
	</body>
</o:MultiLanguage>
</html>