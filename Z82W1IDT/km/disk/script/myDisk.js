/**for myDisk.jsp**/
 
/**
 * 记录当前交互状态下，相应的操作状态设置
 * enabled{upload,newFolder,share,download,del,move,rename}
 */
var enabled = {
		newFolder : true,	//新建文件夹是否可操作
		download : true,	//下载是否可操作
		del : true,			//删除是否可操作
		rename : true,		//重命名是否可操作
		share : true,		//分享是否可操作
		move : true,		//移动是否可操作
		authorize : true,	//授权是否可操作
		adminAuthorize : true,	//企业域授权是否可操作
		moreBtn : true,		//更多操作按钮是否可操作
		showIcon : true,  	//重命名的时候,数据列鼠标悬停事件不可操作。
		batchdownload : true  //批量下载是否可以操作
};

var jsonA = [];					//导航树形json数据

/**
 * 权限设置功能
 */
var permission = {
		permissionArray : new Array(),
		
		/**
		 * 权限设置常量
		 */
		permissionType : {
			able : 1,		//有权限
			unable : 2		//无权限
		},
		/**
		 * 用户权限设置
		 * permission{upload,newFolder,share,download,del,move,rename}
		 */
		data : {
				id : 'id',
				upload : 1,		//上传
				newFolder : 1,		//新建文件夹
				share : 1,			//分享
				download : 1,		//下载
				del : 1,			//删除
				move : 1,			//移动
				rename : 1,		//重命名
				authorize : 1,		//授权
				adminAuthorize : 1	//管理员授权
		},
		/**
		 * 权限初始化
		 */
		init : function(){
			var $checkboxs = jQuery("#tableData input[type=checkbox]");
			var checkLength = $checkboxs.size();
			for(var i=0;i<checkLength;i++){
				var jsonStr = jQuery($checkboxs[i]).attr("permissions");
//				alert(jsonStr);
				var jsonObj = jQuery.parseJSON(jsonStr);
				//添加权限数据
				this.setPermission(jsonObj);
			}

			//根据权限数据设置操作权限状态
			this.setDataPermission();
			operateDisplay(isDirManager); //是否显示上传与新建操作
		},

		/**
		 * 设置权限数组数据
		 * @param permission
		 * @returns {Boolean}
		 */
		setPermission : function(permission){
			for(var i=0;i<this.permissionArray.length;i++){
				if(this.permissionArray[i] && this.permissionArray[i].id == permission.id){
					this.permissionArray[i] = permission;
					return;
				}
			}
			this.permissionArray[this.permissionArray.length] = permission;
		},

		/**
		 * 通过id获取数据权限
		 * @param id
		 * @returns {___anonymous1069_1070}
		 */
		getPermission : function(id){
			var permission = {};
			for(var i=0;i<this.permissionArray.length;i++){
//				alert(id + " <----> " + this.permissionArray[i].id);
				if(this.permissionArray[i] && this.permissionArray[i].id == id){
					permission = this.permissionArray[i];
					return permission;
				}
			}
			
			return false;
		},

		/**
		 * 获取对应权限的值
		 * @param id：数据id
		 * @param name：属性名
		 * @returns 属性值
		 */
		getPermissionVal : function(id,name){
			var permission = {};
			permission = this.getPermission(id);
			return permission[name];
		},

		/**
		 * 检验是否有权限
		 * @param id：数据id
		 * @param name：属性名
		 * @returns {Boolean}
		 */
		checkedPermission : function(id,name){
			if(this.getPermissionVal(id,name) == this.permissionType.unable){
				return false;
			}
			return true;
		},

		/**
		 * 根据权限设置数据操作状态
		 */
		setDataPermission : function(){
			var $tableDataTrs = jQuery("#tableData").find("tr");
			var length = $tableDataTrs.size();
			for(var i=0;i<length;i++){
				var $tr = jQuery($tableDataTrs[i]);
				var permission = this.getPermission($tr.find("input[type=checkbox]").val());
				var _filetype = $tr.find("input[type=checkbox]").attr("_filetype");
				if(permission){
					if(permission.share == this.permissionType.unable){
						$tr.find(".more_share").addClass("shareFalse");
					}
					if(permission.download == this.permissionType.unable){
						$tr.find(".more_download").addClass("downloadFalse");
					}
					if(permission.move == this.permissionType.unable){
						$tr.find(".move_to").addClass("unabled");
					}
					if(permission.rename == this.permissionType.unable){
						$tr.find(".renaming").addClass("unabled");
					}
					if(permission.del == this.permissionType.unable){
						$tr.find(".delete").addClass("unabled");
					}
//					alert(permission.authorize);
					if(permission.authorize == this.permissionType.unable){
						$tr.find(".more_authorize").addClass("unmore_authorize");
					}
					if(!isPublicDiskAdmin || _filetype != 1){
						$tr.find(".adminAuthorize").addClass("unabled");
					}
				}
			}
		}
};

/**
 * 设置新建文件夹按钮的状态
 */
function setEnabled4NewFlder(){
	//新建文件夹
	if(enabled.newFolder){
		if(typeof(parent.setNewFolderStyle)){
			parent.setNewFolderStyle(1);
		}else{
			parent.parent.setNewFolderStyle(1);
		}
	}else{
		if(typeof(parent.setNewFolderStyle)){
			parent.setNewFolderStyle(2);
		}else{
			parent.parent.setNewFolderStyle(2);
		}
	}
}

/**
 * 设置下载按钮的状态
 */
function setEnabled4Down(){
	if(enabled.download){
		jQuery("#download").css("color","#000");
		jQuery(".downloadTrue").removeClass("downloadFalse");
	}else{
		jQuery("#download").css("color","gray");
		jQuery(".downloadTrue").addClass("downloadFalse");
		jQuery(".download").removeAttr("onclick");
	}
}

/**
 * 设置批量下载按钮的状态
 */
function setEnabled4BatchDown() {
	if (enabled.batchdownload) {
		jQuery(".downShow").show();
	} else {
		jQuery(".downShow").hide();
	}
}

/**
 * 设置分享按钮的状态
 */
