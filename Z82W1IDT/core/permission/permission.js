/**
 * 权限映射类
 * @return
 */
function PermissionMap(){
	var json = {};
	
	this.setJson = function(json){
		this.json = json;
	};
	
	this.getResourcePermissions = function(resourceid){
		if (this.json[resourceid]){
			return this.json[resourceid];
		}
		
		return new Array();
	};
	
	/**
	 * 获取选中的操作
	 */
	this.getSelectedOperations = function(resourceid){
		var permissions = this.json[resourceid];
		var ids = [];
		if (permissions && permissions.length > 0) {
			for ( var i = 0; i < permissions.length; i++) {
				var id = permissions[i]['operationid'];
				var allow = permissions[i]['allow'];
				if (allow) {
					ids.push(id);
				}
			}
		}
		return ids;
	};
	
	this.getUnSelectedOperations = function(resourceid){
		var permissions = this.json[resourceid];
		var ids = [];
		if (permissions && permissions.length > 0) {
			for ( var i = 0; i < permissions.length; i++) {
				var id = permissions[i]['operationid'];
				var allow = permissions[i]['allow'];
				if (!allow) {
					ids.push(id);
				}
			}
		}
		return ids;
	};
	
	/**
	 * 为资源添加允许或禁止的操作权限
	 */
	this.put = function(resourceid, operationPermission){
		if (json[resourceid] && json[resourceid] instanceof Array){
			json[resourceid].push(operationPermission);
		} else {
			json[resourceid] = [];
			json[resourceid].push(operationPermission);
		}
	};
	
	/**
	 * 移除菜单操作权限
	 * 如果指定移除某个operationid，则删除具体的operation权限，否则移除整个resource的权限
	 */
	this.remove = function(resourceid, operationid){
		if (json[resourceid] && json[resourceid] instanceof Array){
			if (operationid) {
				var permissionArray = json[resourceid];
				for ( var i = 0; i < permissionArray.length; i++) {
					var operationPermission = permissionArray[i];
					if (operationPermission['operationid'] == operationid){
						permissionArray.slice(i, 1);
						break;
					}
				}
			} else {
				delete json[resourceid];
			}
		}
	};
	
	/**
	 * 输出JSON字符串
	 */
	this.toString = function(){
		return jQuery.json2Str(json);
	};
}

var _publicMenus = "";
function treeload() {
	// 菜单资源树
	menutree = new dTree('menutree','','menusCheckbox');
	menutree.config.multiSelect = true; // 设置多选

	menutree.add('root', '-1', menuroot);

	var menuUrl = contextPath + "/core/privilege/res/resourcesTree.action";
	menuUrl += "?application=" + jQuery("#app").val();
	menuUrl += "&datetime=" + new Date().getTime();
	menuUrl += "&roottype=32";
	
	jQuery.ajax({
		type: "POST",
	   	url: menuUrl,
	   	cache: false,
	   	dataType:"json",
	   	success: function(data){
	   		if(data!=null){
	   			// 2代表菜单资源
				var menus=data;
				for(var i=0; i<menus.length;i++){
					var url = '<ww:url value="/core/resource/edit.action"/>?application=' + jQuery("#app").val() + "&id=" + menus[i].id;
					var extCheckboxonclick = "changePermissionByMenu(this);";
					
					var html = menus[i].data;
					var title =  menus[i].id + "@" + menus[i]['attr']['resourcename'] +"@"+ menus[i]['attr']['resourcetype'];
					var parentid = menus[i]['attr']['parentid'];
					
					var permissionType = menus[i]['attr']['permissionType'];
					if("public"==permissionType){
						_publicMenus+=menus[i].id+',';
					}
					
					if(parentid==null || parentid==""){
						menutree.add(menus[i].id, 'root', html, url, title, 'contentFrame', null, false, false, false, null, extCheckboxonclick);
					}else{
						menutree.add(menus[i].id, parentid, html, url, title, 'contentFrame', null, false, false, false, null, extCheckboxonclick);
					}
					//rightFunction="treeRightFunction('"+app+"','"+menus[i].id+"')";
				};
			}
	   		jQuery("#menutreeDiv").html(""+menutree);
	   		initMenuByPermissionJSON();
	   	}
	});

	// 模块资源树
	moduletree = new dTree('moduletree','','modulesCheckbox');
	moduletree.add('root', '-1', moduleroot);

	var moduleUrl = contextPath + "/core/privilege/res/resourcesTree.action";
	moduleUrl += "?application=" + jQuery("#app").val();
	moduleUrl += "&datetime=" + new Date().getTime();
	moduleUrl += "&roottype=16";
	
	jQuery.ajax({
		type: "POST",
	   	url: moduleUrl,
	   	cache: false,
	   	dataType:"json",
	   	success: function(data){
	   		if(data!=null){
	   			// 2代表菜单资源
				var modules=data;
				for(var i=0; i<modules.length;i++){
					var html = modules[i].data;
					var title =  modules[i]['attr']['resourcename'];
					var parentid = modules[i]['attr']['parentid'];
					var script = "javascript:getModuleResourceList('"+modules[i].id+"')";

					if(parentid==null || parentid==""){
						moduletree.add(modules[i].id, 'root', html, script, title);
					}else{
						moduletree.add(modules[i].id, parentid, html, script, title);
					}
				};
			}
	   		jQuery("#moduletreeDiv").html(""+moduletree);
	   	}
	});

	// 文件夹资源树
	foldertree = new dTree('foldertree','','foldersCheckbox');
	foldertree.add('root', '-1', folderroot);

	var folderUrl = contextPath + "/core/privilege/res/resourcesTree.action";
	folderUrl += "?application=" + jQuery("#app").val();
	folderUrl += "&datetime=" + new Date().getTime();
	folderUrl += "&roottype=64";
	
	jQuery.ajax({
		type: "POST",
	   	url: folderUrl,
	   	cache: false,
	   	dataType:"json",
	   	success: function(data){
	   		if(data!=null){
	   			// 2代表菜单资源
				var folders=data;
				for(var i=0; i<folders.length;i++){
					var html = folders[i].data;
					var title =  folders[i]['attr']['resourcename'];
					var parentid = folders[i]['attr']['parentid'];
					var resourcetype =  folders[i]['attr']['resourcetype'];
					var script = "javascript:getFolderOperationList('"+folders[i].id+"', '"+resourcetype+"', '"+title+"')";
					
					if(parentid==null || parentid==""){
						foldertree.add(folders[i].id, 'root', html, script, title);
					}else{
						foldertree.add(folders[i].id, parentid, html, script, title);
					}
				};
			}
	   		jQuery("#foldertreeDiv").html(""+foldertree);
	   	}
	});
}

