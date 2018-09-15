
var $ = jQuery, // just in case. Make sure it's not an other libaray.

$wrap = $('#uploader'),

// 图片容器
$queue = $('<ul class="filelist"></ul>').appendTo($wrap.find('.queueList')),

// 状态栏，包括进度和控制按钮
$statusBar = $wrap.find('.statusBar'),
// 文件总体选择信息。
$info = $statusBar.find('.info'),

// 上传按钮
$upload = $wrap.find('.uploadBtn'),

// 没选择文件之前的内容。
$placeHolder = $wrap.find('.placeholder'),

// 总体进度条
$progress = $statusBar.find('.progress').hide(),

// 添加的文件数量
fileCount = 0,

// 添加的文件总大小
fileSize = 0,

// 可能有pedding, ready, uploading, confirm, done.
state = 'pedding',

// 所有文件的进度信息，key为file id
percentages = {},

supportTransition = (function() {
	var s = document.createElement('p').style, r = 'transition' in s
			|| 'WebkitTransition' in s || 'MozTransition' in s
			|| 'msTransition' in s || 'OTransition' in s;
	s = null;
	return r;
})();


var FU = {};
FU.config = {

	// 优化retina, 在retina下这个值是2
	ratio : window.devicePixelRatio || 1,

	// 缩略图大小
	thumbnailWidth : 110 * this.ratio, 
	thumbnailHeight : 110 * this.ratio,	
};

//完成操作
FU.returnResult = function() {
	value = "";
	for ( var obj in values) { // 这个是关键
		if (value != "") {
			value += ";" + values[obj];
		} else {
			value += values[obj];
		}
	}
	OBPM.dialog.doReturn(decodeURIComponent(value));
}

//取消操作
FU.cancelResult = function() {
	OBPM.dialog.doExit();
}
//负责view的销毁
FU.removeFile = function(file) {
	var $li = $('#' + file.id);

	delete percentages[file.id];
	FU.updateTotalProgress();
	$li.off().find('.file-panel').off().end().remove();
};

FU.showError = function(code) {
	
	switch (code) {
	case 'exceed_size':
		text = '文件大小超出';
		break;

	case 'interrupt':
		text = '上传暂停';
		break;

	case 'none_ext':
		text = '无后缀名，请重试';
		break;
	case 'server':
		text = '上传失败，文件类型非法或服务器没响应';
		break;
		
	default:
		text = '上传失败，请重试';
		break;
	}
	return text;
};

//当有文件添加进来时执行，负责view的创建
FU.addFile = function(file) {
	var $li = $('<li id="' + file.id + '"><p class="title">' + file.name + '</p>' + '<p class="imgWrap"></p>'
			+ '<p class="progress"><span></span></p>' + '</li>'),
	$btns = $('<div class="file-panel"><span class="cancel">删除</span></div>').appendTo($li), 
	$prgress = $li.find('p.progress span'), 
	$wrap = $li.find('p.imgWrap'), 
	$info = $('<p class="error"></p>');

	if (file.getStatus() === 'invalid') {
		$info.text(FU.showError(file.statusText)).appendTo($li);
	} else if (file.ext == '') {
		$info.text(FU.showError('none_ext')).appendTo($li);
	} else {
		// @todo lazyload
		$wrap.text('预览中');
		uploader.makeThumb(file, function(error, src) {
			if (error) {
				$wrap.text('不能预览');
				return;
			}

			var img = $('<img src="' + src + '">');
			$wrap.empty().append(img);
		}, FU.config.thumbnailWidth, FU.config.thumbnailHeight);

		percentages[file.id] = [ file.size, 0 ];
		file.rotation = 0;
	}

	file.on('statuschange', function(cur, prev) {
		if (prev === 'progress') {
			$prgress.hide().width(0);
		} else if (prev === 'queued') {
			$li.off('mouseenter mouseleave');
			$btns.remove();
		}

		// 成功
		if (cur === 'error' || cur === 'invalid') {
			console.log(file.statusText);
			$info.text(FU.showError(file.statusText)).appendTo($li);
			percentages[file.id][1] = 1;
		} else if (cur === 'interrupt') {
			$info.text(FU.showError('interrupt')).appendTo($li);
		} else if (cur === 'queued') {
			percentages[file.id][1] = 0;
		} else if (cur === 'progress') {
			$info.remove();
			$prgress.css('display', 'block');
		} else if (cur === 'complete') {
			$li.append('<span class="success"></span>');
		}
		$li.removeClass('state-' + prev).addClass('state-' + cur);
	});

	$li.on('mouseenter', function() {
		$btns.stop().animate({
			height : 30
		});
	});

	$li.on('mouseleave', function() {
		$btns.stop().animate({
			height : 0
		});
	});

	$btns.on(
					'click',
					'span',
					function() {
						var index = $(this).index(), deg;

						switch (index) {
						case 0:
							uploader.removeFile(file);
							return;

						case 1:
							file.rotation += 90;
							break;

						case 2:
							file.rotation -= 90;
							break;
						}

						if (supportTransition) {
							deg = 'rotate(' + file.rotation + 'deg)';
							$wrap.css({
								'-webkit-transform' : deg,
								'-mos-transform' : deg,
								'-o-transform' : deg,
								'transform' : deg
							});
						} else {
							$wrap
									.css(
											'filter',
											'progid:DXImageTransform.Microsoft.BasicImage(rotation='
													+ (~~((file.rotation / 90) % 4 + 4) % 4)
													+ ')');
						}

					});

	$li.appendTo($queue);
};

