(function($) {
	 
	var ALBUM = false;
	//微信拍照
	$("#takephoto").click(function(){
		PM.task.CreateTask();
		var oField = jQuery("#onlinePhoto")
		var _wx = top.wx ? top.wx : wx;
		 _wx.chooseImage({
			 count: 1, // 默认9
			 sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			 sourceType: ALBUM? ['album','camera']:['camera'],
		     success: function (res) {
		        var localIds = res.localIds;
		        setTimeout(function(){
		            _wx.uploadImage({
				        localId: localIds[0],
				        success: function (res) {
				          var serverId = res.serverId;
							// 本地上传方法
				          $.get(contextPath+"/portal/weixin/jsapi/PMupload.action",{"serverId":serverId,"taskid":$("#form-create-task-id").val()},function(result){
					          if(result.status==1){
							 	$("#tmplUpload").tmpl(result).appendTo(".list");
								$(".list").find(".up-list[name='"+result.data+"']").find("i").hide();
								$(".list").find(".up-list[name='"+result.data+"']").find("img").attr("src",localIds[0]).show();
					          }
					       });
				        },
				        fail: function (res) {
				          alert("网络异常，请再次尝试！");
				        }
				      });
		        }, 100)
		      }
		    });
	});
		
	/**
	 * 获取录音计时器
	 */
	function _getTimer(){
		var timer = $(".time-total").text();
		if(timer==0){
			timer = setInterval(function(){
						var tl = $(".time-total");
						tl.text(parseInt(tl.text())+1);
				},1000);
		}
		return timer;
	} 

})(jQuery);
//初始化webuploader
function webUploader(taskId){
	$list = $("#fileList"),
    // 优化retina, 在retina下这个值是2
    ratio = window.devicePixelRatio || 1,
    // 缩略图大小
    thumbnailWidth = 100 * ratio,
    thumbnailHeight = 100 * ratio,
	// 初始化Web Uploader
	uploader = uploader || WebUploader.create({
	    // 选完文件后，是否自动上传。
	    auto: true,
	    // swf文件路径
	    swf: 'webuploader/Uploader.swf',
	    // 文件接收服务端。
	    server: contextPath+"/pm/task/addAttach",
	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#filePicker',
	    // 只允许选择图片文件。
	    accept: {
	        title: 'Images',
	        extensions: 'gif,jpg,jpeg,bmp,png',
	        mimeTypes: 'image/*'
	    }
	}); 
	//当开始上传流程时触发
	uploader.on( 'startUpload', function() {
		PM.task.hideActionSheet($('#weui_actionsheet'), $('#mask'));
	});
	// 当有文件添加进来的时候
	uploader.on( 'fileQueued', function( file ) {
		var $uploadLi = $(
	            '<li id="' + file.id + '" class="task-attachment-li file-item thumbnail weui_uploader_status">' +
	                '<img width="64px;"/>' +
	                '<div class="weui_uploader_status_content"><i class="fa fa-spinner"></i></div>' +
	            '</li>'
	            ),
	        $img = $uploadLi.find('img');


	    // $list为容器jQuery实例
	    $list.append( $uploadLi );

	    // 创建缩略图
	    // 如果为非图片文件，可以不用调用此方法。
	    // thumbnailWidth x thumbnailHeight 为 100 x 100
	    uploader.makeThumb( file, function( error, src ) {
	        if ( error ) {
	            $img.replaceWith('<span>不能预览</span>');
	            return;
	        }

	        $img.attr( 'src', src );
	    }, thumbnailWidth, thumbnailHeight );
	});
	// 文件上传过程中创建进度条实时显示。
	/*uploader.on( 'uploadProgress', function( file, percentage ) {
	    var $uploadLi = $( '#'+file.id ),
	        $percent = $uploadLi.find('.progress span');

	    // 避免重复创建
	    if ( !$percent.length ) {
	        $percent = $('<p class="progress"><span></span></p>')
	                .appendTo( $uploadLi )
	                .find('span');
	    }

	    $percent.css( 'width', percentage * 100 + '%' );
	});*/
	// 文件上传成功，给item添加成功class, 用样式标记上传成功。
	uploader.on( 'uploadBeforeSend', function(object,data,headers) {
		data["taskid"] = PM.cache.currentEditTaskId;
	});
	// 文件上传成功，给item添加成功class, 用样式标记上传成功。
	uploader.on( 'uploadSuccess', function(file,data) {
		var attachmentVal = "";
		$( '#'+file.id ).attr("_id",data.id);
		$( '#'+file.id ).attr("_url","../../"+data.url.replace(new RegExp("\\\\","g"),"/"));
		$( '#'+file.id ).addClass("task-attachment-pic");
		
		if(location.hash=="#/tpl_task-create"){
 			attachmentVal = $("#form-create-task-attachment").val();
 		}else{
 			attachmentVal = $("#form-edit-task-attachment").val();
 		}
 		
 		if(attachmentVal!=""){
 			var attachmentJson = JSON.parse(attachmentVal);
 		}else{
 			var attachmentJson = {};
 		}
 		
 		
 		attachmentJson[data.id] = {"id": data.id,"name":data.name,"url":data.path,"size":data.size,"isCompress":data.isCompress == "true"?true:false};
 		if(location.hash=="#/tpl_task-create"){
 			$("#form-create-task-attachment").val(JSON.stringify(attachmentJson));
 		}else{
 			$("#form-edit-task-attachment").val(JSON.stringify(attachmentJson));
 		}
		//upload_exist_init(taskId);
		$( '#'+file.id ).addClass('upload-state-done');//上传成功的标志
	});

	// 文件上传失败，显示上传出错。
	uploader.on( 'uploadError', function( file ) {
	    var $uploadLi = $( '#'+file.id ),
	        $error = $uploadLi.find('div.error');

	    // 避免重复创建
	    if ( !$error.length ) {
	        $error = $('<div class="error"></div>').appendTo( $li );
	    }

	    $error.text('上传失败');
	});
	// 完成上传完了，成功或者失败，先删除进度条/loadding。
	uploader.on( 'uploadComplete', function( file ) {
	    //$( '#'+file.id ).find('.progress').remove();
		$( '#'+file.id ).removeClass("weui_uploader_status");//删除loadding遮罩
		$( '#'+file.id ).find(".weui_uploader_status_content").remove();//删除loadding
	});
}


