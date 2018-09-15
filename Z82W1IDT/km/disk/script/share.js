/**
*分享按钮弹出窗口设置
*/
var enabled4Share = true;		//分享是否可操作
function showShare_page() {
	if(enabled4Share){
		var sharefile = document.getElementById("sharefile").value;
		var _dirselects = "";
		var _fileselects = "";
		jQuery(".checkbox").find("input[name='_dirSelects'][checked='checked']").each(function(){
			_dirselects += jQuery(this).attr("value") + ";";
		});
		
		jQuery(".checkbox").find("input[name='_fileSelects'][checked='checked']").each(function(){
			_fileselects += jQuery(this).attr("value") + ";";
		});
		if(_dirselects.length>1){
			_dirselects = _dirselects.substring(0, _dirselects.length-1);
		}
		
		if(_fileselects.length>1){
			_fileselects = _fileselects.substring(0, _fileselects.length-1);
		}
		
		var checkedJson = "{'_dirSelects':'" + _dirselects + "','_fileselects':'" + _fileselects + "'}";
		
		OBPM.dialog.show({
			opener : window.top,
			width : 545,
			height : 350,
			url : contextPath + "/km/disk/share_page.jsp?sharefileid=" + _fileselects,
			args : {'checkedJson':checkedJson},
			title : sharefile,
			maximized: false, // 是否支持最大化
			close : function() {
			}
		});
	}
}

function show_favorite_page(fileId) {
	OBPM.dialog.show({
		opener : window.top,
		width : 545,
		height : 300,
		url : contextPath + "/km/disk/favorite_page.jsp",
		args : {'fileId':fileId},
		title : "收藏文件 ",
		maximized: false, // 是否支持最大化
		close : function() {
			window.location.reload();
		}
	});
}

function show_recommend_page(fileId) {
	OBPM.dialog.show({
		opener : window.top,
		width : 545,
		height : 300,
		url : contextPath + "/km/disk/recommend_page.jsp",
		args : {'fileId':fileId},
		title : "推荐文件 ",
		maximized: false, // 是否支持最大化
		close : function() {
			window.location.reload();
		}
	});
}

function showShare_page_detail(objId){
	var checkedJson = "{'_fileselects':'" + objId + "'}";
	var sharefile = document.getElementById("sharefile").value;
	OBPM.dialog.show({
		opener : window.top,
		width : 545,
		height : 350,
		url : contextPath + "/km/disk/share_page.jsp?sharefileid=" + objId,
		args : {'checkedJson':checkedJson},
		title : sharefile,
		maximized: false, // 是否支持最大化
		close : function() {
		}
	});
}
jQuery(document).ready(function(){
	jQuery(".goShareDetail").click(function(){

		var objId = jQuery(this).attr("id");
		
		showShare_page_detail(objId);
	});
});

/**
 * 选择用户 for KM
 * 
 * @param {}
 *            actionName
 * @param {}
 *            settings
 */
function selectUser4Km(actionName, settings, roleid) {
	var url = contextPath + "/km/disk/selectUserByAll4Km.jsp";
	var setValueOnSelect = true;
	if (settings.setValueOnSelect == false) {
		setValueOnSelect = settings.setValueOnSelect;
	}
	var title = "选择用户";
	if(settings.title){title = settings.title;}
	
	OBPM.dialog.show({
				opener : window.top,
				width : 682,
				height : 500,
				url : url,
				args : {
					// p1:当前窗口对象
					"parentObj" : window,
					// p2:存放userid的容器id
					"targetid" : settings.valueField,
					// p3:存放username的容器id
					"receivername" : settings.textField,
					// p4:默认选中值, 格式为[userid1,userid2]
					"defValue": settings.defValue,
					//选择用户数
					"limitSum": settings.limitSum,
					//选择模式
					"selectMode":settings.selectMode,
					// 存放userEmail的容器id
					"receiverEmail" : settings.showUserEmail
				},
				title : title,
				maximized: false, // 是否支持最大化
				close : function(result) {
				}
			});
}

/**
 * 选择用户 for KM
 * 
 * @param {}
 *            actionName
 * @param {}
 *            settings
 */
function selectDept4Km(actionName, settings, roleid) {
	var url = contextPath + "/km/disk/selectDeptByAll4Km.jsp";
	var setValueOnSelect = true;
	if (settings.setValueOnSelect == false) {
		setValueOnSelect = settings.setValueOnSelect;
	}
	var title = "选择部门";
	if(settings.title){title = settings.title;}
	
	OBPM.dialog.show({
				opener : window.top,
				width : 450,
				height : 350,
				url : url,
				args : {
					// p1:当前窗口对象
					"parentObj" : window,
					// p2:存放userid的容器id
					"targetid" : settings.valueField,
					// p3:存放username的容器id
					"receivername" : settings.textField,
					// p4:默认选中值, 格式为[userid1,userid2]
					"defValue": settings.defValue,
					//选择用户数
					"limitSum": settings.limitSum,
					//选择模式
					"selectMode":settings.selectMode,
					// 存放userEmail的容器id
					"receiverEmail" : settings.showUserEmail
				},
				title : title,
				maximized: false, // 是否支持最大化
				close : function(result) {
				}
			});
}
/**
 * 选择角色 for KM
 * 
 * @param {}
 *            actionName
 * @param {}
 *            settings
 */
function selectRole4Km(actionName, settings, roleid) {
	var url = contextPath + "/km/org/role/selectlist.jsp";
	var setValueOnSelect = true;
	if (settings.setValueOnSelect == false) {
		setValueOnSelect = settings.setValueOnSelect;
	}
	var title = "选择角色";
	if(settings.title){title = settings.title;}
	
	OBPM.dialog.show({
				opener : window.top,
				width : 300,
				height : 400,
				url : url,
				args : {
					// p1:当前窗口对象
					"parentObj" : window,
					// p2:存放userid的容器id
					"targetid" : settings.valueField,
					// p3:存放username的容器id
					"receivername" : settings.textField,
					// p4:默认选中值, 格式为[userid1,userid2]
					"defValue": settings.defValue,
					//选择用户数
					"limitSum": settings.limitSum,
					//选择模式
					"selectMode":settings.selectMode,
					// 存放userEmail的容器id
					"receiverEmail" : settings.showUserEmail
				},
				title : title,
				maximized: false, // 是否支持最大化
				close : function(result) {
					if(result && result.length>0){
						var roleIds ="";
						var roleNames = "";
						var _rtn = result.split(",");
						for(var i=0;i<_rtn.length;i++){
							var r = _rtn[i].split("|");
							roleIds+=r[0]+";";
							roleNames+=r[1]+";";
						}
						if(roleIds.length>0){
							roleIds = roleIds.substring(0, roleIds.length-1);
						}
						if(roleNames.length>0){
							roleNames = roleNames.substring(0, roleNames.length-1);
						}
						jQuery("#roleInput").attr("value",roleNames);
						jQuery("#roleHidden").attr("value",roleIds);
					}
					
				}
			});
}