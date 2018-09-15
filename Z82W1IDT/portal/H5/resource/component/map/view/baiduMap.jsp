<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.util.property.DefaultProperty" %>
    <%
    request.setCharacterEncoding("UTF-8");
    String displayType = request.getParameter("displayType");
    String formid = request.getParameter("formid");
    String _viewid = request.getParameter("_viewid");
    String contextPath = request.getContextPath();
   

//String key="ABQIAAAAnqA-6Fc1LCSEFTRYWMrd7xRi_j0U6kJrkFvY4-OX2XYmEAa76BRM9Fv5bM-yN1bKEDrsEVq2N22XTg";
String key = DefaultProperty.getProperty("key");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<link rel="stylesheet" href="<s:url value='/portal/share/css/main.css'/>" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>baiduMapView</title>
<script src='<s:url value="/portal/share/script/AC_OETags.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/map/baiduMapAPI.js"/>'></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript">

var formid = '<%=formid%>';
var key='<%=key %>';
var contextPath='<%=request.getContextPath() %>';
var _viewid = '<%=_viewid%>';
var URL = "<%=contextPath%>";

var editMulti ="{*[Edit]*}";
var deleteMulti = "{*[Delete]*}";
jQuery(document).ready(function(){
	try{
		jQuery("#map").css("visibility","visible");
		jQuery("#networktip").css("visibility","hidden");
		var isIE=navigator.userAgent.toUpperCase().indexOf("MSIE")==-1?false:true;
		mapData = "";
		//mapData = '{"defaultLevel": "4", "defaultAddress": "中国","deleteReadOnly": false,"editReadOnly": false,"mapInfo": [{ "fieldid": "11e2-06f9-4ecb363c-80be-6d96d8d7542b_javascriptmap","lat": 38.61384,"lng": 115.661434,"level": "7","title": "12312","detail": "3123","address": "中国河北省", "addressInfo": {"country": "中国","province": "河北省", "city": "","town": "", "street": "" }}, { "level": "14","addressInfo": {"province": "北京","city": "西城区","country": "中国", "town": "阜成门" },"detail": "312313","title": "121","address": "中国北京西城区阜成门","lng": 116.361681,"fieldid": "11e2-0773-430d3a7f-9ea7-ad0a9a7bd3a0_javascriptmap", "lat": 39.929361 }]}';
		//application = "11de-ef9e-c010eee1-860c-e1cadb714510";
		var div = parent.document.getElementById("baiduMapData");
		if(isIE){
			mapData = div.innerHTML;
		}else{
			mapData = div.textContent;
		}
		application = parent.document.getElementById("ApplicationID").value;
		var height = parent.jQuery("#dataTable").height();
		jQuery("#map").height(height-30);
		initializeview();
	}catch(e){
		jQuery("#map").css("visibility","hidden");
		jQuery("#networktip").css("visibility","visible");
	}
});

//定义一个控件类，即function    
function WarmingControl(){    
    // 设置默认停靠位置和偏移量  
    this.defaultAnchor = BMAP_ANCHOR_BOTTOM_RIGHT;    
    this.defaultOffset = new BMap.Size(20, 20);    
}

function ErrorControl(){
	this.defaultAnchor = BMAP_ANCHOR_BOTTOM_RIGHT;    
    this.defaultOffset = new BMap.Size(20, 50);
}

try{
	// 通过JavaScript的prototype属性继承于BMap.Control   
	WarmingControl.prototype = new BMap.Control();
	ErrorControl.prototype = new BMap.Control();

	ErrorControl.prototype.initialize = function(map){
		var div = document.getElementById("errorPoint");
		map.getContainer().appendChild(div);
		return div;
	};
	WarmingControl.prototype.initialize = function(map){    
		//创建一个DOM元素   
		var div = document.createElement("div");

		//添加文字说明
		var img = document.createElement('img');
	 	img.src = "<%=request.getContextPath() %>/portal/default/resource/imgv2/front/main/warning.jpg";
	 	img.style.height = "25px";
	 	img.style.width = "25px";
		div.appendChild(img);    
		// 设置样式    
		div.style.cursor = "pointer";    
		// 绑定事件，点击一次放大两级    
		div.onclick = function(e){
			if(errorCtrl == null){
				errorCtrl = new ErrorControl();
				map.addControl(errorCtrl);
				document.getElementById("errorText").innerHTML = errorAddress;
			}
			if(document.getElementById("errorPoint").style.display == "none"){
				document.getElementById("errorPoint").style.display = "";
			}else{
				document.getElementById("errorPoint").style.display = "none";
			}
		};

		// 添加DOM元素到地图中   
		map.getContainer().appendChild(div); 
		// 将DOM元素返回  
		return div;
	};	
}catch(e){
	jQuery("#map").css("display","none");
	jQuery("#networktip").css("display","display");
}

</script>
</head>
<body style="margin:0px;width: 100%;height: 100%;">
	<div id="mapbutton" class="nav-s-td" style="line-height:27px">
		显示路线：<input id="isline" type="checkbox" onchange="isline()"/>
	</div>
	<div id="map" style="position: absolute; left: 1px; z-index: 1; overflow: hidden; -webkit-user-select: none;font-family:arial, sans-serif;font-size:12px;font-variant:normal;overflow: hidden;width: 100%;"></div>
	<div style="padding:6px;position: absolute;z-index: 2;width:300px;background: rgb(252, 253, 252);display:none;" id="errorPoint">
		<span style="color:#00c;"><b>无法找到以下地址:</b></span>
  		<span style="color:#666;display:block;zoom:1;overflow:hidden;" id="errorText"></span>
	</div>
	<div id="networktip" align="center" style="visibility:hidden;visitilyposition: absolute; left: 1px; z-index: 1; overflow: hidden; -webkit-user-select: none;font-family:arial, sans-serif;font-size:12px;font-variant:normal;overflow: hidden;width: 99%;height:100%;">
		<table style="background-color: white; position: absolute;z-index: 2;border-collapse: collapse;width: 100%;height: 100%;text-align: center;vertical-align: middle;">
			<tr>
				<td style="vertical-align: bottom;">
					<img src='<s:url value="/portal/default/resource/imgv2/front/main/warning.jpg"/>'>
				</td>
			</tr>
			<tr>
				<td style="vertical-align: top;">
					<h3>无法链接百度地图服务器，请检查网络链接或联系百度客服</h3>
				</td>
			</tr>
		</table>
	</div>
</body>
</o:MultiLanguage>
</html>