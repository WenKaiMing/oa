var WeixinTrial = {
	
		init : function(){
			
			this.bindEvent();
		},
		
		bindEvent : function(){
			$("#btn-register").on("click",function(e){
				var name = $("input[name='name']").val();
				var tel = $("input[name='telephone']").val();
				if(name.length==0){
					WeixinTrial.showMessage("姓名不能为空！","error");
					return;
				}
				if(tel.length==0){
					WeixinTrial.showMessage("手机号码不能为空！","error");
					return;
				}
				$.getJSON("register.action",$("#form-register").serialize(),function(result){
					if(1==result.status){
						var message = result.message;
						WeixinTrial.showMessage(message,"info");
						$("#page-register").hide();
						$("#page-qrcode").show();
					}else{
						WeixinTrial.showMessage(result.message,"error");
					}
				});
			});
		},
		
		showMessage : function(message,type){
			if(type=="info"){
				$("#msgbox").html('<div class="alert alert-success" style="text-align: center;" role="alert">'+message+'</div>');
			}else{
				$("#msgbox").html('<div class="alert alert-danger"  style="text-align: center;" role="alert">'+message+'</div>');
			}
		}
};