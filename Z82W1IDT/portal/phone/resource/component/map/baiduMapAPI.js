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
var infoWindow = null;
var jsonObject = {};
var addressInfo = {};
var title;
var detail;
var isSave = false;   //是否保存


var countryTemporary = ""; //缓存国家
var provinceTemporary = ""; //缓存省份
var cityTemporary = "";  //缓存城市
var townTemporary = "";  //缓存镇
var streetTemporary = "";   //缓存街道

var countryStr="";//国家
var provinceStr="";//省份
var cityStr="";//城市
var townStr="";//镇
var streetStr="";//街道
var titleStr="";//标题
var detailStr="";//内容

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
	//下拉列表监听
	initOptions();
	initMarker();
}

//添加按钮
function addMarker(){
	jQuery("#selectPupWindow").css("visibility","visible");
	initEvent();
	//禁止重复添加或删除
	jQuery("#addButton").attr("disabled","disabled");
	jQuery("#delButton").attr("disabled","disabled");
}

//清空按钮
function delMarker(){
	map.removeOverlay(marker);
	if(type=="dialog"){
		OBPM.dialog.doClear();
	}else{
		parent.document.getElementById(fieldID).value="";
	}
	jQuery("#address").text("");
	countryStr = "";
	provinceStr = "";
	cityStr = "";
	townStr = "";
	streetStr = "";
	titleStr = "";
	detailStr = "";
	jQuery("#addButton").val(addMulti);
	
}

//确定按钮
function okBtn(){
	if(jQuery("#title").val() !="" && jQuery("#content").val() != ""){
		jQuery("#selectPupWindow").css("visibility","hidden");
		var address = jQuery("#address").text();
		isSave = true;
		doGeocodeForm(address);
		jQuery("#addButton").removeAttr("disabled");
		jQuery("#delButton").removeAttr("disabled");
		jQuery("#addButton").val(editMulti);
	}else{
		alert("请输入标题及内容");
	}
}

function createField(){
	countryStr = countryTemporary;
	provinceStr = provinceTemporary;
	cityStr = cityTemporary;
	townStr = townTemporary;
	streetStr = jQuery("#detailAddress").val();
	titleStr = jQuery("#title").val();
	detailStr = jQuery("#content").val();
	jsonObject = {};
	jsonObject["fieldid"] = fieldID;
	jsonObject["lat"] = point.lat;
	jsonObject["lng"] = point.lng;
	jsonObject["level"] = jQuery("#level").val();
	jsonObject["title"] = titleStr;
	jsonObject["detail"] = detailStr;
	jsonObject["address"] = jQuery("#address")[0].innerHTML;
	addressInfo["country"] = countryStr;
	addressInfo["province"] = provinceStr;
	addressInfo["city"] = cityStr;
	addressInfo["town"] = townStr;
	addressInfo["street"] = streetStr;
	jsonObject["addressInfo"] = addressInfo;
	mapData = jQuery.json2Str(jsonObject);
}

//取消按钮
function canBtn(){
	jQuery("#selectPupWindow").css("visibility","hidden");
	jQuery("#address").text(countryStr + provinceStr + cityStr + townStr + streetStr);
	jQuery("#addButton").removeAttr("disabled");
	jQuery("#delButton").removeAttr("disabled");
}

//确定按钮 弹出层
function saveResult(){
	if(type == "dialog"){
		OBPM.dialog.doReturn(mapData);
	}
}

function closeIframe(){
	if(type == "dialog"){
		OBPM.dialog.doReturn(null);
	}
}

//初始化标记点 mapData为空值时定位中心点，有值的时候定位标记点为中心
function initMarker(){
	//测试数据
	//mapData = '{"fieldid":"11e1-db79-418ef85c-9f4b-e77667fa5532_maps","lat":"35.219488","lng":"103.650544","level":"14","title":"44","address":"中国天津市河东区‎大王庄","addressInfo":{"country":"中国","province":"天津市","city":"河东区","town":"大直沽","street":"kkk"},"detail":"是34"}';
	if(mapData == null || mapData ==""){
		map.centerAndZoom(point,4);
	}else{
		jQuery("#addButton").val(editMulti);
		var objdata = JSON.parse(mapData);
		jQuery("#level").val(objdata.level);
		countryStr = objdata.addressInfo.country;
		provinceStr=objdata.addressInfo.province;
		cityStr=objdata.addressInfo.city;
		townStr=objdata.addressInfo.town;
		streetStr=objdata.addressInfo.street;
		titleStr = objdata.title;
		detailStr = objdata.detail;
		if(countryStr == null || countryStr == "null"){
			countryStr = "";
		}
		if(provinceStr == null || provinceStr == "null"){
			provinceStr = "";
		}
		if(cityStr == null || cityStr == "null"){
			cityStr = "";
		}
		if(townStr == null || townStr == "null"){
			townStr = "";
		}
		if(streetStr == null || streetStr == "null"){
			streetStr = "";
		}
		initEvent();
		point = new BMap.Point(objdata.lng, objdata.lat);
		jQuery("#title").val(titleStr);
		jQuery("#content").val(objdata.detail);
		jQuery("#address").text(countryStr + provinceStr + cityStr + townStr + streetStr);
		createFormMarker(point,titleStr,"<p>"+contentMulti+":"+ detailStr + "<p>地址:" + jQuery("#address").text());
	}
}