function setEnabled4Share(){
	if(enabled.share){
		jQuery(".goShare").css("color","#000");
		jQuery(".goShareBtn").css("color","#000");
		jQuery(".goShare").removeClass("shareFalse");
	}else{
		jQuery(".goShare").css("color","gray");
		jQuery(".goShareBtn").css("color","gray");
		jQuery(".goShare").addClass("shareFalse");
	}
}

/**
 * 设置重命名按钮的状态
 * @return
 */
function setEnabled4Rename(){
	if(enabled.rename){
		jQuery("#renaming").removeClass("unabled");
	}else{
		jQuery("#renaming").addClass("unabled");
	}
}

/**
 * 设置删除按钮的状态
 * @return
 */
function setEnabled4Del(){
	if(enabled.del){
		jQuery("#delBtn").removeClass("unabled");
	}else{
		jQuery("#delBtn").addClass("unabled");
	}
}

/**
 * 设置授权按钮的状态
 * @return
 */
function setEnabled4Authorize(){
	if(enabled.authorize){
		jQuery("#authorizeBtn").removeClass("unabled");
	}else{
		jQuery("#authorizeBtn").addClass("unabled");
	}
}

/**
 * 设置企业域授权按钮的状态
 */
function setEnabled4AdminAuthorize() {
	if(enabled.adminAuthorize){
		jQuery("#adminAuthorizeBtn").removeClass("unabled");
	}else{
		jQuery("#adminAuthorizeBtn").addClass("unabled");
	}
}
/**
 * 设置移动到按钮的状态
 * @return
 */
function setEnabled4Move(){
	if(enabled.move){
		jQuery("#mBtn .move_to").removeClass("unabled");
	}else{
		jQuery("#mBtn .move_to").addClass("unabled");
	}
}

/**
 * 设置操作按钮的状态
 * @return
 */
function setBtnState(){
	
	var dirSelectsSize = jQuery("input:checkbox:checked").filter(jQuery("input[name='_dirSelects']")).size();//选中的目录个数
	var fileSelectsSize = jQuery("input:checkbox:checked").filter(jQuery("input[name='_fileSelects']")).size();//选中的文件个数
	
	//分享功能
	if(dirSelectsSize > 0 || fileSelectsSize > 1){
		enabled.share = false;
	}else{
		enabled.share = true;
	}
	
	isFavoritesState();

	var $checkObjs = jQuery("#tableData").find("input:checkbox:checked");

	var selectsSize = $checkObjs.size();//选中的目录个数
	//当选中的项超过一个时重命名失效！
	if(selectsSize > 1){
		enabled.rename = false;
		enabled.authorize = false;
		enabled.adminAuthorize = false;
	}else{
		enabled.rename = true;
		enabled.authorize = true;
		enabled.adminAuthorize = true;
	}
	
	enabled.batchdownload = true;
	
	//权限检验，设置操作状态
	$checkObjs.each(function(){
		var id = jQuery(this).val();
		if(!permission.checkedPermission(id,"del")){
			enabled.del = false;
		}
		if(!permission.checkedPermission(id,"move")){
			enabled.move = false;
		}
		if(!permission.checkedPermission(id,"rename")){
			enabled.rename = false;
		}
		if(!permission.checkedPermission(id,"authorize")){
			enabled.authorize = false;
		}
		if(!permission.checkedPermission(id,"adminAuthorize")){
			enabled.adminAuthorize = false;
		}
		
		if(!permission.checkedPermission(id,"download")){
			enabled.batchdownload = false;
		}
	});
	
	
	setEnabled4BatchDown(); //批量下载
	setEnabled4Down();		//下载
	setEnabled4Share();		//分享
	setEnabled4Rename();	//重命名
	setEnabled4Del();		//删除
	setEnabled4Authorize();	//授权
	setEnabled4AdminAuthorize();	//授权
	setEnabled4Move();		//移动
}

/**
 * 我的收藏下的文件不允许分享
 * @return
 */
function isFavoritesState(){
	if(typeof(isFavorites) != "undefined" && isFavorites){
		enabled.share = false;
		enabled.download = false;
	}
}

/**
 * 初始化导航内容
 * @return
 */
function settingNav(){
	var jsonStr = jQuery("#naviJson").val();
	var back = document.getElementById("back").value;
	var allfile = document.getElementById("allfile").value;
	if(jsonStr){
		jsonA = jQuery.parseJSON(jsonStr);
		jQuery("#inventory").show();
		jQuery(".myDocuemnt").html("");
		var html = "<a class='backHigherLevel'>"+back+"</a>|<a class='allFile'>"+allfile+"</a>";
		for(var i=0;i<jsonA.length; i++){
			if(i+1 == jsonA.length){
				html += "<span>>></span><a style='color:#000!important;text-decoration:none;cursor:none' id="+jsonA[i].id+" name='list' title="+jsonA[i].name+" pId="+jsonA[i].pId+">"+jsonA[i].name+"</a>";
			}else{
				html += "<span>>></span><a class='navClick' id="+jsonA[i].id+" name='list' title="+jsonA[i].name+" pId="+jsonA[i].pId+">"+jsonA[i].name+"</a>";
			}
		}
		jQuery(".directory").empty().append(html);
	}
	
	/**
	 * 遍历更新导航json数据
	 * @param curId
	 * @return
	 */
	function refreshJsonA(curId){
		for(var k=0;k<jsonA.length;k++){
			if(jsonA[k]["pId"] == curId){
				curId = jsonA[k]["id"];
				jsonA.splice(k,1);
				refreshJsonA(curId);
			}
		}
	}
	/**
	 * 导航目录点击事件
	 */
	jQuery(".navClick").click(function(){
		refreshJsonA(this.id);
		jQuery("#naviJson").val(JSON.stringify(jsonA));
		document.getElementById("ndirid").value = jQuery(this).attr("id");
		document.getElementById("_currpage").value = 1;
		document.forms[0].action = contextPath + '/km/disk/viewndir.action';
		document.forms[0].submit();
	});
	
	/**
	 * 返回上一级的点击事件
	 */
	jQuery(".backHigherLevel").click(function(){
		var pId = document.getElementById("ndirid").value;
		pId = jQuery("#"+pId).attr("pId");
		refreshJsonA(pId);
		if(pId && jsonA.length >0){
			jQuery("#naviJson").val(JSON.stringify(jsonA));
			document.getElementById("ndirid").value = pId;
			document.getElementById("_currpage").value = 1;
			document.forms[0].action = contextPath + '/km/disk/viewndir.action';
			document.forms[0].submit();
		}else{
			var _type = document.getElementById("_type").value;
			window.location.href = contextPath + '/km/disk/listView.action?_type='+_type;
		}
	});
	
	/**
	 * 全部文件
	 */
	jQuery(".allFile").click(function(){
		var _type = document.getElementById("_type").value;
		location.href = contextPath + '/km/disk/listView.action?_type='+_type;
		jQuery(".loadNum").html(jQuery("#tableData").find(jQuery("input:checkbox")).size());
	});
}


