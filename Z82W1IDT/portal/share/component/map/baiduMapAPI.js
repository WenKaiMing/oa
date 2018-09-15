/*************************************Field*************************************/
//公用字段
var level;
var opts = {width:200,height:130};
var mapData="";

//表单字段
var docID="";
var fieldID="";

var map = null;
var point = null;
var marker = null;
var polyline = null;
var label = null;
var infoWindow = null;
var jsonObject = {};
var title;
var detail;
var isSave = false;   //是否保存
var isrtnMarker = false;

var titleStr="";//标题
var detailStr="";//内容
var address="";//详细地址


//视图字段
var application = "";
var lnglatStr = "";
var detailPoint;
var documentid = "";
var defaultPoint;
var readOnly = false;
var deleteReadOnly = false;	
var errorAddress = "";
var warningCtrl;
var errorCtrl;
var errorVisibility = false;
var isclick=true;
var polylinePointsArray = [];

/*************************************Field*************************************/

/*************************************Form*************************************/
//初始化地图
function initializeform() {
	point = new BMap.Point(116.904, 39.915);
	marker = new BMap.Marker(point);
	infoWindow = new BMap.InfoWindow("", opts);  // 创建信息窗口对象  
	map = new BMap.Map('map');
	//地图平移缩放控件，默认位于地图左上方，它包含控制地图的平移和缩放的功能。
	map.addControl(new BMap.NavigationControl({offset: new BMap.Size(0, 40)}));
	//缩略地图控件，默认位于地图右下方，是一个可折叠的缩略地图。
	map.addControl(new BMap.ScaleControl());
	map.addControl(new BMap.OverviewMapControl());
	map.addControl(new BMap.MapTypeControl({mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP,BMAP_SATELLITE_MAP]}));
	map.disableDoubleClickZoom();
	addDblclick();
	initMarker();
	if(isrtnMarker == false && (navigator.userAgent.match(/(iPhone|iPod|Android|ios|iPad)/i))){
		jQuery("#addButton").hide();
		gpsPosition();
	}else{
		jQuery("#relocate").hide();
	}
}

// 移除标记
function delmarker(){
	marker.closeInfoWindow();
	map.clearOverlays();
	jQuery("#title").val("");
	jQuery("#content").val("");
	jQuery("#latitude").val("");
	jQuery("#longitude").val("");
	address="";
	createField();
	parent.document.getElementById(fieldID).value="";
	parent.document.getElementById(fieldID).value=mapData; 
}

//GPS定位
function gpsPosition(){
	//百度api定位方法
	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(position){
		if(this.getStatus() == BMAP_STATUS_SUCCESS){
			marker = new BMap.Marker(position.point);
			var gc = new BMap.Geocoder(); 
			gc.getLocation(position.point, function(rs){
			// 获取当前标注地址
			var addComp = rs.addressComponents;
			address=addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
			jQuery("#longitude").val(position.point.lng);
			jQuery("#latitude").val(position.point.lat);
			jQuery("#address").text(address);
			createField();
	 		parent.document.getElementById(fieldID).value=mapData; 
			});
			map.clearOverlays();
			map.centerAndZoom(position.point,20);
			map.addOverlay(marker);
		}else{
			alert("定位失败，请确认是否打开GPS和网络是否可用！！！");
		}
	},{enableHighAccuracy: true,timeout: 15000});
}