FU.init = function(){

	if (!WebUploader.Uploader.support()) {
		alert('Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
		throw new Error(
				'WebUploader does not support the browser you are using.');
	}

	this.initUploader();
	this.bindEvent();
};

FU.initUploader = function(){

	// 实例化
	uploader = WebUploader.create({
		pick : {
			id : '#filePicker',
			label : '点击选择文件'
		},
		dnd : '#uploader .queueList',
		paste : document.body,
		threads : 1,
		accept : {
			title : 'File Type',
			extensions : webAcceptExtensions,
			mimeTypes : file_types_description
		},
		compress : false,
		// swf文件路径
		swf : 'webuploader/Uploader.swf',
		disableGlobalDnd : true,
		chunked : false,	// 开起分片上传
		// server: 'http://webuploader.duapp.com/server/fileupload.php',
		server : urlUpload,		
		fileNumLimit : sunUploadSize,
		fileSizeLimit : mamaximumSize * 1024, // 200 M
		fileSingleSizeLimit : webFileSingleSizeLimit * 1024
	// 50 M
	});
	
	// 添加“添加文件”的按钮，
	uploader.addButton({
		id : '#filePicker2',
		label : '继续添加'
	});

	/**
	 * 上传时触发
	 */
	uploader.onUploadProgress = function(file, percentage) {
		var $li = $('#' + file.id), $percent = $li.find('.progress span');

		$percent.css('width', percentage * 100 + '%');
		percentages[file.id][1] = percentage;
		FU.updateTotalProgress();
	};

	/**
	 * 当文件被加入队列以后触发
	 */
	uploader.onFileQueued = function(file) {
		fileCount++;
		fileSize += file.size;

		if (fileCount === 1) {
			$placeHolder.addClass('element-invisible');
			$statusBar.show();
		}

		FU.addFile(file);
		FU.setState('ready');
		FU.updateTotalProgress();
	};

	/**
	 * 当文件被移除队列后触发
	 */
	uploader.onFileDequeued = function(file) {
		fileCount--;
		fileSize -= file.size;

		if (!fileCount) {
			FU.setState('pedding');
		}

		FU.removeFile(file);
		FU.updateTotalProgress();

	};
	/**
	 * 监听所有事件
	 */
	uploader.on('all', function(type, file, response) {
		var stats;

		if (type == "uploadSuccess") {
			keys.push(file.id);
			var result = file.name.replace("#", "_").replace(",", "_").replace("'", "_").replace(";", "_").replace("%", "_").replace("&", "_").replace("+", "%2B");
			var _f = response._raw.split(",");
			if(_f.length==2){
				result+=","+_f[1];
			}
			values.push(result);
		}

		switch (type) {
		case 'uploadFinished':
			FU.setState('confirm');
			break;

		case 'startUpload':
			FU.setState('uploading');
			break;

		case 'stopUpload':
			FU.setState('paused');
			break;

		}
		FU.updateStatus();
	});

	/**
	 * 上传错误时触发
	 */
	uploader.onError = function(code) {
		if (code == "Q_EXCEED_NUM_LIMIT") {
			alert('上传文件数量超出限制');
		} else if (code == "Q_EXCEED_SIZE_LIMIT") {
			alert('上传文件总大小超出限制');
		} else if (code == "Q_TYPE_DENIED") {
			if(webAcceptExtensions != null){
				alert('文件类型(仅支持\''+webAcceptExtensions+'\'格式)或大小错误');
			}else{
				alert('文件类型或大小错误');
			}
		} else if (code == "F_DUPLICATE") {
			alert('上传文件重复');
		} else if (code == "F_EXCEED_SIZE") {
			alert('上传文件大小超出限制');
		} else {
			alert('Error: ' + code);
		}
	};
};

FU.bindEvent = function(){

	$('.state-ok').bind("click",function(){
		FU.returnResult();
	});
	
	$('.state-cancel').bind("click",function(){
		FU.cancelResult();
	});

	$upload.on('click', function() {
		if ($(this).hasClass('disabled')) {
			return false;
		}

		if (state === 'ready') {
			uploader.upload();
		} else if (state === 'paused') {
			uploader.upload();
		} else if (state === 'uploading') {
			uploader.stop();
		}
	});

	$info.on('click', '.retry', function() {
		uploader.retry();
	});

	$info.on('click', '.ignore', function() {
		if(values.length>0){
			$('.state-ok').trigger("click");
		}else{
			$('.state-cancel').trigger("click");
		}
	});

	$upload.addClass('state-' + state);
	FU.updateTotalProgress();
};


FU.updateTotalProgress = function() {
	var loaded = 0, total = 0, spans = $progress.children(), percent;

	$.each(percentages, function(k, v) {
		total += v[0];
		loaded += v[0] * v[1];
	});

	percent = total ? loaded / total : 0;

	spans.eq(0).text(Math.round(percent * 100) + '%');
	spans.eq(1).css('width', Math.round(percent * 100) + '%');
	FU.updateStatus();
}

/**
 * 更新操作栏状态
 */
FU.updateStatus = function() {
	var text = '', stats;
	if (state === 'ready') {
		text = '选中 ' + fileCount + '/' + sunUploadSize + ' 个文件，共'
				+ WebUploader.formatSize(fileSize) + '， 单个文件大小限制：  '+ WebUploader.formatSize( mamaximumSize ) +"。";
	} else if (state === 'confirm') {
		stats = uploader.getStats();
		if (stats.uploadFailNum) {
			text = '已成功上传'
					+ stats.successNum
					+ '个文件，'
					+ stats.uploadFailNum
					+ '个文件上传失败，<a class="retry" href="#">重新上传</a>失败文件或<a class="ignore" href="#">忽略</a>'
		}

	} else {
		stats = uploader.getStats();
		text = '共' + fileCount + '个（' + WebUploader.formatSize(fileSize)
				+ '），已上传' + stats.successNum + '个';

		if (stats.uploadFailNum) {
			text += '，失败' + stats.uploadFailNum + '个';
		}
	}

	$info.html(text);

	//添加文件数已经到达限制上传文件数时隐藏“继续添加”按钮
	if (fileCount == file_upload_limit) {
		$("#filePicker2").css("display", "none");
	} else {
		$("#filePicker2").css("display", "inline-block");
	}
	//没有已选择但未上传的文件时不要显示“开始上传”按钮
	if ($(".uploadBtn").hasClass("disabled")) {
		$(".uploadBtn").css("display", "none");
		$("#filePicker2").css("display", "none");//避免出现滚动条
	} else {
		$(".uploadBtn").css("display", "inline-block");
	}
}

FU.setState = function(val) {
	var file, stats;

	if (val === state) {
		return;
	}

	$upload.removeClass('state-' + state);
	$upload.addClass('state-' + val);
	state = val;

	switch (state) {
	case 'pedding':
		$placeHolder.removeClass('element-invisible');
		$queue.parent().removeClass('filled');
		$queue.hide();
		//$statusBar.addClass( 'element-invisible' );
		$statusBar.hide();
		uploader.refresh();
		break;

	case 'ready':
		$placeHolder.addClass('element-invisible');
		$('#filePicker2').removeClass('element-invisible');
		$queue.parent().addClass('filled');
		$queue.show();
		$statusBar.removeClass('element-invisible');
		$('.state-cancel').show();
		uploader.refresh();
		break;

	case 'uploading':
		$('#filePicker2').addClass('element-invisible');
		$progress.show();
		$upload.text('暂停上传');
		break;

	case 'paused':
		$progress.show();
		$upload.text('继续上传');
		break;

	case 'confirm':
		$progress.hide();
		$('.state-cancel').show();
		$('.state-ok').hide();
		$upload.text('开始上传').addClass('disabled');
		stats = uploader.getStats();
		if (stats.successNum && !stats.uploadFailNum) {
			FU.setState('finish');
			return;
		}
		break;
	case 'finish':
		stats = uploader.getStats();
		if (stats.successNum) {
			$('.state-cancel').hide();
			$('.state-ok').show();
			//alert( '上传成功' );
		} else {
			// 没有成功的图片，重设
			state = 'done';
			location.reload();
		}
		break;
	}

//	FU.updateStatus();
}
