$(document).ready(function(){
	
	var progressId;
	
	var isTrayReady = false;
	var trayProgress;
	
	$.ajax({
		url: trayHost+'/ping',
		dataType: 'jsonp',
		timeout: 2000,
	   	jsonp: 'jsonpCallback',
		success:function(result){
			if(result.state == 1){
				isTrayReady = true;
				setServerHost();
			}
		},
		error:function (XMLHttpRequest, textStatus, errorThrown) {
			//测试网络连通性
			trayProgress = window.setInterval(function(){
				$.ajax({
					url: trayHost+'/ping',
					dataType: 'jsonp',
					timeout: 2000,
				   	jsonp: 'jsonpCallback',
					success:function(result){
						if(result.state == 1){
							window.clearInterval(progressId);
							isTrayReady = true;
							setServerHost();
						}
					},
					error:function (XMLHttpRequest, textStatus, errorThrown) {
					}
				});
			}, 4*1000);
		}
	});
	
	function setServerHost(){
		$.ajax({
			async:false,
			url: trayHost+'/setServerHost?host='+serverHost,
			dataType: 'jsonp',
		   	jsonp: 'jsonpCallback',
			success:function(result){
				if(result.state == 1){
					$(".activity-edit").show();
				}
			},
			error:function (XMLHttpRequest, textStatus, errorThrown) {
			}
		});
	}
	
	function startTrayProgress(){
		progressId = window.setInterval(function(){
			$.ajax({
				async:false,
				url: trayHost+'/progress?name='+name,
				dataType: 'jsonp',
			   	jsonp: 'jsonpCallback',
			   	timeout: 2000,
				success:function(result){
					if(result.state == 1){
						var state = result.data;
						console.log('state-->'+state);
						$(".activity-edit").hide();
						switch (state) {
						case 0:
							$("#progress").text("文档编辑中...");
							break;
						case 11:
							$("#progress").text("文档编辑中...");
							break;
						case 12:
							$("#progress").text("文档暂存中...");
							break;
						case 13:
							$("#progress").text("文档已暂存!");
							break;
						case 21:
							$("#progress").text("文档编辑中...");
							break;
						case 22:
							$("#progress").text("文档编辑中...");
							break;
						case 23:
							$("#progress").text("文档已更新！");
							var $container = $(".preview-body-container");
							$container.find("iframe").attr("src",previewUrl);
							$(".activity-edit").show();
							window.clearInterval(progressId);
							
							break;
						default:
							$("#progress").text("");
							break;
						}
					}
				},
				error:function (XMLHttpRequest, textStatus, errorThrown) {
				    $(".activity-edit").hide();
				    this; // 调用本次AJAX请求时传递的options参数
				}
			});
		}, 2*1000);
	}
	
	if(action == "edit"){
		$(".activity-edit").show().on("click",function(e){
			if(!isTrayReady){
				OBPM.message.showConfirm("托盘程序未找到","需要下载托盘程序并安装,点击\"确定\"按钮下载。",function(result){
					if(result){//确认框--确认执行
						//下载托盘程序
						url = encodeURI(contextPath + "/portal/share/common/preview/resource/myapps_tray.exe");
						var _tmpwin = window.open(url,"_blank");
						_tmpwin.location.href = url;
					}
				});
				return;
			}
			$.ajax({
				async:false,
				url:trayHost+'/download?path='+path+'&name='+name,
				dataType: 'jsonp',
				jsonp: 'jsonpCallback',
				success:function(result){
					if(result.state == 1){
						startTrayProgress();
					}
				},
				error:function (XMLHttpRequest, textStatus, errorThrown) {
				}
			});
		});
	}
	
	$(".activity-download").on("click",function(e){
		var url ;
		if(isWaterMarkFile(waterMarkSetting,showName)){
			url = encodeURI(contextPath + "/portal/dynaform/document/fileDownloadWithWaterMark.action?filename="+ showName + "&filepath=" + fullPath + "&waterMarkSetting="+encodeURI(waterMarkSetting));
		}else{
			url = encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+ showName + "&filepath=" + fullPath);
		}
		var _tmpwin = window.open(url,"_blank");
		_tmpwin.location.href = url;
	});
	
	/**
	 * 是否能够获取水印文件
	 */
	function isWaterMarkFile(waterMarkSetting,filename){
		if(waterMarkSetting != null || waterMarkSetting != undefined || waterMarkSetting != "" || waterMarkSetting != "null"){
			var setting  = eval ("(" + waterMarkSetting + ")");
			if(setting.type != null && setting.type.indexOf("download")>-1){
				var fileType = filename.substring(filename.lastIndexOf(".")+1);
				if ("doc"== fileType || "docx"== fileType
						|| "xls"== fileType || "xlsx"== fileType
						|| "pdf"== fileType || "txt"== fileType
						|| "rtf"== fileType || "et"== fileType
						|| "ppt"== fileType || "pptx"== fileType
						|| "dps"== fileType || "pot"== fileType
						|| "pps"== fileType || "wps"== fileType
						|| "html"== fileType || "htm"== fileType) {
					return true;
				}
			}
		}
		return false ;
	}
});