// 获取指定点地址并创建InfoWindow
function createwindow(e){
	var gc = new BMap.Geocoder(); 
	gc.getLocation(e.point, function(rs){
	// 获取当前标注地址
	var addComp = rs.addressComponents;
	address=addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
	jQuery("#longitude").val(e.point.lng);
	jQuery("#latitude").val(e.point.lat);
	var sContent = null;
	// 自定义InfoWindow
	if(markTitle == null || markTitle == ""){
		sContent =
			"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>地址：</h4>" +
			"<p>"+address+"</p>"+
			"<br>"+
			"<p>添加标题:&nbsp;<input type='text' id='title' size='20' value='' style='width:160px;' /></p>"+
			"<p>添加内容:&nbsp;<input type='text' id='content' size='20' value='' style='width:160px;' /></p>"+
			"<p><span id='check' style='color:red;margin-left:52px'></span></p>"+
			"<button id ='ok' style='margin-left:52px;' onclick='addMarker()'>确定</button><button id ='no' style='margin-left:40px;' onclick='clearmark()'>重置</button>";
	}else{
		sContent =
			"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>地址：</h4>" +
			"<p>"+address+"</p>"+
			"<br>"+
			"<p>标题:&nbsp;<input type='text' id='title' size='20' value='"+markTitle+"' style='width:160px;' /></p>"+
			"<p>内容:&nbsp;<input type='text' id='content' size='20' value='"+markContent+"' style='width:160px;' /></p>"+
			"<p><span id='check' style='color:red;margin-left:52px'></span></p>"+
			"<button id ='ok' style='margin-left:52px;' onclick='addMarker()'>编辑</button><button id ='no' style='margin-left:40px;' onclick='delmarker()'>移除</button>";
	}
	
	var info = new BMap.InfoWindow(sContent);// 创建信息窗口对象
	info.setHeight(210);
	info.setWidth(250);
	marker.openInfoWindow(info,e);
	});
}

// 添加地图双击事件
function addDblclick(){
		map.addEventListener("dblclick", function(e){
			markTitle = null;
			markContent = null;
			map.clearOverlays();
		
			marker = new BMap.Marker(e.point), px = map.pointToPixel(e.point);
			marker.addEventListener("click", function(e){
				createwindow(e);
			});
			
			createwindow(e);
			marker.enableDragging();
			// 监听标注拖动结束事件
			marker.addEventListener("dragend", function(e){
				jQuery("#longitude").val(e.point.lng);
				jQuery("#latitude").val(e.point.lat);
			});
			map.addOverlay(marker);
		});
}

//添加按钮
function addbtn(){
	jQuery("#selectPupWindow").css("visibility","visible");
	//禁止重复添加或删除
	jQuery("#addButton").attr("disabled","disabled");
	jQuery("#delButton").attr("disabled","disabled");
}

//标记窗口确定按钮
function addMarker(){
	markTitle=document.getElementById("title").value;
	markContent=document.getElementById("content").value;
	if(markTitle == "" || markTitle == null || markContent == "" || markContent == null){
		document.getElementById("check").innerHTML="标题或内容不能为空！！！";
	}else{
		createField();
		if(type != "dialog"){
			parent.document.getElementById(fieldID).value=mapData;	
		}
		marker.closeInfoWindow();
	}		
}

//更新mapData数据集
function createField(){
	titleStr = jQuery("#title").val();
	detailStr = jQuery("#content").val();
	jsonObject = {};
	jsonObject["fieldid"] = fieldID;
	jsonObject["lat"] = jQuery("#latitude").val();
	jsonObject["lng"] = jQuery("#longitude").val();
	jsonObject["title"] = titleStr;
	jsonObject["detail"] = detailStr;
	jsonObject["address"] = address;
	mapData = jQuery.json2Str(jsonObject);
}

//表单地图中创建右键菜单
function createContextMenu(){
	var menu = new BMap.ContextMenu();
	var txtMenuItem = [
		{
			text:'标记该点位置',
			callback:function(p){
				markTitle = null;
				markContent = null;
				map.clearOverlays();
				marker = new BMap.Marker(p), px = map.pointToPixel(p);
				marker.addEventListener("click", function(e){
					createwindow(e);
				});
				//允许标记拖动
				marker.enableDragging();
				// 监听标注拖动结束事件
				marker.addEventListener("dragend", function(e){
					jQuery("#longitude").val(e.point.lng);
					jQuery("#latitude").val(e.point.lat);
				});
				
            	map.addOverlay(marker); 
            	
            }
		},
		{
			text:'取消标记',
			callback:function(){map.removeOverlay(marker);}
		},
		{
			text:'放大',
			callback:function(){map.zoomIn();}
		},
		{
			text:'缩小',
			callback:function(){map.zoomOut();}
		}
	];
	for(var i=0; i < txtMenuItem.length; i++){
		menu.addItem(new BMap.MenuItem(txtMenuItem[i].text,txtMenuItem[i].callback));
		if(i == 1){ 
			menu.addSeparator(); 
		}
	}
	map.addContextMenu(menu);
}