/**
 * 绑定选择所有事件
 * @return
 */
function bindSelectAll(){
	jQuery('#operationSelectAll').bind('click', function(){
		if (jQuery(this).attr('checked') == true) {
			jQuery("#operationDiv input[name='operation']").each(function(){
				jQuery(this).attr('checked', true);
			});
		} else {
			jQuery("#operationDiv input[name='operation']").each(function(){
				jQuery(this).attr('checked', false);
			});
		}
	});

	jQuery('#subResourceSelectAll :radio').each(function(){
		jQuery(this).bind("click", function(){
			var className = jQuery(this).val();
			jQuery("#subResourceDiv ." + className).click();
		});
	});
}

var DEFAULT_SELECT_VALUE = false;

/**
 * 根据模块ID获取模块资源(表单、视图)
 * @param moduleid 模块ID
 * @return
 */
function getModuleResourceList(moduleid){
	jQuery.ajax({
		type: "POST",
	   	url: "module_resourcelist.jsp",
	   	cache: false,
	   	data: "moduleid="+moduleid+"&applicationid=" + jQuery("#app").val(),
	   	dataType:"html",
	   	success: function(html){
			document.getElementById("modulepermission").innerHTML = '';
			document.getElementById("modulepermission").innerHTML = html;
			// 选中已设置的模块资源
			initModuleResourceByPermissionJSON();
			initModuleResourceByTempPermissionJSON();
			initOpenByPermissionJSON();
	   	}
	});
}

/**
 * 获取文件夹操作
 * @param resourceid
 * @param resourcetype
 * @param resourcename
 * @return
 */
function getFolderOperationList(folderid, resourcetype, resourcename){
	jQuery.ajax({
		type: "POST",
	   	url: "folderlist.jsp",
	   	cache: false,
	   	data: "resourceid="+folderid+"&resourcetype="+resourcetype+"&resourcename="+resourcename+"&applicationid=" + jQuery("#app").val(),
	   	dataType:"html",
	   	success: function(html){
			document.getElementById("folderpermission").innerHTML = '';
			document.getElementById("folderpermission").innerHTML = html;
			// 选中已设置的模块资源
			initFolderOperationByPermissionJSON();
			initFolderOperationByTempPermissionJSON();
	   	}
	});
}

// 从PermissionJSON中获取菜单选中项
function initMenuByPermissionJSON(){
	var perm = jQuery.parseJSON(jQuery("#permissionJSON").val());
	jQuery("#menutreeDiv input[name='menusCheckbox']").each(function(){
		var val = jQuery(this).val();
		
		jQuery(this).attr("checked", DEFAULT_SELECT_VALUE);
		if (val){
			var vals = val.split("@");
			if (vals.length == 3) {
				var resourceid = vals[0];
				var permArr = perm[resourceid];
				if(permArr && permArr instanceof Array){
					if(permArr[0]['allow'] == !DEFAULT_SELECT_VALUE || 
							permArr[0]['allow'] == (!DEFAULT_SELECT_VALUE).toString()){
						jQuery(this).attr("checked", !DEFAULT_SELECT_VALUE);
					}
				}
				if(_publicMenus.indexOf(resourceid)>=0){//属于公开类型的菜单
					jQuery(this).attr("checked", !DEFAULT_SELECT_VALUE);
					jQuery(this).attr("disabled", "disabled");
				}
			}
		}
  	});
}

