/**
 * 微信 js API类库
 */
var WeixinApi = {
	
	_initialized : false,
	
	/**
	 * 初始化
	 */
	init : function() {
		this.bindEvent();
		this.config();
		
	},
	/**
	 * 绑定事件
	 */
	bindEvent : function() {
	},
	
	config : function(_url){
		showLoadingToast();
		_url = _url || location.href.split('#')[0];
		$.getJSON(contextPath+"/portal/weixin/jsapi/getJsapiConfig.action",{"_url":_url},function(result){
			if(result.status==1){
				wx.config({
				      debug: false,
				      appId: result.data.appId,
				      timestamp: result.data.timestamp,
				      nonceStr: result.data.nonceStr,
				      signature: result.data.signature,
				      jsApiList: [
				        'checkJsApi',
				        'onMenuShareTimeline',
				        'onMenuShareAppMessage',
				        'onMenuShareQQ',
				        'onMenuShareWeibo',
				        'hideMenuItems',
				        'showMenuItems',
				        'hideAllNonBaseMenuItem',
				        'showAllNonBaseMenuItem',
				        'translateVoice',
				        'startRecord',
				        'stopRecord',
				        'onRecordEnd',
				        'playVoice',
				        'pauseVoice',
				        'stopVoice',
				        'uploadVoice',
				        'downloadVoice',
				        'chooseImage',
				        'previewImage',
				        'uploadImage',
				        'downloadImage',
				        'getNetworkType',
				        'openLocation',
				        'getLocation',
				        'hideOptionMenu',
				        'showOptionMenu',
				        'closeWindow',
				        'scanQRCode',
				        'chooseWXPay',
				        'openProductSpecificView',
				        'addCard',
				        'chooseCard',
				        'openCard'
				      ]
				  });
				wx.ready(function () {
					//alert('weixin jsAPI ready!');
				});
				wx.error(function(res){
				    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
					//alert('error');
				});
			}
		});
	}
	
		
};

function weixinApiInit(){
	if(!WeixinApi._initialized){
		if(visit_from_weixin=="true"){
			WeixinApi.init();
			WeixinApi._initialized = true;
		}
	}
}
