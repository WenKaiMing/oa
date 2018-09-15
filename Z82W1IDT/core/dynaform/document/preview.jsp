<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[Preview]*}</title>
<script type="text/javascript">
var formId = '<%=request.getParameter("_formid")%>';

function changeSkinType(value){
	document.getElementById("preview").src = '<s:url value="/core/dynaform/document/preview.action" />'+'?_formid='+formId+'&_skinType='+value+ '&application=<%=request.getParameter("application")%>';
}

//获取容器内容高度
function getContentHeight(){
	var preIframe = document.getElementById("preview");
	//getIsComplete方法在document.js页面，判断表单是否重构完成。
	if(typeof(preIframe.contentWindow.getIsComplete)=="function"){
		if(preIframe.contentWindow.getIsComplete()){
			var activityTableH = preIframe.contentWindow.jQuery("#activityTable").height();
			var toAllH  = preIframe.contentWindow.jQuery("#toAll").height();
			jQuery("#iframeDiv").height(activityTableH + toAllH + 96);
			jQuery(".DivBack").height(activityTableH + toAllH + 60);
		}else{
			setTimeout(function(){
				getContentHeight();
			},300);
		}
	}
}
//设置容器的高度
function setHeight(){
	var preIframe = document.getElementById("preview");
	if(preIframe.contentWindow.document.readyState == "complete"){
		setTimeout(function(){
			getContentHeight();
		},500);
	}else{
		setTimeout(function(){
			setHeight();
		},500);
	}
}
jQuery(document).ready(function(){
	jQuery("#skinType").find("option[value='H5']").attr("selected",true);
	changeSkinType("H5");
	setTimeout(function(){
		setHeight();
	},500);
});
</script>
</head>
<body style="height:100%;overflow:hidden;margin:0;padding:0;padding-top:35px;">
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
	<div style="width:100%;position:absolute;top:0px;left:10px;height:35px;line-height:35px;background:#fff;">
		<span style="font-size: 12px;">{*[cn.myapps.core.domain.switch_skin]*}：</span>
		<s:select cssClass="input-cmd" cssStyle="margin-top:6px;" id="skinType" list="#dh.querySkinTypes(null)" onchange="changeSkinType(this.value)" name="content.skinType" />
		<span style="color: #008000;font-size: 13px;margin-left: 50px;">{*[cn.myapps.core.domain.preview_point]*}</span>
	</div>
	<div style="position:relative;width:100%;height:90%;overflow:auto;">
		<div id="iframeDiv" style="width:100%;">
			<iframe id="preview" src="" width="99%" height="99%"></iframe>
			<div class="DivBack" style="position: absolute; z-index: 50; width: 100%; top: 0px; right: 25px; background-color:#DED8D8; filter: alpha(opacity = 20); opacity: 0.2;"></div>
		</div>
	</div>
</body>
</o:MultiLanguage>
</html>