//建立标记点
function createFormMarker(createPoint,title,content){
	marker.setPosition(createPoint);
	infoWindow.setTitle("<font size='4px'>"+title+"</font>");
	infoWindow.setContent(content);
	marker.addEventListener("click", function(e){ 
		map.openInfoWindow(infoWindow,createPoint);
	});
	map.centerAndZoom(createPoint,jQuery("#level").val());
	map.addOverlay(marker);
}
//国家改变事件
function countryEvent(){
	jQuery.ajax({
		url : "country.xml",
		timeout: 3000,
		success : function(xml) {
			jQuery(xml).find("country").each(
				function() {
					var t = jQuery(this).attr("label");
					jQuery("#country").append("<option value='"+t+"'>" + t + "</option>");
				});
			provinceEvent();
		}
	});
}
//省份改变事件								
function provinceEvent(){
	jQuery("#province>option").remove();
	var pname = jQuery("#country").val();
	if(provinceStr != "") {
		jQuery("#province").val(provinceStr);
	}
	jQuery.ajax({url : "country.xml",
		timeout: 3000,
		success : function(xml) {
			jQuery(xml).find("country[label='"+ pname+ "']>province").each(
				function() {
					var t = jQuery(this).attr("label");
					jQuery("#province").append("<option value='"+t+"'>"+ t+ "</option>");
			});
			cityEvent();
		}
	});
}
//城市改变事件							
function cityEvent(){
	jQuery("#city>option").remove();
	var pname = jQuery("#province").val();
	jQuery.ajax({url : "country.xml",
		timeout: 3000,
		success : function(xml) {
			jQuery(xml).find("province[label='"+ pname+ "']>city").each(
				function() {
					var t = jQuery(this).attr("label");
					jQuery("#city").append("<option value='"+t+"'>"+ t+ "</option>");
			});
			townEvent();
		}
	});
}
//乡镇改变事件									
function townEvent(){
	jQuery("#town>option").remove();
	var pname = jQuery("#city").val();
	jQuery.ajax({url : "country.xml",
		timeout: 3000,
		success : function(xml) {
			jQuery(xml).find("city[label='"+ pname+ "']>town").each(
				function() {
					var t = jQuery(this).attr("label");
					jQuery("#town").append("<option value='"+t+"'>"+ t+ "</option>");
			});
		}
	});
}

//编辑窗口改变监听事件
function initOptions() {
		//国家改变事件							
	jQuery("#country").change(function() {
		provinceEvent();
		jQuery("#detailAddress").val("");
		jQuery("#level").val("4");
		if(jQuery("#country").children('option:selected').val() !="请选择"){
			countryTemporary = jQuery("#country").children('option:selected').val();
		}else{
			countryTemporary = "";
		}
		provinceTemporary = "";
		cityTemporary = "";
		townTemporary = "";
		doGeocodeForm(countryTemporary);
	});
	//城市改变事件							
	jQuery("#province").change(function() {
		cityEvent();
		jQuery("#detailAddress").val("");
		jQuery("#level").val("7");
		if(jQuery("#province").children('option:selected').val() !="请选择"){
			provinceTemporary = jQuery("#province").children('option:selected').val();
		}else{
			provinceTemporary = "";
		}
		cityTemporary = "";
		townTemporary = "";
		doGeocodeForm(countryTemporary + provinceTemporary);
	});
	//县改变事件					
	jQuery("#city").change(function() {
		townEvent();
		jQuery("#detailAddress").val("");
		jQuery("#level").val("10");
		if(jQuery("#city").children('option:selected').val() !="请选择"){
			cityTemporary = jQuery("#city").children('option:selected').val();
		}else{
			cityTemporary = "";
		}
		townTemporary = "";
		doGeocodeForm(countryTemporary + provinceTemporary + cityTemporary);
	});
	//镇改变事件
	jQuery("#town").change(function() {
		jQuery("#level").val("13");
		jQuery("#detailAddress").val("");
		if(jQuery("#town").children('option:selected').val() !="请选择"){
			townTemporary = jQuery("#town").children('option:selected').val();
		}else{
			townTemporary = "";
		}
		doGeocodeForm(countryTemporary + provinceTemporary + cityTemporary + townTemporary);
	});
	//详细地址改变事件
	jQuery("#detailAddress").change(function() {
		jQuery("#level").val("15");
		streetTemporary = jQuery("#detailAddress").val();
		doGeocodeForm(countryTemporary + provinceTemporary + cityTemporary + townTemporary + streetTemporary);
	});
}