/**
 * 查看文件夹
 * @param dirid:文件夹id
 */
function doView(id,title) {
	var jsonObjCur = {};
	jsonObjCur["id"] = id;
	jsonObjCur["name"] = title;
	jsonObjCur["pId"] = document.getElementById("ndirid").value;
	jsonA[jsonA.length] = jsonObjCur;
	jQuery("#naviJson").val(JSON.stringify(jsonA));
	document.getElementById("ndirid").value = id;
	document.getElementById("_currpage").value = 1;
	document.forms[0].action = contextPath + '/km/disk/viewndir.action';
	document.forms[0].submit();
}

/**
 * 查看文件夹4 subTreeview
 * @param dirid:文件夹id
 */
function doViewTree(id,title) {
	document.getElementById("ndirid").value = id;
	document.getElementById("_currpage").value = 1;
	document.forms[0].action = contextPath + '/km/disk/viewndir.action';
	document.forms[0].submit();
}
/**
 * 删除文件和文件夹
 */
function doDelete(){
	var deletetip = document.getElementById("deletetip").value;
	if(enabled.del && confirm(deletetip)){
		document.forms[0].action = contextPath + '/km/disk/delete.action';
		document.forms[0].submit();
	}
}

/**
 * 获取文件夹路径
 */
function getFolderUrl() {
	var id = jQuery("#tableData").find("input:checkbox:checked").val();
	var url = serverAddr + '/km/disk/listView.action?ndirid='+id+'&_type=1';
	return url;
}
/**
 * 获取文件路径
 */
function getFileUrl() {
	var id = jQuery("#tableData").find("input:checkbox:checked").val();
	var ndirid = document.getElementById("ndirid").value;
	var ndiskid = document.getElementById("ndiskid").value;
	var _currpage = document.getElementById("_currpage").value;
	var _rowcount = document.getElementById("_rowcount").value;
	var _type = document.getElementById("_type").value;
	var _sortStatus = document.getElementById("_sortStatus").value;
	var orderbyfield = document.getElementById("orderbyfield").value;
	var url = serverAddr+"/km/disk/file/view.action?id=" + id+"&ndirid="+ndirid+"&_currpage="+_currpage+"&_rowcount="+_rowcount+"&_type="+_type+"&_sortStatus="+_sortStatus+"&orderbyfield="+orderbyfield+"&_ndiskid="+ndiskid;
	return url;
}

/**
 * 复制文件或文件夹路径到剪贴板
 */
function doCopyUrl(){
	var copylinksuccess = document.getElementById("copylinksuccess").value;
	var copytip = document.getElementById("copytip").value;
	if(navigator.userAgent.indexOf("MSIE") > 0){
		var fileType = jQuery("#tableData").find("input:checkbox:checked").attr('_fileType');
		var url = "";
		if (fileType=="1") {
			url = getFolderUrl();
		}
		else  if (fileType=="2"){
			url = getFileUrl();
		}
		if(window.clipboardData) {   //仅仅支持IE浏览器
		   window.clipboardData.clearData();
		   window.clipboardData.setData("Text", url);
		   alert(copylinksuccess);
		} 
	}else{
		alert(copytip);
	}
}



/**
 *鼠标移到tr上面时显示的图标的事件
 */
function trOperation(){
	jQuery(".more_sfile").click(function(event){
		if(enabled.showIcon){
			event.stopPropagation();
			selectedCurrent(this); //取消其它选中项，选中当前点击项
			var time3="";
			var time4="";
			var tableData_boxH = jQuery(".tableData_box").height();
			var more_sfileIndex = jQuery(".more_sfile").index(this);
			var boxScrollTop = jQuery(".tableData_box").scrollTop();
			var moreH = jQuery(this).find(".more_sfile_inner").height();
			var more_sfileTop = (more_sfileIndex + 1) *30;
			if((more_sfileTop + moreH) > (tableData_boxH + boxScrollTop)){
				jQuery(".more_sfile_inner").css({"top":"-85px"});
				jQuery(".more_sfile_inner").css({"z-index":"1"});
			}else{
				jQuery(".more_sfile_inner").css({"top":"18px"});
				jQuery(".more_sfile_inner").css({"z-index":"1"});
			};
			jQuery(this).find(jQuery(".more_sfile_inner")).addClass("showHide");
			time3 = setTimeout(function(){
				jQuery(".showHide").removeClass("showHide");
			},2000);
			jQuery(".more_sfile_inner").mouseover(function(event){
				jQuery(".showHide").parent().parent().show();
				event.stopPropagation();
				clearTimeout(time3);
				clearTimeout(time4);
			}).mouseout(function(event){
				event.stopPropagation();
				time4 = setTimeout(function(){
					jQuery(".showHide").parent().parent().hide();
					jQuery(".showHide").removeClass("showHide");
				},200);
			});
			jQuery(this).mouseout(function(event){
				event.stopPropagation();
				jQuery(".showHide").parent().parent().hide();
				time4 = setTimeout(function(){
					jQuery(".showHide").removeClass("showHide");
				});
			});
			if(document.getElementById("_type").value != 5){
				showMoreBtn();//显示更多按钮
			}
			jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input[checked='checked']")).size());
			changeBackground();
			setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		}
	});
}

/**
 *点击新建文件夹
 */