function initModuleResourceByPermissionJSON(){
	var perm = jQuery.parseJSON(jQuery("#permissionJSON").val());
	jQuery("#modulepermission input[name=operation]").each(function(){
		var resourceid = jQuery(this).attr("resourceid");
		var operationid = jQuery(this).val();
		if(jQuery(this).attr("disabled")!='disabled'){
			jQuery(this).attr("checked", DEFAULT_SELECT_VALUE);
		}
		var permArr = perm[resourceid];
		//遍历当前resourceid为resourceid的所有permission
		if(permArr && permArr instanceof Array){
			for(var i = 0;i<permArr.length;i++){
				if(operationid == permArr[i]['operationid']){
					//如果permission权限allow为true,则初始化为checked
					if(!DEFAULT_SELECT_VALUE == permArr[i]['allow'] || 
							(!DEFAULT_SELECT_VALUE).toString() == permArr[i]['allow']){
						jQuery(this).attr("checked", !DEFAULT_SELECT_VALUE);
					}
				}
			}
		}
	});
}

function initModuleResourceByTempPermissionJSON(){
	var perm = jQuery.parseJSON(jQuery("#savePermissionJSON").val());
	jQuery("#modulepermission input[name=operation]").each(function(){
		var resourceid = jQuery(this).attr("resourceid");
		var operationid = jQuery(this).val();
		var permArr = perm[resourceid];
		//遍历当前resourceid为resourceid的所有permission
		if(permArr && permArr instanceof Array){
			for(var i = 0;i<permArr.length;i++){
				if(operationid == permArr[i]['operationid']){
					//如果permission权限allow为true,则初始化为checked
					if(!DEFAULT_SELECT_VALUE == permArr[i]['allow'] || 
							(!DEFAULT_SELECT_VALUE).toString() == permArr[i]['allow']){//选中
						jQuery(this).attr("checked", !DEFAULT_SELECT_VALUE);
					}else if(DEFAULT_SELECT_VALUE == permArr[i]['allow'] || 
							(DEFAULT_SELECT_VALUE).toString() == permArr[i]['allow']){//不选中
						jQuery(this).attr("checked", DEFAULT_SELECT_VALUE);
					}
				}
			}
		}
	});
}

/**
 * 初始化表单、视图的Open权限（未设置时默认为勾选状态）
 * @return
 */
function initOpenByPermissionJSON(){
	var perm = jQuery.parseJSON(jQuery("#permissionJSON").val());
	jQuery("#modulepermission input[open=open]").each(function(){
		var resourceid = jQuery(this).attr("resourceid");
		var operationid = jQuery(this).val();
		var permArr = perm[resourceid];
		//遍历当前resourceid为resourceid的所有permission
		if(permArr && permArr instanceof Array){
			var exist = false;
			for(var i = 0;i<permArr.length;i++){
				if(operationid == permArr[i]['operationid']){
					//"打开"权限已设置
					exist = true;
					break;
				}
			}
			if(!exist){
				//如果"打开"权限未设置,则初始化为checked，同时更新savePermissionJSON
				jQuery(this).attr("checked", !DEFAULT_SELECT_VALUE);
				changePermissionByModule(this);
			}
		}else{
			//如果"打开"权限未设置,则初始化为checked，同时更新savePermissionJSON
			jQuery(this).attr("checked", !DEFAULT_SELECT_VALUE);
			changePermissionByModule(this);
		}
	});
}

/**
 * 回选选中的操作
 * @return
 */
function initFolderOperationByPermissionJSON(){
	var val = jQuery("#folderpermission #folder").val();
	var map = getResourceMap(val);
	var resourceid = map["resourceid"];
	var perm = jQuery.parseJSON(jQuery("#permissionJSON").val());
	jQuery("#folderpermission input[name=operation]").each(function(){
		jQuery(this).attr("checked", DEFAULT_SELECT_VALUE);
		var operationid = jQuery(this).val();
		var permArr = perm[resourceid];
		//遍历当前resourceid为resourceid的所有permission
		if(permArr && permArr instanceof Array){
			for(var i = 0;i<permArr.length;i++){
				if(operationid == permArr[i]['operationid']){
					//如果permission权限allow为true,则初始化为checked
					if(!DEFAULT_SELECT_VALUE == permArr[i]['allow'] || 
							(!DEFAULT_SELECT_VALUE).toString() == permArr[i]['allow']){
						jQuery(this).attr("checked", !DEFAULT_SELECT_VALUE);
					}
				}
			}
		}
	});
}

