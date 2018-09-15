/**
 * 用户选择框
 * @author Happy
 */
var UserSelect = {
	
	_initialized : false,
	//成功回调函数
	_successCallback: undefined,
	//取消事件回调函数
	_cancelCallback : undefined,
	//初始化已选用户
	_initUsers : [],
	//是否为单选模式
	_singleSelect : false,
	
	/**
	 * 初始化
	 */
	init : function() {
		this.bindEvent();
		
		//初始化用户选择框相关属性和参数
		var args = art.dialog.data("args");
		if(args){
			this._successCallback = args["success"];
			this._cancelCallback = args["cancel"];
			if(args["initUsers"]){
				this._initUsers = args["initUsers"];
			}
			if(args["singleSelect"]){
				this._singleSelect = true;
			}
		}
		if(this._singleSelect){
			document.getElementById("addAll").style.display = "none";
		}
		art.dialog.data("UserSelect",this);
		
		//
		this.getDeptTree();
		this.getOnlineUsers();
		this.getFavoriteContacts();
	},
	/**
	 * 绑定事件
	 */
	bindEvent : function() {
		/**
		 * 联系人单选|复选框单击事件
		 */
		$("#rightcontent_userlist,#online-users,#search-list").on("click",".user_item",function(e){
			var $this = $(this);
			
			if(UserSelect._singleSelect){
				$(".onSelect").remove();
				UserSelect.cache.selectedUsers ="";
			}
			
			if($this.is(':checked')){
				var flag = false;
				$(".onSelect").each(function(){
					if($(this).data("id")==$this.data("id")){		
						flag = true;
					}
				});
				
				if(flag) return;
				
				var sHtml = [];
				sHtml.push('<div class="onSelect" ');
				sHtml.push('data-id="');sHtml.push($this.data("id"));sHtml.push('" ');
				sHtml.push('data-name="');sHtml.push($this.data("name"));sHtml.push('" ');
				sHtml.push('data-email="');sHtml.push($this.data("email"));sHtml.push('" ');
				sHtml.push('data-mobile="');sHtml.push($this.data("mobile"));sHtml.push('" ');
				sHtml.push('data-loginno="');sHtml.push($this.data("loginno"));sHtml.push('" ');
				sHtml.push('data-deptid="');sHtml.push($this.data("deptid"));sHtml.push('" ');
				sHtml.push('data-domainid="');sHtml.push($this.data("domainid"));sHtml.push('" ');
				sHtml.push('><img src="');sHtml.push($this.data("avatar"));
				sHtml.push('" />');sHtml.push($this.data("name"));
				sHtml.push('</div>');
				$("#selectedUserDiv").append(sHtml.join(''));
				UserSelect.cache.selectedUsers+=$this.data("id");
			}else{
				$(".onSelect").each(function(){
					if($(this).data("id")==$this.data("id")){		
						$(this).remove();
						UserSelect.cache.selectedUsers = UserSelect.cache.selectedUsers.replace($(this).data("id"),"");
					}
				});	
			}
		});
		/**
		 * 移除所有按钮单击事件
		 */
		$("#deleteAll").on("click",function(e){
			$(".onSelect").remove();
			UserSelect.cache.selectedUsers ="";
		});
		
		/**
		 * 查询按钮点击事件
		 */
		$("#btn-search").on("click",function(e){
			var value = $("#sm_name").val();
			if(value){
				UserSelect.searchUsers(value);
			}
		});
		
		/**
		 * 上一页按钮单击事件
		 */
		$("#rightcontent_userlist").on("click","#dept-users-next-btn",function(e){
			UserSelect.getUserListByDept(UserSelect.cache.domainid,UserSelect.cache.deptid,$(this).data("currpage")+1);
		});
		/**
		 * 下一页按钮单击事件
		 */
		$("#rightcontent_userlist").on("click","#dept-users-Pre-btn",function(e){
			UserSelect.getUserListByDept(UserSelect.cache.domainid,UserSelect.cache.deptid,$(this).data("currpage")-1);
		});
		
	},
	
	/**
	 * 用户选择框 确定
	 * @returns {Boolean}
	 */
	success : function(){
		var users = [];
		$(".onSelect").each(function(){
			var $this = $(this);
			var user = {};
			user.id = $this.data("id");
			user.name = $this.data("name");
			user.loginNo = $this.data("loginno");
			user.avatar = $this.data("avatar");
			user.deptId = $this.data("deptid");
			user.domainId = $this.data("domainid");
			
			users.push(user);
		});
		
		if(this._successCallback && typeof this._successCallback == "function"){
			this._successCallback(users);
		}
		 //art.dialog.close();//关闭弹出框
		return true;
		
	},
	
	/**
	clear : function(){
		if(this._cleanCallback && typeof this._cleanCallback == "function"){
			this._cleanCallback();
		}
	},
	**/
	/**
	 * 用户选择框取消事件
	 */
	cancel: function(){
		if(this._cancelCallback && typeof this._cancelCallback == "function"){
			this._cancelCallback();
		}
		return true;
	},
	
	
	
	/*初始化部门树*/
	 getDeptTree : function() {  
		//jQuery("#lefthead").html("{*[Department]*}{*[List]*}:");
		depttree = jQuery("#leftcontent").jstree({ 
			core:{
				initially_open: ['root']
			}, 
			"json_data" : {
				"ajax" : { 
					"url" : function (){
						return contextPath + "/portal/department/departTree.action?domain="+domainid+"&datetime=" + new Date().getTime();
					},
					"data" : function (node) { 
						var params = {};
						if (node.attr) {
							params['parentid'] = node.attr("id"); // 上级部门ID
							params['data'] = node.attr("data");
						}
						return params;
					}
				}
			},
			"plugins" : [ "themes", "json_data","lang", "ui",]
		}).bind("select_node.jstree", function(e, data){
			var node = data.rslt.obj;
			if (node && node.attr) {
				if(node.attr("id")!=""){
					var deptid=node.attr("id");
					var deptname=node.attr("name");
					UserSelect.getUserListByDept(domainid,deptid);
				}
			}
		});
	},
	
	
	/*用户点击部门节点返回该部门下的用户*/
	 getUserListByDept : function(domainid,deptid,currpage){
		if(domainid!="" && deptid!=""){
			this.cache.deptid = deptid;
			this.cache.domainid = domainid;
			currpage = currpage || 1;
			$.ajax({
					url:contextPath+"/portal/component/user/listByDept.action",
					type:"post",
					datatype:"json",
					data:{"domain":domainid,"departid":deptid,"_currpage":currpage},
					success:function(result){
						if(result.status==1){
							var users = result.data.datas;
							$("#rightcontent_userlist").html("");
							for (var i = 0; i < users.length; i++) {
								var sHtml = [];
								sHtml.push('<div class="list_div"><input name="user_item" class="list_div_click user_item" ');
								sHtml.push(UserSelect._singleSelect? 'type="radio" ':'type="checkbox" ');
								sHtml.push(UserSelect.cache.selectedUsers.indexOf(users[i].id)>=0? ' checked="checked" ':'');
								sHtml.push('data-id="');sHtml.push(users[i].id);sHtml.push('" ');
								sHtml.push('data-name="');sHtml.push(users[i].name);sHtml.push('" ');
								sHtml.push('data-email="');sHtml.push(users[i].email);sHtml.push('" ');
								sHtml.push('data-mobile="');sHtml.push(users[i].mobile);sHtml.push('" ');
								sHtml.push('data-avatar="');sHtml.push(users[i].avatar? users[i].avatar : 'images/t002.png');sHtml.push('" ');
								sHtml.push('data-loginno="');sHtml.push(users[i].loginNo);sHtml.push('" ');
								sHtml.push('data-deptid="');sHtml.push(users[i].deptId);sHtml.push('" ');
								sHtml.push('data-domainid="');sHtml.push(users[i].domainId);sHtml.push('" ');
								sHtml.push('><img src="');sHtml.push(users[i].avatar? users[i].avatar : 'images/t002.png');
								sHtml.push('" />');sHtml.push(users[i].name);
								sHtml.push('</div>');
								$("#rightcontent_userlist").append($(sHtml.join('')));
							}
							var nav = [];
							nav.push("<nav><span class=\"page\">共"+result.data.pageCount+"页</span>");
							nav.push('<ul class="pagination pagination-sm"><li');
							nav.push(result.data.pageNo-1>0? '':' class="disabled"');
							nav.push('><a id="dept-users-Pre-btn" data-currpage="'+result.data.pageNo+'" href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>');
							nav.push('<li class="active"><a href="#">'+result.data.pageNo+'</a></li>');
							nav.push('<li');
							nav.push(result.data.pageNo+1<=result.data.pageCount? '':' class="disabled"');
							nav.push('><a id="dept-users-next-btn" data-currpage="'+result.data.pageNo+'" href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li></ul></nav>');
							
							$("#rightcontent_userlist").append(nav.join(""));
							
						}else{
						}
						},
					error:function(data,status){
							//alert("failling to visited...");
						}
			});	
		}
	},
	
	getOnlineUsers : function(){
		$.ajax({
			url:contextPath+"/portal/component/user/onlineUsers.action",
			type:"post",
			datatype:"json",
			data:{"domain":domainid},
			success:function(result){
				if(result.status==1){
					var users = result.data.datas;
					$("#online-users").html("");
					for (var i = 0; i < users.length; i++) {
						var sHtml = [];
						sHtml.push('<div class="list_div"><input name="user_item" class="list_div_click user_item" ');
						sHtml.push(UserSelect._singleSelect? 'type="radio" ':'type="checkbox" ');
						sHtml.push(UserSelect.cache.selectedUsers.indexOf(users[i].id)>=0? ' checked="checked" ':'');
						sHtml.push('data-id="');sHtml.push(users[i].id);sHtml.push('" ');
						sHtml.push('data-name="');sHtml.push(users[i].name);sHtml.push('" ');
						sHtml.push('data-email="');sHtml.push(users[i].email);sHtml.push('" ');
						sHtml.push('data-mobile="');sHtml.push(users[i].mobile);sHtml.push('" ');
						sHtml.push('data-avatar="');sHtml.push(users[i].avatar? users[i].avatar : 'images/t002.png');sHtml.push('" ');
						sHtml.push('data-loginno="');sHtml.push(users[i].loginNo);sHtml.push('" ');
						sHtml.push('data-deptid="');sHtml.push(users[i].deptId);sHtml.push('" ');
						sHtml.push('data-domainid="');sHtml.push(users[i].domainId);sHtml.push('" ');
						sHtml.push('><img src="');sHtml.push(users[i].avatar? users[i].avatar : 'images/t002.png');
						sHtml.push(' " class="face" />');sHtml.push(users[i].name);
						sHtml.push('</div>');
						$("#online-users").append($(sHtml.join('')));
					}
					$("#online-user-count").text(result.data.rowCount);
				}else{
				}
				},
			error:function(data,status){
					//alert("failling to visited...");
				}
		});	
	},
	
	searchUsers:function(value){
		$.ajax({
			url:contextPath+"/portal/component/user/searchUsers.action",
			type:"post",
			datatype:"json",
			data:{"domain":domainid,"sm_name":value},
			success:function(result){
				if(result.status==1){
					var users = result.data.datas;
					$("#search-list").html("");
					for (var i = 0; i < users.length; i++) {
						var sHtml = [];
						sHtml.push('<div class="list_div"><input name="user_item" class="list_div_click user_item" ');
						sHtml.push(UserSelect._singleSelect? 'type="radio" ':'type="checkbox" ');
						sHtml.push(UserSelect.cache.selectedUsers.indexOf(users[i].id)>=0? ' checked="checked" ':'');
						sHtml.push('data-id="');sHtml.push(users[i].id);sHtml.push('" ');
						sHtml.push('data-name="');sHtml.push(users[i].name);sHtml.push('" ');
						sHtml.push('data-email="');sHtml.push(users[i].email);sHtml.push('" ');
						sHtml.push('data-mobile="');sHtml.push(users[i].mobile);sHtml.push('" ');
						sHtml.push('data-avatar="');sHtml.push(users[i].avatar? users[i].avatar : 'images/t002.png');sHtml.push('" ');
						sHtml.push('data-loginno="');sHtml.push(users[i].loginNo);sHtml.push('" ');
						sHtml.push('data-deptid="');sHtml.push(users[i].deptId);sHtml.push('" ');
						sHtml.push('data-domainid="');sHtml.push(users[i].domainId);sHtml.push('" ');
						sHtml.push('><img src="');sHtml.push(users[i].avatar? users[i].avatar : 'images/t002.png');
						sHtml.push(' " class="face" />');sHtml.push(users[i].name);
						sHtml.push('</div>');
						$("#search-list").append($(sHtml.join('')));
					}
				}else{
				}
				},
			error:function(data,status){
					//alert("failling to visited...");
				}
		});	
	},
	
	getFavoriteContacts : function(){
		$.ajax({
			url:contextPath+"/portal/component/user/favoriteContacts.action",
			type:"get",
			datatype:"json",
			data:{},
			success:function(result){
				if(result.status==1){
					var users = result.data;
					$("#favoriteContacts").html("");
					for (var i = 0; i < users.length; i++) {
						var sHtml = [];
						sHtml.push('<div class="list_div"><input name="user_item" class="list_div_click user_item" ');
						sHtml.push(UserSelect._singleSelect? 'type="radio" ':'type="checkbox" ');
						sHtml.push(UserSelect.cache.selectedUsers.indexOf(users[i].id)>=0? ' checked="checked" ':'');
						sHtml.push('data-id="');sHtml.push(users[i].id);sHtml.push('" ');
						sHtml.push('data-name="');sHtml.push(users[i].name);sHtml.push('" ');
						sHtml.push('data-email="');sHtml.push(users[i].email);sHtml.push('" ');
						sHtml.push('data-mobile="');sHtml.push(users[i].mobile);sHtml.push('" ');
						sHtml.push('data-avatar="');sHtml.push(users[i].avatar? users[i].avatar : 'images/t002.png');sHtml.push('" ');
						sHtml.push('data-loginno="');sHtml.push(users[i].loginNo);sHtml.push('" ');
						sHtml.push('data-deptid="');sHtml.push(users[i].deptId);sHtml.push('" ');
						sHtml.push('data-domainid="');sHtml.push(users[i].domainId);sHtml.push('" ');
						sHtml.push('><img src="');sHtml.push(users[i].avatar? users[i].avatar : 'images/t002.png');
						sHtml.push(' " class="face" />');sHtml.push(users[i].name);
						sHtml.push('</div>');
						$("#favoriteContacts").append($(sHtml.join('')));
					}
				}else{
				}
				},
			error:function(data,status){
					//alert("failling to visited...");
				}
		});	
	},
	
	cache :{
		deptid:null,
		domainid:null,
		selectedUsers:""
	}
		
};

if(!UserSelect._initialized){
	
	$(document).ready(function(){
		UserSelect.init();
		UserSelect._initialized = true;
	});
	
}
