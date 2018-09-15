var Application = {
	/**
	 * 初始化
	 */
	init : function() {
		this.bindEvent();
	},
	/**
	 * 绑定事件
	 */
	bindEvent : function() {
		$(".app-item-add").on("click",function(e){
			$("#modal-iframe").attr("src",contextPath+"/saas/weioa/app/candidateList.action");
			$("#applist-modal").modal({
			});
		});
		$("#modal-btn-save").on("click",function(e){
			$.ajax({
				   type: "POST",
				   url: contextPath+"/saas/weioa/app/addApp.action",
				   data: $(window.frames[0].document.forms[0]).serialize(),
				   success: function(result){
				     $("#user-edit-modal").modal('hide');
				     location.reload();
				     //location=location 
				   },
				   error : function(r,s,e){
				   }
				});
		});
		$("#modal-btn-close").on("click",function(e){
			$(window.frames['modal-iframe'].document.body).html("");
			$("#user-edit-modal").modal('hide');
		});
		$(".btn-remove-app").on("click",function(e){
			if(!window.confirm("删除应用将清空此应用下的角色授权数据，是否确定删除？")) return;
			var id = $(this).data("id");
			$.ajax({
				   type: "POST",
				   url: contextPath+"/saas/weioa/app/removeApp.action?id="+id,
				   data: $(window.frames[0].document.forms[0]).serialize(),
				   success: function(result){
				     location.reload();
				     //location=location 
				   },
				   error : function(r,s,e){
				   }
				});
		});
	},
	
};