function doNewFolder(){
	if(enabled.newFolder){
		document.forms[0].action = contextPath + '/km/disk/save.action';
		enabled.newFolder = false;
		enabled.showIcon = false; //重命名的时候,数据列鼠标悬停事件不可操作。
		enabled.download = false;
		enabled.share = false;
		enabled.del = false;
		enabled.moreBtn = false;
		jQuery(".download").css("color","gray");
		jQuery(".delete").css("color","gray");
		jQuery(".copyUrl").css("color","gray");
		jQuery(".goShare").css("color","gray");
		jQuery("#mBtn").css("color","gray");
		jQuery("#tableData").prepend("<tr class='newTr'><td align='center' class='checkbox'>"
				+"<input type='checkbox'/></td><td class='newFileName'><div class='imgContent icon-file-s icon-file-folder'></div>"
				+"<input id='content.name' type='text' name='content.name' class='inputClass' value=''/>"
				+"<input onClick='doSaveFolder()' type='button' class='newFileNameTrue'/>"
				+"<input onClick='doCancel()' type='button' class='newFileNameFalse'/>"
				+"</td><td class='size'></td><td class='dateTime'></td></tr>");
		jQuery(".inputClass").focus().keydown(function(event){
        	if(event.keyCode == "13"){
        		doSaveFolder();
        		return false;
        	}
		});
	}
	resizeTbData_box(); //调整显示列表的iframe高度
}

/**
 *新建文件夹保存
	*/
function doSaveFolder(){
	document.forms[0].action = contextPath + '/km/disk/save.action';
	if(jQuery(".inputClass").val()!=""){
		parent.setNewFolderStyle(1); //设置新建文件夹按钮操作模式
		document.forms[0].submit();
	}
	else alert("文件名不能为空");
}

/**
*新建文件夹取消
*/
function doCancel(){
	if(!enabled.newFolder){
		document.forms[0].action = "";
		jQuery(".newTr").empty();
		jQuery(".download").css("color","#000");
		jQuery(".delete").css("color","#000");
		jQuery(".copyUrl").css("color","gray");
		jQuery(".goShare").css("color","#000");
		jQuery("#mBtn").css("color","#000");
		moreOperation(); //更多的鼠标事件，用来显示更多的操作项
		trOperation(); ////鼠标移到tr上面时显示的图标的事件
		parent.setNewFolderStyle(1); //设置新建文件夹按钮操作模式
		enabled.showIcon = true; //重命名的时候,数据列鼠标悬停事件不可操作。
		enabled.newFolder = true;
		enabled.download = true;
		enabled.share = true;
		enabled.del = true;
		enabled.moreBtn = true;
		resizeTbData_box(); //调整显示列表的iframe高度
	}
}

/**
 *	树型视图点击新建文件夹
 */
function doNewFolder2(){
	if(enabled.newFolder){
		document.forms[0].action = contextPath + '/km/disk/save.action';
		mouseoverShowIcon = false;  //重命名的时候,数据列鼠标悬停事件不可操作。
		enabled.newFolder = false;
		enabled.showIcon = false; //重命名的时候,数据列鼠标悬停事件不可操作。
		enabled.download = false;
		enabled.share = false;
		enabled.del = false;
		enabled.moreBtn = false;
		jQuery(".download").css("color","gray");
		jQuery(".delete").css("color","gray");
		jQuery(".copyUrl").css("color","gray");
		jQuery(".goShare").css("color","gray");
		jQuery("#mBtn").css("color","gray");
		jQuery("#tableData").prepend("<tr class='newTr'><td align='center' class='checkbox'>"
				+"<input type='checkbox'/></td><td class='newFileName'><div class='imgContent icon-file-s icon-file-folder'></div>"
				+"<input id='content.name' type='text' name='content.name' class='inputClass' value=''/>"
				+"<input onClick='doSaveFolder2()' type='button' class='newFileNameTrue'/>"
				+"<input onClick='doCancel2()' type='button' class='newFileNameFalse'/>"
				+"</td><td class='size'></td><td class='dateTime'></td></tr>");
		jQuery(".inputClass").focus().keydown(function(event){
        	if(event.keyCode == "13"){
        		doSaveFolder2();
        		return false;
        	}
		});
	}
}

/**
 *	树型视图新建文件夹保存
**/
function doSaveFolder2(){
	document.forms[0].action = contextPath + '/km/disk/save.action';
	if(jQuery(".inputClass").val()!=""){
		parent.parent.setNewFolderStyle(1);   //重新绑定新建文件夹的方法
		document.forms[0].submit();
	}
	else alert("文件名不能为空");
}

/**
*	树型视图新建文件夹取消
*/
function doCancel2(){
	if(!enabled.newFolder){
		jQuery(".newTr").empty();
		jQuery("#doNewFolder").css("color","");
		jQuery(".download").css("color","");
		jQuery(".delete").css("color","");
		jQuery(".copyUrl").css("color","gray");
		jQuery(".goShare").css("color","");
		jQuery("#mBtn").css("color","");
		enabled.showIcon = true; //重命名的时候,数据列鼠标悬停事件不可操作。
		enabled.newFolder = true;
		enabled.download = true;
		enabled.share = true;
		enabled.del = true;
		enabled.moreBtn = true;
		moreOperation(); //更多的鼠标事件，用来显示更多的操作项
		trOperation(); ////鼠标移到tr上面时显示的图标的事件
		mouseoverShowIcon = true;  //重命名的时候,数据列鼠标悬停事件不可操作。
	}
}

/**
 *监听事件
 */
