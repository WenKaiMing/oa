
function file_upload_init() {  
	var TaskId = $('#pm-task-name').attr("data-id");
	if(TaskId == undefined){
		TaskId = PM.cache.currentEditTaskId
	}
	if(PM.cache.openType == PM.TaskOpenType._edit){
		upload_exist_init(TaskId);
	}
	$('#file_upload').uploadify({
		'formData'     : {
		'TaskId'   : TaskId
					},
		'swf' : './js/uploadify/uploadify.swf',  
	    'uploader' : contextPath+'/pm/task/addAttach',  
	    'buttonText':'添加附件',
	    'buttonClass': 'newStyle',
	    'width':'40px',
	    'removeCompleted':true,
		'multi'    :true,
	    
	    //选择文件后自动上传
        'auto': true,
        'onUploadSuccess' : function(file,data,response){
        	if(PM.cache.openType == PM.TaskOpenType._new){
        		create_upload_exist_init(data);
        		
        	}else{	//打开面板，openType状态1,编辑;
        		upload_exist_init(TaskId);
        	}
			
			return;
	    }
	});
	
	//点击粘贴截图
	$("#pasteImg").bind("click", function(){
		var $p = $("#attach_block").find(".pasteP");
		if($p.size() == 0){
			
			$p = $("<p contenteditable='true' class='pasteP upload_exist_p'><a class='upload_name_a upload_name_a_img' title='粘贴截图'></a>&nbsp;&nbsp;</p>");
			
			$del = $("<a class='upload_delete_a' title='删除'>X</a>");
			$del.bind("click", function(){	//删除粘贴截图的方框
				$(this).parent().remove();
			}).appendTo($p);
			
			$("#attach_block").prepend($p);
		}
		$p.focus();
	});

	//粘贴图片时自动上传
	$("#attach_block").on("paste", function(e){
		
		if(e.originalEvent && e.originalEvent.clipboardData){
			var url = contextPath + '/pm/task/addAttach';
			
			var clipboard = e.originalEvent.clipboardData;
			for(var i=0,len=clipboard.items.length; i<len; i++) {
		        if(clipboard.items[i].kind == 'file' || clipboard.items[i].type.indexOf('image') > -1) {

		            var imageFile = clipboard.items[i].getAsFile();
		            var form = new FormData;
		            form.append('t', 'ajax-uploadpic');
		            form.append('avatar', imageFile, "11.png");
		            form.append('TaskId', TaskId);

		            $.ajax({
		                url : url,
		                type: "POST",
		                data: form,
		                processData: false,
		                contentType: false,
		                beforeSend: function() {
		                },
		                error: function() {
		                },
		                success: function(file,data,response){
		                	if(PM.cache.openType == PM.TaskOpenType._new){
		                		create_upload_exist_init(file);
		                		
		                	}else{
		                		upload_exist_init(TaskId);
		                	}
		        			return;
		        	    }
		            })
		            e.preventDefault();
		        }
		    }
		}
		
	});
}

