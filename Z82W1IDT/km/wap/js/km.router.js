KM.Router = {
	init : function (){
		Route.init({
	        //传输列表
	        'upload': function(){
	        	KM.Util.controlLoading("show");
	        	KM.Core.upload.init();
	        	KM.Util.controlLoading("hide");
	        },
	        //预览
	        'preview/:id': function(){
	            KM.Util.controlLoading("show");
	        	KM.Core.preview.init(arguments);
	        	KM.Util.controlLoading("hide");
	        },
	        //列表
	        'list/:path/:page': function(){
	        	KM.Util.controlLoading("show");
	        	KM.Config.pageArguments = arguments;
	        	KM.Core.refreshList();
	        	KM.Util.controlLoading("hide");
	        }
	    });
	}
}