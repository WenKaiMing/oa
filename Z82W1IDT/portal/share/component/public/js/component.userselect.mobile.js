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
		this._successCallback = Components.cache.get("success");
		this._singleSelect = Components.cache.get("singleSelect");
		//
		
		//渲染页面
		this.randerContactsList();
	},
	/**
	 * 绑定事件
	 */
	bindEvent : function() {
		//单击部门名称展开|折叠下级
		$("#contacts-list-deptlist").on("click",".dept",function(e){
			e.preventDefault();
			e.stopPropagation();
			$(this).toggleClass("open");
			$(">ul",$(this)).toggle();
		});
		//单击联系人
		$("#contacts-list-deptlist,#favorite-contacts-listview,#all-contacts-listview").on("click",".user-item",function(e){
			var $this=$(this);
			
			var user = {};
			user.id = $this.data("id");
			user.name = $this.data("name");
			user.deptId = $this.data("deptid");
			user.deptname = $this.data("deptname");
			user.email = $this.data("email");
			user.mobile = $this.data("mobile");
			user.loginNo = $this.data("loginno");
			user.domainId =  $this.data("domainid");
			user.avatar =  $this.data("avatar");
			if(UserSelect._singleSelect){
				$("#selected-list").html($("#tmpl-selected-list-item").tmpl(user));
			}else{//多选模式下
				if(UserSelect.cache.selectedUsers.indexOf(user.id)==-1){
					$("#tmpl-selected-list-item").tmpl(user).appendTo("#selected-list");
					UserSelect.cache.selectedUsers+=user.id;
					$this.find("input[name='contact']").attr("checked",'true');
				}else{
					$(".selected-item").each(function(){
						if($(this).data("id")==user.id){		
							$(this).remove();
							UserSelect.cache.selectedUsers = UserSelect.cache.selectedUsers.replace(user.id,"");
							$this.find("input[name='contact']").attr("checked",false);
						}
					});	
				}
				
			}
			e.preventDefault();
			e.stopPropagation();
		});
		
		$("#btn-search").on("click",function(e){
			UserSelect.randerContactsList($("input[name='sm_name']").val());
		});
		
		$("#btn-success").on("click",function(e){
			UserSelect.success();
			
		});
		$("#btn-cancel").on("click",function(e){
			UserSelect.cancel();
			
		});
	},
	
	/**
	 * 用户选择框 确定
	 * @returns {Boolean}
	 */
	success : function(){
		var users = [];
		$(".selected-item").each(function(){
			var $this = $(this);
			var user = {};
			user.id = $this.data("id");
			user.name = $this.data("name");
			user.email = $this.data("email");
			user.mobile = $this.data("mobile");
			user.loginNo = $this.data("loginno");
			user.avatar = $this.data("avatar");
			user.deptId = $this.data("deptid");
			user.deptName = $this.data("deptname");
			user.domainId = $this.data("domainid");
			
			users.push(user);
		});
		if(this._successCallback && typeof this._successCallback == "function"){
			this._successCallback(users);
		}
		$("#userselect_iframe").attr("src","");
		//window.history.go(-1);
		return true;
		
	},
	/**
	 * 用户选择框取消事件
	 */
	cancel: function(){
		
		if(this._cancelCallback && typeof this._cancelCallback == "function"){
			this._cancelCallback();
			$("#userselect_iframe").attr("src","");
		}
		return true;
	},
	/** 
	 * 渲染部门列表
	 */
	randerContactsList :function(sm_name){
		$.getJSON("/obpm/portal/component/user/getUsersTree.action",{"sm_name":sm_name?sm_name:""},function(result){
			if(1==result.status){
				var html = [];
				html.push('<ul>');
				$.each(result.data,function(i,item){
					html.push(UserSelect.buildDeptHTML(item));
				});
				html.push('</ul>');
				//alert(html.join(""));
				$("#contacts-list-deptlist").html(html.join(""));
			}else{
			}
		});
		
		/**
		 * 全部用户
		 */
		$.getJSON("/obpm/portal/component/user/getAllUsers.action",{"sm_name":sm_name?sm_name:""},function(result){
			if(1==result.status){
				$("#all-contacts-listview").html("");
				$.each(result.data,function(i,item){
					if(!item.avatar){
						item.avatar = "images/head.png";
					}
					if(UserSelect._singleSelect){
						$("#tmpl-contacts-listview-item").tmpl(item).appendTo("#all-contacts-listview");
					}else{
						$("#tmpl-contacts-listview-item-with-checkbox").tmpl(item).appendTo("#all-contacts-listview");
					}
				});
			}else{
			}
		});
		
		/**
		 * 加载常用联系人
		 */
		$.getJSON("/obpm/portal/component/user/favoriteContacts.action",{"sm_name":sm_name?sm_name:""},function(result){
			if(1==result.status){
				$("#favorite-contacts-listview").html("");
				$.each(result.data,function(i,item){
					if(!item.avatar){
						item.avatar = "images/head.png";
					}
					if(UserSelect._singleSelect){
						$("#tmpl-contacts-listview-item").tmpl(item).appendTo("#favorite-contacts-listview");
					}else{
						$("#tmpl-contacts-listview-item-with-checkbox").tmpl(item).appendTo("#favorite-contacts-listview");
					}
					
				});
			}else{
			}
		});
		
		
	},
	/**
	 * 构建联系人部门树HTML结构
	 * @param item
	 * @returns
	 */
	buildDeptHTML:function(item){
		var html = [];
		html.push('<li class="dept"><div class="deptlist-box deptlist-title"><span class="adron"></span>');
		//html.push(UserSelect._singleSelect? '':'<input type="checkbox" class="deptlist-input" />');
		html.push('<span class="name">');
		html.push(item.name);
		html.push('</span></div>');
		
		if(item.children.length>0){
			html.push('<ul>');
			$.each(item.children,function(i,item){
				if(item.type==1){
					html.push('<li class="user-item"');
					html.push(' data-id="'+item.id+'"');
					html.push(' data-name="'+item.name+'"');
					html.push(' data-deptname="'+item.dept+'"');
					html.push(' data-deptid="'+item.deptId+'"');
					html.push(' data-loginno="'+item.loginNo+'"');
					html.push(' data-domainid="'+item.domainId+'"');
					html.push(' data-mobile="');
					html.push(item.mobile? item.mobile:'');
					html.push('"');
					html.push(' data-email="');
					html.push(item.email? item.email:'');
					html.push('"');
					html.push(' data-avatar="');
					html.push(item.avatar? item.avatar:'images/head.png');
					html.push('"');
					html.push(' >');
					html.push('<div class="deptlist-box">');
					html.push(UserSelect._singleSelect? '':'<input type="checkbox" class="deptlist-input"  name="contact" />');
					html.push('<a class="user">');
					html.push('<div class="head">');
					html.push('<div><img src="');
					html.push(item.avatar? item.avatar:'images/head.png');
					html.push('" /></div>');
					html.push('</div>');
					html.push('<span class="name">');
					html.push(item.name);
					html.push('</span></a></div></li>');
					if(!item.avatar){
						item.avatar = "images/head.png";
					}
				}else if(item.type==2){
					html.push(UserSelect.buildDeptHTML(item));
				}
			});
			html.push('</ul>');
		}
		html.push("</li>");
		return html.join("");
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
