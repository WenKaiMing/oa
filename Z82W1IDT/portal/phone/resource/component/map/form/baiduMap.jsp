<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.util.property.DefaultProperty" %>
<%@ page import="cn.myapps.core.baidumap.BaiduMap"%>
<%@ page import="java.net.URLDecoder" %>
<%
request.setCharacterEncoding("UTF-8");
String type = request.getParameter("type");
String fieldID = "";
String mapData = "";
String displayType = request.getParameter("displayType");
String applicationid=request.getParameter("applicationid");


//测试数据
//type = "dialog22";
//fieldID = "11e1-db79-418ef85c-9f4b-e77667fa5532_maps";
//displayType = "2";
//applicationid ="11de-ef9e-c010eee1-860c-e1cadb714510";   

if(!type.equals("dialog")){
	fieldID=request.getParameter("fieldID");
	fieldID =java.net.URLDecoder.decode(fieldID,"utf-8");  
	mapData = BaiduMap.getMapData(fieldID, applicationid);
}

String key = DefaultProperty.getProperty("key");
String hostAddres=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
String contextPath = request.getContextPath();
%>
<html>
<o:MultiLanguage>
<head>
<title>baiduMap</title>
<!-- js百度地图api -->
<link rel="stylesheet" href="<s:url value='/portal/share/css/main.css'/>" type="text/css">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>baiduMap</title>
<script type="text/javascript" src='<s:url value="/portal/share/component/map/baiduMapAPI.js"/>'></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script language="JavaScript" type="text/javascript">

var type = '<%=type%>';
var key='<%=key %>';
var hostAddres='<%=hostAddres %>';
var applicationid='<%=applicationid %>';
var displayType = '<%=displayType%>';

var addMulti = "{*[Add]*}";
var editMulti = "{*[Edit]*}";
var contentMulti = "{*[Content]*}";

jQuery(document).ready(function(){
	try{
		jQuery("#map").css("visibility","visible");
		jQuery("#mapbutton").css("visibility","visible");
		jQuery("#networktip").css("visibility","hidden");
		if(displayType!=2 && displayType != '2'){
			jQuery("#addButton").css("display","none");
			jQuery("#delButton").css("display","none");
		}
		if(type=="dialog"){
			fieldID = OBPM.dialog.getArgs()['fieldID'];
			mapData = OBPM.dialog.getArgs()['mapData'];
			jQuery("#saveButton").css("visibility","visible");
			jQuery("#closeButton").css("visibility","visible"); 
		}else{
			fieldID = '<%=fieldID%>';
			mapData = '<%=mapData%>';
		}
		if(fieldID!=""){
			docID = fieldID.split("_")[0];
		}
		var height = document.body.height;
		initializeform();
	}catch(e){
		jQuery("#map").css("visibility","hidden");
		jQuery("#mapbutton").css("visibility","hidden");
		jQuery("#networktip").css("visibility","visible");
	}
});

/* function loadScript() {
	var script = document.createElement("script");
	script.src = "http://api.map.baidu.com/api?v=1.3&callback=initializeform";
	document.body.appendChild(script);
}

window.onload = loadScript; */

</script>
</head>
<body style="margin:0px;border: 1px solid #999;overflow: hidden;">
	<div id="mapbutton" class="nav-s-td">
		<input id="addButton" type="button" value="{*[Add]*}" onclick="addMarker()"/>
		<input id="delButton" type="button" value="{*[Delete]*}" onclick="delMarker()" /> 
		地址:<s:label id="address" value=""/>
		<input id="saveButton" type="button" value="{*[OK]*}" onclick="saveResult()" style="visibility: hidden;position: absolute;right: 45px;color: green;"/>
		<input id="closeButton" type="button" value="{*[Close]*}" onclick="closeIframe()" style="visibility: hidden;position: absolute;right: 0px;color: green;" />
	</div>
	<div id="map" style="position: absolute; left: 1px; top: 30px; z-index: 1; overflow: hidden; -webkit-user-select: none;width:100%;font-family:arial, sans-serif;font-size:12px;font-variant:normal;overflow: hidden;height: 95%;"></div>
	<div id="networktip" align="center" style="visibility:hidden;position: absolute; left: 1px; z-index: 1; overflow: hidden; -webkit-user-select: none;font-family:arial, sans-serif;font-size:12px;font-variant:normal;overflow: hidden;width: 99%;height:100%;">
		<table style="background-color: white; position: absolute;z-index: 2;border-collapse: collapse;width: 100%;height: 100%;text-align: center;vertical-align: middle;">
			<tr>
				<td style="vertical-align: bottom;">
					<img src='<s:url value="/portal/share/images/imgnew/warning.jpg"/>'>
				</td>
			</tr>
			<tr>
				<td style="vertical-align: top;">
					<h3>无法链接百度地图服务器，请检查网络链接或联系百度客服</h3>
				</td>
			</tr>
		</table>
	</div>
	<table id="selectPupWindow" width="300px" height="200px" style="background-color: white; position: absolute; visibility:hidden; z-index: 2; top: 29px; left: 2px;border-collapse: collapse;border: 1px solid #999;">
		<tr>
			<td align="center" colspan="2" style="font-size: 25;font-weight: bold;height: 40px;background: rgb(226, 226, 226);" >地址信息</td>
		</tr>
		<tr>
			<td align="right" width="15%">国家：</td>
			<td align="left" width="10%"><select id="country" style="width: 135px;"/></td>
		</tr>
		<tr>
			<td align="right" width="15%">省市自治区：</td>
			<td align="left" width="10%"><select id="province" style="width: 135px;"/></td>
		</tr>
		<tr>
			<td align="right" width="15%">市县区：</td>
			<td align="left" width="10%"><select id="city" style="width: 135px;"/></td>
		</tr>
		<tr>
			<td align="right" width="15%">市县镇：</td>
			<td align="left" width="10%"><select id="town" style="width: 135px;"/></td>
		</tr>
		<tr>
			<td align="right" width ="15%">详细地址:</td>
			<td align="left" width ="10%"><input type="text" id="detailAddress"/></td>
		</tr>
		<tr>
			<td align="right" width="15%">标题:</td>
			<td align="left" width="10%"><input type="text" id="title"/></td>
		</tr>
		<tr>
			<td align="right" width="15%" valign="top" >内容:</td>
			<td align="left" width="10%"><textarea id="content" style="width: 135px;height: 50px;"></textarea></td>
		</tr>
		<tr>
			<td align="center" colspan="2" height="30px">
				<input type="button" value="确定" onclick="okBtn()" />
				<input type="button" value="取消" onclick="canBtn()"/>
			</td>
		</tr>
	</table>
<input type="hidden" name="content.level" id="level"/>
</body>
</o:MultiLanguage>
</html>