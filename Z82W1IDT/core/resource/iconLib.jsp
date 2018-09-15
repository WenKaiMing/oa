<%@include file="/common/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<s:bean id="rh"
	name="cn.myapps.core.resource.action.ResourceHelper" />
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<style type="text/css">
body {
	font-size: 12px;
	padding: 0px;
	margin: 0px;
}

.bigTable {
	border-bottom: 1px solid dotted;
	border-color: black;
	width: 98%;
	margin: 5px;
}
.canvas_td_over {
	background-color: #E7F3FE;
	cursor:pointer;	
	

	
}
.canvas_td_select {
	background-color: #70BAFE;
	cursor:pointer;	
	
	
}
.icon_table_size {
	color: #666;
}
</style>
<script language="javascript">
var temp;
var icon ='';
var application = '<%=request.getParameter("application")%>';
var _path = '<%=request.getParameter("path")%>'
function ev_selectIcon(obj,value){
	//alert(1);
	if(obj){
		jQuery(obj).toggleClass('canvas_td_select');
		jQuery(obj).unbind('mouseover mouseout');
		if(temp){
			jQuery(temp).removeClass('canvas_td_select canvas_td_over');
			jQuery(temp).bind('mouseover mouseout',function(){
				jQuery(this).toggleClass('canvas_td_over');
		  	});
			
		}
		temp = obj;
		icon = value.substring("uploads/lib/icon".length);
		
	}
	
		
}
function ev_dbclickFolder(obj,value){
	if(obj){
		jQuery(obj).toggleClass('canvas_td_select');
		jQuery(obj).unbind('mouseover mouseout');
		if(temp){
			jQuery(temp).removeClass('canvas_td_select canvas_td_over');
			jQuery(temp).bind('mouseover mouseout',function(){
				jQuery(this).toggleClass('canvas_td_over');
		  	});
			
		}
		temp = obj;
		icon = value;
		window.location.href=contextPath + '/core/resource/iconLib.jsp?path='+value+'&application='+ application;
	}
	
		
}
function uploadIcon(){
	var path = (_path != "null" && _path.length>0)? _path :'UPLOADICON_PATH';
	var url = contextPath + '/core/upload/upload.jsp?path='+path+'&application=' + application + '&allowedTypes=image';

	OBPM.dialog.show({
		opener : window.parent.parent,
		width : 800,
		height : 600,
		url : url,
		args : {},
		title : '图标上传',
		close : function(result) {
			location.reload();
		}
	});

}

jQuery(document).ready(function(){
  // 在这里写你的代码...
  addListener();
});

function addListener(){
	jQuery(".icon").bind('mouseover mouseout',function(){
		jQuery(this).toggleClass('canvas_td_over');
	  });
}

function ev_commit(){
	OBPM.dialog.doReturn(icon);
}
function ev_exit(){
	OBPM.dialog.doExit();
}
function ev_back(){
	window.history.back(-1); 
}
</script>
</head>
<body>
	<table cellpadding="0" cellspacing="0" width="100%" style="position: fixed;">
		<tr class="nav-s-td">
			<td align="right" class="nav-s-td">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<s:if test="#parameters.path != null">
							<button class="button-image" type="button"
								onClick="ev_back();"><img
								src="<s:url value="/resource/image/back.gif"/>">{*[Back]*}</button>
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							</s:if>
							<button class="button-image" type="button"
								onClick="uploadIcon();"><img
								src="<s:url value="/resource/imgnew/add.gif"/>">{*[Upload]*}</button>
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button class="button-image" type="button"
								onClick="ev_commit();"><img
								src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[OK]*}</button>
							<button class="button-image" type="button"
								onClick="ev_exit();"><img
								src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<table width="100%" border="0" cellpadding="0" cellspacing="10" id="canvas" style="padding-top:20px">
<s:iterator value="#rh.getIcons(#parameters.path)" id="icon" status="status" >
<s:if test="#status.index==0 || #status.index % 4==0 ">
<tr>
</s:if>
<td class="canvas_td" >
	<s:if test="fileType==1">
		<table class="icon" width="100%" border="0" cellpadding="0" cellspacing="0"  onclick="ev_selectIcon(this,'<s:property value="path"/>')" >
	      <tr>
	        <td width="48" height="48" rowspan="3"><img src="../../<s:property value="path"/>"
	        <s:if test="width>48">
	         width="48" height="48" 
	         </s:if>
	         /></td>
	        <td>&nbsp;<s:property value="name"/></td>
	      </tr>
	      <tr>
	        <td class="icon_table_size" id="size">&nbsp;<s:property value="size"/></td>
	      </tr>
	      <tr>
	        <td class="icon_table_size" id="le">&nbsp;<s:property value="length"/></td>
	      </tr>
	    </table>
    </s:if>
    <s:elseif test="fileType==2">
		<table class="icon" width="100%" border="0" cellpadding="0" cellspacing="0" ondblclick="ev_dbclickFolder(this,'<s:property value="path"/>')" >
	      <tr>
	        <td width="48" height="48" rowspan="3"><img src="../../resource/images/folder_48.png"
	         /></td>
	        <td>&nbsp;<s:property value="name"/></td>
	      </tr>
	      <tr>
	        <td class="icon_table_size" id="size">&nbsp;文件夹</td>
	      </tr>
	    </table>
    </s:elseif>
</td>
</s:iterator>
</table>
</body>
</o:MultiLanguage>
</html>