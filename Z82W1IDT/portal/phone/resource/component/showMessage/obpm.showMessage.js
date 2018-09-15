(function($){
	OBPM.message = {
			
		defaultOptions : {
			swalOptions : {
				title: "",  
				text: "", 
				type: "warning",   
				showCancelButton: true, 
				confirmButtonColor: "#DD6B55",   
				confirmButtonText: "确定",  
				cancelButtonText: '取消',
				closeOnConfirm: true 
			},
			toastrOptions : {
				"closeButton": true,
				"debug": false,
				"progressBar": true,
				"positionClass": "toast-top-right",
				"onclick": null,
				"showDuration": "400",
				"hideDuration": "1000",
				"timeOut": "3000",
				"extendedTimeOut": "1000",
				"showEasing": "swing",
				"hideEasing": "linear",
				"showMethod": "fadeIn",
				"hideMethod": "fadeOut"
			}
		},
		
		//显示确认框
		showConfirm : function(msg1,msg2,callback){
			this.defaultOptions.swalOptions.title = msg1;
			this.defaultOptions.swalOptions.text = msg2;
			swal(this.defaultOptions.swalOptions,callback);
		},
		
		//显示成功通知框-success(绿色)
		showSuccess : function(content){
			toastr.options = this.defaultOptions.toastrOptions
			toastr["success"](content);
		},
		
		//显示一般信息通知框-info(蓝色)
		showInfo : function(content){
			toastr.options = this.defaultOptions.toastrOptions
			toastr["info"](content);
		},
		
		//显示警告通知框-warning(黄色)
		showWarning : function(content){
			toastr.options = this.defaultOptions.toastrOptions
			toastr["warning"](content);
		},
		
		//显示危险通知框-error(红色)
		showError : function(content){
			toastr.options = this.defaultOptions.toastrOptions
			toastr["error"](content);
		},
		
		//
		showDefault : function(option,content){
			toastr.options = $.extend({},this.defaultOptions.toastrOptions,option);
			toastr["defaults"](content);
		}
	};
	
	$.fn.obpmMessage = OBPM.message;
	/*
	$.fn.obpmConfirmField = function(option,callback){
		var _option = {
			title: "",  
			text: "", 
			type: "warning",   
			showCancelButton: true, 
			confirmButtonColor: "#DD6B55",   
			confirmButtonText: "确定",  
			cancelButtonText: '取消',
			closeOnConfirm: true 
		};
		option = $.extend({},_option,option);
		swal(option,callback);
	}*/
})(jQuery);