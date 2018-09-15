<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="cn.myapps.core.homepage.action.HomePageHelper"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.myapps.core.user.ejb.UserDefined"%>
<%@page import="cn.myapps.core.widget.ejb.PageWidget"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@page import="cn.myapps.util.property.PropertyUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>HomePage</title>
	<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>
	<link href='<s:url value="/portal/share/fonts/custom/widget_icon_lib.css"/>' rel="stylesheet" />
	<link href="./resource/homepage/css/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
	<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
	<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
	
	<script type="text/javascript">
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
<body>
	<input style="display: none" type='text' id='userId' name='userId'
		value='<%=user.getId()%>' />
	<textarea style="display: none" id='templateElement'
		name='templateElement'>
	<%
		UserDefined userDefined = homePageHelper.getUserDefined(user);
		if (userDefined != null && userDefined.getTemplateElement() != null) {
			out.print(userDefined.getTemplateElement());
		}
	%>
	</textarea>
</body>

<script type="text/javascript" src="./resource/homepage/js/Jh.js"></script>
</html>
</o:MultiLanguage>