function doClick(){
	jQuery("#doNewFolder").click(function(){
		doNewFolder();
	});
	jQuery("#adminAuthorizeBtn").click(function(){
		var isAuthorize = true;
		var $checkbox = jQuery("#tableData").find("input:checkbox:checked");
		if($checkbox.size()!=1) isAuthorize = false;	//未勾选时
		if(!permission.checkedPermission($checkbox.val(),"authorize"))
			isAuthorize = false;
		
		if(isAuthorize){
			var _fileId =  $checkbox.val();
			var _fileType =  $checkbox.attr("_fileType");
			adminAuthorize(_fileId,_fileType);
		}
	});
	jQuery(".checkbox").find("input").click(function(){
		if(jQuery(this).attr("checked")=="checked") jQuery(this).attr("checked","checked");
		else jQuery(this).removeAttr("checked");
	});
	jQuery(".renaming").click(function(){
		doRenaming();
	});
	jQuery(".delete").click(function(){
		var id = jQuery("#tableData").find("input:checkbox:checked").val();
		if(permission.checkedPermission(id,"del")){
			doDelete();	
		}
	});
	jQuery(".copyUrl").click(function(){
		doCopyUrl();	
	});
	jQuery(".download").click(function(){
		download();
	});
	jQuery(".batchdownload").click(function() {
		batchDownload();
	});
	jQuery(".adminAuthorize").click(function(){
		var $checkbox = jQuery(this).parents("tr").find("input:checkbox");
		var id = $checkbox.val();
		var _fileType =  $checkbox.attr("_fileType");
		if(permission.checkedPermission(id,"adminAuthorize") && _fileType == 1){
			var _fileId =  $checkbox.val();
			adminAuthorize(_fileId,_fileType);
		}
	});
	moreOperation(); //更多的鼠标事件，用来显示更多的操作项
	trOperation(); //鼠标移到tr上面时显示的图标的事件
}

/**
 *更多的鼠标事件，用来显示更多的操作项
 */
function moreOperation(){
	var time1="";
	var time2="";
	jQuery("#mBtn").mouseover(function(){
		if(enabled.moreBtn){
			clearTimeout(time1);
			jQuery(".pull_down_menu").addClass("showHide");	
		}
	}).mouseout(function(){
		time1 = setTimeout(function(){
			jQuery(".pull_down_menu").removeClass("showHide");
		},500);
	});
	jQuery(".pull_down_menu").mouseover(function(){
		clearTimeout(time1);
		clearTimeout(time2);
	}).mouseout(function(event){
		time2 = setTimeout(function(){
			jQuery(".pull_down_menu").removeClass("showHide");
		},500);
	});
}

/**
 *重命名
 */
function doRenaming(){
	if(enabled.rename){
		var $selected = jQuery(".table2").find("input[checked='checked']");
		if($selected.length > 1) alert("只能选择单个文件或文件夹");
		else{
			var id = $selected.val();
			if(!permission.checkedPermission(id,"rename")){
				return;
			}
			enabled.rename = false;
			enabled.showIcon = false; //重命名的时候,数据列鼠标悬停事件不可操作。
			jQuery(".renaming").css("color","gray");
			var selectName = $selected.attr("name");
			var $oldTd = $selected.parent().next().find(".fileView");
			var aHtml = $oldTd.html();
			$oldTd.replaceWith("<span id='newSpan'><input class='inputClass' id='content.name' name='content.name' type='text' value='" + aHtml + "'/>"
					+"<input id='newTrue' type='button' class='newFileNameTrue'/>"
					+"<input id='newFalse' type='button' class='newFileNameFalse'/></span>");
			jQuery(".inputClass").select().keydown(function(event){
	        	if(event.keyCode == "13"){
	        		jQuery("#newTrue").click();
	        		return false;
	        	}
			});
			jQuery("#newFalse").click(function(){
				jQuery("#newSpan").replaceWith($oldTd);
				jQuery(".renaming").click(function(){
					doRenaming();
				});
				jQuery(".renaming").css("color","");
				enabled.showIcon = true; //重命名的时候,数据列鼠标悬停事件不可操作。
			});
			
			jQuery("#newTrue").click(function(){
				var newName = document.getElementById("content.name").value
				if(newName != null && newName != undefined && jQuery.trim(newName) != ""){
					enabled.rename = true;
					var ndiskid = document.getElementById("ndiskid").value;
					var selectedVal = $selected.val();
					if(selectName == "_dirSelects"){
						document.forms[0].action = contextPath + '/km/disk/rename.action?renameNDirid=' + selectedVal;
					}else {
						document.forms[0].action = contextPath + '/km/disk/rename.action?renameNFileid=' + selectedVal  + "&_ndiskid=" + ndiskid;
					}
					document.forms[0].submit();
				}else{
					alert("文件名不能为空");
					doRenaming();
				}
				
			});
			
		}
	}
}

/**
 *复制到
 */
function copyTo() {
	var ndiskid = document.getElementById("ndiskid").value;
	OBPM.dialog.show({
		opener : window.top,
		width : 600,
		height : 400,
		url : copyToUrl,
		args : {},
		title : "复制到",
		close : function() {
		}
	});
}

/**
 * 移动到
 */
function moveTo() {
	var ndirid = document.getElementById("ndirid").value;
	var movetotitle = document.getElementById("movetotitle").value;
	var _dirselects = "";
	var _fileselects = "";
	var isPermission = true;
	jQuery(".checkbox").find("input[name='_dirSelects'][checked='checked']").each(function(){
		var id = jQuery(this).attr("value");
		if(permission.checkedPermission(id,"move"))
			_dirselects += id + ";";
		else{
			isPermission = false;
			return;
		}
	});
	
	jQuery(".checkbox").find("input[name='_fileSelects'][checked='checked']").each(function(){
		var id = jQuery(this).attr("value");
		if(permission.checkedPermission(id,"move"))
			_fileselects += id + ";";
		else{
			isPermission = false;
			return;
		}
	});
	if(!isPermission) return;
	
	if(_dirselects.length>1){
		_dirselects = _dirselects.substring(0, _dirselects.length-1);
	}
	
	if(_fileselects.length>1){
		_fileselects = _fileselects.substring(0, _fileselects.length-1);
	}
	
	var checkedJson = "{'_dirSelects':'" + _dirselects + "','_fileselects':'" + _fileselects + "'}";
	OBPM.dialog.show({
		opener : window.top,
		width : 530,
		height : 400,
		url : moveToUrl,
		args : {'checkedJson':checkedJson},
		title : movetotitle,
		maximized: false, // 是否支持最大化
		close : function() {
			document.forms[0].action = contextPath + '/km/disk/viewndir.action';
			document.forms[0].submit();
		}
	});
}

