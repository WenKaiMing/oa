<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="width:100%;height:100%" id="weixingpsfield_map_container"></div>

<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<script charset="utf-8" src="https://apis.map.qq.com/api/js?v=2.exp&key=25CBZ-LCS3G-2NPQT-I3F7Y-J4K52-RLFKL&libraries=drawing,geometry,autocomplete,convertor"></script>
<script type="text/javascript">
$(document).ready(function(){
	var arg = OBPM.dialog.getArgs();
	if(!arg) return;
	var location = arg["location"];
	var geocoder,map, marker = null;
	var center = new qq.maps.LatLng(location.latitude,location.longitude);
    map = new qq.maps.Map(document.getElementById('weixingpsfield_map_container'),{
        center: center,
        zoom: 25
    });
    var info = new qq.maps.InfoWindow({map: map});
    geocoder = new qq.maps.Geocoder({
        complete : function(result){
            map.setCenter(result.detail.location);
            var marker = new qq.maps.Marker({
                map:map,
                position: result.detail.location
            });
            qq.maps.event.addListener(marker, 'click', function() {
                info.open();
                info.setContent('<div style="width:220px;height:60px;">'+
                		location.address+'</div>');
                info.setPosition(result.detail.location);
            });
            setTimeout(function(){
            	qq.maps.event.trigger(marker,'click');
            }, 500);
          
        }
    });
    geocoder.getAddress(center);
});

</script>
</body>
</html>