//取消按钮
function canBtn(){
	jQuery("#selectPupWindow").css("visibility","hidden");
//	jQuery("#address").text(countryStr + provinceStr + cityStr + townStr + streetStr);
	jQuery("#addButton").removeAttr("disabled");
	jQuery("#delButton").removeAttr("disabled");
}

//确定按钮 弹出层
function saveResult(){
	if(type == "dialog"){
		OBPM.dialog.doReturn(mapData);
	}
}

//关闭按钮 弹出层
function closeIframe(){
	if(type == "dialog"){
		OBPM.dialog.doReturn(null);
	}
}

//初始化标记点 mapData为空值时定位中心点，有值的时候定位标记点为中心
function initMarker(){
	//旧数据测试
	//mapData = '{"fieldid":"11e4-a5f3-d8f33184-a9a3-956bfcc0f507_地图","lat":37.849271,"lng":113.768978,"level":"13","title":"qqq","detail":"qqqq","address":"中国山西省阳泉市平定县","addressInfo":{"country":"中国","province":"山西省","city":"阳泉市","town":"平定县","street":""}}';
	if(mapData == null || mapData ==""){
		map.centerAndZoom(point,4);
	}else{
		var objdata = JSON.parse(mapData);
		titleStr = objdata.title;
		detailStr = objdata.detail;
		point = new BMap.Point(objdata.lng, objdata.lat);
		jQuery("#title").val(titleStr);
		jQuery("#content").val(objdata.detail);
		jQuery("#address").text(objdata.address);
		createFormMarker(point,titleStr,detailStr,jQuery("#address").text(),18);
	}
}

// 更新回显标记信息
function updateMarker(){
	markTitle=document.getElementById("title").value;
	markContent=document.getElementById("content").value;
	if(markTitle == "" || markTitle == null || markContent == "" || markContent == null){
		document.getElementById("check").innerHTML="标题或内容不能为空！！！";
	}else{
		createField();
		initMarker();
 		parent.document.getElementById(fieldID).value=mapData; 
		marker.closeInfoWindow();
	}
}

// 生成回显标记和编辑窗口
function createFormMarker(createPoint,rmarkTitle,rmarkContent,markAddress,leve){
	if((navigator.userAgent.match(/(iPhone|iPod|Android|ios|iPad)/i))){
		jQuery("#addButton").hide();
	}
	isrtnMarker = true;
	marker.setPosition(createPoint);
	marker.addEventListener("click", function(e){ 
		var gc = new BMap.Geocoder(); 
		gc.getLocation(e.point, function(rs){
		// 获取当前标注地址
		var addComp = rs.addressComponents;
		address=addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
		jQuery("#longitude").val(e.point.lng);
		jQuery("#latitude").val(e.point.lat);
		markTitle = rmarkTitle;
		markContent = rmarkContent;
		var sContent = null;
		if(type == "dialog"){
			sContent =
				"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>地址：</h4>" +
				"<p>"+markAddress+"</p>"+
				"<br>"+
				"<p>标题:&nbsp;"+rmarkTitle+"</p>"+
				"<p>内容:&nbsp;"+rmarkContent+"</p>";
		}else{
			if(isclick == true){
				sContent =
					"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>地址：</h4>" +
					"<p>"+markAddress+"</p>"+
					"<br>"+
					"<p>标题:&nbsp;<input type='text' id='title' size='20' value='"+rmarkTitle+"' style='width:160px;' /></p>"+
					"<p>内容:&nbsp;<input type='text' id='content' size='20' value='"+rmarkContent+"' style='width:160px;' /></p>"+
					"<p><span id='check' style='color:red;margin-left:52px'></span></p>"+
					"<button id ='ok' style='margin-left:52px;' onclick='updateMarker()'>编辑</button><button id ='no' style='margin-left:40px;' onclick='delmarker()'>移除</button>";
				isclick = false;
			}else{
				sContent =
					"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>地址：</h4>" +
					"<p>"+address+"</p>"+
					"<br>"+
					"<p>标题:&nbsp;<input type='text' id='title' size='20' value='"+markTitle+"' style='width:160px;' /></p>"+
					"<p>内容:&nbsp;<input type='text' id='content' size='20' value='"+markContent+"' style='width:160px;' /></p>"+
					"<p><span id='check' style='color:red;margin-left:52px'></span></p>"+
					"<button id ='ok' style='margin-left:52px;' onclick='updateMarker()'>编辑</button><button id ='no' style='margin-left:40px;' onclick='delmarker()'>移除</button>";
			}
		}
		var info = new BMap.InfoWindow(sContent);// 创建信息窗口对象
		info.setHeight(210);
		info.setWidth(250);
		marker.openInfoWindow(info,e);
		createField();
 		parent.document.getElementById(fieldID).value=mapData; 
		}); 
	});
	
	marker.enableDragging();
	// 监听标注拖动结束事件
	marker.addEventListener("dragend", function(e){
		jQuery("#longitude").val(e.point.lng);
		jQuery("#latitude").val(e.point.lat);
	});
	map.centerAndZoom(createPoint,leve);
	map.addOverlay(marker);
}