function initFolderOperationByTempPermissionJSON(){
	var val = jQuery("#folderpermission #folder").val();
	var map = getResourceMap(val);
	var resourceid = map["resourceid"];
	var perm = jQuery.parseJSON(jQuery("#savePermissionJSON").val());
	jQuery("#folderpermission input[name=operation]").each(function(){
		var operationid = jQuery(this).val();
		var permArr = perm[resourceid];
		//遍历当前resourceid为resourceid的所有permission
		if(permArr && permArr instanceof Array){
			for(var i = 0;i<permArr.length;i++){
				if(operationid == permArr[i]['operationid']){
					//如果permission权限allow为true,则初始化为checked
					if(!DEFAULT_SELECT_VALUE == permArr[i]['allow'] || 
							(!DEFAULT_SELECT_VALUE).toString() == permArr[i]['allow']){//选中
						jQuery(this).attr("checked", !DEFAULT_SELECT_VALUE);
					}else if(DEFAULT_SELECT_VALUE == permArr[i]['allow'] || 
							(DEFAULT_SELECT_VALUE).toString() == permArr[i]['allow']){//不选中
						jQuery(this).attr("checked", DEFAULT_SELECT_VALUE);
					}
				}
			}
		}
	});
}

function setBatchAuthSet(){
	var value = "";
	jQuery("#batchAuth input[name=role]").each(function(){
		if (jQuery(this).attr("checked") == true) {
			if(value != null && value != ''){
				value += ";" + jQuery(this).val();
			} else {
				value += jQuery(this).val();
			}
		}
	});
	jQuery("#rolesSelected").attr("value", value);
}

/**
 * 根据值获取资源映射
 * @param val 数据结构resourceid@resourcename@resourcetype
 * @return {resourceid:资源ID,resourcename:资源名称,resourcetype:资源类型}
 */
function getResourceMap(val){
	if (val) {
		var vals = val.split("@");
		if (vals.length == 3){
			var resourceid = vals[0];
			var resourcename = vals[1];
			var resourcetype = new Number(vals[2]);
			
			return {'resourceid': resourceid, 'resourcename': resourcename, 'resourcetype': resourcetype};
		}
	}
	return null;
}

//取消
function resourcesExit(){
	OBPM.dialog.doExit();
}
//清空
function resourcesClear(){
	OBPM.dialog.doReturn("clear");
}

function selectAll(mode,scope){
	if(mode =='selectAll'){//全选模式
		if(scope == 'form'){
			jQuery("#formOperations input[name=operation]").each(function(){
				jQuery(this).attr("checked",true);
			});
			jQuery("#formOperations input[name=operation]").each(function(){
				changePermissionByModule(this);
			});
		}else if(scope =='view'){
			jQuery("#viewOperations input[name=operation]").each(function(){
				jQuery(this).attr("checked",true);
			});
			jQuery("#viewOperations input[name=operation]").each(function(){
				changePermissionByModule(this);
			});
		}
	}else if(mode =='unSelectAll'){//反选模式
		if(scope == 'form'){
			jQuery("#formOperations input[name=operation]").each(function(){
				jQuery(this).attr("checked",false);
			});
			jQuery("#formOperations input[name=operation]").each(function(){
				changePermissionByModule(this);
			});
		}else if(scope =='view'){
			jQuery("#viewOperations input[name=operation]").each(function(){
				jQuery(this).attr("checked",false);
			});
			jQuery("#viewOperations input[name=operation]").each(function(){
				changePermissionByModule(this);
			});
		}
	}
	
}

/**
 * 更改表单的授权类型
 * @param id
 * 		表单主键
 * @param permissionType
 * 		授权类型
 */
function changeFormPermissionType(id,permissionType){
	jQuery.ajax({	
		type: 'post',
		url : contextPath + '/core/dynaform/form/changePermisionType.action',
		dataType : 'text',
		data : {id:id,permissionType:permissionType},
		success:function(result) {
			alert(result);
			if(result=='success'){
			}
		},
		error: function(x) {
			
		}
	});
}
/**
 * 更改视图的授权类型
 * @param id
 * 		表单主键
 * @param permissionType
 * 		授权类型
 */
function changeViewPermissionType(id,permissionType){
	jQuery.ajax({	
		type: 'post',
		url : contextPath + '/core/dynaform/view/changePermisionType.action',
		dataType : 'text',
		data : {id:id,permissionType:permissionType},
		success:function(result) {
			alert(result);
			if(result=='success'){
			}
		},
		error: function(x) {
			
		}
	});
}