/**
 * 企业域授权
 */
 function adminAuthorize(_fileId,_fileType){
	 var adminAuthorizetitle = document.getElementById("adminAuthorizetitle").value;
	 
	var url = contextPath + "/km/permission/manage_permission_list.action?resource="+_fileId+"&resourceType=directory";
	OBPM.dialog.show({
					opener : window.top,
					width : 610,
					height : 450,
					url : url,
					args : {},
					title : adminAuthorizetitle,
					maximized: false, // 是否支持最大化
					close : function() {
					}
		});
}
 
/**
 * 翻到下一页
 */
function showNextPage(){
	var ck = getCookie("km_fileList_pageLine");
	if(ck == null) ck = 20;
	var	FO = document.forms;
	var pageNo = parseInt(FO[0]._currpage.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ ck);
	if (pageCount > 1 && pageCount > pageNo) {
		FO[0].action = contextPath + '/km/disk/viewndir.action';
		FO[0]._currpage.value = pageNo + 1;
		FO[0].submit();
	}
}

/**
 * 翻到下一页（ 用于首页）
 */
function showNextPageForHomePage(){
	var	FO = document.forms;
	var pageNo = parseInt(FO[0]._currpage.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ 10);
	if (pageCount > 1 && pageCount > pageNo) {
		//FO[0].action = contextPath + '/km/disk/listHotest.action';
		FO[0]._currpage.value = pageNo + 1;
		FO[0].submit();
	}
}

/**
 * 翻到上一页
 */
function showPreviousPage(){
	var FO = document.forms;
	var pageNo = parseInt(FO[0]._currpage.value);

	if (pageNo > 1) {
		FO[0]._currpage.value = pageNo - 1;
		FO[0].action = contextPath + '/km/disk/viewndir.action';
		FO[0].submit();
	}
}

/**
 * 翻到上一页（用于首页）
 */
function showPreviousPageForHomePage(){
	var FO = document.forms;
	var pageNo = parseInt(FO[0]._currpage.value);

	if (pageNo > 1) {
		FO[0]._currpage.value = pageNo - 1;
		//FO[0].action = contextPath + '/km/disk/listHotest.action';
		FO[0].submit();
	}
}
/**
 * 翻到第一页
 */
function showFirstPage(){
	var	FO = document.forms;
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ 10);

	if (pageCount > 1) {
		FO[0].action = contextPath + '/km/disk/viewndir.action';
		FO[0]._currpage.value = 1;
		FO[0].submit();
	}
}
/**
 * 翻到第一页（用于首页）
 */
function showFirstPageForHomePage(){
	var	FO = document.forms;
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ 10);

	if (pageCount > 1) {
		//FO[0].action = contextPath + '/km/disk/listHotest.action';
		FO[0]._currpage.value = 1;
		FO[0].submit();
	}
}

/**
 * 翻到最后一页
 */
function showLastPage(){
	var ck = getCookie("km_fileList_pageLine");
	if(ck == null) ck = 20;
	var	FO = document.forms;
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ck);

	if (pageCount > 1) {
		FO[0].action = contextPath + '/km/disk/viewndir.action';
		FO[0]._currpage.value = pageCount;
		FO[0].submit();
	}
}

/**
 * 翻到最后一页（用于首页）
 */
function showLastPageForHomePage(){
	var	FO = document.forms;
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/10);

	if (pageCount > 1) {
		//FO[0].action = contextPath + '/km/disk/listHotest.action';
		FO[0]._currpage.value = pageCount;
		FO[0].submit();
	}
}

/**
 * 设置cookie值
 */
