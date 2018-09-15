<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<%@include file="/common/tags.jsp"%>
<%@ page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.core.deploy.module.ejb.ModuleVO"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO,cn.myapps.constans.*"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="ah" />
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="mh" />
<% 
	String contextPath = request.getContextPath();
	ApplicationHelper helper = new ApplicationHelper();
	Collection<ApplicationVO> applist = helper.getAppList();
%>
<html><o:MultiLanguage>
<head>
<title>{*[MyApps platform -- TeemLink]*}</title>
<link rel="stylesheet" type="text/css"	href="<s:url value='/resource/css/main.css' />" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<link rel="stylesheet" href='<s:url value="/resource/css/dtree.css" />' type="text/css">
<link rel="stylesheet" href='<s:url value="/resource/css/popupmenu.css" />' type="text/css">
<script src="<s:url value='/script/tree.js'/>"></script>
<script src='<s:url value="/dwr/interface/ModuleHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationHelper.js"/>'></script>
<script type="">
	var contextPath = "<%=contextPath%>";
	var applicationid = '<%=request.getParameter("id")%>';
</script>
<script>
	var d = new dTree('d');
	function init_ModuleTree(){
		d = new dTree('d');
		var nowParam;
		var root = applicationid;
		nowParam = "rightFunction('" + root + "',0)";
		//根节点url
		var rootURL = contextPath + "/core/deploy/application/edit.action?id=" + root + 
		'&application=' + applicationid + jQuery("#pagelinesid").val() + jQuery("#queryparams").val();
		ApplicationHelper.getApplicationById(root, function(application){
			if(application != null){
				//根节点
				d.add(root, '-1', application.name, rootURL, '', 'applicationframe', null, null, null, nowParam);
				//初始化当前application下的所有模块节点
				var modules = application.modules;
				if(modules != null){
				//ModuleHelper.get_moduleList(applicationid, function(modules){
					for(var i=0;i<modules.length;i++){//迭代所有模块
						var module = modules[i];
						var superior = module.superior;
						var moduleURL = '<s:url value="/core/deploy/module/displayFormAndView.jsp"/>?application=' + 
							root + "&moduleid=" + module.id;
						if(superior == null || superior.id == null || superior.id.replace(/(^\s*)|(\s*$)/g,"") == ''){
							//在当前的application添加模块节点
							nowParam = "rightFunction('" + root + "','" + module.id + "')";
							d.add(module.id, root, module.name, moduleURL, '', 'applicationframe', 
									null, null, null, nowParam);
						} else {
							//在当前模块的上级模块下添加当前模块节点
							nowParam = "rightFunction('" + root + "','" + module.id + "','" + superior.id + "')";
							d.add(module.id, superior.id, module.name, moduleURL, '', 'applicationframe', 
									null, null, null, nowParam);
						}
					}
					init_cm(modules);
					jQuery("#dtree").html(""+d);
				}
				//});
			}
		});
	}

	function init_cm(modules){
		if(modules == null || modules.length<=0){
			jQuery("#cm").css("display","");
		} else {
			jQuery("#cm").css("display","none");
		}
	}
