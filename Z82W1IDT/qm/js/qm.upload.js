function file_upload_init(holder,option,key) {  
	if(option.pic && option.pic != ""){
		uploaderPic_init(key,option.pic);
	}
	
	var uploader = WebUploader.create({
	    auto: true,
	    swf: '../js/webuploader/Uploader.swf',
	    server: contextPath+'/qm/servlet/upload',
	    pick: '#filePicker-'+key,
	    accept: {
	        title: 'Images',
	        extensions: 'gif,jpg,jpeg,bmp,png',
	        mimeTypes: 'image/*'
	    }
	});

	uploader.onUploadSuccess = function(file,response){
		uploaderPic_init(key,contextPath+response.url);
	};
	
	uploader.onUploadError = function(file){
		alert("上传失败");
	};
}
//初始化图片
function uploaderPic_init(key,url){
	var $uploadBtn = $('#filePicker-'+key);
	var $uploadList = $('#fileList-'+key);
	var $uploadPic = $uploadList.find("a");
	
	$uploadPic.attr("href",url);
	$uploadPic.find(".filePic").data("key",key);
	$uploadPic.find(".filePic").attr("src",url);
	$uploadPic.show();
}