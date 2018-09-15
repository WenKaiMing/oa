/**
 * KM 核心类
 * 封装KM界面渲染与交互行为
 */
;
var KM = {};

KM.Config = {
    mainActive : "",
    isUploadList : false,
    pageArguments : null
};

KM.Core = {
    bindEven : function(){
                
        var $container = $('#container');

        //搜索框
        $container.on('click','#searchText', function(){
            $('#searchBar').addClass('weui-search-bar_focusing');
            $('#searchInput').focus();
        });
        $container.on('blur', '#searchInput', function () {
            if(!this.value.length){
            	KM.Util.controlPlaceholder("hide");
            	KM.Util.cancelSearch();
            	if(KM.Config.loadMoreScroll != null){
                	KM.Config.loadMoreScroll.refresh();
            	}
            } 
        }).on('input','#searchInput', function(){
            if(this.value.length) {
                $('#searchResult').show();
                $('#searchResult').siblings(".my-bar").hide();
                $('#searchResult').siblings(".km-list").hide();
            } else {
            	KM.Util.controlPlaceholder("hide");
                $('#searchResult').hide();
                $('#searchResult').empty();
                $('#searchResult').siblings(".my-bar").show();
                $('#searchResult').siblings(".km-list").show();
            }
        }).on('keydown','#searchInput',function(event){
        	var $this = $(this);
        	if(event.keyCode == "13"){
            	var params = {
            		"queryString" : this.value,
            		"nDiskId" : diskIdOfPublic
            	};
            	KM.Service.search(params,function(datas){
            		var data = {
            			"contextPath" : contextPath,
            			"datas":datas
            		}
            		if(datas.length <= 0){
                		KM.Util.controlPlaceholder("show","search");
            		}else{
            			KM.Util.controlPlaceholder("hide");
            			
            			
            			for(var i = 0;i < datas.length; i++){
                			var _this = datas[i]
                			if(_this.extendName && _this.extendName != ""){
                				_this.extendNameChecked = KM.Util.checkExtendName(_this.extendName);
                			}
                		}
            			
            			var html = template('atp-search-list-item', data);
                		$('#searchResult').html(html)
            		}	
            		$('#searchResult').show();
                    $('#searchResult').siblings(".my-bar").hide();
                    $('#searchResult').siblings(".km-list").hide();
                })
        		return false;
        	}
        });
        $container.on('click', '#searchClear',function(){
        	if(KM.Config.mainActive == 'my'){
                $('#searchBar').show();
                $('.my-bar').show();
            }else if(KM.Config.mainActive == 'share'){
                $('#searchBar').hide();
                $('.my-bar').hide();
            }else if(KM.Config.mainActive == 'public'){
                $('#searchBar').show();
                $('.my-bar').hide();
            }else if(KM.Config.isUploadList){
                $('#searchBar').hide();
                $('.my-bar').hide();
            }
        	KM.Util.controlPlaceholder("hide");
            KM.Util.hideSearchResult();
            $('#searchInput').focus();
        });
        $container.on('click', '#searchCancel',function(){
        	if(KM.Config.mainActive == 'my'){
                $('#searchBar').show();
                $('.my-bar').show();
            }else if(KM.Config.mainActive == 'share'){
                $('#searchBar').hide();
                $('.my-bar').hide();
            }else if(KM.Config.mainActive == 'public'){
                $('#searchBar').show();
                $('.my-bar').hide();
            }else if(KM.Config.isUploadList){
                $('#searchBar').hide();
                $('.my-bar').hide();
            }
        	KM.Util.controlPlaceholder("hide");
            KM.Util.cancelSearch();
            $('#searchInput').blur();

        });

        //顶部菜单
        $('#iosMask').on('click', KM.Util.hideActionSheet);

        $('#actionsheetCancel').on('click', KM.Util.hideActionSheet);

        $container.on("click", '.my-bar .my-bar__item',function(){

            var $this = $(this);
            var type = $this.attr('data-type');
            var $createFolderDialog = $('#createFolderDialog');
            
            if(type == "createFolder"){//新建文件夹
                $createFolderDialog.fadeIn(200);
            }else if(type == "uploadFile"){//上传
            	//if(isAndroid){
            	//	$('#upload-actionsheet').addClass('weui-actionsheet_toggle');
                //    $('#iosMask').fadeIn(200);
				//}else{
					$("#filePicker").find("input").trigger("click");
				//}
            }
        });

        //新建文件夹对话框
        $('#createFolderDialog').on('click', '.weui-dialog__btn', function(){
        	var $this = $(this);
        	var $createFolderDialog = $("#createFolderDialog");
        	var $createFolderInput = $createFolderDialog.find("input.weui-input");
        	
        	var active = $this.attr("data-active");
        	var name = $createFolderInput.val();
        	if(name == ""){
        		name = "新建文件夹";
        	}
        	
        	if(active == "submit"){
        		KM.Util.controlLoading("show");
        		var params = {
        			"name" : name,
        			"nDiskId" : diskIdOfMine,
        			"nDirId": KM.Util.cache.nDirId
        		}
            	KM.Service.saveFolder(params,function(){
            		$("#createFolderDialog").fadeOut(200);
            		$createFolderInput.val("");
    				KM.Core.refreshList();
                }) 
                KM.Util.controlLoading("hide");
        	}else{
        		$createFolderDialog.fadeOut(200);
        		$createFolderInput.val("");
        	}       
        });

        //列表点击
        $container.on('touchend', '.my-list__item', function(a) {
            var $this = $(this);
            var $arrow = $(a.target).closest('.my-list__arrow');
            if ($arrow.length) {
                a.preventDefault();
                a.stopPropagation();
                var $itemDiv = $arrow.closest('.weui-cell');
                var $textDiv = $itemDiv.find('.my-list__text');
                var $operateDiv = $itemDiv.find('.my-list__operate');
                var $otherItem = $('.my .weui-cell').not($itemDiv);
                var $otherText = $('.my .my-list__text').not($textDiv);
                $otherItem.find(".fa").removeClass("fa-rotate-180");
                $otherItem.removeClass('open');
                $otherText.slideDown();
                $arrow.find(".fa").toggleClass("fa-rotate-180");
                $itemDiv.toggleClass('open');
                $textDiv.slideToggle("fast");
            }
        });

        //列表点击-预览内容
        $container.on('click', '.my-list__item .my-list__text', function(a) {
            var $this = $(this);
            var id = $this.attr("data-id");
            var fileType = $this.attr("data-filetype");
            if(fileType == "1"){
            	location.hash = "#list/"+id+"/1";
            }else{
            	var params = {
                	"nFileId":id	
                };
                KM.Service.openFile(params,function(data){
                	KM.Util.cache.previewFile = data;
                	location.hash = "#preview/"+id;
                });
            }
        });
        
        //列表操作栏
        $container.on('click', '.file-operate .weui-flex__item', function(a) {
            var $this = $(this);
            var active = $this.attr("data-active");
            var id = $this.parent().attr("data-id");
            var fileType = $this.parent().attr("data-filetype");
            
            switch(active){
            case "download":
            	KM.Service.openFile({"nFileId":id},function(data){
            		window.location.href = window.location.origin + data.url;
                })  
            	break;
            case "delete":
            	var $deleteDialog = $("#deleteDialog");
            	$deleteDialog.attr("data-id",id);
            	$deleteDialog.attr("data-filetype",fileType);
            	$deleteDialog.fadeIn(200);
            	break;
            case "rename":
            	var $this = $(this);
            	var $renameDialog = $("#renameDialog");
            	var name = $this.attr("data-name");
            	$renameDialog.attr("data-id",id);
            	$renameDialog.attr("data-filetype",fileType);
            	$renameDialog.attr("data-name",name);
            	$renameDialog.find("input.weui-input").val(name);
            	$renameDialog.fadeIn(200);
            	break;
            }
        });
        
        //删除对话框
        $('#deleteDialog').on('click', '.weui-dialog__btn', function(){
        	var $this = $(this);
        	var $deleteDialog = $("#deleteDialog");
            var active = $this.attr("data-active");
            var id =  $deleteDialog.attr("data-id");
            var fileType = $deleteDialog.attr("data-filetype");
        	$this.parents('.js_dialog').fadeOut(200);
            if(active == "submit"){
            	KM.Util.controlLoading("show");

            	if(fileType == "1"){
            		var params = {
                		"nDiskId":diskIdOfMine,
                		"dirSelects":id
                	}
            	}else{
            		var params = {
                		"nDiskId":diskIdOfMine,
                		"fileSelects":id
                	}
            	}
            	KM.Service.deleteFolderAndFile(params,function(data){
            		var $div = $("div.my-list__text[data-id='"+id+"']").closest('.weui-cell');
        			$div.each(function(){
        				$(this).remove();
        			});
        			KM.Core.refreshList();

	
                })
                KM.Util.controlLoading("hide");
        	}else{
        		$deleteDialog.fadeOut(200);
        	}
        });
        
        //重命名对话框
        $('#renameDialog').on('click', '.weui-dialog__btn', function(){
        	var $this = $(this);
        	var $renameDialog = $('#renameDialog');
        	var $renameInput = $renameDialog.find("input.weui-input");
        	
        	var active = $this.attr("data-active");
        	var id = $renameDialog.attr("data-id");
        	var name = $renameDialog.attr("data-name");
        	var fileType = $renameDialog.attr("data-filetype");
        	
        	if(active == "submit"){
        		KM.Util.controlLoading("show");
        		if(fileType == "1"){
            		var params = {
                		"name":$renameInput.val() == "" ? name : $renameInput.val(),
                		"renameNDirId":id
                	}
            		KM.Service.renameFolder(params,function(data){
            			$("#renameDialog").fadeOut(200);
            			var $div = $("div.my-list__text[data-id='"+id+"']");
            			$div.find("h3>span.filename").text(params.name)
            			$div.parent().find("div[data-active='rename']").attr("data-name",params.name);
            			$renameInput.val('');
                    })
            	}else{
            		var params = {
                		"name":$renameInput.val() == "" ? name : $renameInput.val(),
                		"renameNFileId":id
                	}
            		KM.Service.renameFile(params,function(data){            			
            			$("#renameDialog").fadeOut(200);
            			var $div = $("div.my-list__text[data-id='"+id+"']");
            			var extendNameIndex = params.name.lastIndexOf(".");
            			if(extendNameIndex >= 0){
            				var extendName = params.name.substr(params.name.lastIndexOf(".")+1);
            				var extendNameChecked = KM.Util.checkExtendName(extendName);
            			}else{
            				var extendNameChecked = "unknown";
            			}
            			$div.find("h3").text(params.name);
            			$div.parent().find("div[data-active='rename']").attr("data-name",params.name);
            			$div.parent().parent().find(">i").removeClass().addClass("icon-file icon-file-"+extendNameChecked);
            			$div.parent().parent().find(".my-list__arrow").trigger("touchend");
            			$renameInput.val('');
                    })
            	}
        		KM.Util.controlLoading("hide");
        	}else{
        		$renameDialog.fadeOut(200);
        	}
        });
        
        //翻页
        $container.on('click', '#pagination', function(a) {
            var $this = $(this);
        	var $pageBtn = $(a.target);
        	var nodeType = $pageBtn.attr("node-type");
        	var pageNo = parseInt($this.attr("data-page"));
        	var path = $this.attr("data-path");
        	if(!$pageBtn.hasClass("inactive")){
        		if($pageBtn.hasClass("pre-page")){
            		location.hash = "#list/"+path+"/"+(pageNo-1);
            	}else if($pageBtn.hasClass("next-page")){
            		location.hash = "#list/"+path+"/"+(pageNo+1);
            	}
        	}
        });

        //首页tabbar事件
        $container.on('click', '.weui-tabbar__item', function () {
        	KM.Util.controlPlaceholder("hide");
        	if($('#searchInput').val().length > 0){
                KM.Util.cancelSearch();
            }
            var type = $(this).attr("data-type");
            
            if(type == 'upload'){
            	KM.Config.isUploadList = true;
            	$('#searchBar').hide();
                $('.my-bar').hide();
                location.hash = "#upload";
            }else{
            	KM.Config.mainActive = type;
            	if(type == 'my'){
                	KM.Util.cache.nDirId = dirIdOfMine;
                	KM.Util.cache.nDiskId = diskIdOfMine;
                    $('#searchBar').show();
                    $('.my-bar').show();
                }else if(type == 'share'){
                    $('#searchBar').hide();
                    $('.my-bar').hide();
                }else if(type == 'public'){
                	KM.Util.cache.nDirId = dirIdOfPublic;
                	KM.Util.cache.nDiskId = diskIdOfMine;
                    $('#searchBar').show();
                    $('.my-bar').hide();
                }
                location.hash = "#list/"+type+"/1";
            }
            
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
        });
    },
	/**
	 * 首页
	 */
	main : {
		init : function(arguments) {
            var $my = $('#container').find('.page.my');
            var mainActive = arguments[0];
            var pageNo = arguments[1];
            
            KM.Config.mainActive = mainActive;
            
            if($my.size() > 0){
            	if(!$('#container').find(".page").last().hasClass('my')){
            		$my.addClass('slideIn');
                    $my.on('animationend webkitAnimationEnd', function(){
                        $my.removeClass('slideIn').addClass('js_show');
                        $('#container').find('.page').not($my).removeClass('js_show');
                        $('#container').find('.preview').remove();
                    });
            	}
            	var $tabBarItem = $my.find(".weui-tabbar__item[data-type='"+mainActive+"']");
            	$tabBarItem.addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
                $('#container').append($my);
            }else{
                this.renderMain(mainActive);  
            }
            var params = {
        		"linesPerPage":15,
        		"pageNo":pageNo
        	}
            this.renderList(params);
		},
		/**
         * 渲染首页tab
         */
        renderMain : function(mainActive){
            var html = template('atp-home', {});
            var $html = $(html).addClass('slideIn');
            var $tabBarItem = $html.find(".weui-tabbar__item[data-type='"+mainActive+"']")
            $tabBarItem.addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $html.on('animationend webkitAnimationEnd', function(){
                $html.removeClass('slideIn').addClass('js_show');
                $('#container').find('.page').not($html).removeClass('js_show');
            });
            $('#container').append($html);
        },
        /**
         * 渲染列表
         */
        renderList : function(params){
        	if(!params){
        		var params = {
            		"linesPerPage":15,
            		"pageNo":1
            	}
        	}
        	KM.Util.controlPlaceholder("hide");
        	var listData = KM.Core.main.getListData(params)
        	var pageCount = listData.pageCount;
        	var rowCount = listData.rowCount;
        	if(rowCount > 0){
        		var html = template('atp-list-item', listData);
        		$('#container').find(".km-list").html(html);
        	}else{
        		$('#container').find(".km-list").html("");
    			KM.Util.controlPlaceholder("show","content");
        	}
        },
        getListData : function(params){
        	var active = KM.Config.mainActive;
        	var listData = {};
        	switch(active){
            case "my":
            	KM.Util.cache.nDirId = dirIdOfMine;
            	KM.Util.cache.nDiskId = diskIdOfMine;
            	KM.Service.getMyList(params,function(data){
                	data.contextPath = contextPath;
                	if(data.datas.length > 0){
                		listData = data;
                	}
                	listData.showArrow = true;
                })
            	break;
            case "share":
            	KM.Service.getHostList(params,function(data){
                	data.contextPath = contextPath;
                	if(data.datas.length > 0){
                		listData = data;
                	}
                	listData.showArrow = false;
                })
                break;
            case "public":
            	KM.Util.cache.nDirId = dirIdOfPublic;
            	KM.Util.cache.nDiskId = diskIdOfMine;
            	KM.Service.getPublicList(params,function(data){
                	data.contextPath = contextPath;
                	if(data.datas.length > 0){
                		listData = data;
                	}
                	listData.showArrow = isPublicDiskAdmin;
                })
                break;
            }
        	if(listData.datas && listData.datas.length > 0){
        		listData.datas = KM.Util.setLanguage(listData.datas);
        		listData.path = KM.Config.mainActive;
        		for(var i = 0;i < listData.datas.length; i++){
        			var _this = listData.datas[i]
        			if(_this.extendName && _this.extendName != ""){
        				var extendNameIndex = _this.name.lastIndexOf(".");
            			if(extendNameIndex >= 0){
            				var extendName = _this.name.substr(_this.name.lastIndexOf(".")+1);
            				var extendNameChecked = KM.Util.checkExtendName(extendName);
            			}else{
            				var extendNameChecked = "unknown";
            			}
        				_this.extendNameChecked = extendNameChecked;
        			}
        		}
        	}
        	return listData;
        }
	},
	/**
     * 目录
     */
    folder : {
    	init : function(arguments){
    		var $my = $('#container').find('.page.my');
            if($my.size() > 0){
            	if(!$('#container').find(".page").last().hasClass('my')){
            		$my.addClass('slideIn');
                    $my.on('animationend webkitAnimationEnd', function(){
                        $my.removeClass('slideIn').addClass('js_show');
                        $('#container').find('.page').not($my).removeClass('js_show');
                    });
            	}
                $('#container').append($my);
            }else{
            	KM.Core.main.renderMain();
            }
    		this.renderList(arguments);
    	},
    	renderList : function(arguments){
    		var id = arguments[0];
    		var pageNo = arguments[1];
    		KM.Util.cache.nDirId = id;
            KM.Util.controlPlaceholder("hide");

        	var params = {
    			"nDirId":KM.Util.cache.nDirId,
        		"linesPerPage":15,
        		"pageNo":pageNo
        	}
        	KM.Service.openFolder(params,function(data){  	
        		var pageCount = data.pageCount;
        		var rowCount = data.rowCount;
            	if(rowCount > 0){
            		$('#container').find(".km-list").html("");
            		data.contextPath = contextPath;
            		data.path = params.nDirId;
                	data.datas = KM.Util.setLanguage(data.datas);
                	for(var i = 0;i < data.datas.length; i++){
            			var _this = data.datas[i]
            			if(_this.extendName && _this.extendName != ""){
            				var extendNameIndex = _this.name.lastIndexOf(".");
                			if(extendNameIndex >= 0){
                				var extendName = _this.name.substr(_this.name.lastIndexOf(".")+1);
                				var extendNameChecked = KM.Util.checkExtendName(extendName);
                			}else{
                				var extendNameChecked = "unknown";
                			}
            				_this.extendNameChecked = extendNameChecked;
            			}
            			
            			
            			var active = KM.Config.mainActive;
                    	switch(active){
                        case "my":
                        	data.showArrow = true;
                        	break;
                        case "share":
                        	data.showArrow = false;
                            break;
                        case "public":
                        	data.showArrow = isPublicDiskAdmin;
                            break;
                        }
            		}
            		var html = template('atp-list-item', data);
            		$('#container').find(".km-list").html(html);
            	}else{
            		$('#container').find(".km-list").html("");
            		KM.Util.controlPlaceholder("show","content");
            	}
            })
    	}
    },
    
    /**
     * 预览
     */
    preview : {
        init : function(arguments) {
        	KM.Util.controlPlaceholder("hide");
            var id = arguments[0];
            var $previewBox = $('#preview-'+id);
            if($previewBox.size() > 0){
                $previewBox.addClass('slideIn');
                $previewBox.on('animationend webkitAnimationEnd', function(){
                    $previewBox.removeClass('slideIn').addClass('js_show');
                    $('#container').find('.page').not($previewBox).removeClass('js_show');
                });
                $('#container').append($previewBox);
            }else{
                this.renderPreview(id);
            }
        },
        
        /**
         * 渲染预览界面
         */
        renderPreview : function(id){
        	var renderData = function(data){
        		data.contextPath = contextPath;
        		data.windowHeight = $(window).height();
        		data.extendNameChecked = KM.Util.checkExtendName(data.extendName);
        		var html = template('atp-preview', data);
                var $html = $(html).addClass('slideIn');
                $html.on('animationend webkitAnimationEnd', function(){
                    $html.removeClass('slideIn').addClass('js_show');
                });
                $('#container').append($html);
                //渲染完成后清空文件数据缓存
                KM.Util.cache.previewFile = null;
        	}
        	if(KM.Util.cache.previewFile != null){
        		renderData(KM.Util.cache.previewFile);	
        	}else{
        		var params = {
            		"nFileId":id	
            	};
            	KM.Service.openFile(params,function(data){
            		renderData(data);
                }) 
        	}         
        }
    },
    /**
     * 传输列表
     */
    upload : {
        init : function() {
        	KM.Util.controlPlaceholder("hide");
        	
        	$('#searchBar').hide();
            $('.my-bar').hide();
            
            this.renderUploadList();
        },
        renderUploadList : function(){
        	if(KM.Util.cache.uploader){
        		var webUploadList = KM.Util.cache.uploader.getFiles();
        		var uploadList = KM.Util.cache.uploadFiles;
        		if(webUploadList.length <= 0){
        			$('#container').find(".km-list").html("");
            		KM.Util.controlPlaceholder("show","content");
            	}else{
            		for(var i = 0;i < webUploadList.length;i++){
            			var renderStatus = "";
            			for(var r = 0;r < uploadList.length;r++){
            				if(uploadList[r].id == webUploadList[i].id){
            					
            					switch (uploadList[r].status) {
                    			case 'fileQueued'://加入文件
                    				renderStatus = "准备上传";
                    				break;
                    			case 'uploadProgress'://上传文件
                    				renderStatus = "正在上传";
                    				break;
                    			case 'uploadSuccess'://上传成功
                    				renderStatus = "上传成功";
                    				break;
                    			case 'uploadComplete'://上传完成
                    				renderStatus = "上传完成";
                    				break;
                    			}
            				}
            			}
            			webUploadList[i].renderSize = KM.Util.renderSize(webUploadList[i].size);
            			webUploadList[i].renderStatus = renderStatus;
            			webUploadList[i].extendName = KM.Util.checkExtendName(webUploadList[i].ext);            			
            		}
            		var data = {
            			"onwer" : userName,
            			"list" : webUploadList
            		}
            		var html = template('atp-upload-list-item', data);
                    $('#container').find(".km-list").html(html);
            	}
        	}else{
        		location.hash = "#my";
        	}
        },
        refreshUpList : function(type,file){
        	if(file && file.id){
        		var id = file.id;
            	if($(".my-upload-list__item").size()>0){
            		var $upFileBox = $(".my-upload-list__item[data-id='"+id+"']");
            		var statusText = "";
            		switch (type) {
        			case 'fileQueued'://加入文件
        				statusText = "准备上传";
        				break;
        			case 'uploadProgress'://上传文件
        				statusText = "正在上传";
        				break;
        			case 'uploadSuccess'://上传成功
        				statusText = "上传成功";
        				break;
        			case 'uploadComplete'://上传完成
        				statusText = "上传完成";
        				$upFileBox.find(".content__status").addClass("color_09bb07");
        				break;
        			}
            		$upFileBox.find(".content__status").text(statusText);
            	}
        	}
        	var $upNumBox = $(".weui-tabbar").find(".badge");
        	var uploadProgressNum = KM.Util.cache.uploader.getFiles("queued").length + KM.Util.cache.uploader.getFiles("progress").length;
    		if(uploadProgressNum <= 0){
    			$upNumBox.hide();
    		}else{
    			$upNumBox.text(uploadProgressNum).show();
    		}
        }
    },
    //刷新列表
    refreshList : function(){
    	var hash = location.hash;
    	if(hash != "#upload"){
    		var active = KM.Config.pageArguments[0];
        	if(active == "my" || active == "share" || active == "public" || active == "upload"){
        		KM.Core.main.init(KM.Config.pageArguments);
        	}else{
        		if(KM.Config.pageArguments.length <= 2){
        			//KM.Config.pageArguments.push(KM.Config.mainActive);
        		}
        		KM.Core.folder.init(KM.Config.pageArguments);
        	}
        	var mainActive = KM.Config.mainActive;
        	if(mainActive == 'my'){
                $('#searchBar').show();
                $('.my-bar').show();
            }else if(mainActive == 'share'){
                $('#searchBar').hide();
                $('.my-bar').hide();
            }else if(mainActive == 'public'){
                $('#searchBar').show();
                $('.my-bar').hide();
            }else if(KM.Config.isUploadList){
                $('#searchBar').hide();
                $('.my-bar').hide();
            }
    	}
    }
}