</script>
<script type="text/javascript">
	var firstapp='<%=request.getParameter("id")%>';
	
	jQuery(document).ready(function(){
		init_ModuleTree();
		var thislayout=jQuery('body').layout({ 
			applyDefaultStyles: true 
		});
		var isError = '<s:property value="#parameters.error" />';
		var refresh = '<s:property value="#parameters.refresh" />';
		// 是否存在错误
		if (isError == '1') {
			alert('{*[page.core.deploy.have.module]*},{*[page.cannot.delete]*}');
		}
		if(navigator.userAgent.indexOf("Firefox")!=-1||navigator.userAgent.indexOf("Chrome")!=-1){
			jQuery("#leftTree").height(jQuery("#leftTree").height());
		}
	});
	
	jQuery(document).ready(function(){
		/*init iframe src*/
		jQuery("#applicationframe").attr("src",'<s:url value="/core/deploy/application/edit.action"/>?id=' + 
				applicationid + '&application=' + applicationid + jQuery("#pagelinesid").val() + jQuery("#queryparams").val());
		/* init mouse right click function */
		jQuery(document).bind({contextmenu: function(e) {
            //if (e.which == 0){
            	showmenuie5(e);		
		   		return false; 
            //}
		}});
		
		/*init body click then hide the div*/
		jQuery("body").click(function(){
			hidemenuie5();
		});
		
		/*init the mouseover&mouseout function of the ie5menu div's menus */
		jQuery("#ie5menu > .link").mouseover(function(){
			jQuery(this).addClass("overlink");
		}).mouseout(function(){
			jQuery(this).removeClass("overlink");
		});
		
		/*init New_Module click function*/
		jQuery("#ie5menu > #New_Module").click(function(){
			//addModule();
			var appid=document.getElementById("nowappid").value;
			var moduleid=document.getElementById("nowmoduleid").value;
			var url="<s:url value='/core/deploy/module/new.action'/>?application=<%= request.getParameter("id") %>&_superiorid=" + moduleid;
			jQuery("#applicationframe").attr("src",url);
		});
		
		/*init New_Wizard click function*/
		jQuery("#ie5menu > #New_Wizard").click(function(){
			//wizard();
			var url="<s:url value='/core/wizard/tostart.action'/>?application=<%= request.getParameter("id") %>";
			jQuery("#applicationframe").attr("src",url);
		});
		
		/*init Refresh click function*/
		jQuery("#ie5menu > #Refresh").click(function(){
			window.location.reload();
		});
		
		/*init Delete click function*/
		jQuery("#ie5menu > #Delete").click(function(){
			//deleteSel();
			var appid=document.getElementById("nowappid").value;
			var moduleid=document.getElementById("nowmoduleid").value;
			if(appid!=0){
				if(moduleid!=0){ 
					if(confirm('{*[cn.myapps.core.deploy.application.delete_this_module]*}')){	
						document.forms[0].action ='<s:url value="/core/deploy/module/moddelete.action"/>'+'?_selects='+moduleid+'&application=<%= request.getParameter("id") %>';
						document.forms[0].submit();
					}
				}else{
					alert('{*[cn.myapps.core.deploy.application.please_delete_list_application]*}');	
				}
			}	
			else {   alert("{*[page.core.deploy.delete]*}!");}
		});
		
		/*init CopyAll click function*/
		jQuery("#ie5menu > #CopyAll").click(function(){
			var appid=document.getElementById("nowappid").value;
			var moduleid=document.getElementById("nowmoduleid").value;
			if(moduleid!=0){
			    document.forms[0].action  ="<s:url value='/core/deploy/copymodule/copyall.action'/>"+"?_selects="+moduleid+"&application=<%=request.getParameter("id")%>";
			  	document.forms[0].action = document.forms[0].action + "&refresh=rightFrame";
				document.forms[0].submit(); 
			}
			else if(moduleid==0 && appid !=null && appid!=0 ){
				alert("{*[App]*}{*[Not_allowed]*}{*[Copy]*}");
				//var url ="<s:url value='/core/deploy/application/copynew.action'/>"+"?application="+appid;
			  	//jQuery("#applicationframe").attr("src",url);
			}else{
				confirm('{*[page.core.deploy.copy]*}');
			}
		});
		
		/*init Import_Export click function*/
		jQuery("#ie5menu > #Import_Export").click(function(){
			var appid = document.getElementById("nowappid").value;
			var moduleid = document.getElementById("nowmoduleid").value;
			var importURL = "<s:url value='/core/expimp/exporimp.jsp'/>";
			importURL += "?applicationid=<%= request.getParameter("id") %>";
			jQuery("#applicationframe").attr("src",importURL);
		});
	});
	
	function showmenuie5(event){
		
		var rightedge=document.body.clientWidth-event.clientX;
		var bottomedge=document.body.clientHeight-event.clientY-25;
		if (rightedge<ie5menu.offsetWidth){
			if(50<rightedge && rightedge<100){
				ie5menu.style.left=document.body.scrollLeft+event.clientX-ie5menu.offsetWidth+25;
			}else{
				ie5menu.style.left=document.body.scrollLeft+event.clientX-ie5menu.offsetWidth;
			}
		}
		else{
			ie5menu.style.left=document.body.scrollLeft+event.clientX;
		}
		if (bottomedge<ie5menu.offsetHeight){
			ie5menu.style.top=document.body.scrollTop+event.clientY-ie5menu.offsetHeight;
		}else{
			ie5menu.style.top=document.body.scrollTop+event.clientY;
		}
		
		//ie5menu.style.visibility="visible";
		jQuery("#ie5menu").css("display","");//ff不支持visibility,所以改用display
		return false;
	}
	
	function hidemenuie5(){
		//ie5menu.style.visibility="hidden";
		jQuery("#ie5menu").css("display","none");//ff不支持visibility,所以改用display
		document.getElementById("nowappid").value=0;
		document.getElementById("nowmoduleid").value=0;
	}
	function rightFunction(appid,moduleid){
		//if(event.button==0||event.button==2){
			document.getElementById("nowappid").value=appid;
			document.getElementById("nowmoduleid").value=moduleid;
		//}
	}
	
	function refreshRightFrame(){
		window.location.reload();
	}
	
	function copyModule(){
		var appid=document.getElementById("nowappid").value;
		var moduleid=document.getElementById("nowmoduleid").value;
		var url="<s:url value='/core/deploy/module/copy.action'/>?application=<%= request.getParameter("id") %>&_moduleid=" + moduleid;
		jQuery("#applicationframe").attr("src",url);
	}
	
	function copy(){
		var url ="<s:url value='/core/deploy/copymodule/tostart.action'/>?application=<%= request.getParameter("id") %>";
	   	jQuery("#applicationframe").attr("src",url);
	}
	
	function copyResource() {
		var url="<s:url value='/core/resource/toCopyResource.action'/>?application=<%= request.getParameter("id") %>";
		jQuery("#applicationframe").attr("src",url);
	}
