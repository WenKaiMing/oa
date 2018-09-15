if(window.jQuery || window.Zepto){
	(function($){
		"use strict";

		var NAMESPACE = 'obpm.includedView';
		var EVENT_REFRESH = 'refresh.' + NAMESPACE;
		var EVENT_LOAD = 'load.' + NAMESPACE;
		var EVENT_LOADED = 'loaded.' + NAMESPACE;
		var EVENT_SHOW = 'show.' + NAMESPACE;
		var EVENT_SHOWN = 'shown.' + NAMESPACE;
		var EVENT_HIDE = 'hide.' + NAMESPACE;
		var EVENT_HIDDEN = 'hidden.' + NAMESPACE;

		var IncludedView = function(element, options){
			this.$body = $(document.body);
			this.$element = $(element);
			this.options = options;
	    };
	    
	    IncludedView.DEFAULTS = {};

	    //刷新
	    IncludedView.prototype.refresh = function(){
	    	var $this = this.$element;
	        $this.trigger(EVENT_REFRESH);  
	    };

	    //读取
	    IncludedView.prototype.load = function(){
	    	var $this = this.$element;
	        $this.trigger(EVENT_LOAD);
	        this.loaded();  
	    };

	    //读取后
	    IncludedView.prototype.loaded = function(){
	    	var $this = this.$element;
	        $this.trigger(EVENT_LOADED);
	    };

	    //显示
	    IncludedView.prototype.show = function(){
	    	var $this = this.$element;
	        $this.trigger(EVENT_SHOW);
	        this.shown();  
	    };

	    //显示后
	    IncludedView.prototype.shown = function(){
	    	var $this = this.$element;
	        $this.trigger(EVENT_SHOWN);
	    };

	    //隐藏
	    IncludedView.prototype.hide = function(){
	    	var $this = this.$element;  
	        $this.trigger(EVENT_HIDE);  
	        this.hidden(); 
	    };

	    //隐藏后
	    IncludedView.prototype.hidden = function(){
	    	var $this = this.$element;
	        $this.trigger(EVENT_HIDDEN);
	    };

	    function Plugin(option){
	        //return this.each(function(){
				var $this = $(this)
				// 判断是否初始化过的依据
				var data = $this.data('obpm.includedView');
			    var options = $.extend({}, IncludedView.DEFAULTS, $this.data(), typeof option == 'object' && option)
				// 如果没有初始化过, 就初始化它
				if (!data){
					$this.data('obpm.includedView', (data = new IncludedView(this,options)));
				} 

				if (typeof option == 'string'){
					data[option](this);
				}
				
	        //})
	    };

		//这里的 $.fn.IncludedView 有可能是之前已经有定义过的插件，在这里做无冲突处理使用。
	    var old = $.fn.includedView; 

	    //暴露类名, 可以自定义扩展
	    $.fn.includedView = Plugin;
	    $.fn.includedView.Constructor = IncludedView;

	    //无冲突处理
	    $.fn.includedView.noConflict = function(){
	        $.fn.includedView = old;
	        return this
	    };
	})(window.jQuery || window.Zepto);
}