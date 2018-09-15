Contacts.User = {
	init : function(){
		this.setConfig();
		this.setLayout();
		this.bindEvent();
	},
	/**
	 * 数据配置
	 */
	setConfig : function(){
		var args = top.OBPM.dialog.getArgs();
		// 默认值
		var defValue=args['defValue'];
		var multiple = args['multiple'];
		/*选择模式*/
		if(typeof args['multiple'] != "undefined"){
			Contacts.config.multiple = args['multiple'];
		}

		if(typeof args['toChooseUsers'] != "undefined"){
			Contacts.config.toChooseUsers = args['toChooseUsers'];
		}
		//回选已选择用户
		if(typeof args['selecteds'] != "undefined"){
			Contacts.config.selecteds = args['selecteds'];
		}
		/***/
		var tabs = args['tabs'];
		var showTab = Contacts.config.showTab;
		for(var i in showTab){	//重置为false
			showTab[i] = false;
		}
		
		if(tabs){
			Contacts.config.tabs = tabs;
			//计算tab数量
			var tabLength = 0;
			for(var i in tabs){
				tabLength++;
				showTab[i] = true;
			}
			showTab["tabLength"] = tabLength;
		}
	},
	/**
	 * 布局设置
	 */
	setLayout : function(){
		$("#contacts-select-panel").show();
	},
	/**
	 * 刷新显示的统计数据
	 */
	refreshCount : function(){
		var count = Object.getOwnPropertyNames(Contacts.config.selecteds).length;
		$("#contacts-select-panel .count").html("(" + count + ")");
	},
	/**
	 * 增加或删除变量中已选择的用户
	 * @param $t--$checkbox
	 */
	addOrDelSelected : function($t){
		var data = $t.data();
		if($t.is(":checked")){
			if(!Contacts.config.multiple){
				Contacts.config.selecteds = {};
			}
			Contacts.config.selecteds[data.id] = data;
		}else{
			delete Contacts.config.selecteds[data.id];
		}
	},
	/**
	 * 显示已选择用户
	 * 
	 */
	showSelecteds : function(){
		var selects = Contacts.config.selecteds;
		var data = {
				list : []
		}
		for(var o in selects){
			data.list.push(selects[o]);
		}
		var winHeight = $(window).height();
    	var searchHeight = Contacts.config.showSearchbar == false ? 0 : 44;
    	var navBarHeight = $(".contacts-main").find(".weui_navbar").css("display") == "none" ? 0 : 70;
    	var selectHeight = $("#contacts-select-panel").outerHeight();
		if(data.list.length > 0){
			$(".contacts-main").find(".contacts-search-show").height(winHeight-searchHeight-navBarHeight-127); 
		}else{
			$(".contacts-main").find(".contacts-search-show").height(winHeight-searchHeight-navBarHeight-59); 
		}
		$("#contacts-select-list").html(template('atp-contacts-select-item', data));
	},
	/**
	 * 设置已选择数据
	 * @param $t--$checkbox
	 */
	setSelecteds : function($t){
		if($t.attr("name") == "all"){
			var val = $t.prop("checked");
			var $selects = $("#contacts").find("[name=_select]").prop("checked", val);
			
			$selects.each(function(){
				Contacts.User.addOrDelSelected($(this));
			});
		}else if($t.hasClass("select-item")){
			Contacts.User.addOrDelSelected($t);
			$t.remove();
		}else{
			Contacts.User.addOrDelSelected($t);
		}
		this.refreshCount();
		this.showSelecteds();
	},
	/**
	 * 加载用户数据后回选已选择的用户
	 */
	checkSelectedUsers : function(){
		if(Contacts.config.select){
			var selects = Contacts.config.selecteds;
			for(var o in selects){
				$("#contacts").find("[name=_select][data-id='" + o + "']").prop("checked", true);
			}
			this.refreshCount();
			this.showSelecteds();
		}
	},
	/**
	 * 事件绑定
	 */
	bindEvent : function(){
		//操作面板事件
		$("#contacts-select-panel").on("click", "#doReturn", function(){	//确定
			var array = new Array();
			var selects = Contacts.config.selecteds;
			for(var o in selects){
				var rtn = {};
				rtn.value = selects[o].id;
				rtn.text = selects[o].name;
				rtn.dept = selects[o].dept;
				rtn.mobile = selects[o].mobile;
				rtn.mobile2 = selects[o].mobile2;
				rtn.email = selects[o].email;
//				rtn.emailAccount = selects[o].emailAccount;
				rtn.avatar = selects[o].avatar;	//用户头像
				
				rtn.id = selects[o].id;
				rtn.name = selects[o].name;
				
				array.push(rtn);
			}
			var result = {
					data : array,
					state : "success"
			};
			top.OBPM.dialog.doReturn(result);
		}).on("click", "#deleteAll", function(){	//清空
			$("input[name=_select]:checked, input[name=all]:checked").attr("checked", false);
			Contacts.config.selecteds = {};
			Contacts.User.refreshCount();
			Contacts.User.showSelecteds();
		}).on('click', '.select-item', function () {	//点击显示的已选用户
			
			var $this = $(this);
        	var id = $this.data("id");
			var $check = $("#contacts").find("#item-"+id);
			$check.prop("checked",false);
			Contacts.User.setSelecteds($this);
			return false;
		});
		
		var $contacts = $("#contacts");
		//选中 移除选中 操作
		$contacts.on('change', 'input.weui_check', function () {
			var $contacts = $("#contacts");
        	var $selectPanel = $("#contacts-select-panel");
        	var $searchShowPanel = $contacts.find(".contacts-search-show");
        	var $this = $(this);
        	var $label = $this.parents("label.weui_check_label");
        	var id = $label.data("id");
        	var name = $label.data("name");
        	var avatar = $label.data("avatar");
        	var searchShowH = $searchShowPanel.height();
			
        	Contacts.User.setSelecteds($this);
		});
	}
};