//经纬度搜索
function qurbyNumber(){
	var lng = jQuery("#longitude").val();
	var lat = jQuery("#latitude").val();
	var points = new BMap.Point(lng,lat);
	if(lng == "" || lng == null || lat == "" || lat == null){
		alert("经度或纬度不能为空！！！");
	}else{
		map.centerAndZoom(points,15);
	}
}

//地址搜索
function doGeocodeForm(){
	var address = jQuery("#detailAddress").val();
	var options = {
			renderOptions: {
				map: map
			},
			onMarkersSet:function(results){
				map.clearOverlays();
			}
		};
	var local = new BMap.LocalSearch(map, options);
	local.search(address);
}
/*************************************Form*************************************/

/*************************************View*************************************/
function initializeview(){
	map = new BMap.Map('map');
	//地图平移缩放控件，默认位于地图左上方，它包含控制地图的平移和缩放的功能。
	map.addControl(new BMap.NavigationControl({offset: new BMap.Size(0, 40)}));
	//缩略地图控件，默认位于地图右下方，是一个可折叠的缩略地图。
	map.addControl(new BMap.ScaleControl());
	map.addControl(new BMap.OverviewMapControl());
	map.addControl(new BMap.MapTypeControl({mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP,BMAP_SATELLITE_MAP]}));
	if(mapData != ""){
		try{
			var objdata = JSON.parse(mapData);
			var myGeo = new BMap.Geocoder();
			if(objdata.defaultAddress != null && objdata.defaultAddress !=""){
				myGeo.getPoint(objdata.defaultAddress,function(point){
					if(point){
						defaultPoint = point;
						level = objdata.defaultLevel;
						doGeocodeView(objdata.defaultAddress);
					}
				});
			}else{
				map.centerAndZoom(new BMap.Point(116.904, 39.915),4);
			}
			if(objdata.editReadOnly !=null && objdata.editReadOnly != ""){
				readOnly = objdata.editReadOnly;
			}
			if(objdata.deleteReadOnly != null && objdata.editReadOnly != ""){
				deleteReadOnly = objdata.deleteReadOnly;
			}
		}catch(e){
			map.centerAndZoom(new BMap.Point(116.904, 39.915),5);
		}
		
	}else{
		map.centerAndZoom(new BMap.Point(116.904, 39.915),5);
	}
	map.addEventListener("click",function(e){
		document.getElementById("errorPoint").style.display = "none";
	});
	
	onMapDataMarkers();
	polyline = new BMap.Polyline(polylinePointsArray, {strokeColor:"blue", strokeWeight:3, strokeOpacity:0.5});
	
	var objdata = JSON.parse(parent.document.getElementById("baiduMapData").innerHTML);
	if(objdata.defaultLine=="true"){
		document.getElementById("isline").checked=true;
		onMapDataMarkers();
		map.addOverlay(polyline);
	}
}

//是否显示路线
function isline(){
	if(document.getElementById("isline").checked){
		onMapDataMarkers();
		map.addOverlay(polyline);
	}else{
		onMapDataMarkers();
		map.removeOverlay(polyline);
	}
}