</script>

</head>
<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td valign="top" width="160px;" style="border: 2px solid #DDDDDD;">
		<div id="leftTree" style="width: 160px;height: 100%;overflow: auto;">
		<s:form action="" method="post">
			<div id="dtree" class="dtree" style="padding: 10px;overflow:visible;"></div><br/>
			<div style="display: none;color: #bbbbbb;padding-left: 10px" id="cm">
					<font>{*[Click]*} </font>
					<font color='gray'>
						<b><a href='<s:url value="/core/wizard/tostart.action?application=%{#parameters.id}" />' target="applicationframe">
							{*[cn.myapps.core.deploy.application.here]*}</a>
						</b>
					</font>
					<font> {*[cn.myapps.core.deploy.application.to_getting_start]*}......</font>
			</div>
			<s:if test="hasFieldErrors()">
				<span class="errorMessage"><br>
					<s:iterator value="fieldErrors">
						<script>
							window.setTimeout("alert('* {*[page.core.deploy.have.module]*},{*[page.cannot.delete]*}')",200);
						</script>
					</s:iterator> 
				</span>
			</s:if>
			<s:hidden name="_currpage" value="%{#parameters._currpage}"/>
			<s:hidden name="_pagelines" value="%{#parameters._pagelines}"/>
			<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
			<s:hidden name="sm_description" value="%{#parameters.sm_description}"/>
		</s:form>
		
		
		<input type="hidden" id="nowappid" name="nowappid" value="0">
		<input type="hidden" id="nowmoduleid" name="nowmoduleid" value="0">
	</div>
	</td>
	<td align="left" valign="top">
			<iframe width="100%" height="100%" src="" id="applicationframe" scrolling="no" frameborder="0" name="applicationframe" /></iframe>
	</td>
</tr>
</table>
<div id="ie5menu" class="menu" style="text-align: left; position: absolute; display: none; width: 90px; z-index: 200; padding: 1px" >
	<!--<div class=link onMouseOver=this.className='overlink' onMouseOut=this.className='link' style='padding-top:2;padding-bottom:2;text-align: left' onclick="javascript:addApplication();">&nbsp;&nbsp;{*[New_App]*}</div> -->
	<div id="New_Module" class="link" style='padding-top: 2; padding-bottom: 2; text-align: left'>&nbsp;&nbsp;{*[New_Module]*}</div>
	<div id="New_Wizard" class=link style='padding-top: 2; padding-bottom: 2; text-align: left'>&nbsp;&nbsp;{*[New]*}{*[Wizard]*}</div>
	<div id="Delete" class=link style='padding-top: 2; padding-bottom: 2; text-align: left'>&nbsp;&nbsp;{*[Delete]*}&nbsp;&nbsp;</div>
	<div id="Refresh" class=link style='padding-top: 2; padding-bottom: 2; text-align: left'>&nbsp;&nbsp;{*[Refresh]*}&nbsp;&nbsp;</div>
	<table width=100%>
		<tr height=2>
			<td width=100% BACKGROUND="<%=contextPath%>/resource/images/line.gif"></td>
		</tr>
	</table>
	<div id="CopyAll" class=link style='padding-top: 2; padding-bottom: 2; text-align: left'>&nbsp;&nbsp;{*[cn.myapps.core.deploy.application.copy_all]*}&nbsp;&nbsp;</div>
	<div id="Import_Export" class="link" style='padding-top: 2; padding-bottom: 2; text-align: left'>&nbsp;&nbsp;{*[Import]*}/{*[Export]*}&nbsp;&nbsp;</div>
</div> 
<s:hidden id="isclick" value="false"></s:hidden>
<s:hidden id="selectnode" value=""></s:hidden>
<s:hidden id="departname" value=""></s:hidden>
<s:hidden id="isedit" value="false"></s:hidden>
<input type="hidden" id="queryparams" value='&sm_name=<s:property value="%{#parameters.sm_name}"/>&sm_description=<s:property value="%{#parameters.sm_description}"/>'/>
<input type="hidden" id="pagelinesid" value="&_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>" />
</body>
</o:MultiLanguage>
</html>
