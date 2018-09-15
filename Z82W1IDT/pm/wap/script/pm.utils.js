/**
 * PM工具类
 * <p>封装公共组件的调用方法</p>
 * @author Happy
 */
var Utils = {
		
	/**
	 * 跳转页面
	 * @param to 目标页面url或hash
	 * @param options 设置选项
	 */	
	showMask : function(){
		$(".mask").fadeIn();
	},
	//隐藏遮罩
	hideMask : function(){
		$(".mask").fadeOut();
	},
	//关闭弹出层
	hidePop: function() {
	    $(".popup").hide(),
	    $(".mask").fadeOut();
	},	
	changePage : function(pos) {
			    $("html,body").animate({scrollTop:pos});
			    },
			 
	//显示loading
	showLoading :function(){
		$.mobile.loading( 'show', {
			  text: "加载中...",
			  textVisible: true,
			  theme: "b",
			  textonly: false,
			  html: ""
			  });
	},
	//隐藏loading
	hideLoading :function(){
		$.mobile.loading( 'hide');
	},
		
    /**
	 * 显示消息提示
	 * @param msg
	 * 		消息内容
	 * @param type
	 * 		消息类型（'info','error'）
	 * @param hideAfter
	 * 		延时几秒后关闭消息窗体
	 */
	showMessage : function(msg, type,hideAfter) {
	},
	/**
	 * 打开用户选择框
	 */
	selectUser : function(settings){
		art.dialog.data("args",{
			// p1:当前窗口对象
			"parentObj" : window,
			// p2:存放userid的容器id
			container : settings.container,
			callback : settings.callback,
			selectMode : settings.selectMode
		});
		art.dialog.open("../../pm/selectUser.jsp",{width: '600px',height: '400px'});
	},
	
    resizeFourPart: function() {
    	//宽度
   	 var leftWidth = 140,
        wMarggin = 50,
        pWidth = $(window).width() - leftWidth - wMarggin,
        taskItemWidth = (pWidth - 22) / 2,
        taskNameWidth = taskItemWidth - 200;
        $(".table-view-cell").width(taskItemWidth).find(".text p").width(taskNameWidth);
    },
	//滑动删除
	deletebtn : function(){
    // 设定每一行的宽度=屏幕宽度+按钮宽度
    $(".line-scroll-wrapper").width($(".line-wrapper").width() + $(".line-btn-delete").width());
    // 设定常规信息区域宽度=屏幕宽度
    $(".line-scroll-wrapper").width($(".line-wrapper").width());
    // 设定文字部分宽度（为了实现文字过长时在末尾显示...）
//    $(".line-normal-msg").width($(".line-normal-wrapper").width() - 280);

    // 获取所有行，对每一行设置监听
    var lines = $(".line-scroll-wrapper");
    var len = lines.length; 
    var lastX, lastXForMobile;

    // 用于记录被按下的对象
    var pressedObj;

    // 用于记录按下的点
    var start;

    // 网页在移动端运行时的监听
    for (var i = 0; i < len; ++i) {
        lines[i].addEventListener('touchstart', function(e){
            lastXForMobile = e.changedTouches[0].pageX;
            pressedObj = this; // 记录被按下的对象 

            // 记录开始按下时的点
            var touches = event.touches[0];
            start = { 
                x: touches.pageX, // 横坐标
                y: touches.pageY  // 纵坐标
            };
        });

        lines[i].addEventListener('touchmove',function(e){
            // 计算划动过程中x和y的变化量
            var touches = event.touches[0];
            delta = {
                x: touches.pageX - start.x,
                y: touches.pageY - start.y
            };

            // 横向位移大于纵向位移，阻止纵向滚动
            if (Math.abs(delta.x) > Math.abs(delta.y)) {
                event.preventDefault();
            }
        });

        lines[i].addEventListener('touchend', function(e){
            var diffX = e.changedTouches[0].pageX - lastXForMobile;
            if (diffX < -150) {
                $(pressedObj).animate({marginLeft:"-100px"}, 500); // 左滑
            } else if (diffX > 150) {
                $(pressedObj).animate({marginLeft:"0"}, 500); // 右滑
            }
        });
    }

    // 网页在PC浏览器中运行时的监听
    for (var i = 0; i < len; ++i) {
        $(lines[i]).bind('mousedown', function(e){
            lastX = e.clientX;
            pressedObj = this; // 记录被按下的对象
        });

        $(lines[i]).bind('mouseup', function(e){
            var diffX = e.clientX - lastX;
            if (diffX < -150) {
                $(pressedObj).animate({marginLeft:"-100px"}, 500); // 左滑
            } else if (diffX > 150) {
                $(pressedObj).animate({marginLeft:"0"}, 500); // 右滑
            }
        });
    }
},

cache : {
	
},
	/**
	 * 获取用户头像图片url地址
	 * @param userId
	 */
	getAvatar:function(userId){
		if(!this.cache[userId]){
			$.ajax({
				type: "GET",
				url: "../../contacts/getAvatar.action",
				data: {"id":userId},
				async: false,
				dataType: "json",
				success:function(result){
					if(1==result.status){
						Utils.cache[userId] = result.data;
					}
				}
			});
		}
		
		return this.cache[userId];;
	},
	/**
	 * 内容为空
	 * @param 
	 */
	controlPlaceholder:function(active){
		if(active == "show"){
			$(".nullbox").css("display","block");
		}else{
			$(".nullbox").css("display","none");
		}
	}
};