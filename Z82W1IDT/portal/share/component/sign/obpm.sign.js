;
/**
 * web在线签章控件
 * @author Happy
 * @param $
 */
(function($){
	
	
	$.fn.Isignature = function(options, param){
		if (typeof options == 'string'){
			var method = $.fn.Isignature.methods[options];
			if (method){
				return method(this, param);
			}
		}
		
		options = options || {};
		return this.each(function(){
			var state = $.data(this, 'Isignature');
			if (state){
				$.extend(state.options, options);
			} else {
				$.data(this, 'Isignature', {
					options: $.extend({}, $.fn.Isignature.defaults, $.fn.Isignature.parseOptions(this), options)
				});
				_init(this);
			}
		});
	};
	
	$.fn.Isignature.methods = {
		
		sign: function(target){
			return target.each(function(){
				_sign(this);
			});
		},
		remove: function(target){
			return target.each(function(){
				_remove(this);
			});
		}
	};
	
	$.fn.Isignature.parseOptions = function(target){
		return parseOptions(target);
	};
	
	$.fn.Isignature.defaults = {
			actType: 46,
			actId:''
	};
	/**
	**印章对象
	**/
	function Sign(opts) {
	    var options = $.extend({
	    	id:'',
	    	userId:'',
	        img: '',
	        width: 120,
	        height: 120,
	        left: 12,
	        top: 12,
	        offset: 12, //边界值
	        parent:undefined,
	        isNew:true
	    }, opts || {});

	    var _parent = $(options.parent);
	    var range = {
	        minX: options.offset,
	        minY: options.offset,
	        maxX: _parent.width() - options.width - options.offset - 18,      //扣去2个padding=8px以及2个边框1px
	        maxY: _parent.height() - options.height - options.offset - 18
	    };

	    
	    var sign = $("<div class='sign' data-userid='"+options.userid+"' data-img='"+options.img+"' data-width='"+options.width+"' data-height='"+options.height+"' data-offset='"+options.offset+"' style='height:" + options.height + "px;width:" + options.width + "px;top:" + options.top + "px;left:" + options.left + "px'><img src='" +contextPath+options.img + "' draggable='false'/></div>").appendTo(_parent);
		//绑定移动事件

		sign.data("options",options);

		if(!options.isNew) {
			sign.addClass('ok');
			return sign;
		}

		sign.append("<a class='btn ok' >确 定</a><a class='btn del' >取 消</a>");

	    sign.on('mousedown', function (e) {
	        sign.data('x', e.clientX);
	        sign.data('y', e.clientY);
	        var position = sign.position();
	        $(document).on('mousemove', function (e1) {
	            var x = e1.clientX - sign.data('x') + position.left;
	            var y = e1.clientY - sign.data('y') + position.top;
	            x = x < range.minX ? range.minX : x;
	            x = x > range.maxX ? range.maxX : x;
	            y = y < range.minY ? range.minY : y;
	            y = y > range.maxY ? range.maxY : y;

	            sign.css({ left: x, top: y });
	        }).on('mouseup', function () {
	            $(this).off('mousemove').off('mouseup');
	        });
	    });

		//确定盖章
	    $('.ok', sign).click(function () {
	        var _signs = $("input[name='content.sign']").val()? JSON.parse($("input[name='content.sign']").val()) : [];
	        var item = {
	        	id:options.id,
	        	userId:options.userId,
	        	img:options.img,
	        	left:sign.position().left,
	        	top:sign.position().top
	        };
	        _signs.push(item);
	        $("input[name='content.sign']").val(JSON.stringify(_signs));
	        options.left = item.left;
	        options.top = item.top;
	        sign.addClass('ok').off('mousedown').find('.btn').remove();
	        Activity._LOCK = false;
	        Activity.doExecute(options.actId,46);
            
	   
	    });
	    $('.del', sign).click(function () {
	        //取消盖章
	        sign.remove();
	    });

	 	sign.data("options",options);
	    return sign;

	};



	/**
	 * 初始化
	 */
	function _init(target){
		var state = $.data(target, 'Isignature');
		var opts = state.options;

		//1.渲染签章工具栏
		$(target).addClass("isignature");
		var toolPanel = "<div class='toolPanel' data-act-id='"+opts.actId+"' style='display:none;'>"
						+"<a class='cancel_btn'><img src='../../share/component/sign/close.png'/></a>"
						+"<div class='sign-group' ><a class='btn btn-primary manager_btn' >印章管理</a><select id='sign_select' style='width:250px;'><option value=''>请选择一个印章</option></select><a class='btn btn-success sign_btn' >盖 章</a></div>"
						+"</div>"
		var toolPanel = $(toolPanel).appendTo(target);
		_refreshSignOptions();
		//单击签章
		$('.sign_btn', toolPanel).click(function () {
			var id = $("#sign_select").val();//印章id
			if(id.length==0){
				alert("签章前请先选中一个印章！");
				return;
			}
			var pw = prompt("请输入密码","");
			if(pw.length==0){
				alert("密码不能为空！");
				return;
			}
			$.ajax({
				   type: "POST",
				   url: contextPath+"/portal/user/findSign.action",
				   data: {id:id,pw:pw},
				   dataType:"json",
				   async:false,
				   success: function(result){
					   if(result.status==1){
						   var opts = {actId:toolPanel.data("actId"),userId:WebUser.id,img:"/uploads/signs/"+result.data.img,parent:target,isNew:true}
					       var _sign = new Sign(opts);
						   Activity._LOCK = true;
						}else{
							alert(result.message);
						}
				   }
				});
	    });
		//单击印章管理
		$('.manager_btn', toolPanel).click(function(){
			var _url = contextPath+"/portal/share/component/sign/manager.jsp";
			var _path = "../H5/resource/component/artDialog";
			OBPM.dialog.show({
				opener: window,
				width: 720,
				height: 500,
				url: _url,
				icon:"icons_3",
				path: _path,
				title: "印章管理",
				close: function(rtn) {
					_refreshSignOptions();
				}
			});
		});	
		
	    $('.cancel_btn', toolPanel).click(function () {
	        toolPanel.hide();
	    });

		//2.渲染签章控件
		var _signs = $("input[name='content.sign']").val()? JSON.parse($("input[name='content.sign']").val()) : [];
		for (var i = 0; i < _signs.length; i++) {
			var _sign = _signs[i];
			var opts = $.extend({
		        width: 120,
		        height: 120,
		        offset: 12, //边界值
		        parent:target,
		        isNew:false
		    	}, _sign || {});
			new Sign(opts);
		}
	}
	/**
	 * 刷新印章选项
	 */
	function _refreshSignOptions(){
		$.ajax({
			   type: "POST",
			   url: contextPath+"/portal/user/getSigns.action",
			   data: {},
			   dataType:"json",
			   async:true,
			   success: function(result){
				   if(result.status==1){
					   var $select = $("#sign_select");
					   $select.find("option").remove();
					   $("<option value=''>请选择一个印章</option>").appendTo($select);
					   var signs = result.data;
					   for(var i=0;i<signs.length;i++){
						   var sign = signs[i];
						   $("<option value='"+sign.id+"'>"+sign.name+"</option>").appendTo($select);
					   }
					}else{
						alert(result.message);
					}
			   }
			});
	}
	
	/**
	 * 执行签章操作
	 */
	function sign(target){
		var state = $.data(target, 'Isignature');
		var opts = state.options;
		//TODO
		alert('call open method');
		if(opts.onOpen){
			opts.onOpen.apply(this,arguments);
		}
	}
	/**
	 * 解析属性
	 */
	function parseOptions(target){
		var t = $(target);
		return {
			
		};
	}
	
})(jQuery);