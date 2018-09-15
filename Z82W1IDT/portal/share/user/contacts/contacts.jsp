<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<% 
	String contextPath = request.getContextPath();
	String skinType = (String)request.getSession().getAttribute("SKINTYPE");
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="java.util.List"%>
<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%><html><o:MultiLanguage>
<head>
<title>{*[User_List]*}</title>
<link rel="stylesheet" href="<s:url value='/portal/share/css/setting-up.css'/>" type="text/css">
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script type="text/javascript" src="<s:url value='/dwr/engine.js'/>"></script>
<script type="text/javascript" src="<s:url value='/dwr/util.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script type="">
	var contextPath='<%=contextPath%>';
	var skinType='<%=skinType%>';
</script>
<script type="text/javascript">
/**
 * 记录当前交互状态下，相应的操作状态设置
 * enabled{}
 */
var enabled = {
		showIcon : true  	//重命名的时候,数据列鼠标悬停事件不可操作。
};
	function doNewGroup(){
		var icons;
		var _path;
		if(skinType == "H5"){
			icons = "icons_2";
			_path = "../H5/resource/component/artDialog"
		}else{
			icons = "";
			_path = "";
		}
		var domainId = document.getElementsByName("domain")[0].value;
		var url = contextPath + '/portal/share/user/contacts/inputusergroupname.jsp?domain=' + domainId;
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 350,
			height: 200,
			url: url,
			icon:icons,
			path: _path,
			args: {},
			maximized: false,
			title: '{*[cn.myapps.core.usergroup.inputname]*}',
			close: function(rtn) {
				location.reload();
			}
		});
	}

	function doviewByGroup(val){
		var domain = document.getElementById("domain").value;
		document.getElementById("userlistframe").src = contextPath + '/portal/usergroup/list.action?domain=' + domain + '&userGroupId=' + val;
	}

	function changeBcground(obj){
		jQuery("#subgroup_list td").removeClass("selectBackground");
		jQuery(obj).parent().parent().addClass("selectBackground");
	}

	/**
	 *重命名分组
	 */
	function doRename(btn){
		enabled.showIcon = false;
		var pri_html = jQuery(btn).parent().parent().prev().html();
		var old_td = jQuery(btn).parent().parent().prev();
		var inputId = old_td.attr("id");
		if(old_td){
		old_td.replaceWith("<span id='newSpan'><input class='inputClass' id='" + inputId + "' name='renameInput' type='text' value='" + pri_html + "' style='font-size: 12px;padding:0;margin:0;width:95px;line-height:21px; border: 1px #eaedef solid;border-radius: 4px;'/>"
				+"<input id='rename_t' type='button' class='rename_t'/>"
				+"<input id='rename_f' type='button' class='rename_f'/></span>");
		}
		jQuery(".inputClass").select();
		jQuery(".more_btn").hide();
		
		jQuery("#rename_f").click(function(){
			jQuery("#newSpan").replaceWith(old_td);
			jQuery(this).parent().parent().find(".more_rename img").click(function(){
				doRename(this);
			});
			enabled.showIcon = true;
		});

		jQuery("#rename_t").click(function(){
			if(confirm("您确定要用这个名字命名该分组吗？")){
				 var domain = document.getElementById("domain").value;
				 var rename = document.getElementsByName("renameInput")[0].value;
				 var urlStr =contextPath + "/portal/usergroup/rename.action?renameId="+inputId+"&&domain="+domain; 
				 var f= document.createElement('form');
				 f.action = urlStr;
				 f.method = 'post';
				 document.body.appendChild(f);
				 var temp=document.createElement('input');
				 temp.type= 'hidden';
				 temp.value=rename; 
				 temp.name='rename';
				 f.appendChild(temp);
				 f.submit();
				 				 
			}
		});
	}

	/**
	 *删除分组
	 */
	 function doDelete(btn){
		 if(confirm("您确定要删除该联系人分组吗？")){
			 var delId = jQuery(btn).parent().parent().prev().attr("id");
			 var domain = document.getElementById("domain").value;
			 window.location.href=contextPath + "/portal/usergroup/removegroup.action?delid="+delId+"&&domain="+domain; 
		 }
	 }

	function adjustLayout(){
		var bodyW = jQuery("body").width();
		var leftW = jQuery("#subgroup_list").width();
		var listW = jQuery("#contacts_list").width(bodyW - leftW-1);
	}

	jQuery(document).ready(function(){
		adjustLayout(); //调整通讯录界面布局
		jQuery("#subgroup_list td").mouseover(function(){
			if(enabled.showIcon){
			//jQuery("#subgroup_list td").removeClass("onBackground");
			//jQuery(this).addClass("onBackground");
			jQuery(this).find(".more_btn").show();
			}
		});
		jQuery("#subgroup_list td").mouseout(function(){
			//jQuery("#subgroup_list td").removeClass("onBackground");
			jQuery(".more_btn").hide();
		});
		jQuery(".more_rename img").click(function(){
			doRename(this);
		});
		jQuery(".more_delete img").click(function(){
			doDelete(this);
		});
	});

	jQuery(window).resize(function(){
		adjustLayout(); //调整通讯录界面布局
	});
</script>
</head>
<body id="domain_user_list" class="listbody" style="overflow:hidden;">
<s:hidden name="domain" value="%{#parameters.domain}" />
<div id="subgroup_list" class="subgroup_list">
	
	<table style="width: 100%;">
		<tr>
			<td>
				<div style="height:30px;line-height:30px;color:#7b8d9d;padding-left: 5px;font-size: 14px;font-weight: 700;border-bottom:1px solid #f0f0f0;">
					<a href="javascript:doviewByGroup('all')" onclick="changeBcground(this)" style="color:black;">{*[cn.myapps.core.usergroup.allcontact]*}</a>
				</div>
			</td>
		</tr>
		<s:iterator value="datas.datas" status="index" id="usergroupvo">
			<tr>
				<td>
					<div style="position: relative;" class="createGroupDiv">
						<a href="javascript:doviewByGroup('<s:property value='id'/>')" id="<s:property value='id'/>" onclick="changeBcground(this)" class="groupName" title="<s:property value='name' />"><s:property value="name" /></a>
						<div class="more_btn" style="position: absolute; top: 4px; right: 0px;display: none;">
							<div class="more_rename" title="{*[Rename]*}"><img src="<s:url value="/resource/images/edit_act.gif"/>"/></div>
							<div class="more_delete" title="{*[Delete]*}"><img src="<s:url value="/resource/images/del_act.gif"/>"/></div>
						</div>
					</div>
				</td>
			</tr>
		</s:iterator>
	</table>
	<div class="doNewGroup">
		<a href="###" onclick="doNewGroup();"><span style="font-size:14px;color:#7a8d9d;">+</span>{*[cn.myapps.core.usergroup.new]*}</a>
	</div>
</div>
<div id="contacts_list" style="float:right;height:100%;">
	<iframe id="userlistframe" width="100%" height="100%" scrolling="no" frameborder="0" src="<s:url value='/portal/usergroup/list.action'><s:param name='domain' value='%{#parameters.domain}'/><s:param name='userGroupId' value='all'/></s:url>"></iframe>
</div>
</body>
</o:MultiLanguage></html>