//初始化已经上传的附件
function upload_exist_init(TaskId){
	
	var params = {};
	params.id = TaskId;
	$.getJSON("task/view.action",params,function(result){
		if(result.data.attachment && result.data.attachment != ""){
			var data = eval( '(' + result.data.attachment + ')' );
			var keys = leng(data);
			var contents="";//存放图片
			var contentsOther="";//存放非图片
			while(keys.length > 0){
				var key = keys.shift();
				var size = '';	//判断上传的图片是否有大小，图片的title显示图片名和图片大小
				if(typeof(data[key].size) != "undefined"){
					var size = ' , '+ bytesToSize(data[key].size);
				}
				var isPicture =  data[key].name.substring(data[key].name.lastIndexOf('.') + 1);
				var url = data[key].url;
				var isCompress = data[key].isCompress;
				switch(isPicture){//判断如果是图片就获取图片的路径并显示出来
					case "png":
					case "jpg":
					case "jpeg":
					case "gif":
						var _original = contextPath + url +"/" + key + "." + isPicture;
						if(isCompress == true || isCompress == "true" ){
							var _url = contextPath + url +"/" +"Compress_"+key + "." + isPicture;
						}else if(isCompress == false || isCompress == "false" ){
							var _url = contextPath + url +"/" + key + "." + isPicture;
						}else if(isCompress == undefined){ //兼容旧数据
							var _url = contextPath + "/task/" + params.id + "/" + key + "." + isPicture;
						}
						contents= contents+"<li class='upload_exist_p' data-id="+key+"><a class='upload_name_a upload_name_a_img' title='"+data[key].name+size+"' _filename='"+data[key].name+"'><img url='"+_original+"' src="+_url+"></a>&nbsp;&nbsp;<a class='upload_delete_a' title='删除'>x</a></li>";
						break;
					default:
					    var imgCss = isPicture?isPicture:"other";
						contentsOther= contentsOther+"<p class='btn upload_exist_p' data-id="+key+">"+
										"<a class='pic other "+imgCss+"'></a>"+
										"<a class='upload_name_a' title='"+data[key].name+size+"' _filename='"+data[key].name+"' _url = '"+url+"'>"+data[key].name+"</a>&nbsp;&nbsp;"+
										"<a class='upload_delete_a del' title='删除'>x</a>"+
									  "</p>";
						break;	
				}
			}
			$('#attach_block_other').html(contentsOther);
			$('#attach_block').html(contents);
			
			$("#attach_block[data-view='viewer']").viewer('destroy').viewer({
				"url":"url"
			});
			
			$('.upload_exist_p').on("click",".upload_delete_a",function(){
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					if(confirm("确认删除附件吗？")){
						var TaskId = $('#pm-task-name').attr("data-id");
						var key = $(this).parent().attr("data-id");
						
						params = {};
						params.id = TaskId;
						params.key = key;
						$.getJSON("task/deleteAttachment.action",params,function(result){
							upload_exist_init(TaskId);
						});
					}
				}
				
			});
			$('.upload_exist_p').on("click",".upload_name_a",function(){
				var TaskId = $('#pm-task-name').attr("data-id");
				var id = $(this).parent().attr("data-id");
				var fileName = $(this).attr("_filename");
				var fileUrl = $(this).attr("_url");
				var fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1);
				var realName = id+"."+fileExtension;
				var params = {};
				params.taskid = TaskId;
				params.id = id;
				
				switch(fileExtension){
					case "png":
					case "jpg":
					case "jpeg":
					case "gif":

						/*Utils.showMask();
						var _url = contextPath + "/task/" + params.taskid + "/" + params.id + "." + fileExtension;
						$("#pm-task-pic-view").find("img").attr("src",_url);
						$("#pm-task-pic-view").show();
						var picHeight = $("#pm-task-pic-view").find("img").height();
						var picWidth = $("#pm-task-pic-view").find("img").width();
						$("#pm-task-pic-view").css("margin-top","-"+(picHeight/2)+"px");
						$("#pm-task-pic-view").css("margin-left","-"+(picWidth/2)+"px");
						$(".mask,#pm-task-pic-view,.pm-task-pic-view-close").on("click",function(){
							$("#pm-task-pic-view").hide();
							Utils.hideMask();
						});
						*/
						break;
					default:
						var _file= {
							id : id,
							url : fileUrl,
							extName : fileExtension
						};
						var isPreView = isPreViewFile(_file) ;
						var file = {
								 TaskId : TaskId,
								 id : id,
								 webPath : fileUrl+"/"+fileName,
								 showName : fileName,
								 realName : realName
						};
						if(isPreView.status == 1){
							previewFile(file);
						}else{
							if(isPreView.message == "FileConversion"){
								Utils.showMessage("预览文件正在转换中，请稍后","error");
							}else{
								downloadFile(TaskId, id);
							}
						}
						break;	
				}
			});
		}
	});
}
function isPreViewFile(_file){
	var url = contextPath + '/pm/task/hasSwfFile.action';
	var data;
	$.ajax({
		url:url,
		async:false,
		cache:false,
		data:_file,
		success:function (result){
			data = result;
		}
	});
	return data;
}
function previewFile(file) {
	var previewEdit = false;
	var edit = previewEdit == true ? "edit" : "";
	var url = encodeURI(contextPath
			+ "/pm/js/plugin/preview/preview.jsp?action=" + edit + "&path="
			+ file.webPath + "&name=" + file.realName+"&showName="+file.showName+"&TaskId="+file.TaskId+"&id="+file.id);
	
	var _tmpwin = window.open(url, "_blank");
	_tmpwin.location.href = url;
}
function downloadFile(TaskId,id){
	var url = "task/download.action?taskid="+TaskId+"&id="+id;
	window.open(url) ;
}
function create_upload_exist_init(data){
		//保存数据
		data = JSON.parse(data);
		var attachmentVal = $(".tag-add-wrap").attr("_value");
		var url = data.url.substring(0,data.url.lastIndexOf('\\'));
		if(attachmentVal!=""){
			var attachmentJson = JSON.parse(attachmentVal);
		}else{
			var attachmentJson = {};
		}
		
		attachmentJson[data.id] = {"id": data.id,"name":data.name,"url":url,"isCompress":data.isCompress == "true"?true:false};
		$(".tag-add-wrap").attr("_value",JSON.stringify(attachmentJson));
		//数据回选
		var contents="";//存放图片
		var contentsOther="";//存放非图片
		var size = data.size;	//判断上传的图片是否有大小，图片的title显示图片名和图片大小
		var size = '';	//判断上传的图片是否有大小，图片的title显示图片名和图片大小
		if(typeof(data.size) != "undefined"){
			var size = ' , '+ bytesToSize(data.size);
		}
		var key = data.id;
		var isPicture =  data.name.substring(data.name.lastIndexOf('.') + 1);
		var isCompress = data.isCompress;
		switch(isPicture){//判断如果是图片就获取图片的路径并显示出来
			case "png":
			case "jpg":
			case "jpeg":
			case "gif":
				var _original = contextPath + url +"/" + key + "." + isPicture;
				if(isCompress == true || isCompress == "true"){
					var _url = contextPath + url +"/" +"Compress_"+key + "." + isPicture;
				}else if(isCompress == false || isCompress == "false"){
					var _url = contextPath + url +"/" + key + "." + isPicture;
				}
				contents= contents+"<li class='upload_exist_p' data-id="+key+"><a class='upload_name_a upload_name_a_img' title='"+data.name+size+"' _filename='"+data.name+"'><img url='"+_original+"' src="+_url+"></a>&nbsp;&nbsp;<a class='upload_delete_a' title='删除'>X</a></li>";
				break;
			default:
				var imgCss = isPicture?isPicture:"other";
				contentsOther= contentsOther+"<p class='btn upload_exist_p' data-id="+key+">"+
							"<a class='pic other "+imgCss+"'></a>"+
							"<a class='upload_name_a' title='"+data.name+size+"' _filename='"+data.name+"' _url = '"+url+"'>"+data.name+"</a>&nbsp;&nbsp;"+
							"<a class='upload_delete_a del' title='删除'>x</a>"+
						  "</p>";
				//contentsOther= contentsOther+"<p class='upload_exist_p' data-id="+key+"><a class='upload_name_a' title='"+data.name+size+"' _filename='"+data.name+"' _url='"+url+"'>"+data.name+"</a>&nbsp;&nbsp;<a class='upload_delete_a' title='删除'>X</a></p>";
				break;	
		}
	if($("#attach_block").find(".pasteP")){
		$("#attach_block").find(".pasteP").remove();
	}	
	$('#attach_block_other').prepend(contentsOther);
	$('#attach_block').prepend(contents);
	
	$("#attach_block[data-view='viewer']").viewer('destroy').viewer({
		"url":"url"
	});
	
	$('.upload_exist_p').on("click",".upload_delete_a",function(){
		if(PM.cache.memberIdentity == 2){
			return false;
		}else{
			if(confirm("确认删除附件吗？")){
				var TaskId = $('#pm-task-name').attr("data-id");
				var key = $(this).parent().attr("data-id");
				params = {};
				params.id = TaskId;
				params.key = key;
				var attachmentValDel = $(".tag-add-wrap").attr("_value");
				
				if(attachmentValDel!=""){
	  	 			var attachmentJsonDel = JSON.parse(attachmentValDel);
	  	 		}else{
	  	 			var attachmentJsonDel = {};
	  	 		}
				$.each(attachmentJsonDel,function(i){
					if(this.id == key){
						delete attachmentJsonDel[i];
						$(".tag-add-wrap").attr("_value",JSON.stringify(attachmentJsonDel));
					}
				})
				$(".tag-add-wrap").find("*[data-id='"+key+"']").remove();
			}
		}
		
	});
}
function leng(data){
	var keys = [];
	for(var key in data) {
		keys.push(key);
	}
	
	var temp;
	// 选择排序法
	for (var i = 0; i < keys.length - 1; ++i) {
		for(var j = i; j < keys.length; ++j) {
			var data1 = data[keys[i]];
			var data2 = data[keys[j]];
			// 兼容旧数据，若没有sortNo说明没排序号，不做排序
			if(data1.sortNo === undefined) {
				//若data1没有sortNo则直接跳到下一个
				continue;
			}
			if(data2.sortNo === undefined || data1.sortNo > data2.sortNo) {
				// 若data2没有sortNo 或 data1.sortNo 比 data2.sortNo 大，
				// 说明应该把data2放在前面，交换它们的顺序，只排序临时的key值
				temp = keys[i];
				keys[i] = keys[j];
				keys[j] = temp;
			}
		}
	}
	
	return keys;
}
function bytesToSize(bytes) {
    if (bytes === 0) return '0 B';
    var k = 1024, 
        sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = Math.floor(Math.log(bytes) / Math.log(k));
   return Math.round((bytes / Math.pow(k, i)).toPrecision(3)) + ' ' + sizes[i];
}
