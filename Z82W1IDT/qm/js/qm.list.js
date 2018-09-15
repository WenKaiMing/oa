var select_id = "";
	/* todo */
	$(document).ready(function() {
		
		/*
		 * type:{
		 * 		0:我发布的,
		 * 		1:我参与的
		 * }
		 * status{
		 * 		0:草稿,
		 * 		1:进行中,
		 * 		2:已完成
		 * }
		 * */
		var params = {
				"type":$("input[name='type']").val()? $("input[name='type']").val() :1,
				"status":$("input[name='status']").val()? $("input[name='status']").val() :1,
				"_currpage":$("input[name='_currpage']").val()?$("input[name='_currpage']").val() :1
				};
		
		$("input[name='type']").val(params.type);
		$("input[name='status']").val(params.status);
		
		if($("input[name='type']").val() == "1"){
			$(".all-left").find(".all-left-one").addClass("nodisplay");
			$(".all-left").find(".all-left-two").addClass("btn-active join-playing").siblings().removeClass("btn-active");
			$(".all-right").find(".all-right-two").addClass("btn-active").siblings().removeClass("btn-active");
		}else{
			$(".all-left").find(".all-left-one").removeClass("nodisplay");
			$(".all-left").find(".all-left-two").removeClass("join-playing");
			$(".all-right").find(".all-right-one").addClass("btn-active").siblings().removeClass("btn-active");
		}
		if($("input[name='status']").val() == "0"){
			$(".all-left").find(".all-left-one").addClass("btn-active").siblings().removeClass("btn-active");
		}else if($("input[name='status']").val() == "2"){
			$(".all-left").find(".all-left-thre").addClass("btn-active").siblings().removeClass("btn-active");
		}else{
			$(".all-left").find(".all-left-two").addClass("btn-active").siblings().removeClass("btn-active");
		}
		
		$(this).addClass("btn-active").siblings().removeClass("btn-active");
		
		initList(params);
		
    	/* todo */
		/*$(".q_new").click(function() {
			window.location.href = "new.action";
		});*/
		$('#publishDialog .theme-poptit .close').click(function(){
			$('.theme-popover-main').hide();
			$('.theme-popover-mask').fadeOut(100);
			$('#publishDialog').slideUp(200);
		});
		
		jQuery("#formList_content_scopeuser").click(function() {
			jQuery("#userTr").css("display", "");
			jQuery("#roleTr").css("display", "none");
			jQuery("#deptTr").css("display", "none");

			//清除角色信息
			jQuery("#roleInput").attr("title", "");
			jQuery("#roleInput").val("");
			jQuery("#roleHidden").val("");
			//清除部门信息
			jQuery("#deptInput").attr("title", "");
			jQuery("#deptInput").val("");
			jQuery("#deptHidden").val("");
		});
		jQuery("#formList_content_scoperole").click(function() {
			jQuery("#roleTr").css("display", "");
			jQuery("#userTr").css("display", "none");
			jQuery("#deptTr").css("display", "none");

			//清除用户信息
			jQuery("#userInput").attr("title", "");
			jQuery("#userInput").val("");
			jQuery("#userHidden").val("");
			//清除部门信息
			jQuery("#deptInput").attr("title", "");
			jQuery("#deptInput").val("");
			jQuery("#deptHidden").val("");
		});
		jQuery("#formList_content_scopedept").click(function() {
			jQuery("#deptTr").css("display", "");
			jQuery("#userTr").css("display", "none");
			jQuery("#roleTr").css("display", "none");
			//清除用户信息
			jQuery("#userInput").attr("title", "");
			jQuery("#userInput").val("");
			jQuery("#userHidden").val("");
			//清除角色信息
			jQuery("#roleInput").attr("title", "");
			jQuery("#roleInput").val("");
			jQuery("#roleHidden").val("");
		});
		jQuery("#formList_content_scopedeptAndrole").click(
				function() {
					jQuery("#deptTr").css("display", "");
					jQuery("#userTr").css("display", "none");
					jQuery("#roleTr").css("display", "");
					//清除用户信息
					jQuery("#userInput").attr("title", "");
					jQuery("#userInput").val("");
					jQuery("#userHidden").val("");

				});
		
		$("#clear1User").click(function(){
			$(".user1Select").find("#userHidden").val("");
			$(".user1Select").find("#userInput").val("");
		});
		
		$("#clear2User").click(function(){
			$(".user2Select").find("#roleHidden").val("");
			$(".user2Select").find("#roleInput").val("");
		});
		
		$("#clear3User").click(function(){
			$(".user3Select").find("#deptHidden").val("");
			$(".user3Select").find("#deptInput").val("");
		});
		
		$(".nav-search-input").keyup(function(event){	//回车事件
        	if (event.keyCode == 13) {
        		var title = $(".nav-search-input").val();
        		var type = $(".all-right").find(".btn-active").attr("_value");
        		var status = $(".all-left").find(".btn-active").attr("status");
    			var params = {
    					"type": $("[name='type']").val(),
    					"status": $("[name='status']").val(),
    					"title" :title
    				}
    			initList(params);
    		}
    	});
		$(".nav-search-input").keydown(function(event){	//回车事件
        	if (event.keyCode == 13) {
    			return false;
    		}
    	});
		//我发布的和我参与的
		$(".all-right>button").click(function(){
			var type  = $(this).attr("_value"); //"1"为我参与的，"0"为我发布的
			if(type == "1"){
				$(".all-left").find(".all-left-one").addClass("nodisplay");
				$(".all-left").find(".all-left-two").addClass("btn-active join-playing").siblings().removeClass("btn-active");
			}else{
				$(".all-left").find(".all-left-one").removeClass("nodisplay");
				$(".all-left").find(".all-left-two").removeClass("join-playing");
			}
			$(this).addClass("btn-active").siblings().removeClass("btn-active");
			var status = $(".all-left").find(".btn-active").attr("status");
			var title = $(".nav-search-input").val();
			$("[name='type']").val(type);
			$("[name='status']").val(status);
			$("[name='_currpage']").val(1);
			
			var params = {
				"type": $("[name='type']").val(),
				"status": $("[name='status']").val(),
				"_currpage": $("[name='_currpage']").val(),
				"_pagelines": $("[name='_pagelines']").val(),
				"title" :title
			}
			initList(params);
		});
		//问卷的进行状态
		$(".all-left>button").click(function(){
			var status  = $(this).attr("status"); //"1"进行中，"2"已完成
			var type  = $(".all-right").find(".btn-active").attr("_value");
			var title = $(".nav-search-input").val();
			$("[name='type']").val(type);
			$("[name='status']").val(status);
			$("[name='_currpage']").val(1);
			$(this).addClass("btn-active").siblings().removeClass("btn-active");
			var params = {
					"type": $("[name='type']").val(),
					"status": $("[name='status']").val(),
					"_currpage": $("[name='_currpage']").val(),
					"_pagelines": $("[name='_pagelines']").val(),
					"title" :title
				}
				initList(params);
		});
		
		$("#redoRecover").unbind().click(function() {//弹出层的回收按钮点击事件
			Common.Util.hidePop();
            doRecover($("#doRecoverId").val());
        });
		$("#redoDelete").click(function() {//弹出层的删除按钮点击事件
			Common.Util.hidePop();
			doDelete($("#dodeleteId").val());
        });
	});
	function init_scope(){
		var scope = 'user';
		$("#formList_content_scopeuser").attr("checked","checked");
		var ownerNames = '';
		var ownerIds = '';
		if(scope =='role'){
			jQuery("#roleTr").css("display","");
			jQuery("#userTr").css("display","none");
			jQuery("#deptTr").css("display","none");
			jQuery("#roleInput").val(ownerNames);
			jQuery("#roleHidden").val(ownerIds);
		}else if(scope =='user'){
			jQuery("#userTr").css("display","");
			jQuery("#roleTr").css("display","none");
			jQuery("#deptTr").css("display","none");
			jQuery("#userInput").val(ownerNames);
			jQuery("#userHidden").val(ownerIds);
		}else if(scope =='dept'){
			jQuery("#deptTr").css("display","");
			jQuery("#roleTr").css("display","none");
			jQuery("#userTr").css("display","none");
			jQuery("#deptInput").val(ownerNames);
			jQuery("#deptHidden").val(ownerIds);
		}else if(scope =='deptAndrole'){
			jQuery("#deptTr").css("display","");
			jQuery("#roleTr").css("display","");
			jQuery("#userTr").css("display","none");
			var ownerId = ownerIds.split(";;");
			var ownerName = ownerNames.split(";;");
			jQuery("#deptInput").val(ownerName[0]);
			jQuery("#deptHidden").val(ownerId[0]);
			jQuery("#roleInput").val(ownerName[1]);
			jQuery("#roleHidden").val(ownerId[1]);
		}
	}

	function showResult(id) {
		//window.location.href = "chartMain.jsp?id=" + id;
		document.forms[0].action = "chartMain.jsp?id=" + id;
		document.forms[0].submit();
	}

	function selectAll(b, isRefresh) {
		var c = document.all('_selects');
		if (c == null)
			return;

		if (c.length != null) {
			for (var i = 0; i < c.length; ++i){
				c[i].checked = b && !(c[i].disabled);
			}
		} else {
			c.checked = b;
		}
	}

	function isSelectedOne2(fldName) {
		var c = document.getElementsByName(fldName);
		var flag = false;
		if (c && c.length > 0) {
			for (var i = 0; i < c.length; i++) {
				if (c[i].checked) {
					flag = true;
					break;
				}
			}
		}
		if (!flag) {
			alert("请选择其中一项");
			return false;
		}
		return true;
	}
	 
	function doPubilsh(id){
			$('.theme-popover-main').show();
			$('.theme-popover-mask').fadeIn(100);
			$('#publishDialog').slideDown(200);
			
			init_scope();
			
			select_id = id;
	}
	
	/*
	* 发布校验
	*/
	function checkout(){
		var u_ownerNames = document.getElementsByName("u_ownerNames")[0].value;
		var r_ownerNames = document.getElementsByName("r_ownerNames")[0].value;
		var d_ownerNames = document.getElementsByName("d_ownerNames")[0].value;
		var scope = jQuery("input[name='content.scope']:checked")[0].value;
		if(scope=="user" && u_ownerNames.length<=0){
			alert("请选择用户");
			return;
		}
		if(scope=="role" && r_ownerNames.length<=0){
			alert("请选择角色");
			return;
		}
		if(scope=="dept" && d_ownerNames.length<=0){
			alert("请选择部门");
			return;
		}
		if(scope=="deptAndrole" && (d_ownerNames.length<=0 || r_ownerNames.length<=0)){
			alert("请同时选择部门和角色");
			return;
		}
		
		ev_publish();
	}
	
	function ev_publish(){
		var scope = jQuery("input[name='content.scope']:checked")[0].value;
		var ownerIds = "";
		var ownerNames = "";
		if(scope == "user"){
			ownerIds = document.getElementById("userHidden").value;
			ownerNames = document.getElementById("userInput").value;
		}else if(scope == "role"){
			ownerIds = document.getElementById("roleHidden").value;
			ownerNames = document.getElementById("roleInput").value;
		}else if(scope == "dept"){
			ownerIds = document.getElementById("deptHidden").value;
			ownerNames = document.getElementById("deptInput").value;
		} else if(scope == "deptAndrole"){
			ownerIds = document.getElementById("deptHidden").value + ";;" +  document.getElementById("roleHidden").value;
			ownerNames = document.getElementById("deptInput").value + ";;" + document.getElementById("roleInput").value;
		}
		
		$.ajax({
		    type: 'POST',
		    url: "publishforId.action",
		    dataType:"html",
		    data: {'id':select_id,'scope':scope,'ownerIds':ownerIds,'ownerNames':ownerNames} ,
		    success:function(data){
				if(data){
					if(data.indexOf("SUCCESS") >= 0){
						//todo
						$('#publishDialog').hide();
						//alert("成功");
						Common.Util.showMessage("发布成功", "success");
						/* todo */
						//var page=$('#cp').text();
						//window.location.href = "list.action?_currpage="+page;
						$('.theme-popover-main').hide();
						var params = {
								"type": $("[name='type']").val(),
								"status": $("[name='status']").val(),
							}
							initList(params);
						/* todo end*/
					}
				}else{
					//alert("回收失败");
					Common.Util.showMessage("发布失败", "error");
				}
			},
			error:function(data,status){
				alert("failling to visited...");
			}
		});
	}
	
	function doRecover(id){
		$.ajax({
		    type: 'POST',
		    url: "recover.action",
		    data: {'id':id} ,
		    dataType:"html",
		    success:function(data){
				if(data){
					if(data.indexOf("SUCCESS") >= 0){
						Common.Util.showMessage("回收成功", "success");
						/* todo */
						//var page=$('#cp').text();
						/* todo begin*/
						//window.location.href = "list.action?_currpage="+page;
						var _currpage = $("[name='_currpage']").val();
						if(!turnPage(_currpage)){
							_currpage = _currpage-1;
							$("[name='_currpage']").val(_currpage);
						}
						var params = {
								"type": $("[name='type']").val(),
								"status": $("[name='status']").val(),
								"_currpage": _currpage
							}
							initList(params);
						/* todo end*/
					}
				}else{
					Common.Util.showMessage("回收失败", "error");
				}
			},
			error:function(data,status){
				Common.Util.showMessage("failling to visited...", "warning");
			}
		});
	}
	function doDelete(id){
		var _currpage = $("[name='_currpage']").val();
		if(!turnPage(_currpage)){
			_currpage = _currpage-1;
			$("[name='_currpage']").val(_currpage);
		}
		var params = {
				"type": $("[name='type']").val(),
				"status": $("[name='status']").val(),
				"title" :$(".nav-search-input").val(),
				"_currpage": _currpage
			}
		//if(confirm("删除后会将已答卷的问卷删除，是否继续?")){
			$.ajax({
	    		url: contextPath + "/qm/questionnaire/delete.action?_selects="+id,
	    		async: false,
	    		success: function(result){
	    			initList(params);
	    			Common.Util.showMessage("删除成功", "success");
	    		}
			});
			//document.forms[0].action = "delete.action?_selects="+$id;
			//document.forms[0].submit();
		//}
	}
	
	function selectUser4Qm(actionName, settings, roleid) {
		var url = contextPath + "/qm/questionnaire/selectUserByAll4Qm.jsp";
		var setValueOnSelect = true;
		if (settings.setValueOnSelect == false) {
			setValueOnSelect = settings.setValueOnSelect;
		}
		var title = "选择用户";
		
		OBPM.dialog.show({
					opener : window.top,
					width : 690,
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
	* 选择角色 for QM
	* 
	* @param {}
	*            actionName
	* @param {}
	*            settings
	*/
	function selectRole4Qm(actionName, settings, roleid) {
	var url = contextPath + "/qm/questionnaire/selectrolelist4Qm.jsp";
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
				console.info("result-->"+result);
				if(result.indexOf("|")>0){
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
						jQuery("#roleInput").val(roleNames);
						jQuery("#roleHidden").val(roleIds);
					}
				}
			}
		});
	}

	/**
	* 选择部门 for QM
	* 
	* @param {}
	*            actionName
	* @param {}
	*            settings
	*/
	function selectDept4Qm(actionName, settings, roleid) {
	var url = contextPath + "/qm/questionnaire/selectDeptByAll4Qm.jsp";
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
	

	//设置cookie值
	function setCookie(name,value){
	    var exp  = new Date();  
	    exp.setTime(exp.getTime() + 30*24*60*60*1000);
	    jQuery("input[name='_pagelines']").val(value);
	}
	
	function initList(params){
		var url = contextPath + "/qm/questionnaireservice/center.action";
		$.ajax({
    		url: contextPath + "/qm/questionnaireservice/center.action",
    		async: false,
    		data:params,
    		success: function(result){
    			if(params.type == "1"){
    				setJoinList(result);
    			}else{
    				setList(result);
    			}
    		}
		});
	}
	
	function setList(result){
		var $tbody = $("#pm-task-table-body2").html("");
		for(var i = 0;i < result.data.datas.length;i++){
			var creatorDeptName = result.data.datas[i].creatorDeptName;
			var status = result.data.datas[i].status;
			var creator = result.data.datas[i].creator;//创建人的id
			var creatorName = result.data.datas[i].creatorName;
			var avatar = Common.Util.getAvatar(creator);//获取创建人头像的url
			var _avatar;
			if(avatar!="" && avatar!=undefined){
				_avatar = "<img src ="+avatar+">";
			}else{
				_avatar = "<div class='noAvatar'>"+ creatorName.substr(creatorName.length-2, 2) +"</div>";
			}
			var dataStatus;
			switch(status){
				case 0:
					dataStatus = '<span class="label  label-status0 ">草稿</span>';	
				break;
				case 1:
					dataStatus = '<span class="label  label-status1 ">进行中</span>';	
				break;
				case 2:
					dataStatus = '<span class="label  label-status2 ">已完成</span>';
				break;
				default:
				break;
			}
			var _creatorDeptName = "";
			if(creatorDeptName != null){
				var _creatorDeptName = '<span class="deptment">['+result.data.datas[i].creatorDeptName+']</span>';
			}
			
			var $eachTr = '<tr class="row" data-id = "'+result.data.datas[i].id+'">'
			+ '<td class="project-status">'+dataStatus+'</td> '
			+ '<td class="project-title"><div class="project-title-flex"><div class="touxiang"><div class="touxiangDiv">'+_avatar +'</div></div><div class="each-detail"><div class="project_task_name"><a>'+result.data.datas[i].title+'</a></div><div style="line-height: 20px;margin-bottom: 10px;"><span class="executor">'+result.data.datas[i].creatorName+'</span>'+_creatorDeptName+'</div></div></div></td>'
			+ '<td class="project-completion" style="display:none;"><div class="progress-title"><span>2</span>份&nbsp;参与率<span>12%</span></div><div class="progress progress-mini"><div style="width: 0%;" class="progress-bar"></div></div></td>'
			+ '<td class="project-date"><span class="date">'+result.data.datas[i].createDate+'</span></td>'
			+ '<td class="project-handle"><div class="handle-div">';
			if(status == "0"){
				$eachTr += '<a class="publish" ><img src="../images/publish-icon.png"/>我要发布</a>'
							+'<a class="edit" href="javascript: document.forms[0].action=\''+contextPath+'/qm/questionnaire/edit.action?id='+result.data.datas[i].id+'\';document.forms[0].submit();"><img src="../images/edit-icon.png"/>编辑</a><a class="q_delete"><img src="../images/delete-icon.png"/>删除</a></div></td> </tr>';
			}else if(status == "1"){
				$eachTr += '<a class="edit" href="javascript: document.forms[0].action=\''+contextPath+'/qm/questionnaire/edit.action?id='+result.data.datas[i].id+'\';document.forms[0].submit();"><img src="../images/edit-icon.png"/>编辑</a><a style="display:none;"><img src="../images/copy-icon.png"/>复制</a><a class="doRecover" data-target="#qm_deleteRecover" ><img src="../images/recycle-icon.png"/>回收</a><a class="q_delete"><img src="../images/delete-icon.png"/>删除</a></div></td></tr>';
			}else{
				$eachTr += '<a class="edit" href="javascript: document.forms[0].action=\''+contextPath+'/qm/questionnaire/edit.action?id='+result.data.datas[i].id+'\';document.forms[0].submit();"><img src="../images/edit-icon.png"/>编辑</a><a class="reportForm" target="_blank"><img src="../images/result-icon.png"/>统计分析</a><a style="display:none;"><img src="../images/copy-icon.png"/>复制</a><a class="q_delete"><img src="../images/delete-icon.png"/>删除</a></div></td></tr>';
			}
			$tbody.append($eachTr);
		}
		bindEvent();
		pageNum(result);
		Common.Util.renderPagination();//分页
	}
	
	function setJoinList(result){
		var $tbody = $("#pm-task-table-body2").html("");
		for(var i = 0;i < result.data.datas.length;i++){
			var creatorDeptName = result.data.datas[i].creatorDeptName;
			var status = result.data.datas[i].fillStatus;
			var creator = result.data.datas[i].creator;//创建人的id
			var creatorName = result.data.datas[i].creatorName;
			var avatar = Common.Util.getAvatar(creator);//获取创建人头像的url
			var _avatar;
			if(avatar!="" && avatar!=undefined){
				_avatar = "<img src ="+avatar+">";
			}else{
				_avatar = "<div class='noAvatar'>"+ creatorName.substr(creatorName.length-2, 2) +"</div>";
			}
			var dataStatus;
			switch(status){
				case 1:
					dataStatus = '<span class="label  label-status1 ">进行中</span>';
				break;
				case 2:
					dataStatus = '<span class="label  label-status2 ">已完成</span>';
				break;
				default:
				break;
			}
			var _creatorDeptName = "";
			if(creatorDeptName != null){
				var _creatorDeptName = '<span class="deptment">['+result.data.datas[i].creatorDeptName+']</span>';
			}
			
			var $eachTr = '<tr class="row joinRow" data-id = "'+result.data.datas[i].id+'">'
			+ '<td class="project-status">'+dataStatus+'</td> '
			+ '<td class="project-title"><div class="project-title-flex"><div class="touxiang"><div class="touxiangDiv">'+_avatar +'</div></div><div class="each-detail"><div class="project_task_name"><a>'+result.data.datas[i].title+'</a></div><div style="line-height: 20px;margin-bottom: 10px;"><span class="executor">'+result.data.datas[i].creatorName+'</span>'+_creatorDeptName+'  </div></div></div></td>'
			+ '<td class="project-completion" style="display:none;"><div class="progress-title"><span>2</span>份&nbsp;参与率<span>12%</span></div><div class="progress progress-mini"><div style="width: 0%;" class="progress-bar"></div></div></td>'
			+ '<td class="project-date"><span class="date">'+result.data.datas[i].createDate+'</span></td>'
			+ '<td class="project-handle"><div class="handle-div">';
			if(status == "1"){
				$eachTr += '<a class="edit q_write" href="javascript: void(0)"><img src="../images/edit-icon.png"/>填写</a></div></td></tr>';
			}else{
				$eachTr += '<a class="showResult q_result"><img src="../images/result-icon.png"/>结果分析</a></div></td></tr>';
			}
			$tbody.append($eachTr);

		}
		bindEvent();
		pageNum(result);
		Common.Util.renderPagination();//分页
	}
	
	function bindEvent(){
		/*$("#pm-task-table-body2>.row").hover(function(){
			$(this).find(".project-completion>div").hide();
			$(this).find(".date").hide();
			$(this).find(".handle-div").show();
		},function(){
			$(this).find(".handle-div").hide();
			$(this).find(".date").show();
			$(this).find(".project-completion>div").show();
		});*/
		$("#formList").slimscroll({
			height:$(window).height()
		});
		$("#pm-task-table-body2").find(".row").click(function(){
			var $id = $(this).attr("data-id");
			document.forms[0].action= contextPath+'/qm/questionnaire/edit.action?id='+$id;
			document.forms[0].submit();
		});
		$("#pm-task-table-body2").find(".joinRow").unbind("click");
		$(".handle-div>a").click(function(event){
			event.stopPropagation();
		});
		$(".q_new").click(function() {
			document.forms[0].action = "new.action";
			document.forms[0].submit();
		});
		$(".q_delete").click(function() {
			var $id = $(this).parents(".row").attr("data-id");
        	$("#qm_delete").find("#dodeleteId").val($id);
        	Common.Util.showMask();
        	$("#qm_delete").show();
			
			
		});
		$(".publish").click(function() {
			var $id = $(this).parents(".row").attr("data-id");
			var ifname = true;
			var name = $(this).parents(".row").find(".project_task_name").text();
			if(name == ""){
				ifname = false;
				Common.Util.showMessage("问卷标题未设置", "warning");
			}
			if(ifname){
				doPubilsh($id)
			}
		});
		/*我参与的问卷的操作*/
		$(".q_write").click(function(){
			
			var $id = $(this).parents(".row").attr("data-id");
			document.forms[0].action = "../answer/new.action?id="+$id;
			document.forms[0].submit();
		});
		$(".showResult").click(function(){
			var $id = $(this).parents(".row").attr("data-id");
			document.forms[0].action = "../answer/view.action?id="+$id;
			document.forms[0].submit();
		});
		$(".reportForm").click(function(){
			var $id = $(this).parents(".row").attr("data-id");
			document.forms[0].action = "chartMain.jsp?id="+$id;
			document.forms[0].submit();
		});
		$(".doRecover").click(function(){//回收问卷
			Common.Util.showMask();
        	var target = $(this).attr("data-target");
        	var $id = $(this).parents(".row").attr("data-id");
        	$(target).find("#doRecoverId").val($id);
        	return $(target).show();
        
        });
		$(".close-popup,.btn-cancel").click(function() {//关闭弹出层的钮点击事件
            return Common.Util.hidePop();
        });
		
        
	}
	function pageNum(result){
		$("#pagination-panel").html("");
		var _datasPageCount = result.data.rowCount;
		var _datasPageItem = result.data.linesPerPage;
		//改变分页的当前页、当前显示条数、总条数这3个参数的值
		if($("input[name='_currpage']").val() == ""){
			$("input[name='_currpage']").val(1);
		}
		if($("input[name='_pagelines']").val() == ""){
			$("[name='_pagelines']").val(_datasPageItem);
		}
		//$("[name='_pagelines']").val(_datasPageItem); 	//显示条数
		$("[name='_rowcount']").val(_datasPageCount);	    //总条数
	}
	function turnPage(_currpage){
		var turn = true;
		var trTotal = $("#pm-task-table-body2>tr").length;
		if(_currpage != "1"){
			if(trTotal <= 1){
				turn = false;
			}
		}else{
			_currpage="";
		}
		return turn;
	}