//回显编辑窗口的数据
function initEvent(){
	jQuery("#country>option").remove();
	jQuery.ajax({
		url : "country.xml",
		timeout: 3000,
		success : function(xml){
			jQuery(xml).find("country").each(
				function() {
					var t = jQuery(this).attr("label");
					jQuery("#country").append("<option value='"+t+"'>" + t + "</option>");
				}
			);
			if(countryStr != ""){
				jQuery("#country").val(countryStr);
				countryTemporary = countryStr;
				jQuery("#province>option").remove();
				jQuery.ajax({url : "country.xml",
					timeout: 3000,
					success : function(xml) {
						jQuery(xml).find("country[label='"+ countryStr+ "']>province").each(
							function() {
								var t = jQuery(this).attr("label");
								jQuery("#province").append("<option value='"+t+"'>"+ t+ "</option>");
							}
						);
						if(provinceStr != ""){
							jQuery("#city>option").remove();
							jQuery("#province").val(provinceStr);
							provinceTemporary = provinceStr;
							jQuery.ajax({url : "country.xml",
								timeout: 3000,
								success : function(xml) {
									jQuery(xml).find("province[label='"+ provinceStr+ "']>city").each(
										function() {
											var t = jQuery(this).attr("label");
											jQuery("#city").append("<option value='"+t+"'>"+ t+ "</option>");
										}
									);
									if(cityStr != ""){
										jQuery("#town>option").remove();
										cityTemporary = cityStr;
										jQuery("#city").val(cityStr);
										jQuery.ajax({url : "country.xml",
											timeout: 3000,
											success : function(xml) {
												jQuery(xml).find("city[label='"+ cityStr+ "']>town").each(
														function() {
															var t = jQuery(this).attr("label");
															jQuery("#town").append("<option value='"+t+"'>"+ t+ "</option>");
													});
												if(townStr != ""){
													jQuery("#town").val(townStr);
													townTemporary = townStr;
												}
											}
										});
									}else{
										jQuery("#town>option").remove();
									}
								}
							});
						}else{
							jQuery("#city>option").remove();
							jQuery("#town>option").remove();
						}
					}
				});
			}else{
				jQuery("#province>option").remove();
				jQuery("#city>option").remove();
				jQuery("#town>option").remove();
			}
		}
	});
	if(streetStr != ""){
		jQuery("#detailAddress").val(streetStr);
	}else{
		jQuery("#detailAddress").val("");
	}
	if(titleStr != ""){
		jQuery("#title").val(titleStr);
	}else{
		jQuery("#title").val("");
	}
	if(detailStr){
		jQuery("#content").val(detailStr);
	}else{
		jQuery("#content").val("");
	}
}

//路径转换为经纬度
function doGeocodeForm(address){
	jQuery("#address").text(address);
	var myGeo = new BMap.Geocoder();
	myGeo.getPoint(jQuery("#address")[0].innerText, function(pointMap){
		if (pointMap) {
			point = pointMap;
			map.centerAndZoom(pointMap,jQuery("#level").val());
			if(isSave){
				createField();
				if(type != "dialog"){
					if(displayType==2 || displayType == '2'){
				   	 	parent.document.getElementById(fieldID).value="";
				 		parent.document.getElementById(fieldID).value=mapData; 
					}else{
						alert("您没有该操作");
					}
				}
				createFormMarker(point,titleStr,"<p>"+contentMulti+":" + detailStr +"<p>地址:"+address);
				isSave = false;
			}
		}
	});
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
}

//遍历数据
function onMapDataMarkers(){
	if(mapData!=null&&mapData!=""){
		var objdata = JSON.parse(mapData);
		if(objdata.mapInfo != null && objdata.mapInfo != ""){
			jQuery.each(objdata.mapInfo,function(i,obj){
				var titleStr = obj.title;
				var detailStr = "<p>内容:"+obj.detail + "<p>地址:" + obj.address;
				if(obj.lat != "" && obj.lat != null){
					var point = new BMap.Point(obj.lng,obj.lat);
					createViewMarker(point,titleStr,detailStr,obj.fieldid,readOnly,deleteReadOnly);
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
function createViewMarker(point,titleStr,detailStr,fieldid,readOnly,deleteReadOnly){
	var marker=new BMap.Marker(point);
	map.addOverlay(marker);
	detailStr += "<p>";
	if(!readOnly) detailStr += "<a href='javascript:viewType(\"edit\")'>"+editMulti+"</a>&nbsp;&nbsp;";
	if(!deleteReadOnly)	detailStr += "<a href='javascript:viewType(\"delete\")'>"+deleteMulti+"</a>";
	var infoWindow = new BMap.InfoWindow("", opts);
	infoWindow.setTitle("<font size='4px'>"+titleStr+"</font>");
	infoWindow.setContent(detailStr);
	marker.addEventListener("click", function(e){ 
		documentid = "";
		documentid = fieldid.split("_")[0];
		map.openInfoWindow(infoWindow,point);
	});
	
	marker.addEventListener("dblclick",function(e){
		viewDoc(fieldid);
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