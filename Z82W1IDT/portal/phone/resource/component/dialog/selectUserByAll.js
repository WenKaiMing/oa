
	/*初始化返回事件*/
	function bindEvent(){
		jQuery("#doReturn").click(function(){
			var array = new Array();
			jQuery(".onSelect").each(function(){
				var rtn={};
				rtn.value = jQuery(this).attr("id");
				rtn.text = jQuery(this).find(".select-name").text();
				rtn.avatar = jQuery(this).attr("avatar"); //用户头像
				array.push(rtn);
			});
			var result = {
					data : array,
					state : "success"
			};
			top.OBPM.dialog.doReturn(result);
		});

		//删除所有用户
		jQuery("#deleteAll").click(function(){
			jQuery(".list_div_click").each(function(){
				jQuery(this).attr("checked",false);
			});
			jQuery("#selectedUserDiv").html("");
			setListHeight();
			//resetTargetValue();
		});
		
		/*注册页签切换事件*/
		jQuery(".crossUL > a").click(function(){
			
			if($("#right").hasClass("lateral-menu-is-open")){
				$("#right").animate({"width":"0"});
			}
			
			$('#left').removeClass('lateral-menu-is-open');
			$('#leftMask').hide();
			$('#right').removeClass('lateral-menu-is-open');
			
			jQuery(".crossUL a.active").removeClass("active");
			jQuery(this).addClass("active");
			if(jQuery(this).attr("id")=="bydept"){
				$('#right').show();
				getDeptTree();
			}
			if(jQuery(this).attr("id")=="byroles"){
				$('#right').show();
				getRoleslist();
			}
			if(jQuery(this).attr("id")=="byonline"){
				$('#right').hide();
				getOnLineUserList();
			}
			if(jQuery(this).attr("id")=="bycontancts"){
				$('#right').show();
				getContancts();
			}
			if(jQuery(this).attr("id")=="bysearch"){
				$('#right').hide();
				getAllUser();
			}
			if(jQuery(this).attr("id")=="byfavorite"){
				$('#right').hide();
				getFavorite();
			}
			
			//$("#leftcontent").css("height",$("#left").height()-$("#lefthead").height()-10);
			
		});
	}
	

	//设置己选择的用户数据
	function initSetValue(){
		if(flowid=="null" || nodeid=="null"){
			var targetidVal = "";
			var viewNameVal = "";
			var viewEmailVal = "";
			var viewEmailAccountVal = "";
			var viewTelephoneVal = "";
			if (parentObj.document.getElementById(targetid)) {
				targetidVal = parentObj.document.getElementById(targetid).value;
			}
			if (parentObj.document.getElementById(viewName)) {
				viewNameVal = parentObj.document.getElementById(viewName).value;
			}
			if (parentObj.document.getElementById(viewEmail)) {
				viewEmailVal = parentObj.document.getElementById(viewEmail).value;
			}
			if (parentObj.document.getElementById(viewEmailAccount)) {
				viewEmailAccountVal = parentObj.document.getElementById(viewEmailAccount).value;
			}
			if (parentObj.document.getElementById(viewTelephone)) {
				viewTelephoneVal = parentObj.document.getElementById(viewTelephone).value;
			}
			var userIds = targetidVal.split(";");
			var userNames = viewNameVal.split(";");
			var userEmails = viewEmailVal.split(";");
			var userEmailAccounts = viewEmailAccountVal.split(";");
			var userTelephones = viewTelephoneVal.split(";");
			
			var userAvatar = []
			for(var i = 0;i < userIds.length;i++){
				var avatar = Common.Util.getAvatar(userIds[i]);
				userAvatar.push(avatar);
			}
			
			
			for(var i=0; i<userIds.length; i++){
				if(userIds[i] != ""){
					var obj = {id:userIds[i],name:userNames[i],email:userEmails[i],emailAccount:userEmailAccounts[i],telephone:userTelephones[i],avatar:userAvatar[i]};
					addToUserSelectByMap(obj);
				}
			}
		}else{
			var targetidVal = "";
			var viewNameVal = "";
			var viewEmailVal = "";
			if (parentObj.document.getElementById(targetid)) {
				targetidVal = parentObj.document.getElementById(targetid).value;
			}
			if (parentObj.document.getElementById(viewName)) {
				viewNameVal = parentObj.document.getElementById(viewName).value;
			}
			if (parentObj.document.getElementById(viewEmail)) {
				viewEmailVal = parentObj.document.getElementById(viewEmail).value;
			}
			var userIds = targetidVal.split(";");
			var userNames = viewNameVal.split(";");
			var userEmails = viewEmailVal.split(";");
			for(var i=0; i<userIds.length; i++){
				if(userIds[i] != ""){
					var obj = {id:userIds[i],name:userNames[i],email:userEmails[i]};
					addToUserSelectByMap(obj);
				}
			}
		}
		
	}
	

	/*初始化默认值*/
	function initDefValue(defValue){
		if (defValue) {
			var array = jQuery.isArray(defValue) ? defValue: defValue.split(",");
			var params = "";
			if (array && array.length > 0) {
				for (var i = 0; i < array.length; i++) {
					params += "&_selects=" + array[i];
				}
			}
			
			jQuery.ajax({
					url:contextPath+"/portal/user/doListBySelectToJSON.action",
					type:"post",
					datatype:"json",
					timeout: 3000,
					data: "domain=" + domainid + params,
					success:function(userlist){
						if (userlist && userlist.length > 0) {
							for (var i = 0; i < userlist.length; i++) {
								addToUserSelectByMap(userlist[i]);
							}
						}
					},
					
					error:function(data,status){
						alert("failling to doListBySelectToJSON...");
					}
			});	
		}
	}
	
	//设置列表高度
	function setListHeight() {
        var screenHeight = $(window).height();
        var topHeight = $(".card_space_topfix").outerHeight();
        var bottomHeight = $(".card_space_fix").outerHeight();
        
        $("#left").css({"height":screenHeight-topHeight-bottomHeight-20});
        $("#right").css({"height":screenHeight-topHeight-bottomHeight,"overflow":"auto"});
        $(".selectuser").css("width",$(window).width());
        $(".selectUserIS-box").css("width",$(window).width());
        //$("#leftcontent").css("height",$("#left").height()-45);
        if($("#selectedUserDiv").height()==0){
        	$("#leftcontent").css("height",$("#left").height()-45);
        }else{
        	$("#leftcontent").css("height",$("#left").height()-111);
        	
        }
        //this.userScroll.refresh();
        
	}
	
	


	/*用户点击选择用户事件(返回错误信息)*/
	function selectUserWithReturnMsg(obj,isclickone){
		if(selectMode == 'selectOne'){
			if(obj.attr("checked")=="checked"){
				jQuery(".list_div_click").each(function(){
					if(jQuery(this).attr("id") != obj.attr("id")){
						jQuery(this).removeAttr("checked");
					}
				});
				jQuery("#selectedUserDiv").find("span").remove();
				return addToUserSelect(obj);
			}else{
				//jQuery(this).attr("checked",false);
				jQuery(".onSelect").each(function(){
					if(jQuery(this).attr("id")==obj.attr("id")){		
						jQuery("span").remove("#"+obj.attr("id"));
					}
				});	
			}
			
			//resetTargetValue();
		}else{
			if(isclickone){
				if(obj.attr("checked")=="checked"){
					var flag=false;
					//jQuery(this).attr("checked",false);
					jQuery(".onSelect").each(function(){
						if(jQuery(this).attr("id")==obj.attr("id")){
							flag=true;
						}
					});
					return addToUserSelect(obj);
				}else{
					//jQuery(this).attr("checked",false);
					jQuery(".onSelect").each(function(){
						if(jQuery(this).attr("id")==obj.attr("id")){		
							jQuery("span").remove("#"+obj.attr("id"));
						}
					});	
				}
			}else{
				return addToUserSelect(obj);
			}
			
			//resetTargetValue();
		}
	}
	
	/*用户点击选择用户事件*/
	function selectUser(obj,isclickone){
		if(selectMode == 'selectOne'){
			if(obj.prop("checked")){
				jQuery(".list_div_click").each(function(){
					if(jQuery(this).attr("id") != obj.attr("id")){
						jQuery(this).removeAttr("checked");
					}
				});
				jQuery("#selectedUserDiv").find("span").remove();
				addToUserSelect(obj);
			}else{
				//jQuery(this).attr("checked",false);
				jQuery(".onSelect").each(function(){
					if(jQuery(this).attr("id")==obj.attr("id")){		
						jQuery("span").remove("#"+obj.attr("id"));
					}
				});	
			}
			
			//resetTargetValue();
		}else{
			if(isclickone){
				if(obj.prop("checked")){
					var flag=false;
					//jQuery(this).attr("checked",false);
					jQuery(".onSelect").each(function(){
						if(jQuery(this).attr("id")==obj.attr("id")){
							flag=true;
						}
					});
					var error = addToUserSelect(obj);
					alertError(error);
				}else{
					//jQuery(this).attr("checked",false);
					jQuery(".onSelect").each(function(){
						if(jQuery(this).attr("id")==obj.attr("id")){		
							jQuery("span").remove("#"+obj.attr("id"));
						}
					});	
				}
			}else{
				var error = addToUserSelect(obj);
				alertError(error);
			}
			
			//resetTargetValue();
		}
		setListHeight();
		event.stopPropagation();
	}

	function getUserBox(obj) {
		var $menuRriggerEle = $(obj),
		    $contentWrapper = $('#left');
		
		$contentWrapper.removeClass('lateral-menu-is-open');
		$('#leftMask').hide();
		$('#right').removeClass('lateral-menu-is-open');
		$("#right").animate({"width":"0"});
	}
	

	function addToUserSelect(obj){
		var map = {id: obj.attr("id"), name: obj.attr("name"), email: obj.attr("email"), emailAccount: obj.attr("emailAccount"),telephone: obj.attr("telephone"),avatar: obj.attr("avatar")};
		return addToUserSelectByMap(map);
	}
	

	function clickRemoveSelect(id,name){
		/*
		if(jQuery("#"+id)){
			jQuery("#"+id).attr("checked",false);
		}
		if(jQuery("#"+id)){
			jQuery("span").remove("#"+id);
		}
		*/		

		jQuery(".list_div_click").each(function(){
			if(jQuery(this).attr("id")==id){
				jQuery(this).attr("checked",false);
				//resetTargetValue();
			}
		});
		/*
		jQuery(".onSelect").each(function(){
			if(jQuery(this).attr("id")==id){
				jQuery("span").remove("#"+jQuery(this).attr("id"));
			}
		});
		*/
		
		jQuery('span.onSelect').on('click',function(){
			jQuery(this).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', jQuery(this).remove());
			setListHeight();
			//resetTargetValue();
		});
		
		//resetTargetValue();
		jQuery("#selectedUserDiv").focus();
		
		//setListHeight();
	}