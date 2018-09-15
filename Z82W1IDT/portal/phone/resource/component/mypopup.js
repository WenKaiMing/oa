;
(function($,window,document,undefined){
	var _mypopup = function(el,opts){
		this.defaults = {
			url:'',
			title:'',
			success:undefined
		};
		this.el = $(el);
		this.options = $.extends({},this.defaults,opt);
		
		return this;
	};
	
	_mypopup.pototype ={
			init:function(el,opts){
				
				return this;
			},
			
			open:function(opts){
				
			}
			
			
		
	},
	
	$.fn.mypopup = function(el,opts){
		var popup = new _mypopup(el,opts);
		return popup.init();
	}
	
})(JQuery,window,document);