//初始化已经上传的附件
function upload_exist_init(taskId){
	var taskId = $("#form-create-task-id").val();
	if(location.hash=="#/tpl_task-edit"){
		taskId = $("#form-edit-task-id").val();
	}
	var params = {};
	params.id = taskId;
	$.getJSON("../task/view.action",params,function(result){
		var data = eval( '(' + result.data.attachment + ')' );
		var keys = leng(data);
		var contents="";
		
		for(;keys.length>=1;){
			var key = keys.pop();
			var time = data[key].time
			if(time==undefined){
				contents= contents+"<p class='upload_exist_p' data-id="+key+"><div class='icoifile'></div><a class='upload_name_a' title='下载'>"+data[key].name+"</a></p>";
			}
		}
		$('#fileNames').html(contents);
		
		$('.upload_exist_p').on("click",".upload_delete_a",function(){
			var TaskId = $('#pm-task-name').attr("data-id");
			var key = $(this).parent().attr("data-id");
			
			params = {};
			params.id = taskId;
			params.key = key;
			$.getJSON("../task/deleteAttachment.action",params,function(result){
				upload_exist_init(TaskId);
			});
		});
		$('.upload_exist_p').on("click",".upload_name_a",function(){
			var TaskId = $('#pm-task-name').attr("data-id");
			var id = $(this).parent().attr("data-id");
			var params = {};
			params.taskid = taskId;
			params.id = id;
				var url = "../task/download.action?taskid="+taskId+"&id="+id ;
				window.open(url) ;
		});
		
	});
}

function upload_exist_initEdit(task){
		if(location.hash=="#task-create"){
			var $taskDiv = $(".task-create");
		}else{
			var $taskDiv = $(".task-edit");
		}
		
		var data = eval( '(' + task.attachment + ')' );
		var keys = leng(data);
		var contents="";
		for(;keys.length>=1;){
			var key = keys.pop();
			var time = data[key].time
			if(time==undefined){
				var name = data[key].name;
				if(name.indexOf(".jpg")>0){
					contents += '<img style="height:32px;width:32px;margin-left: 6px;margin-top:10px" src="'+contextPath+'/uploads/photo/'+name+'">';
				}else{
					contents= contents+"<p class='upload_exist_p' data-id="+key+"><div class='icoifile'></div><a class='upload_name_a' title='下载'>"+data[key].name+"</a></p>";
				}
			}else{
	        	 var path = data[key].name.replace(".amr",".mp3");
				 var vioceItem = $('<audio><source src='+contextPath+'/uploads/voice/'+path+' type="audio/mpeg" /></audio>');
				// $("#taskEdit-Record").css('display',"inline-block");
				 $("#playVoice-edit").append(vioceItem);
				 setTimeout(function(){
					var myAudio = $taskDiv.find("#sound-play-box").find("audio")[0];
					if(isNaN(myAudio.duration)){
						setTimeout(function(){
							if(!isNaN(myAudio.duration)){
								$taskDiv.find("#sound-play-box").find(".pm-edit-Record-time").text(parseInt(myAudio.duration));
							}
						},2000);
					}else{
						$taskDiv.find("#sound-play-box").find(".pm-edit-Record-time").text(parseInt(myAudio.duration));
					}
					
					$taskDiv.find("#sound-play-box").find("#playVoice-edit").click(function(e){
						 myAudio.play();
						 $taskDiv.find(".sound-play-ico").css({"visibility":"hidden","-webkit-animation":"sound-play-ico 1000ms steps(1) infinite","background-postion-x":"0px 0px"})
						 $(myAudio).on("ended",function(){
							 $taskDiv.find(".sound-play-ico").css({"visibility":"visible","-webkit-animation":"initial","background-postion-x":"-48px 0px"});
						 });
					});
				 },500);
				 
			}
		}
		$('#fileEdit').html(contents);
		
		$('.upload_exist_p').on("click",".upload_name_a",function(){
			var TaskId = $('#pm-task-name').attr("data-id");
			var id = $(this).parent().attr("data-id");
			var params = {};
			params.taskid = taskId;
			params.id = id;
				var url = "../task/download.action?taskid="+taskId+"&id="+id ;
				window.open(url) ;
		});
		
}


function leng(data){
	var jsonLength = 0;
	var a = [];
	for(var item in data){
		a.push(item);
	}
	return a;
}