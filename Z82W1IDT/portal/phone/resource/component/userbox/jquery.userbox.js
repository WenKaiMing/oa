/**
 * userbox 
 * 
 * Copyright 2016 Teemlink
 * Vsrsion 0.1
 * 
 */
(function($){
	/**
	 * 初始化,构建用户选择组件DOM
	 */
	function _createBox(target){
		var $t = $(target);
		var state = $t.data('userbox');
		var opts = state.options;
		
		if(!opts.disabled){
			//清除
			if(opts.clearBtn){
				opts.clearBtn.bind("click",function(){
					_clear(target);
				});
			}
			
			//打开
			if(opts.selectBtn){
				opts.selectBtn.bind("click",function(){
					_open(target);
				});
			}
		}
	}
	
	/**
	 * 打开用户选择面板（完整模式下可用）
	 */
	function _open(target){
		var $t = $(target);
		
		var state = $t.data('userbox');
		var opts = state.options;
		
		var oApp = document.getElementsByName("application")[0];
		var url = "";
		if(opts.isPhone){
			url = contextPath + "/contacts/index.jsp?mode=select";
		}else{
			url = contextPath + "/portal/phone/resource/component/dialog/selectUserByAll.jsp?application="+oApp.value;
		}
		var inputValueId = opts.id;
		var inputTextId = opts.textId;
		var selecteds = getUserSelected(opts.separator, inputValueId, inputTextId);	//获取已选用户的json结构
		
		var args = {
				// p1:当前窗口对象
				"parentObj" : window,
				// p4:默认选中值, 格式为[userid1,userid2]
				"defValue": opts.defValue,
				//选择用户数
				"limitSum": opts.limitSum,
				//选择模式
				"multiple" : opts.multiple,
				// 存放userEmail的容器id
				"receiverEmail" : opts.showUserEmail,
				// 存放userEmail的容器id
				"receiverEmailAccount" : opts.showUserEmailAccount,
				// 存放userTelephone的容器id
				"receiverTelephone" : opts.showUserTelephone,
				//{id:{}};回选已选择的用户
				selecteds : selecteds,
				//[]待选择的静态用户数据
				toChooseUsers : opts.toChooseUsers,
				// [] 配置显示的tab，全部、部门、职务、常用
				tabs : opts.tabs
			};
		
		OBPM.dialog.show({
					width : 610,
					height : 450,
					url : url,
					args : args,
					title : title_uf,
					close : function(result) {
						if(result){
							if(result.state == "success"){
								_success(target, result);
							}else {
								_close(target);
							}
						}
					}
				});
		if(opts.onOpen){
			if(typeof opts.onOpen == "function"){
				opts.onOpen.apply(this,arguments);
			}else{
				eval(opts.onOpen);
			}
			
		}
	}
	/**
	 * 关闭用户选择面板（完整模式下可用）
	 */
	function _close(target){
		var state = $(target).data('userbox');
		var opts = state.options;
		if(opts.onClose){
			if(typeof opts.onClose == "function"){
				opts.onClose.apply(this,arguments);
			}else{
				eval(opts.onClose);
			}
		}
	}

	/**
	 * 成功完成选择，关闭用户选择面板（完整模式下可用）
	 */
	function _success(target, result){
		var $t = $(target).data('userbox');
		var opts = $t.options;

		var rtnValue = "";
		var rtnText = "";
		if(result){
			var data = result.data;
			if(data && data.length>0){
				for(var i = 0; i < data.length; i++){
					rtnValue += data[i].value + opts.separator;
				}

				for(var i = 0; i < data.length; i++){
					rtnText += data[i].text + opts.separator;
				}
			}
			rtnValue = rtnValue.substring(0,rtnValue.length-1);
			rtnText = rtnText.substring(0,rtnText.length-1);
		}
		if (opts.onSuccess) {
			if(typeof opts.onSuccess == "function"){
				opts.onSuccess(result, rtnValue, rtnText);
			}else{//用户选择框控件
				eval(opts.onSuccess);
			}
		}
	}
	/**
	 * 选中用户
	 */
	function _select(target,user){
		var state = $(target).data('userbox');
		var opts = state.options;
		//TODO
		
		if(opts.onSelect){
			opts.onSelect.apply(this,arguments);
		}
	}
	/**
	 * 取消选中用户
	 */
	function _unSelect(target,user){
		var state = $(target).data('userbox');
		var opts = state.options;
		//TODO
		
		if(opts.onUnSelect){
			opts.onUnSelect.apply(this,arguments);
		}
	}
	
	/**
	 * 设置已选用户
	 */
	function _setSelects(target,users){
		var state = $(target).data('userbox');
		var opts = state.options;
		//TODO
		alert('call setSelects method');
	}
	/**
	 * 获取已选中用户集合
	 */
	function _getSelects(target){
		var state = $(target).data('userbox');
		var opts = state.options;
		//TODO
		alert('call getSelects method');
		return [];
	}
	/**
	 * 清空已选中用户
	 */
	function _clear(target){
		var $t = $(target);
		var state = $t.data('userbox');
		var opts = state.options;
		
		if(opts.onClear){
			if(typeof opts.onClear == "function"){
				opts.onClear.apply(this,arguments);
			}else{
				eval(opts.onClear);
			}
			
		}
	}
	/**
	 * 获取已选用户的json结构
	 *
	 * @param {string} separator 返回值的拼接符号
	 * @param {string} inputValueId 存放已选择用户id的容器id
	 * @param {string} inputTextId 存放已选择用户name的容器id
	 * @return {Object} 返回已选用户的json
	 */
	function getUserSelected(separator, inputValueId, inputTextId){
		var _selectedsOjb = {};
		var selectedValue = $("#"+inputValueId).val();
		var selectedText = $("#"+inputTextId).attr("result") ? $("#"+inputTextId).attr("result") : $("#"+inputTextId).val();
		if(selectedValue != "" && selectedText != ""){
			selectedValue = selectedValue.split(separator);
			selectedText = selectedText.split(separator);
			for(var i=0;i<selectedValue.length;i++){
				var name = selectedText[i];
				var avatar = Common.Util.getAvatar(selectedValue[i]);
				var id = selectedValue[i];
				var obj = {
						'id' : id,
						'name' : name,
						'dept' : '',
						'mobile' : '',
						'mobile2' : '',
						'email' : '',
						'avatar' : avatar
				}
				_selectedsOjb[id] = obj;
			}
		}
		return _selectedsOjb;
	}
	/**
	 * 解析属性
	 */
	function parseOptions(target){
		var t = $(target);
		return {
			multiple: (t.attr('multiple') ? (t.attr('multiple') == 'true' || t.attr('multiple') == true) : undefined),
			mode: (t.attr('mode') || undefined),
			options: (t.attr('options') || undefined),
			tabs: (t.attr('tabs') || undefined),
			width: (t.attr('width') || undefined),
			disabled: (t.attr('disabled') ? true : undefined),
			required: (t.attr('required') ? (t.attr('required') == 'true' || t.attr('required') == true) : undefined),
			separator: (t.attr('separator') || undefined),
		};
	}
	$.fn.userbox = function(options, param){
		if (typeof options == 'string'){
			var method = $.fn.userbox.methods[options];
			if (method){
				return method(this, param);
			}
		}
		
		options = options || {};
		return this.each(function(){
			var state = $(this).data('userbox');
			if (state){
				$.extend(state.options, options);
			} else {
				var _options = options;
				if(!options.tabs){	//未传值时使用合并参数
					_options = $.extend({}, $.fn.userbox.defaults, $.fn.userbox.parseOptions(this), options);
				}
				$(this).data('userbox', {
					options: _options
				});
			}
			_createBox(this);
		});
	};
	
	$.fn.userbox.methods = {
		
		open: function(target){
			return target.each(function(){
				_open(this);
			});
		},
		close: function(target){
			return target.each(function(){
				_close(this);
			});
		},
		setSelects: function(target, value){
			return target.each(function(){
				_setSelects(this, value);
			});
		},
		getSelects: function(target){
			return _getSelects(target[0]);
		},
		clear: function(target){
			return target.each(function(){
				_clear(this);
			});
		},
	};
	
	$.fn.userbox.parseOptions = function(target){
		return parseOptions(target);
	};
	
	$.fn.userbox.defaults = {
			id:"",//必须，存放回选的用户value值的input的id
			textId:"",//必须，存放回选的用户text值的input的id
			multiple: false,//是否多选模式
			mode: 'all',//simple:精简模式|all:完整模式
			tabs: {		// [] 配置显示的tab，全部、部门、职务、常用
				all : {name:'全部',url: 'getAllUser.action'},
				dept : {name:'部门',url: 'getContactsTree.action'},
			    role : {name:'角色',url: 'getApplicationAndRoleContactsTree.action'},
			    favorite : {name:'常用',url: 'getFavoriteContacts.action'}
			},
			width: 'auto',//宽度
			disabled: false,//是否禁用
			required: false,//是否必填
			separator: ';',//多选模式下的分隔符
			selectUser : [],
			toChooseUsers : [],	//待选择的静态用户数据，结构：[{avatar : "",	dept : "行政部2",email : "",	id : "",mobile : "",mobile2 : "",name : "邢儿",type : 1},{...}]
			
			onSelect: undefined,
			onUnSelect: undefined,
			onSuccess: undefined,
			onOpen: undefined,
			onClose: undefined,
			onClear: undefined
	};
})(jQuery);
