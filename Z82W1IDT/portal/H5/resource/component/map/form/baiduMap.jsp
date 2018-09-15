<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/tags.jsp"%>
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
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/map/baiduMapAPI.js"/>'></script>
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script> 
<script language="JavaScript" type="text/javascript">

var type = '<%=type%>';
var key='<%=key %>';
var hostAddres='<%=hostAddres %>';
var applicationid='<%=applicationid %>';
var displayType = '<%=displayType%>';

var addMulti = "{*[Add]*}";
var editMulti = "{*[Edit]*}";
var contentMulti = "{*[Content]*}";
var markContent = "";
var markTitle = "";

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
			fieldID = OBPM.dialog.getArgs().fieldID;
			mapData = OBPM.dialog.getArgs().mapData;
			mapData = mapData.replace(/@quot;/g, '"');
			jQuery("#saveButton").css("visibility","visible");
			jQuery("#closeButton").css("visibility","visible");
			window.setTimeout(function(){
				  map.reset();
			},500);
		}else{
			fieldID = '<%=fieldID%>';
			mapData = '<%=mapData%>';
		}
		if(fieldID!=""){
			docID = fieldID.split("_")[0];
		}
		var height = document.body.height;
		initializeform();
		createContextMenu();
	}catch(e){
		jQuery("#map").css("visibility","hidden");
		jQuery("#mapbutton").css("visibility","hidden");
		jQuery("#networktip").css("visibility","visible");
	}
});

//重置按钮
function clearmark(){
	var title=document.getElementById("title");
	var content=document.getElementById("content");
	title.value="";
	content.value="";
	title.focus();
}

</script>
</head>
<body id="body" style="margin:0px;border: 1px solid #999;overflow: hidden;">
	<div id="mapbutton" class="nav-s-td">
		<input id="addButton" type="button" value="查询" onclick="addbtn()"/>
		<s:label id="address" value="" style="font-size: 15px;line-height:27px"/>
		<input id="relocate" type="button" value="重新定位" onclick="gpsPosition()" style="position: absolute;right: 0px;"/>
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
	<table id="selectPupWindow" style="background-color: white; position: absolute; visibility:hidden; z-index: 2; top: 29px; left: 2px;border-collapse: collapse;border: 1px solid #999;">
		<tr>
			<td align="left" style="font-size: 25;font-weight: bold;height: 40px;background: rgb(226, 226, 226);" >搜索:</td>
			<td align="right" style="height: 40px;background: rgb(226, 226, 226);" ><input type="button" value="关闭" onclick="canBtn()"/></td>
		</tr>
		<tr>
			<td colspan="2"  style="padding: 5px;padding-top: 10px"><h3>经纬度搜索：</h3></td>
		</tr>
		
		<tr>
			<td colspan="2"  style="padding: 5px">经度:</td>
		</tr>
		<tr>
			<td colspan="2" style="padding: 5px"><input type="text" id="longitude" style="width: 180px;"/></td>
		</tr>
		
		<tr>
			<td colspan="2"  style="padding: 5px">纬度:</td>
		</tr>
		<tr>
			<td colspan="2" style="padding: 5px"><input type="text" id="latitude" style="width: 180px;"/></td>
		</tr>
		
		<tr>
			<td colspan="2"  style="padding: 5px"><input type="button" value="查询" onclick="qurbyNumber()"/></td>
		</tr>
		
		<tr>
			<td colspan="2"  style="padding: 5px;padding-top: 50px"><h3>地址搜索：</h3></td>
		</tr>
		
		<tr>
			<td colspan="2"  style="padding: 5px">详细地址:</td>
		</tr>
		<tr>
			<td colspan="2" style="padding: 5px"><input type="text" id="detailAddress" style="width: 200px;"/></td>
		</tr>
		<tr>
			<td colspan="2"  style="padding: 5px"><input type="button" value="查询" onclick="doGeocodeForm()"/></td>
		</tr>
		<tr>
			<td colspan="2"  style="padding: 5px;padding-top: 90px"></td>
		</tr>
	</table>
<input type="hidden" name="content.level" id="level"/>
</body>
</o:MultiLanguage>
</html>