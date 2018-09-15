<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page
	import="java.io.File,cn.myapps.util.property.DefaultProperty,cn.myapps.constans.Environment,java.net.*"%>
<%!public final static String FILE_SAVE_MODE_SYSTEM = "00";
	public final static String FILE_SAVE_MODE_CUSTOM = "01";

	private Environment env = Environment.getInstance();

	/**
	 * 获取文件真实保存目录
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getFileRealDir(String path) {
		return env.getApplicationRealPath() + path;
	}

	/**
	 * 获取文件保存目录
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getFileDir(String path, String fileSaveMode) {
		try {
			String dir = "";
			if (fileSaveMode.equals(FILE_SAVE_MODE_CUSTOM)) {
				dir = "uploads\\" + path.replace("/", "\\").substring(1);
			} else if (fileSaveMode.equals(FILE_SAVE_MODE_SYSTEM)) {
				dir = "uploads";
				File f1 = new File(getFileRealDir(DefaultProperty
						.getProperty(path)));
				if (!f1.exists()) {
					f1.mkdirs();
				}
			}

			return dir;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "";
	}%>
<%
	//上下文路径
	String contextPath = request.getContextPath();

	String hostAddres = request.getScheme()+"://"+ request.getServerName() + ":"+ request.getServerPort() + contextPath;
	
	String applicationid = request.getParameter("applicationid");

	//获得角色列表
	String rolelist = ((WebUser) request.getSession().getAttribute("FRONT_USER")).getRolelist(applicationid);


	//系统默认的文件保存路径
	String path = request.getParameter("path");

	//文件保存模式
	String fileSaveMode = request.getParameter("fileSaveMode");


	//文件类型
	String allowedTypes = request.getParameter("allowedTypes");

	//限制大小
	String maximumSize = request.getParameter("maximumSize");

	//显示路径和真实路径，项目真实路径
	String showPath = "";
	String realPath = "";
	String envRealPath = "";
	String rootName = "uploads";
	if (fileSaveMode.equals(FILE_SAVE_MODE_CUSTOM)) {
		showPath = getFileDir(path, fileSaveMode).substring(getFileDir(path, fileSaveMode).lastIndexOf("\\") + 1);
		realPath = getFileRealDir(getFileDir(path, fileSaveMode));
		envRealPath = realPath.substring(0,realPath.lastIndexOf("/") + 1);
		//如果不存在该文件夹就创建
		File f1 = new File(realPath);
		if (!f1.exists()) {
			f1.mkdirs();
		}
	} else if (fileSaveMode.equals(FILE_SAVE_MODE_SYSTEM)) {
		showPath = "uploads";
		realPath = getFileRealDir(getFileDir(path, fileSaveMode));
		envRealPath = env.getRealPath("");
	}
%>


<%@page import="java.util.Properties"%>
<%@page import="java.io.InputStream"%>
<%@page import="cn.myapps.core.user.action.WebUser"%><html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<title>{*[Upload_File]*}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src='<s:url value="/portal/share/script/AC_OETags.js"/>'></script>
	<script type="text/javascript">
	window.onload = function(){
		var scrW = document.body.scrollWidth;
		var scrH = document.body.scrollHeight;
		if(scrW < 700 || scrH < 400) return;
		OBPM.dialog.resize(scrW+20, scrH+70);
	};
	
	function ev_doEmpty() {
		OBPM.dialog.doClear();
	}
	function ev_doClose(s) {
		OBPM.dialog.doReturn(s);
	}


    </script>
	</head>
	<body style="width: 100%; height: 100%; margin: 0px">
	<script language="JavaScript" type="text/javascript">
	<!--
	//Globals
	//Major version of Flash required
	var requiredMajorVersion = 9;
	//Minor version of Flash required
	var requiredMinorVersion = 0;
	//Minor version of Flash required
	var requiredRevision = 124;
	// Version check for the Flash Player that has the ability to start Player Product Install (6.0r65)
	// Version check based upon the values defined in globals
	var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
	
	if (!hasRequestedVersion) {
		var alternateContent = '{*[Flash_Player_Install]*} '
		   	+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
		    document.write(alternateContent);  // insert non-flash content
	}
	// -->
	</script>
	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
		id="FileManager" width="100%" height="100%"
		codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
		<param name="movie" value="FileManager1.swf" />
		<param name="quality" value="high" />
		<param name="bgcolor" value="#869ca7" />
		<param name="FlashVars"
			value="allowedTypes=<%=allowedTypes%>&maximumSize=<%=maximumSize%>&contextPath=<%=contextPath%>&realPath=<%=realPath%>&showPath=<%=showPath%>&envRealPath=<%=envRealPath%>&hostAddres=<%=hostAddres%>&rolelist=<%=rolelist%>&rootName=<%=rootName%>&fileSaveMode=<%=fileSaveMode %>" />
		<param name="allowScriptAccess" value="sameDomain" />
		<embed src="FileManager1.swf" quality="high" bgcolor="#869ca7"
			width="100%" height="100%" name="FileManager" align="middle"
			play="true" loop="false" quality="high"
			allowScriptAccess="sameDomain"
			FlashVars="allowedTypes=<%=allowedTypes%>&maximumSize=<%=maximumSize%>&contextPath=<%=contextPath%>&realPath=<%=realPath%>&showPath=<%=showPath%>&envRealPath=<%=envRealPath%>&hostAddres=<%=hostAddres%>&rolelist=<%=rolelist%>&rootName=<%=rootName%>&fileSaveMode=<%=fileSaveMode %>"
			type="application/x-shockwave-flash"
			pluginspage="http://www.adobe.com/go/getflashplayer">
		</embed> </object>
	</body>
</o:MultiLanguage>
</html>

