<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="cn.myapps.core.homepage.action.HomePageHelper"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.myapps.core.user.ejb.UserDefined"%>
<%@page import="cn.myapps.core.widget.ejb.PageWidget"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.util.property.PropertyUtil"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
	String closeUrlStr = new OBPMDispatcher().getDispatchURL("../../../portal/dispatch/closeTab.jsp",request,response);

	WebUser user = (WebUser) request.getSession().getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	HomePageHelper homePageHelper = new HomePageHelper();
	Collection<PageWidget> widgetList = homePageHelper.getMyWidgets(user);

	String widget_custom = PropertyUtil.getByPropName("myapp","widget.config.custom");
	String widget_layoutStyle = PropertyUtil.getByPropName("myapp","widget.config.layoutStyle");
	
	StringBuffer appL = new StringBuffer();
	StringBuffer appM = new StringBuffer();
	StringBuffer appR = new StringBuffer();
	StringBuffer iconLinkStr = new StringBuffer();
	String str;
	
	int count = 0;//将Widget 分别初始化到左、中、右位置中
	
	for (PageWidget widget : widgetList) {
		
		String widget_icon = widget.getIcon();
		String _typeStr = widget.getType();

		if(widget.getIconShow()){
			str = "'" + widget.getId() + "':{'name':'" + widget.getName()
				+ "','titleColor':'"+widget.getTitleColor()+"','icon':'"
				+ widget_icon +"','titleBColor':'"+widget.getTitleBColor()+"','iconShow':'"
				+ widget.getIconShow()+ "','type':'"
				+ _typeStr + "','applicationId':'"
				+  widget.getApplicationid() +"'";
			if("view".equals(_typeStr) 
					 || "page".equals(_typeStr) 
					 || "runquanReport".equals(_typeStr)
					 || "report".equals(_typeStr)
					 || "customizeReport".equals(_typeStr)){
				
				String widgetActionContent = widget.getActionContent();
				
				if("report".equals(_typeStr) && widgetActionContent.startsWith("$")){
					widgetActionContent = widgetActionContent.substring(1);
				}
				
				str = str + ",'actionContent':'"+widgetActionContent+"'";
			}
			str = str + "},";
			
			iconLinkStr.append(str);
		}else{
			str = "'" + widget.getId() + "':{'name':'" + widget.getName()
				+ "','titleColor':'"+widget.getTitleColor()+"','icon':'"
				+ widget_icon +"','titleBColor':'"+widget.getTitleBColor()+"','iconShow':'"
				+ widget.getIconShow()+ "','type':'"
				+ _typeStr+"'},";
					
			switch (count % widget_layoutStyle.split(":").length) {
			case 0:
				appL.append(str);
				break;
			case 1:
				appM.append(str);
				break;
			case 2:
				appR.append(str);
				break;
			default:
				appL.append(str);
				break;
			}
			count ++;
		}
	}
	
	if (appL.length() > 0)
		appL.deleteCharAt(appL.length() - 1);
	if (appM.length() > 0)
		appM.deleteCharAt(appM.length() - 1);
	if (appR.length() > 0)
		appR.deleteCharAt(appR.length() - 1);
	if (iconLinkStr.length() > 0)
		iconLinkStr.deleteCharAt(iconLinkStr.length() - 1);

%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
	<link href='<o:Url value="/resource/fonts/custom/widget_icon_lib.css"/>' rel="stylesheet" />
	<link href="./resource/homepage/css/main.css" rel="stylesheet" type="text/css" />
	<script src="<s:url value='/portal/H5/resource/js/jquery-1.11.3.min.js'/>"></script>
	<script src="<s:url value='/portal/H5/resource/component/artDialog/jquery.artDialog.source.js?skin=aries'/>"></script>
<%
boolean isDebug = true;
if(isDebug){
%>
	<link href="./resource/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="./resource/css/swiper.min.css" rel="stylesheet" type="text/css" />
	<link href="./resource/css/myapp.css" rel="stylesheet" type="text/css" />
	<link href="./resource/css/animate.css" rel="stylesheet" type="text/css" />
	
	<script src="<s:url value='/portal/H5/resource/jquery/jquery-ui.min.js'/>"></script>
	<script src="<s:url value='/portal/H5/resource/script/bootstrap.min.js'/>"></script>
	<script src="<s:url value='/portal/H5/resource/script/swiper.min.js'/>"></script>
	<script src="<s:url value='/portal/H5/resource/script/common.js'/>"></script>
	
	<script src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
	<script src="<s:url value='/portal/H5/resource/script/jquery.cityselect.js'/>"></script>
	<script src="<s:url value='/portal/H5/resource/script/jquery.slimscroll.min.js'/>" ></script>
	
	<script src="<s:url value='/portal/H5/resource/component/artDialog/plugins/iframeTools.source.js'/>"></script>
	<script src="<s:url value='/portal/H5/resource/component/artDialog/obpm-jquery-bridge.js'/>"></script>
	<script src="<s:url value='/portal/H5/resource/homepage/js/Jh.js'/>"></script>
<%
}else{
%>
<%@ include file="/portal/H5/resource/common/homepage_css.jsp" %>
<%@ include file="/portal/H5/resource/common/homepage_js.jsp" %>
<%
}
%>
	<script>
	var contextPath = '<%=request.getContextPath()%>';
	//关闭缓存
	$.ajaxSetup({cache:false});
	var closeUrlStr = "<%=closeUrlStr%>";	//Jh.js中使用
	var widget_custom = <%=widget_custom%>;	//Jh.js中使用
	$(function() {
		var defaultCfg = {
				'appIcon':{<%=iconLinkStr %>},
				'layoutStyle':'<%=widget_layoutStyle %>',
				'appL':{<%=appL %>},
				'appM':{<%=appM %>},
				'appR':{<%=appR %>}
		};
		var userCfg;
		try {
			
			var config = $.trim($("#templateElement").val());
			
			//兼容平台旧数据，是旧数据时重置首页
			if(config.indexOf(";")>0){
				config="";
			}
			if (config.length>0) {
				userCfg = $.parseJSON(config);
			}
			Jh.Portal.init(userCfg, defaultCfg);
		} catch(e) {
			alert("JSON:"+e);
		}
	});

	</script>
</head>
<body style="padding-top:10px;">
<input style="display: none" type='text' id='userId' name='userId' value='<%=user.getId()%>' />
<textarea style="display: none" id='templateElement' name='templateElement'>
<%
	UserDefined userDefined = homePageHelper.getUserDefined(user);
	if (userDefined != null && userDefined.getTemplateElement() != null) {
		out.print(userDefined.getTemplateElement());
	}
%>
</textarea>
</body>

</html>


</o:MultiLanguage>