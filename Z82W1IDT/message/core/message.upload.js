
function file_upload_init() {  
	var TaskId = $('#pm-task-name').attr("data-id");
	if(TaskId == undefined){
		TaskId = PM.cache.currentEditTaskId
	}
	upload_exist_init(TaskId);
	
	$('#file_upload').uploadify({
		'formData'     : {
		'TaskId'   : TaskId
					},
		'swf' : './js/uploadify/uploadify.swf',  
	    'uploader' : contextPath+'/pm/task/addAttach',  
	    'buttonText':'添加附件',
	    'removeCompleted':true,
		'multi'    :true,
	    
	    //选择文件后自动上传
        'auto': true,
        'onUploadSuccess' : function(file,data,response){
			upload_exist_init(TaskId);
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
		        			upload_exist_init(TaskId);
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
		var data = eval( '(' + result.data.attachment + ')' );
		var keys = leng(data);
		var contents="";//存放图片
		var contentsOther="";//存放非图片
		for(;keys.length>=1;){
			var key = keys.pop();
			var size = '';	//判断上传的图片是否有大小，图片的title显示图片名和图片大小
			if(typeof(data[key].size) != "undefined"){
				var size = ' , '+ bytesToSize(data[key].size);
			}
			var isPicture = data[key].name.substring(data[key].name.lastIndexOf('.') + 1);
			switch(isPicture){//判断如果是图片就获取图片的路径并显示出来
				case "png":
				case "jpg":
				case "jpeg":
				case "gif":
					var _url = contextPath + "/task/" + params.id + "/" + key + "." + isPicture;
					contents= contents+"<li class='upload_exist_p' data-id="+key+"><a class='upload_name_a upload_name_a_img' title='"+data[key].name+size+"' _filename='"+data[key].name+"'><img src="+_url+"></a>&nbsp;&nbsp;<a class='upload_delete_a' title='删除'>X</a></li>";
					
					break;
				default:
					contentsOther= contentsOther+"<p class='upload_exist_p' data-id="+key+"><a class='upload_name_a' title='"+data[key].name+size+"' _filename='"+data[key].name+"'>"+data[key].name+"</a>&nbsp;&nbsp;<a class='upload_delete_a' title='删除'>X</a></p>";
					break;	
			}
		}
		$('#attach_block_other').html(contentsOther);
		$('#attach_block').html(contents);
		
		$("#attach_block[data-view='viewer']").viewer('destroy').viewer();
		
		$('.upload_exist_p').on("click",".upload_delete_a",function(){
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
		});
		$('.upload_exist_p').on("click",".upload_name_a",function(){
			var TaskId = $('#pm-task-name').attr("data-id");
			var id = $(this).parent().attr("data-id");
			var fileName = $(this).attr("_filename");
			var fileExtension = fileName.substring(fileName.lastIndexOf('.') + 1);
			var params = {};
			params.taskid = TaskId;
			params.id = id;
			
			switch(fileExtension){
				case "png":
				case "jpg":
				case "jpeg":
				case "gif":

					break;
				default:
					var url = "task/download.action?taskid="+TaskId+"&id="+id;
					window.open(url) ;
					break;	
			}
		});
		
		
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

function bytesToSize(bytes) {
    if (bytes === 0) return '0 B';
    var k = 1024, 
        sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = Math.floor(Math.log(bytes) / Math.log(k));
   return Math.round((bytes / Math.pow(k, i)).toPrecision(3)) + ' ' + sizes[i];
}