function setCookie(name,value){
    var exp  = new Date();  
    exp.setTime(exp.getTime() + 30*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

/**
 * 获取cookie值
 */
function getCookie(name){
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
}

/**
 * 输出每页显示数量
 */
function showNumHtml(actionURL){
	if(!actionURL) actionURL = contextPath + '/km/disk/viewndir.action';
	var showpage = document.getElementById("showpage").value;
	var ck = getCookie("km_fileList_pageLine");
	if(ck == null) ck = 20;
	var html = showpage+"：";
	html += ck==10?"10&nbsp;&nbsp;":"<a href='javascript:setCookie(\"km_fileList_pageLine\",10);changeShowNum(\""+actionURL+"\")'>10</a>&nbsp;&nbsp;";
	html += ck==20?"20&nbsp;&nbsp;":"<a href='javascript:setCookie(\"km_fileList_pageLine\",20);changeShowNum(\""+actionURL+"\")'>20</a>&nbsp;&nbsp;";
	html += ck==50?"50":"<a href='javascript:setCookie(\"km_fileList_pageLine\",50);changeShowNum(\""+actionURL+"\")'>50</a>";
	jQuery(".showNum").html(html);
}

/**
 * 切换显示数量
 */
function changeShowNum(actionURL){
	var FO = document.forms;
	FO[0].action = actionURL;
	FO[0].submit();
}

jQuery(document).ready(function(){
	var _type = document.getElementById("_type").value;
	settingNav();	//初始化导航内容
	//全选/全不选
	jQuery(".checkAll").click(function(event){
		event.stopPropagation();
		if(jQuery(this).attr("checked")=="checked"){
			if(_type != 5 && isDirManager){
				jQuery(".checkHidden").hide();
				jQuery(".checkShow").show();
			}
			jQuery("#tableData").find(jQuery("input:checkbox")).attr("checked","checked");
			jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input:checkbox")).size());
		}else{
			hiddenMoreBtn();//隐藏更多按钮
			jQuery("#tableData").find(jQuery("input:checkbox")).removeAttr("checked");
		}
		setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		changeBackground();//选中的时候改变tr背景色
	});
	
	/**
	 * 点击td的时候全部选中或者全部取消
	 */
	jQuery(".tdCheckedAll").click(function(event){
		event.stopPropagation();
		if(jQuery(this).find(jQuery("input:checkbox")).attr("checked")=="checked"){
			jQuery(this).find(jQuery("input:checkbox")).removeAttr("checked");
			hiddenMoreBtn();//隐藏更多按钮
			jQuery("#tableData").find(jQuery("input:checkbox")).removeAttr("checked");
		}else{
			jQuery(this).find(jQuery("input:checkbox")).attr("checked","checked");
			jQuery("#tableData").find(jQuery("input:checkbox")).attr("checked","checked");
			if(_type != 5){
				showMoreBtn();//显示更多按钮
			}
			jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input:checkbox")).size());
		}
		setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		changeBackground();//选中的时候改变tr背景色
	});
	
	/**
	 * 复选框的选中和取消的动作
	 */
	jQuery("#tableData").find(jQuery("input:checkbox")).click(function(event){
		event.stopPropagation();
		if(jQuery(this).attr("checked")=="checked"){
			if(_type != 5 && isDirManager){
				jQuery(".checkHidden").hide();
				jQuery(".checkShow").show();
			}
			var $tableData = jQuery("#tableData");
			var checked = $tableData.find(jQuery("input:checkbox:checked")).size();
			var total = $tableData.find(jQuery("input:checkbox")).size();
			if(checked == total){
				jQuery(".checkAll").attr("checked", true);
			}
			jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input:checkbox:checked")).size());
		}else{
			jQuery(".checkAll").removeAttr("checked");
			if(jQuery("#tableData").find(jQuery("input:checkbox:checked")).size() > 0){
				jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input:checkbox:checked")).size());
			}else{
				hiddenMoreBtn();//隐藏更多按钮
			}
		}
		setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		changeBackground();//选中的时候改变tr背景色
	});
	/**
	  * 鼠标移到标题头tr上面时的事件
	  */
	jQuery("#tableTitle td").mouseover(function(){
		jQuery(this).addClass("backgroundColor");
	}).mouseout(function(){
		jQuery(this).removeClass("backgroundColor");
	});
	
	 /**
	  * 鼠标移到tr上面时的事件
	  */
	if(_type != 5){
		jQuery(".tr").mouseover(function(){
			if(enabled.showIcon){
				var selectsSize = jQuery("#tableData").find("input:checkbox:checked").size(),//选中的目录个数
					trId = jQuery(this).find("input[type=checkbox]").val(),
					trAuthorize = permission.getPermission(trId).authorize;
				//多选的时候，禁用“滑过显示相关操作图标”功能；
				if((selectsSize < 2 && trAuthorize) || _type == 2){
					jQuery(this).find(".more_btn").show();
					jQuery(this).find(".doView").width(jQuery(this).find(".newFileName").width() - jQuery(this).find(".more_btn").width() - 15);
				}
				jQuery(this).addClass("backgroundColor");
			}
		}).mouseout(function(){
			jQuery(this).find(jQuery(".more_btn")).hide();
			jQuery(this).removeClass("backgroundColor");
			jQuery(this).find(".doView").css("width","auto");
		});
	}
	
	 /**
	  * tr上面的点击事件
	  */
	jQuery(".tr").click(function(event){
		event.stopPropagation();
		var bl = !!jQuery(this).find("input:checkbox").attr("checked");//当前是否选中
		var mul = jQuery("input:checkbox:checked").size()>1;//当前是否多选
		jQuery("#tableTitle").find("input:checkbox").removeAttr("checked");
		jQuery("#tableData").find("input:checkbox").removeAttr("checked");
		if(!bl || mul){
			jQuery(this).find("input:checkbox").attr("checked","checked");
			if(_type != 5 && isDirManager){
				jQuery(".checkHidden").hide();
				jQuery(".checkShow").show();
			}
		}else{
			jQuery(this).find("input:checkbox").removeAttr("checked");
			hiddenMoreBtn();//隐藏更多按钮
		}
		jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input:checkbox:checked")).size());
		setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		changeBackground();//选中的时候改变tr背景色
	});
	doClick();
	
	/**
	 * 点击checkbox的td的事件
	 */
	jQuery(".tdChecked").click(function(event){
		event.stopPropagation();
		var checkbox = jQuery(this).find("input:checkbox").attr("checked");
		if(checkbox=="checked"){
			jQuery(this).find("input:checkbox").removeAttr("checked");
			jQuery(".checkAll").removeAttr("checked");
			jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input:checkbox:checked")).size());
			var mul = jQuery("#tableData").find(jQuery("input:checkbox:checked")).size()==0;//是否已没有选择的行
			if(mul){
				hiddenMoreBtn();//隐藏更多按钮
			}
		}else{
			jQuery(this).find("input:checkbox").attr("checked","checked");
			if(_type != 5 && isDirManager){
				jQuery(".checkHidden").hide();
				jQuery(".checkShow").show();
			}
			var $tableData = jQuery("#tableData");
			var checked = $tableData.find(jQuery("input:checkbox:checked")).size();
			var total = $tableData.find(jQuery("input:checkbox")).size();
			if(checked == total){
				jQuery(".checkAll").attr("checked", true);
			}
		}
		setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		changeBackground();//选中的时候改变tr背景色
	});
	
	jQuery(".goShare").click(function(event){
		event.stopPropagation();
		if(enabled.share){
			selectedCurrent(this); //取消其它选中项，选中当前点击项
			showShare_page();
		}
	});
	
	jQuery(".goShareBtn").click(function(){
		if(enabled.share){
			showShare_page();
		}
	});

	jQuery(".more_share").click(function(event){
		event.stopPropagation();
		if(enabled.share){
			jQuery(this).parents(".tr").find("input:checkbox").attr("checked","checked");
			if(_type != 5){
				showMoreBtn();//显示更多按钮
			}
			jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input[checked='checked']")).size());
			changeBackground();
			setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		}
	});
	
	jQuery(".more_download").click(function(event){
		event.stopPropagation();
		jQuery(this).parents(".tr").find("input:checkbox").attr("checked","checked");
		if(_type != 5){
			showMoreBtn();//显示更多按钮
		}
		jQuery("#checkedNum").html(jQuery("#tableData").find(jQuery("input[checked='checked']")).size());
		changeBackground();
		setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
	});
	
	/**
	 * 公共网盘按钮授权事件
	 */
	jQuery("#authorizeBtn").click(function(event){
		var isAuthorize = true;
		var $checkbox = jQuery("#tableData").find("input:checkbox:checked");
		if($checkbox.size()!=1) isAuthorize = false;	//未勾选时
		if(!permission.checkedPermission($checkbox.val(),"authorize"))
			isAuthorize = false;
		
		if(isAuthorize){
			var _fileId =  $checkbox.val();
			var _fileType =  $checkbox.attr("_fileType");
			authorizeListW(_fileId,_fileType);
			setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		}
	});
	
	/**
	 * 公共网盘列表授权图标事件
	 */
	jQuery(".goAuthorize").click(function(event){
		event.stopPropagation();
		jQuery("#tableData").find("input:checkbox").removeAttr("checked");
		var $checkbox = jQuery(this).parents("tr").find("input:checkbox");
		var id = $checkbox.val();
		if(permission.checkedPermission(id,"authorize")){
			$checkbox.attr("checked","checked");
			var _fileId =  $checkbox.val();
			var _fileType =  $checkbox.attr("_fileType");
			authorizeListW(_fileId,_fileType);
			setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
		}
	});
	
	/**
	 * 点击查看文件
	 **/
	jQuery(".fileViewAction").click(function(){
		var id = jQuery(this).attr("id");
		var ndirid = document.getElementById("ndirid").value;
		var ndiskid = document.getElementById("ndiskid").value;
		var _currpage = document.getElementById("_currpage").value;
		var _rowcount = document.getElementById("_rowcount").value;
		var _type = document.getElementById("_type").value;
		var _sortStatus = document.getElementById("_sortStatus").value;
		var orderbyfield = document.getElementById("orderbyfield").value;
		var url = contextPath+"/km/disk/file/view.action?id=" + id+"&ndirid="+ndirid+"&_currpage="+_currpage+"&_rowcount="+_rowcount+"&_type="+_type+"&_sortStatus="+_sortStatus+"&orderbyfield="+orderbyfield+"&_ndiskid="+ndiskid;
		window.open(url);
	});
	
	 setDoNewFolderStyle(); 	//设置新建按钮的样式
	 
	 setBtnState();	//设置分享、下载、重命名三个操作按钮的状态
});


/**
 * 选中的时候改变tr背景色
 * @return
 */
function changeBackground(){
	jQuery("#tableTitle tr").removeClass("backgroundColor2");
	jQuery("#tableData tr").removeClass("backgroundColor2");
	jQuery("#tableData").find("input:checkbox:checked").parent().parent().addClass("backgroundColor2");
	var checkedSize = jQuery("#tableData").find("input:checkbox:checked").size();
	if(checkedSize > 0){
		jQuery("#tableTitle tr").addClass("backgroundColor2");
	}
}

/**
 * 下载
 */
function download(){
	
	if(enabled.download){
		batchDownload();
	}
}

/**
 * 批量下载
 */
function batchDownload() {
	
	if(enabled.batchdownload){
		var fileIds = "";
		var i=0;
		jQuery('input[name="_fileSelects"]:checked').each(function(){  
			var fileId = jQuery(this).val();
			if (i==0) {
				fileIds = fileId;
			} else {
				fileIds += ";" + fileId;
			}
			i++;
		});
		
		var dirIds = "";
		var i=0;
		jQuery("input:checkbox:checked").filter(jQuery("input[name='_dirSelects']")).each(function(){  
			var fileId = jQuery(this).val();
			if (i==0) {
				dirIds = fileId;
			} else {
				dirIds += ";" + fileId;
			}
			i++;
		});
		var url = contextPath+"/km/disk/file/download.action?id="+fileIds +"&dirIds="+ dirIds;
		window.open(url, fileIds);
	}
}

/**
 * 下载
 */
function doDownload(fileId){
	if(enabled.download){
		var url = contextPath+"/km/disk/file/download.action?id="+fileId;
		window.open(url) ;
	}
}


/**
 *列头排序
 */
function orderbyColumn(fieldName){
	var _sort = document.getElementById("_sortStatus");
	document.getElementById("orderbyfield").value = fieldName;
	if(_sort.value != null && _sort.value != ''){
		if(_sort.value == 'ASC'){
			document.getElementById("_sortStatus").value = 'DESC';
		}else if(_sort.value == 'DESC'){
			document.getElementById("_sortStatus").value = 'ASC';
		}
	}else {
		document.getElementById("_sortStatus").value = 'DESC';
	}
	
	document.forms[0].action = contextPath + '/km/disk/viewndir.action';
	document.forms[0].submit();
}
/**
 * //显示更多按钮
 */
function showMoreBtn(){
	if(isPublicDiskAdmin){
		jQuery(".checkHidden").hide();
		jQuery(".checkShow").show();
	}
}
/**
 * //隐藏更多按钮
 */
function hiddenMoreBtn(){
	jQuery(".checkHidden").show();
	jQuery(".checkShow").hide();
}
/**
 * 取消其它选中项，选中当前点击项
 */
function selectedCurrent(obj){
	jQuery("#tableData").find("input:checkbox").removeAttr("checked");
	jQuery(obj).parents("tr").find("input:checkbox").attr("checked","checked");
}

//设置新建按钮的样式
function setDoNewFolderStyle(){
	 if(parent.document.getElementById("doNewFolder")){
		 parent.document.getElementById("doNewFolder").style.color="#000";
	}else if(parent.parent.document.getElementById("doNewFolder")){
		parent.parent.document.getElementById("doNewFolder").style.color="#000";
	} 
}

/**
 * 调整显示列表的iframe高度
 */
function resizeTbData_box(){
	var winH = jQuery(window).height();
	var crumbsH = jQuery(".crumbs").height();
	var tabTitleH = jQuery("#tableTitle").height();
	var pageNavH = jQuery(".pageNav").height();
	var tableData_boxH = winH - crumbsH - tabTitleH - pageNavH;
	var tableDataH = jQuery(".tableData_box>#tableData").height();
	var pageTop = (tableDataH>tableData_boxH-pageNavH)?tableData_boxH:tableDataH;
	jQuery(".tableData_box").height(tableData_boxH);
	jQuery(".pageNav").css("top",(pageTop+crumbsH+tabTitleH+4) + "px");
}

//判断是否显示上传与新建操作按钮
function operateDisplay(isDirManager){
	if(isDirManager){
		jQuery("body",parent.document).find(".operate").show();
	}else{
		jQuery("body",parent.document).find(".operate").hide();
	}
}