//遍历数据
function onMapDataMarkers(){
	if(mapData!=null&&mapData!=""){
		var objdata = JSON.parse(mapData);
		if(objdata.mapInfo != null && objdata.mapInfo != ""){
			jQuery.each(objdata.mapInfo,function(i,obj){
				var titleStr = obj.title;
//				var detailStr = "<p>内容:"+obj.detail + "<p>地址:" + obj.address;
				var detailStr = "<p><h4>"+obj.detail+"</h4>" +"<p><h3>地址:</h3>" +"<p><h4>"+obj.address+"</h4>";
				if(obj.lat != "" && obj.lat != null){
					var point = new BMap.Point(obj.lng,obj.lat);
					polylinePointsArray[i] = new BMap.Point(obj.lng,obj.lat);
					if(document.getElementById("isline").checked){
						createViewMarker(point,titleStr,detailStr,obj.fieldid,readOnly,deleteReadOnly,i+1);
					}else{
						createViewMarker(point,titleStr,detailStr,obj.fieldid,readOnly,deleteReadOnly,"");
					}
				}else{
					doGeocodeLngLat(obj.address,titleStr,detailStr,obj.fieldid);
				}
			});
		}
	}
}

//定位标记点坐标
function doGeocodeLngLat(address,titleStr,detailStr,fieldid){
	var myGeo = new BMap.Geocoder();
	myGeo.getPoint(address, function(pointMap){
		if (pointMap) {
			createViewMarker(pointMap,titleStr,detailStr,fieldid,readOnly,deleteReadOnly);
		}else{
			errorAddress += address + "<br>";
			if(warningCtrl == null){
				warningCtrl = new WarmingControl();
				map.addControl(warningCtrl);
			}
		}
	});
}

//定位中心位置
function doGeocodeView(defaultAddress){
	if(defaultAddress!=null && defaultAddress!="null" && defaultAddress!=""){
		if(defaultPoint !=null&&defaultPoint!=""){
			map.centerAndZoom(defaultPoint,level);
		}else{
			defaultPoint = new BMap.Point(116.404, 39.915);
			map.centerAndZoom(defaultPoint,4);
		}
	}else{
		defaultPoint = new BMap.Point(116.404, 39.915);
		map.centerAndZoom(defaultPoint,4);
	}
}

//生成标记以及链接
function createViewMarker(point,titleStr,detailStr,fieldid,readOnly,deleteReadOnly,number){
	var marker=new BMap.Marker(point);
	var opts = {
			offset: new BMap.Size(5, 5) // 设置文本偏移量
	};
	var labels = new BMap.Label(number, opts);
	labels.setStyle({
		color:"#A6FFFF",
	    border:"0",
	    height:"0",
	    background:"red"
	});
	marker.setLabel(labels);
	map.addOverlay(marker);
	detailStr += "<p>";
//	if(!readOnly) detailStr += "<a href='javascript:viewType(\"edit\")'>"+editMulti+"</a>&nbsp;&nbsp;";//编辑链接
	if(!deleteReadOnly)	detailStr += "<a href='javascript:viewType(\"delete\")'>"+deleteMulti+"</a>";
	var infoWindow = new BMap.InfoWindow("", opts);
	infoWindow.setTitle("<h1>"+titleStr+"</h1>");
	infoWindow.setContent(detailStr);
	
	marker.addEventListener("mouseover", function(e){
		var opts = {
				offset: new BMap.Size(15, 30) // 设置文本偏移量
		};
		label = new BMap.Label("双击可查看详情", opts);
		label.setStyle({
			color:"#000000",
			border:"0",
			background:"#FFFFCE"
		});
		marker.setLabel(label);
	});
	
	marker.addEventListener("mouseout", function(e){
		map.removeOverlay(label);
	});
	
	marker.addEventListener("click", function(e){
		documentid = "";
		documentid = fieldid.split("_")[0];
		map.openInfoWindow(infoWindow,point);
	});
	
	marker.addEventListener("dblclick",function(e){
//		viewDoc(fieldid);
		if(!readOnly){
			viewType("edit");
		}
	});
}

function viewType(type){
	if(type == "edit"){
		viewDoc(documentid);
	}
	if(type== "delete"){
		deleteDoc(documentid);
	}
}

//跳转到编辑表单
function viewDoc(docid){
	parent.viewDoc(docid,formid);
}

//删除坐标
function deleteDoc(docid){
	URL+="/portal/dynaform/document/deleteMap.action?_selects="+docid+"&application="+application+"&_viewid="+_viewid;
	window.parent.location=URL;
}


/*************************************View*************************************/