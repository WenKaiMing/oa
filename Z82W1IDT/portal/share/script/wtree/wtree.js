;
/**
 * wtree，针对手机浏览器的树形插件
 * @author Happy
 * @param $
 */
(function($){
	//防止多次引入，提升性能
	if($.fn.wtree){
		return;
	}
	
	/**
	 * 控件初始化
	 */
	function _init(t){
		var state = t.data("wtree");
		var options = state.options;
		t.addClass("wtree-deptlist");
		var tree = $('<ul></ul>');
		if(typeof options.data=="string"){
			_render_ajax(tree,options);
		}
		tree.appendTo(t);
		return tree;
	}
	
	function _render_ajax(tree,options){
		$.ajax({
			url:options.data,
			type:'GET',
			async:false,
			data:{},
			dataType:'json',
			success :function(result){
			if(1==result.status){
				var root = [];
				var item = result.data[0];
				root.push('<li class="wtree-dept" data-isload="false" data-level="1" data-name="'+item.name+'" data-id="'+item.id+'"><div class="wtree-deptlist-box wtree-deptlist-title"><span class="wtree-adron"><i class="wtree-arrow"></i></span>');
				//root.push(options.checkbox? '<input type="checkbox" class="deptlist-input" />':'');
				root.push('<span class="wtree-name">');
				root.push(item.name);
				root.push('</span></div>');
				root.push("</li>");
				$(root.join('')).appendTo(tree);
			} 
		}});
		
	}
	
	
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
		var state = t.data("wtree");
		state.tree.on("click",".wtree-adron",function(e){
			var $node = $(this).parent().parent();
			var isload = $node.data("isload");
			var level = $node.data("level");
			if(!isload){
				var url = state.options.data;
				if(url.indexOf("?")==-1){
					url+="?parentId="+$node.data("id");
				}else{
					url+="&parentId="+$node.data("id");
				}
				$.ajax({
					url:url,
					type:'GET',
					async:true,
					data:{},
					dataType:'json',
					success :function(result){
					if(1==result.status){
						var node = [];
						node.push('<ul>');
						$.each(result.data,function(i,item){
							node.push('<li class="wtree-dept" data-isload="false" data-level="'+(level+1)+'" data-name="'+item.name+'" data-id="'+item.id+'"><div class="wtree-deptlist-box wtree-deptlist-title"><span class="wtree-adron" style="padding-left:'+(20*level)+'px;"><i class="wtree-arrow"></i></span>');
							if(state.options.checkbox){
								var ischecked = false;
								for(var i=0;i<state.options.checkedNodes.length;i++){
									if(state.options.checkedNodes[i]==item.id){
										ischecked = true;
										break;
									}
									
								}
								node.push('<input type="checkbox" class="wtree-deptlist-input wtree-checkbox" '+(ischecked? 'checked="checked"' : '')+' />');
							}
							node.push('<span class="wtree-name wtree-node-name">');
							node.push(item.name);
							node.push('</span></div>');
							node.push("</li>");
						});
						node.push('</ul>');
						
						$(node.join('')).appendTo($node);
						$node.data("isload","true");
						
						//$node.toggleClass("open");
						//$(">ul",$node).toggle();
					} 
				}});
			}else{
				$node.toggleClass("open");
				$(">ul",$node).toggle();
			}
			e.preventDefault();
			e.stopPropagation();
		});
		
		state.tree.on("click",".wtree-node-name",function(e){
			if(state.options.checkbox){//含复选框模式
				var c = $(this).prev();
				var li = c.parent().parent();
				if(c.prop("checked")){
					c.prop("checked", false);
					t.trigger("unchecked.wtree",{
						name:li.data("name"),
						id:li.data("id")
					});
				}else{
					c.prop("checked", true);
					t.trigger("checked.wtree",{
						name:li.data("name"),
						id:li.data("id")
					});
				}
			}
			
			e.preventDefault();
			e.stopPropagation();
		});
		/*
		t.on("click.wtree",function(e,data){
			alert('click.wtree');
		});*/
		
	}
	
	function _getSelected(t){
		var nodes = [];
		t.find("input:checked").each(function(i){
			var li = $(this).parent().parent();
			nodes.push({
				name:li.data("name"),
				id:li.data("id")
			});
			
		});
		return nodes;
	}
	
	$.fn.wtree = function(options, param){
		
		if(typeof options=="string"){
			return $.fn.wtree.method[options](this,param);
		}
		options = options || {};
		return this.each(function(){
			var t = $(this);
			var state = t.data("wtree");
			if(state){
				$.extend(state.options,options);
			}else{
				state = t.data('wtree', {
					options: $.extend({}, $.fn.wtree.defaults,options),
					tree: undefined
				});
				var tree =_init(t);
				t.data('wtree', {
					options: $.extend({}, $.fn.wtree.defaults,options),
					tree: tree
				});
				_bindEvents(t);
			}
		});
	},
	
	$.fn.wtree.defaults = {
			multiple : true,
			checkbox : true,
			checkedNodes :[],
			data:false
	},
	
	$.fn.wtree.method= {
		/**
		 * 加载数据
		 * @param jq
		 * @param data
		 */	
		load:function(jq,data){
			jq.each(function(){
				_load($(this),data);
			});
		},
		/**
		 * 刷新树
		 * @param jq
		 */
		refresh:function(jq){
			jq.each(function(){
				_refresh($(this));
			});
		},
		/**
		 * 刷新树
		 * @param jq
		 */
		getSelected:function(jq){
			return _getSelected($(jq));
		}
		
	}
	
})(jQuery);
