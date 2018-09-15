<%@ page contentType="text/html; charset=UTF-8"%>
<%@page
	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.email.util.EmailConfig"%>
<%@page import="cn.myapps.core.sysconfig.ejb.KmConfig"%>
<%@page import="java.util.*"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><s:if test="#session.FRONT_USER.getDomain().getSystemName().length()>0"><s:property value="#session.FRONT_USER.getDomain().getSystemName()"/></s:if><s:else>{*[front.teemlink]*} OA</s:else></title>
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/index.css" />
<link type="text/css" rel="stylesheet"
	href="./resource/jquery/layout-default-latest.css">
<link href="./resource/jquery/jquery-ui.min.css" rel="stylesheet">
<script type="text/javascript" src="./resource/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>
<!-- 弹出层插件--start -->
<script src="../H5/resource/component/artDialog/jquery.artDialog.source.js?skin=aries"></script>
<script src="../H5/resource/component/artDialog/plugins/iframeTools.source.js"></script>
<script src="../H5/resource/component/artDialog/obpm-jquery-bridge.js"></script>
<!-- 弹出层插件--end -->
<style>

</style>
<script type="text/javascript">
function doPersonalSetup() {
	var url = "";
<%WebUser user = (WebUser) session
				.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		String userId = user.getId();
		out.println("url = '../user/editPersonal.action?editPersonalId="
				+ userId + 
"';");%>

	OBPM.dialog.show({
		opener : window,
		width : 900,
		height : 550,
		url : url,
		title : "{*[Setup]*}",
		close : function(rtn) {
		}
	});
};
</script>
</head>
<body>
<div id="page" class="row">
  <div id="left" class="col-xs-2">
    <div class="menu">
      <div class="guest">
        <div class="u_face fl"><img alt="" width="45" height="45" src="resource/main/images/logo.png" />
          <div class="face"><img alt="" src="images/face.png" /></div>
        </div>
        <div class="u_name fl">天翎办公系统</div>
        <div class="clear"></div>
      </div>
      <ul>
        <li class="active"><a href="homepage.jsp" target="main"><img alt="" src="images/ico01.png" />主页</a></li>
        <li><a href="flowCenter.jsp" target="main"><img alt="" src="images/ico02.png" />流程</a></li>
        <!-- 
        <li><a href="#" target="main"><img alt="" src="images/ico03.png" />CRM<span class="fr">3</span></a></li>
        <li><a href="#" target="main"><img alt="" src="images/ico04.png" />myApps功能示例</a></li>
        <li><a href="#" target="main"><img alt="" src="images/ico05.png" />OA办公管理系统</a></li>
        <li><a href="#" target="main"><img alt="" src="images/ico06.png" />任务</a></li>
        <li><a href="#" target="main"><img alt="" src="images/ico07.png" />调查问卷</a></li>
        <li><a href="#" target="main"><img alt="" src="images/ico08.png" />知识文档管理</a></li>
        <li><a href="#" target="main"><img alt="" src="images/ico09.png" />消息</a></li>
         -->
        
			<%
				ApplicationHelper ah = new ApplicationHelper();
				Collection<ApplicationVO> appList = ah.getListByWebUser(user);

				String applicationId = request.getParameter("application");
				for (ApplicationVO applicationVO : appList) {
					applicationId = applicationVO.getId();
					String desc = applicationVO.getName().trim();
					String title = desc;
					out.print("<li title='" + title + "'><a href='menu.jsp?application="
							+ applicationId
							+ "' target='main'><img alt='' src='images/ico03.png' />"
							+ desc + "</a></li>");
				}
				
				out.println("<li><a href='../../pm/index.jsp' target='main'><img alt='' src='images/ico06.png' />{*[Task]*}</a></li>");
				//判断是否开启KM
				if (KmConfig.isKmEnable()) {
					out.println("<li><a href='knowledge.jsp' target='main'><img alt='' src='images/ico08.png' />{*[km.name]*}</a></li>");
				}
			%>
        	<li><a href="message.jsp" target="main"><img alt="" src="images/ico09.png" />{*[front.message]*}<span class="fr" id="message-tips">0</span></a></li>
      </ul>
    </div>
    <div class="menu_bottom">
      <div class="b_setting fl" onclick="doPersonalSetup()"><a href="#"><img alt="" src="images/ico10.png" />设置</a></div>
      <div class="b_exit fr"><a href="./logout.jsp"><img alt="" src="images/ico11.png" />{*[Logout]*}</a></div>
    </div>
  </div>
  <div id="if_right" class="col-xs-10">
    <iframe name="main" src="homepage.html"></iframe>
  </div>
</div>
<script src="resource/js/jquery-1.11.3.min.js"></script>
<script src="resource/script/bootstrap.min.js"></script>
</body>
</html>
</o:MultiLanguage>