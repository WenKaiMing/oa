/**
 * 	后台预览的时候判断页面是否重构完成
 */
var isComplete = false; 

/**
 * 	判断视图是否设置了列宽
 */
var isSetWidth = false;

/**
 * 	列模型(之前为后台直接输出js数组,现改为前台定义)
 */
var columnModel = [];

//判断是否网格视图
var isSubGridView = jQuery("#obpm_subGridView").size()>0?true:false;

var subGridView = subGridView || {} ; 

subGridView = {
		
	config : {
		params : {}
	},
	
	init: function(){
		var _viewid = $("#_viewid").val();
		var _clearTemp = true;
		var _application = $("#applicationid").val();
		var	_resourceid = $("#resourceid").val();
		var _parentid = $("#parentid").val();
		var	_isRelate = $("#isRelate").val();

		this.config.params = {
			"_currpage" : 1,
			"_resourceid" : _resourceid,
			"_viewid" : _viewid,
			"application" : _application,	
			"isRelate" : _isRelate,	
			"clearTemp" : _clearTemp,
			"parentid" : _parentid
		}
		
		this.renderGridView();
		this.renderGridViewSort();
		
		//隐藏查询表单内容
		$("#searchFormTable").each(function(){	//只能用移动查询表单内容的方法，避免日期、下拉提示等控件事件丢失无法操作
			$('<script></script>').attr('type','text/obpm').attr('id',($(this).attr('id') + '_hide')).append($(this).children()).insertAfter($(this));
			$(this).remove();
		});
		
		this.bindEven();
		
		//判断页面加载完成 开始调整表格宽度
		var readyState = setInterval(function(){
			if(document.readyState=='complete'){ 
				subGridView.resizeGridViewTable();
				subGridView.config.gridBoxWidth = $(".obpm-view__table-hd").width();
				clearInterval(readyState);
			}
		},10);
		
	},
	
	bindEven: function(){
		var $gridBox = $("#gridView__box");
		
		$gridBox.on("click","td.obpm-isedit",function(){
			var colDocId = $(this).parent("tr").attr("id");
			subGridView.doRowEdit(colDocId,this);
		})

		//全选
		$gridBox.on("change",".obpm-view__table-hd input[data-active='selectAll']",function(){
			var $selectAll = $(this);
			var $gridTableBD = $(".obpm-view__table-bd");
			var status = $selectAll.prop("checked");

			$gridTableBD.find("input[name='_selects']").each(function(){
				$(this).prop("checked",status);
			})
		});
		
		//排序
		$gridBox.on("click",".obpm-view__table-hd td",function(){
			var $this = $(this);
			var id = $this.attr("data-id");
			var coltype = $this.attr("coltype");
			var colname = $this.attr("colname");
			
			if(coltype != "COLUMN_TYPE_ROWNUM" && id != "selectAll"){
				
				subGridView.renderGridViewSort(colname);
				
				
			}

		});
		
		$gridBox.on("click",".obpm-view__table-bd input[name='_selects']",function(e){
			e.stopPropagation();
		});

		//打开查询弹出层
		$("#searchBtn").on("click", function(){
			openSearch(this);
		});

		$(window).on("resize",function(){
			subGridView.resizeGridViewTable();
		})
	},
	
	renderGridView: function(){
		//showLoading();
		$("#isPagination").find("#pagination-panel").html("");
		doCancelAll();
		subGridView.renderGridViewTable();

		if(!subGridView.config.params._isPagination || subGridView.config.params._isPagination == "false"){
			$("#isPagination").height(10);
		}else{
			subGridView.renderPagination();
		}
		
		subGridView.resizeGridViewTable();
		ev_resize4IncludeViewPar();//旧方法 ：调整iframe的高度
		//hideLoading();
		//触发iframe刷新
		var viewParams = subGridView.getGridViewParams();
		parent.$("#"+viewParams._viewid).trigger("load");
	},
	
	renderGridViewSort: function(coltext){
		var _sortStatus = $("#_sortStatus").val();
		if(!coltext){
			var _sortCol = $("#_sortCol").val();
		}else{
			var _sortCol = coltext;
		}
		var sortAscIcon = "<i class='fa fa-long-arrow-up'></i>";
		var sortDescIcon = "<i class='fa fa-long-arrow-down'></i>"; 
		subGridView.config.params._sortStatus = _sortStatus;
		subGridView.config.params._sortCol = _sortCol;
		subGridView.renderGridView();	
		var $td = $(".obpm-view__table-hd").find("td[colname='"+_sortCol+"']");
		if(_sortStatus == "ASC"){
			$td.append(sortAscIcon);
			$("#_sortStatus").val("DESC");
		}else{
			$td.append(sortDescIcon);
			$("#_sortStatus").val("ASC");
		}
	},

	//渲染表格
	renderGridViewTable: function(params){
		if(!params){
			var params = subGridView.config.params;
		}
		var $isPagination = $("#isPagination");
		$isPagination.find("input[name='_currpage']").val(params._currpage);
		var $containerParams = $("#container-params");
		$containerParams.find("input[name='_currpage']").val(params._currpage);
		
		
		params.isedit = $containerParams.find("input[name='isedit']").val();
		subGridView.getGridViewHtml(params,function(result){
			var tableData = result.data;
			var $gridViewBox = $("#gridView__box");
			var pageOption = {
				'_isPagination': result.isPagination,
				'_isShowTotalRow': result.isShowTotalRow,
				'_currpage': result.currpage,
				'_pageCount': result.pageCount,
				'_pagelines': result.pagelines,
				'_totalRowText': result.rowcount,
				'_isShowItem': 'false'
			}

			//参数添加是否渲染分页
			params._isPagination = result.isPagination;
			//参数添加总条数 用于判断是否渲染分页
			params._pageCount = parseInt(result.pageCount);

			//数据为空
			if(tableData.length <= 0){
				if(pageOption._currpage - 1 <= 0){
					//$("#gridview-container").addClass("obpm-placeholder");
					//$gridViewBox.hide();
				}else{
					pageOption._currpage = params._currpage = pageOption._currpage - 1;
					pageOption._pageCount = pageOption._pagelines;
					$("#isPagination").find("#pagination-panel").attr("data-options",JSON.stringify(pageOption));
					subGridView.renderGridViewTable();
					return false;
				}	
			}else{
				if($("#gridview-container").hasClass("obpm-placeholder")){
					$("#gridview-container").removeClass("obpm-placeholder");
				}
				
				if($("#gridView__box").is(":hidden")){
					$("#gridView__box").show();
				}
			}
			
			$("#isPagination").find("#pagination-panel").attr("data-options",JSON.stringify(pageOption));
			for(var i = 0;i < tableData.length;i++){
				var tableDataItem = tableData[i];
				var docId = tableDataItem.docId;
				$.each(tableDataItem,function(key,data){
					if(key != "docId"){
						var newData = subGridView.renderGridViewData(data);
						tableDataItem[key] = newData;
					}
				})
			}

			var tableHtml = template('atp-gridview-table', result);
			$gridViewBox.html(tableHtml);

			//表单控件jquery重构
			jqRefactor();	
			//表单没有操作权限的时候，网格视图按钮隐藏
			hiddenGridBtn();
			
			oTable = document.getElementById('obpm-view__table');

			//根据表格横向滚动距离设置列头横向滚动距离
			$(".obpm-view__table-bd_scroll").on("scroll",function(e){
				var $hbS = $(".obpm-view__table-hd_scroll");
				var left = $(".obpm-view__table-bd_scroll").getNiceScroll(0).scrollLeft();
				$hbS.scrollLeft(left);
			});
		});
	},
	
	//渲染分页
	renderPagination: function(){
		var params = subGridView.config.params;
		if(params._isPagination){
			if(params._pageCount <= 0){
				
			}else{
				Common.Util.renderPagination("isPagination",function(page){
					var params = subGridView.config.params;
					params._currpage = page + 1;
					$("#isPagination").find("a").on("click",function(){
						subGridView.renderGridView();
					})
				});
			}
		}
	},
	//当不出横向滚动条的时候,即列少,计算table的宽度
	gridViewWidthLess: function(){
		var $gridViewBox = $("#gridView__box");
		var $gridViewTable = $("#obpm-view__table");
		var $gridViewHdS = $gridViewBox.find(".obpm-view__table-hd_scroll");
		var $gridViewBdS = $gridViewBox.find(".obpm-view__table-bd_scroll");
		var $gridViewHdFirstTr = $gridViewHdS.find(".table").find("tr:eq(0)");
		var $gridViewBdFirstTr = $gridViewTable.find(">tr:eq(0)");
		var $gridViewBdTr = $gridViewTable.find(">tr");
		
		var widthTotal = $(window).width()-32;	//2px是左右border-width
		
		//设置table外div宽度
		$gridViewHdS.find(".obpm-view__table-hd").outerWidth(widthTotal);
		$gridViewBdS.find(".obpm-view__table-bd").outerWidth(widthTotal);
		
		var leng = $gridViewHdFirstTr.find(">td").length;	//计算固定列头的td的数量
		//根据固定表头的列宽设置数据表格的列宽
		$gridViewHdFirstTr.find(">td").each(function(num){
			var dataWidth = $(this).data("width");
			if(dataWidth && dataWidth != "auto" && dataWidth.toString().indexOf("px") >= 0){	//当td设固定列宽或者选择列、序号列、操作列
				var width = parseInt(dataWidth.substr(0,dataWidth.indexOf("px")));
				
			}else{
				var width = $(this).outerWidth();
			}	
			if($(this).find("input.obpm-check").size()<=0){		//非选择列设td的style
				$gridViewBdS.find("colgroup").find(">col:eq("+num+")").attr("width", width+"px");
				if(num != (leng-1)){	//操作列，列少时，需要一个列不设宽度让浏览器自动分配解决固定列不生效
					//$gridViewHdFirstTr.find(">td:eq("+num+")").css("width",width);
					
					$.each($gridViewBdTr,function(){	//内容所有行的每一列控件需设宽度出内部滚动条
						var $td = $(this).find(">td:eq("+num+")");
						$td.css({
							"width":width,
							"height":"100%"
						});
						
						//td内部的控件外层的div设宽度，出内部滚动条，避免与固定列不对齐
						$td.find(".grid-column-show").outerWidth((width-18));
						$td.find(".grid-column-edit").outerWidth((width-18));
						$td.find(".grid-column-edit").css("min-height","50px");
					});
				}
			}
		})
	},
	//当出横向滚动条的时候,即列多,计算table的宽度
	gridViewWidthMore: function(){
		var $gridViewBox = $("#gridView__box");
		var $gridViewTable = $("#obpm-view__table");
		var $gridViewHdS = $gridViewBox.find(".obpm-view__table-hd_scroll");
		var $gridViewBdS = $gridViewBox.find(".obpm-view__table-bd_scroll");
		var $gridViewHdFirstTr = $gridViewHdS.find(".table").find("tr:eq(0)");
		var $gridViewBdFirstTr = $gridViewTable.find(">tr:eq(0)");
		var $gridViewBdTr = $gridViewTable.find(">tr");
		
		var widthTotal = 0;	//固定列头的宽度
		
		if(subGridView.config.gridBoxWidth){
			widthTotal = subGridView.config.gridBoxWidth;
		}else{
			//循环固定列头的td，获取总宽度
			$gridViewHdFirstTr.find(">td").each(function(num){
				var dataWidth = $(this).data("width");
				var width=0;
				if(num == 0 || $(this).attr("class").indexOf("obpm-hide") == -1){	//首列和非隐藏列
					if(dataWidth && dataWidth.toString().indexOf("px") != -1){	//列宽为“px”就获取设置值显示,百分比或者不带单位的就获取浏览器分配的列宽
						width = parseInt(dataWidth.substr(0,dataWidth.indexOf("px")));
						$(this).css("width",width);
					}else{
						width = $(this).outerWidth();
					}
				}
				//操作列时判断是否存在编辑行 再计算宽度
				if($(this).data("id") == "actions"){
					if(editingRows && editingRows.length > 0){
						widthTotal = widthTotal + width;
					}
				}else{
					widthTotal = widthTotal + width;
				}				
			})
			//因为table和tbody宽度不同 补差
			widthTotal = widthTotal + 1;
		}

		//给table外div设置宽度
		$gridViewHdS.find(".obpm-view__table-hd").width(widthTotal);
		$gridViewBdS.find(".obpm-view__table-bd").width(widthTotal);
		
		//设置表格各列宽度
		$gridViewHdFirstTr.find(">td").each(function(num){
			var width = $(this).outerWidth();
			if($(this).find("input.obpm-check").size()<=0 && $(this).attr("class").indexOf("obpm-hide") == -1){		//非选择列且非隐藏
				$gridViewBdS.find("colgroup").find(">col:eq("+num+")").attr("width", width+"px");		//固定列宽，用col
				
				$.each($gridViewBdTr,function(){	//内容所有行的每一列控件需设宽度出滚动条
					var $td = $(this).find(">td:eq("+num+")");
					
					//td内部的控件外层的div设宽度，出内部滚动条，避免与固定列不对齐
					$td.find(".grid-column-show").outerWidth((width-18));
					$td.find(".grid-column-edit").outerWidth((width-18));
					$td.find(".grid-column-edit").css("min-height","50px");
				});
			}
			//当时数据列且隐藏
			if($(this).find("input.obpm-check").size()<=0 && $(this).attr("class").indexOf("obpm-hide") != -1){		//非选择列且非隐藏
				$gridViewBdS.find("colgroup").find(">col:eq("+num+")").css("display", "none");
			}
			
		})
		
	},
	//计算class为gridView__bd的外边距（包括边框）
	countGridViewGap: function(){
		var $gridViewBd = $(".gridView__bd ");
		var gridViewGap = parseInt($gridViewBd.css('margin-left'))+parseInt($gridViewBd.css('margin-right'));
		gridViewGap = gridViewGap + 2;	//border-width
		return gridViewGap;
	},
	//计算table宽度
	resizeGridViewTable: function(){
		var $gridViewBox = $("#gridView__box");
		var $gridViewTable = $("#obpm-view__table");
		var $gridViewHdS = $gridViewBox.find(".obpm-view__table-hd_scroll");
		var $gridViewBdS = $gridViewBox.find(".obpm-view__table-bd_scroll");
		var $gridViewHdFirstTr = $gridViewHdS.find(".table").find("tr:eq(0)");
		var $gridViewBdFirstTr = $gridViewTable.find(">tr:eq(0)");
		var $gridViewBdTr = $gridViewTable.find(">tr");
		
		//计算表格宽度 设置外层div宽度
		var gridViewGap = subGridView.countGridViewGap();

		if(subGridView.config.gridBoxWidth){		
			var gridViewWidth = subGridView.config.gridBoxWidth;
		}else{			
			var gridViewWidth = $gridViewHdS.find("table").outerWidth();
		}

		if(gridViewWidth < $(window).width() - gridViewGap){		//当不出横向滚动条的时候，即列少
			subGridView.gridViewWidthLess();
		}else{		//当列多，出横向滚动条
			subGridView.gridViewWidthMore();
		}
		
		var bdScroll = $gridViewBdS.getNiceScroll();
		//初始化滚动条
		if(bdScroll.length<=0){
			Common.Util.renderScroll($gridViewBdS,{autohidemode: false});
		}else{
			bdScroll.resize();
		}		
	},
	
	//改造table模板数据
	renderGridViewData: function(data){
		
		var fieldType = data.fieldType;
		var colWidth = data.colWidth;
		var colGroundColor = data.colGroundColor;
		var colColor = data.colColor;
		var colType = data.colType;
		var colFontSize = data.colFontSize;
		var colIsEdit = data.colIsEdit;
		var colIsEditCls = data.colIsEditCls;
		var colDocId = data.colDocId;
		var colIsHideCls = data.colIsHideCls;
		var displayType = data.displayType;
		var displayLength = data.displayLength;
		var colContent = data.colContent;
		var $colContent = $("<div>"+colContent+"</div>")
		var _colContent = "";
		switch(colType){
			//序号列
			case "COLUMN_TYPE_ROWNUM":
				//列宽
				if(colWidth != "" && colWidth != "null" && colWidth != undefined) {
					colWidth = colWidth;
				}else{
					colWidth = "100px";
				}
				_colContent = colContent;
				break;
			case "COLUMN_TYPE_SCRIPT":
				_colContent = colContent;
				break;
			case "COLUMN_TYPE_FIELD":
				var $showHtml = $colContent.find(".grid-column-show");
				var $editHtml = $colContent.find(".grid-column-edit");
				var _showHtml = $showHtml.html();
				var _editHtml = $editHtml.html();
				
				var showHtml = "";
				
				if(fieldType == "onlinetakephoto"){//在线拍照
					if(_showHtml && _showHtml.trim()){
						var url = $(_showHtml).attr("url").replace(/\\'/g,"");
						showHtml = "<img style='display:block;max-width:100%;' src='"+url+"' />";
					}
				}else if(fieldType == "imageupload"){//图片上传
					if(_showHtml && _showHtml.trim()){
						var instances = JSON.parse(_showHtml);
						$.each(instances,function(key,data){
							var attachmentName = data.name;
							var attachmentPath = data.path;
							showHtml += "<img src='"+contextPath+attachmentPath+"' width='100px'>";
						})
					}	
				}else if(fieldType == "attachmentupload"){//附件上传
					if(_showHtml && _showHtml.trim()){
						if(colIsEdit){
							var instances = JSON.parse(_showHtml);	
							$.each(instances,function(key,data){
								var attachmentName = data.name;
								var attachmentPath = data.path;
								showHtml += attachmentName + " ";
							})	
						}else{
							showHtml += _showHtml;
						}
									
					}
				}else if(fieldType == "weixingpsfield"){//微信GPS定位
					if(_showHtml && _showHtml.trim()){
						var location = JSON.parse(_showHtml);
						showHtml = location;
						var _editHtml = location;
					}
				}else if(fieldType == "weixinrecordfield"){//微信录音
					var recordHtml = '<div class="weixin_record"><img src="../../share/images/view/voice.png" width="21px"/></div>';
					showHtml = recordHtml;
					var _editHtml = recordHtml;

				}else if(fieldType == "genericwordfield" ){//通用word控件
					//&& _showHtml.indexOf("{")==0
					if(_showHtml && _showHtml.trim()){
						var btnHtml = "<img src='../../share/images/view/genericword.jpg'></img>";
						showHtml = btnHtml;
					}			
				}else{//其他
					showHtml = _showHtml;
				}
				
				var result = {
					"showId" : $showHtml.attr("id"), 
					"showHtml" : showHtml,
					"editId" : $editHtml.attr("id"), 
					"editHtml" : _editHtml
				}
				_colContent = template('atp-gridview-td', result);
				break;
			default:
				if(fieldType == "actions"){
					var $showHtml = $colContent.find("div:eq(0)");
					var $editHtml = $colContent.find("div:eq(1)");
					$editHtml.find(".grid-button-cancel").addClass("btn btn-default");
					
					var _showHtml = $showHtml.html();
					var _editHtml = $editHtml.html();
					
					var result = {
						"showId" : $showHtml.attr("id"), 
						"showHtml" : _showHtml,
						"editId" : $editHtml.attr("id"), 
						"editHtml" : _editHtml
					}
					_colContent = template('atp-gridview-td', result);
				}
		}
		
		//调整列宽
		if(colWidth != "" && colWidth != "null" && colWidth != undefined) {
			colWidth = colWidth;
		}else{
			colWidth = "auto";
		}

		//构建新数据
		var _data = {
			"fieldType": fieldType,
			"colWidth": colWidth,
			"colGroundColor": colGroundColor,
			"colColor": colColor,
			"colType": colType,
			"colFontSize": colFontSize,
			"colIsEdit": colIsEdit,
			"colIsEditCls": colIsEditCls,
			"colDocId": colDocId,
			"colIsHideCls": colIsHideCls,
			"displayType": displayType,
			"displayLength": displayLength,
			"colContent": _colContent	
		};
		return _data;
	},
	/**
	 * 新建行
	 */
	createTr : function(oTR){
		if (oTR) {
			newRows.push(oTR.attr("id"));
			subGridView.insertRow(oTR[0], 0);	//0插入首行
			subGridView.doRowEdit(oTR.attr("id"));
		}

		jQuery("#" + oTR.attr("id")).bind('change',function(){
			setFieldValChanged(true);
		}).bind("keydown",function(e){
			var key = e.which;
			if (this.type != "textarea" && key == 13) {
				e.preventDefault(); //按enter键时阻止表单默认行为
			}
		});
		showOrHideActionTd();	//当前表格是否要显示操作列		
		//jquery重构按钮和控件
		jqRefactor();
		ev_resize4IncludeViewPar(); // 调整高度
	},

	/**
	* 插入行
	* @param {} oTR
	*/
	insertRow: function(oTR, index){
		
		$("#gridview-container").removeClass("obpm-placeholder");
		$("#gridView__box").show();

		var origTR = oTable.rows[index];
		if (origTR) {
			oTable.insertBefore(oTR, origTR); // origTR为空则插入到最后一行
		} else {	//无节点时插入表格内
			oTable.appendChild(oTR);
		}
		$(oTR).find(".grid-button-cancel").addClass("btn btn-default");
		$(oTR).find("input[name='_selects']").focus();
	},
	/**
	* 编辑行
	* @param {} rowId
	*/
	doRowEdit: function(rowId, event){
		$("a.btn[autoBuild='true']").removeClass("hide");
		
		

		// 没有正在编辑的表格行，及不为当前编辑行时，进行模式切换
		if (isEditAble(rowId)) {
			origTRs[rowId] = $("#"+ rowId).clone(true)[0]; // 保留原TR模型
			origRecords[rowId] = getRecordById(rowId); // 保留原TR数据
			for (var i = 0; i < columnModel.length; i++) {
				if(columnModel[i] == null || columnModel[i] == "" || columnModel[i] == undefined){
					continue;
				}
				var editorId = rowId + "_" + columnModel[i];
				var $th = $("tr").find("[coltext='"+columnModel[i]+"']")
				var editorType = $th.attr("coltype");
				//网格视图脚本列新建时不显示内容 -  
				if(editorType && editorType == "COLUMN_TYPE_SCRIPT"){
					var $_td = $("#"+rowId).find("td:eq("+$th.index()+")");
					$_td.find(".grid-column-show").hide();
					$_td.find(".grid-column-edit").remove();
				}else{
					doEdit(editorId);
				}
			}
			var $el = null;
			if ($el = jQuery(event)) {
				// 获取"Show DIV"的下一个元素"Edit DIV"中的Editor
				try {
					var currentEditorId = $el.next().children().eq(0).attr("id");
					doSelect(currentEditorId); // 当前选中的编辑器ID
				} catch (ex) {
					// alert(ex);
				}
			}
			$("#"+ rowId).removeClass('table-tr-onchange');
			$("#"+ rowId).addClass('grid-rowselected');
			showOrHideActionTd();	//当前表格是否要显示操作列
			$("#" + rowId).bind('change',function(){
				setFieldValChanged(true);
			}).bind("keydown",function(e){
				 var key = e.which;
				 if (this.type != "textarea" && key == 13) {
				 	e.preventDefault(); //按enter键时阻止表单默认行为
				 }
			});
			/**
			 * 点击行编辑的时候,重计算本文档
			 */
			if(event){
				DocumentUtil.doRefreshRow4subGridView(rowId, subGridView.getGridViewParams(), function(rtn) {
					var oTR = eval(rtn);
					var record = _getRecordByRefreshTR(oTR);
					for (var i = 0; i < columnModel.length; i++) {
						if(columnModel[i].indexOf("$") >= 0) break;	//列是系统字段名时，返回
						var editorId = rowId + "_" + columnModel[i];
						var data = record[columnModel[i]];
						var $edit = jQuery("#"+ editorId);
						if ($edit && data) {
							if($edit.attr("type")== 'radio' || $edit.attr("type")== 'checkbox'){
								jQuery.each($("input[name=editorId]"),function(){
									if($(this).val()==data){
										$(this).prop("checked",true);
									}else{
										$(this).prop("checked",false);
									}
								});
							}else{
								$edit.val(data);
							}
						}
					}
				});
			}
			editingRows.push(rowId);
			
			//jquery重构按钮和控件
			jqRefactor();
			ev_resize4IncludeViewPar(); // 调整高度
		}
		subGridView.resizeGridViewTable();
	},

	//获取视图数据
	getGridViewHtml: function(params,callback){
		showLoading();
		$.ajax({
			url: contextPath + "/portal/dynaform/view/displayView4Ajax.action",
    		async: false,
    		cache:false,
    		data:params,
			success: function(html){
				var $html = $("<div>"+html+"</div>");
				var viewJson = subGridView.subGridViewTable2Json($html);
				if(callback && typeof callback == "function"){
					callback(viewJson);
				}
				hideLoading();
			}
		})
	},
	
	//获取视图各类参数
	getGridViewParams: function(){
		var params = {
			"_selects":[]
		};
		
		var $params = $("#container-params");
		$params.find("input,textarea").each(function(){
			var $this = $(this);
			var name = $this.attr("name");
			if($this.is("input")){
				var value = $this.val();
			}else if($this.is("textarea")){
				var value = $this.text();
			}
			if(name && value){
				params[name] = value;
            }
		})
		
		var $gridViewBox = $("#gridView__box");
		$gridViewBox.find("input[name='_selects']").each(function(){
			var $this = $(this);
			if($this.prop("checked")){
				params["_selects"].push($this.val());
			}
		})

		return params;
	},
	//文件下载
	downloadFile : function(url,params){
		var html = '';
		$.each(params,function(name,val){
			html += '<textarea name="'+name+'">'+val+'</textarea>';
		});
		var f = $('<form></form>').attr('method','post').attr('action',url).append(html);
		$('body').append(f);
		f.submit().remove();
	},
	//创建网格视图Json数据
	subGridViewTable2Json: function($html){
		var $table = $html.find("table[moduleType='subGridView']");
		var $tableTr = $table.find("tr"); 
		
		var _isPagination = $html.find("[name='_isPagination']").val();
		var _isShowTotalRow = $html.find("[name='_isShowTotalRow']").val();
		var _currpage = $html.find("[name='_currpage']").val();
		var _pagelines = $html.find("[name='_pagelines']").val();
		var _rowcount = $html.find("[name='_rowcount']").val();
		var _pageCount = $html.find("[name='_pageCount']").val();
		
		var _sortCol = $table.attr("_sortCol");
		var _sortStatus = $table.attr("_sortStatus");
		var isSum = $table.attr("isSum");
		isSum = (isSum == "true");
		
		var viewJson = {
			"isPagination" : _isPagination,
			"isShowTotalRow" : _isShowTotalRow,
			"currpage" : _currpage,
			"pagelines" : _pagelines,
			"rowcount" : _rowcount,
			"pageCount" : _pageCount,
			"isSum" : isSum,
			"isSelect" : true,
			"sortCol" : _sortCol,
			"sortStatus" : _sortStatus,
			"columns" : [],
			"data" : [],
			"sumTrData": []
		}
		
		$tableTr.each(function(i){
			var $tr = $(this);
			if(i == 0){//首行
				$tr.find("td").each(function(j){
					var $td = $(this);
					var _column;
					if(j > 0 && j < $table.find("tr:eq(0)").find("td").size()-1){//其他列
						var id = $td.attr("id");
						var colText = $td.attr("coltext");
						var colType = $td.attr("coltype");
						var colWidth = $td.attr("colwidth");
						var colFieldName = $td.attr("colfieldname");
						var value = $td.attr("value");
						var isVisible = ($td.attr("isvisible") == "true");
						var isHiddenColumn = ($td.attr("ishiddencolumn") == "true");
						var isBlank = ($td.attr("isblank") == "true");
						var isEmpty = ($td.attr("isempty") == "true");
						var isOrderByField = ($td.attr("isorderbyfield") == "true");
						
						var colIsHideCls = "";
						if(isHiddenColumn || !isVisible){
							colIsHideCls = "obpm-hide";
						}

						//调整列宽设置
						if(colType == "COLUMN_TYPE_ROWNUM"){
							colFieldName = "序号"
							if(colWidth != "" && colWidth != "null" && colWidth != undefined) {
								//
							}else{
								var colWidth = "100px";
							}
						}else{
							if(colWidth != "" && colWidth != "null" && colWidth != undefined) {
								//
							}else{
								var colWidth = "auto";
							}
						}
						
						_column = {
							"field": "column_"+j,
							"title": colFieldName,
							"colName": colFieldName,
							"id": id,
							"colText": colText,
							"colType": colType,
							"colWidth": colWidth,
							"value": value,
							"isVisible": isVisible,
							"colIsHideCls": colIsHideCls,
							"isBlank": isBlank,
							"isEmpty": isEmpty,
							"isOrderByField": isOrderByField
						};
						columnModel.push(colFieldName);
					}else{//末列 Actions
						var actions = $td.attr("actions");
						if(actions){
							_column = {
								"colWidth" : "90px",
								"field": "actions",
								"title": actions,
								"colText": actions
							};
							columnModel.push("actions");
						}
					}
					
					if(j > 0){
						viewJson.columns.push(_column);
					}
				})
			}else if($tr.attr("id") == "sumTrId"){//汇总行
				var _data = {};
				$tr.find("td").each(function(j){
					var $td = $(this);
					if(j > 0 && j < $table.find("tr:eq(0)").find("td").size()-1){//其他列
						
						var isVisible = ($td.attr("isvisible") == "true");//"true"
						var isHiddenColumn = ($td.attr("ishiddencolumn") == "true");//"false";
						var isSum = $td.attr("isSum");//"false";
						var isTotal = $td.attr("isTotal");//"false";
						var colName = $td.attr("colName");//"序号";
						var sumByDatas = $td.attr("sumByDatas");//"";
						var sumTotal = $td.attr("sumTotal");//"";
						var colContent = $td.html();
						
						var colIsHideCls = "";
						if(isHiddenColumn || !isVisible){
							colIsHideCls = "obpm-hide";
						}
						
						_data["column_"+j] = {
							"isVisible": isVisible,
							"isSum": isSum,
							"isTotal": isTotal,
							"colName": colName,
							"sumByDatas": sumByDatas,
							"sumTotal": sumTotal,
							"colIsHideCls": colIsHideCls,
							"colContent": colContent
						};
					}else{//末列 Actions
						var content = $td.html();
						_data["actions"] = {
							"colIsHideCls": "",
							"colContent": content
						};
					}
					
				});
				viewJson.sumTrData.push(_data);
			}else{//数据行
				var _data = {};
				$tr.find("td").each(function(j){
					var $td = $(this);
					if(j > 0 && j < $table.find("tr:eq(0)").find("td").size()-1){//其他列
						var fieldType = $td.attr("fieldType");
						var colWidth = $td.attr("colWidth");
						var colGroundColor = ($td.attr("colGroundColor") && $td.attr("colGroundColor") != "null" && $td.attr("colGroundColor") != "FFFFFF")?$td.attr("colGroundColor"):'';
						var colColor = $td.attr("colColor");
						var colType = $td.attr("colType");
						var colFontSize = $td.attr("colFontSize");
						var colIsEdit = $td.attr("colIsEdit");
						var colDocId = $td.attr("colDocId");
						var isVisible = ($td.attr("isvisible") == "true");//"true"
						var isHiddenColumn = ($td.attr("ishiddencolumn") == "true");
						var displayType = $td.attr("displayType");
						var displayLength = $td.attr("displayLength");
						var colContent = $td.html();
						
						var colIsEditCls = "";
						colIsEdit = (colIsEdit == "true");
						if(colIsEdit){
							colIsEditCls = "obpm-isedit";
						}
						if( colType== "COLUMN_TYPE_ROWNUM"){
							colContent = i;
						}

						var colIsHideCls = "";
						if(isHiddenColumn || !isVisible){
							colIsHideCls = "obpm-hide";
						}
						
						colDocId = colDocId?colDocId:"sumTrId";
						_data.docId = colDocId;
						_data["column_"+j] = {
							"fieldType": fieldType,
							"colWidth": colWidth,
							"colGroundColor": colGroundColor,
							"colColor": colColor,
							"colType": colType,
							"colFontSize": colFontSize,
							"colIsEdit": colIsEdit,
							"colIsEditCls": colIsEditCls,
							"colIsHideCls": colIsHideCls,
							"displayType": displayType,
							"displayLength": displayLength,
							"colContent": colContent
						};	
					}else{//末列 Actions
						var content = $td.html();
						_data["actions"] = {
							"colWidth" : "auto",
							"fieldType": "actions",
							"colContent": content
						};
					}
				})
				viewJson.data.push(_data);
			}
		})
		return viewJson;
	}
}

//TODO ------------------------------------- 以下为待整理的旧方法，部分还在使用

/**
 * grid.js方法
 * @return
 */



var activityAction = contextPath + '/portal/dynaform/activity/action.action';

//正在编辑的字段
var editingElements = [];

//已发生改变的数据
var modifiedRecords = {};

//编辑前的数据
var origRecords = {};

//编辑前的表格行模型
var origTRs = {};

//正在编辑的表格行
var editingRows = [];

//新建但尚未保存的表格行
var newRows = [];

//obpm.subGridView.js中赋值
var oTable = null;

var selectionName = "_selects";

/**
* 离开表单页面是否检验
*/
var fieldValChanged = false;


//返回表单是否修改的变量
function getFieldValChanged() {
	return fieldValChanged;
}

//设置表单是否修改的变量
function setFieldValChanged(val) {
	return fieldValChanged = val;
}
/**
* 当前表格是否要显示操作列
* 编辑状态显示，非编辑状态隐藏
* @param {}
*            rowId 表格行ID
* @return {}
*/
function showOrHideActionTd(){
	var hasEditTr = false;	//不存在正在编辑的行
	var $gridTableTr = $("#gridView__box #obpm-view__table >tr");
	$gridTableTr.each(function(){
		if($(this).hasClass("grid-rowselected")){
			hasEditTr = true;
			return false;
		}
	});
	if($gridTableTr.size() > 0 && !hasEditTr){
		$("#gridView__box #obpm-view__table >tr >td:last-child").hide();
		$("#gridView__box .obpm-view__table-hd table tr td:last-child").hide();
	}else{
		$("#gridView__box #obpm-view__table >tr >td:last-child").show();
		$("#gridView__box .obpm-view__table-hd table tr td:last-child").show();
	}
}


/**
* 当前表格行是否可编辑
* 
* @param {}
*            rowId 表格行ID
* @return {}
*/
function isEditAble(rowId) {
	if(jQuery.inArray(rowId,editingRows)==-1){
		return isedit = true ;
	}else{
		return isedit = false;
	};
}

/**
* 选中编辑器
* 
* @param {}
*            id
*/
function doSelect(id) {
	var $editor = jQuery("#"+ id);
	if (!$editor) {
		return;
	}
	switch ($editor.attr("fieldType")) {
		case "InputField" :
			$editor.select();
			break;
		case "NumberField" :
			$editor.select();
			break;
		case "SelectField" :
			$editor.focus();
			break;
		case "CheckboxField" :
			break;
		case "RadioField" :
			break;
		case "TextAreaField" :
			$editor.select();
			break;
		case "DateField" :
			$editor.focus();
			break;
		default :
			break;
	}
}

/**
* 编辑单元格
* 
* @param {}
*            id 编辑器ID
*/
function doEdit(editorId) {
	jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","");
	if(editorId.indexOf("$") >= 0) return;	//列是系统字段名时，返回
	var editor = jQuery("#" + editorId);
	if (!editor) {
		return;
	}
	if(editor.attr("fieldtype") == "SuggestField"){editor.parent().parent().parent().css("overflow","");}
	var editDiv = jQuery("#" + editorId + "_edit");
	var showDiv = jQuery("#" + editorId + "_show");
	if (showDiv && editDiv) {
		editDiv.show();
		showDiv.hide();
	}
}

/**
* 表格行编辑后操作
* 
* @param String
*            rowId 行ID
*/
function doAfterRowEdit(rowId) {
	if (jQuery.inArray(rowId,editingRows) != -1) {
		for (var i = 0; i < columnModel.length; i++) {
			doAfterEdit(rowId + "_" + columnModel[i]);
		}
		editingRows=jQuery.grep(editingRows,function(val,key){
			return val==rowId;
		},true);
		newRows=jQuery.grep(newRows,function(val,key){
			return val==rowId;
		},true);
		jQuery("#" + rowId).removeClass('grid-rowselected');
		showOrHideActionTd();	//当前表格是否要显示操作列
		ev_resize4IncludeViewPar();
		
		jQuery(".imgClick").bind("click",function(event){
			event.stopPropagation();
		});
	}
}

/**
* 编辑后操作
* 
* @param {}
*            id 编辑器ID
*/
function doAfterEdit(id) {
	if(id.indexOf("$") >= 0) return;	//列是系统字段名时，返回
	var editor = jQuery("#" + id);
	if (!editor) {
		return;
	}
	var editDiv = jQuery("#" + id + "_edit");
	var showDiv = jQuery("#" + id + "_show");
	var rtn = "&nbsp";
	var value = editor.val();
	var fieldType = "";
	if(editor){
		fieldType = editor.attr("fieldtype");
	}
	var pre = editor.parent();
	var showType = "";	//真实值；显示值
	var displayType = "";	//显示部分；显示全部
	if(pre){
		showType = pre.attr("showType");
		displayType = pre.attr("displayType");
	}
	switch (fieldType) {
		case 'UserField' :
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = jQuery("#" + id + "_text").val();
			}
			break;	
		case 'SelectField' :
			if (editor.find("option").length > 0) {
				if(displayType == "01")
					value = showDiv.html();
				else{
					if(showType == "01")
					value = editor.find("option:selected").text();
					else
					value = editor.find("option:selected").val();
				}
			}
			break;
		case 'RadioField' :
			var els = document.getElementsByName(editor.attr("name"));
			for (var i = 0; i < els.length; i++) {
				if (els[i].checked) {
					if(displayType == "01")
						value = showDiv.html();
					else{
						if(showType == "01")
							value = els[i].getAttribute("text");
						else
							value = els[i].value;
					}
				}
			}
			break;
		case 'SelectAboutField' :
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).attr("title");
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getT;
				else{
					var edit_id = jQuery("#"+ id + "_edit");
					var selectName = jQuery("#"+ id).attr("name");
					var selectedVal ="";
					var optionSize = jQuery(edit_id).find("[id= " + selectName + "ms2side__dx]").find("option").size();
					jQuery(edit_id).find("[id= " + selectName + "ms2side__dx]").find("option").each(function(i){
						selectedVal += jQuery(edit_id).find("[id= " + selectName + "ms2side__dx]").find("option").eq(i).text();
						if(i != optionSize - 1){
							selectedVal+=";" ;
						}
					});
					value = selectedVal;
				}
			}
			break;
		case 'SuggestField' :
			var pre = editor.parent().parent();
			var showType = "";
			if(pre) {
				showType = pre.attr("showType");
				displayType = pre.attr("displayType");
			}
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).attr("text");
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getT;
			}
			break;
		case 'TreeDepartmentField' :
			var show_id = document.getElementById(editor.attr("id") + "_text");
			var getV = jQuery(show_id).val();
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getV;
			}
			break;
		case 'OnLineTakePhotoField':
			var pre = document.getElementById(editor.attr("id") + "_edit");
			var showType = jQuery(pre).attr("showType");
			var displayType = jQuery(pre).attr("displayType");
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).html();
			if(showType == "01" || displayType == "01")
				value = getT;
			break;
		case 'CheckboxField' :
			var getT = jQuery("#" + editor.attr("id") + "_show").attr("title");
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getT;
			}
			break;
		case 'AttachmentUploadField' :
			var pre = editor.parent().parent().parent().parent().parent();
			var showType = "";
			if(pre){
				showType = pre.attr("showType");
				displayType = pre.attr("displayType");
				}
			if(editor.attr("id")){
				var show_id = document.getElementById(editor.attr("id") + "_show");
				var getT = jQuery(show_id).attr("title");
				if(displayType == "01")
					value = showDiv.html();
				else{
					if(showType == "01")
						value = getT;
				}
			}
//			var fileInfo = new Object(value.split(";")[0] + "..."); // 查看upload.js
//			value = fileInfo.showName;
			break;
		case 'AttachmentUploadToDataBaseField':
			var pre = document.getElementById(editor.attr("id") + "_edit");
			var showType = jQuery(pre).attr("showType");
			var displayType = jQuery(pre).attr("displayType");
			var getT = jQuery("#" + editor.attr("id") + "_show").attr("title");
			if(displayType == "01")
				value = showDiv.html();
			else{
				if(showType == "01")
					value = getT;
			}
			break;
		case 'ImageUploadField' :
			var pre = editor.parent().parent().parent().parent().parent();
			var showType = "";
			if(pre) {
				showType = jQuery(pre).attr("showType");
				displayType = jQuery(pre).attr("displayType");
			}
			if(editor.attr("id")){
				var name = editor.attr("id").substring(editor.attr("id").indexOf("_") + 1);
				var getT = jQuery("div[name=" + name + "_gridView]").html();
				if(displayType == "01")
					value = showDiv.html();
				else{
					if(showType == "01")
						value = getT;
				}
			}
//			if (value) {
//				var fileInfo = new Object(value.split(";")[0]); // 查看upload.js
				// value = '<img border="0" src="'+ fileInfo.url +'" width="40"
				// height="20" broder="0"/>';
//				value = fileInfo.showName;
//			}
			break;
		case 'ImageUploadToDataBaseField':
			var pre = document.getElementById(editor.attr("id") + "_edit");
			var showType = jQuery(pre).attr("showType");
			var displayType = jQuery(pre).attr("displayType");
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).html();
			if(showType == "01" || displayType == "01")
				value = getT;
			break;
		case 'FileManagerField':
			var pre = document.getElementById(editor.attr("id") + "_edit");
			var showType = jQuery(pre).attr("showType");
			var displayType = jQuery(pre).attr("displayType");
			var show_id = document.getElementById(editor.attr("id") + "_show");
			var getT = jQuery(show_id).html();
			if(showType == "01" || displayType == "01")
				value = getT;
			break;
		default :
			if(showType == "01" || displayType == "01")
				value = showDiv.html();
			break;
	}
	if (value) {
		rtn = value;
	}
	
	showDiv.html(rtn);
	if(fieldType =='FileManagerField'){
		var uploadListId = 'uploadList_'+editor.attr("id");
		var eidtorIdDiv = uploadListId+'div';
		jQuery("#"+ eidtorIdDiv).find(".imgList").mouseover(function(event) {
			event.stopPropagation();
			jQuery(this).find(".showImgIcon").show();
		}).mouseout(function(event){
			event.stopPropagation();
			jQuery(this).find(".showImgIcon").hide();
		});
		jQuery("#"+ eidtorIdDiv).find("img[type='previous']").click(function(event) {
			event.stopPropagation();
			doPrevious(uploadListId);
		});
		jQuery("#"+ eidtorIdDiv).find("img[type='next']").click(function(event) {
			event.stopPropagation();
			doNext(uploadListId);
		});
	}
	if(fieldType =='OnLineTakePhotoField'){
		var eidtorIdDiv = editor.attr("id")+'_show';
		jQuery("#"+ eidtorIdDiv).find(".takePhotoImg").mouseover(function(event) {
			event.stopPropagation();
			jQuery(this).find(".takePhotoIcon").show();
		}).mouseout(function(event){
			event.stopPropagation();
			jQuery(this).find(".takePhotoIcon").hide();
		});
	}
	if(fieldType =='ImageUploadField'){
		var eidtorIdDiv = editor.attr("id")+'_show';
		jQuery("#"+ eidtorIdDiv).find(".bigImg").mouseover(function(event) {
			event.stopPropagation();
			jQuery(this).find(".smallIcon").show();
		}).mouseout(function(event){
			event.stopPropagation();
			jQuery(this).find(".smallIcon").hide();
		});
	}
	if(fieldType =='ImageUploadToDataBaseField'){
		var eidtorIdDiv = editor.attr("id")+'_show';
		jQuery("#"+ eidtorIdDiv).find(".bigImg").mouseover(function(event) {
			event.stopPropagation();
			jQuery(this).find(".smallIcon").show();
		}).mouseout(function(event){
			event.stopPropagation();
			jQuery(this).find(".smallIcon").hide();
		});
	}
	showDiv.show();
	editDiv.hide();

	// var record = getRecord(editor);
	// modifiedRecords[record.id] = record; // 放入已修改队列
	editingElements=jQuery.grep(editingElements,function(val,key){
		return val==id;
	},true);
}

/**
* 返回编辑器所对应的表格行数据
* 
* @param {}
*            editor
* @return {}
*/
function getRecord(currentEditor) {
	var origTR = currentEditor.parents("tr[id]");
	return _getRecordByTR(origTR);
}

function getRecordById(id) {
	var oTR = jQuery("#" + id);
	return _getRecordByTR(oTR);
}

/**
* 私有方法
* 
* @param {}
*            origTR
* @return {}
*/
function _getRecordByTR(origTR) {
	var record = {};
	if (origTR) {
		record.id = origTR.attr("id");
		for (var i = 0; i < columnModel.length; i++) {
			if(columnModel[i].indexOf("$") >= 0) continue;	//列是系统字段名时，返回
			var id = origTR.id + "_" + columnModel[i];
			var editor = jQuery("#" + origTR.attr("id") + "_" + columnModel[i])[0];
			if (editor) {
				var itemValue = '';
				var formType = jQuery("#"+ origTR.attr("id") + "_" + columnModel[i]).attr("type");

				if(formType == 'radio' || formType == 'checkbox'){
					jQuery("[id='" + origTR.attr("id") + "_" + columnModel[i] + "']:checked").each(function(){
						if(jQuery(this).val() != "")
							itemValue += jQuery(this).val() + ";";
					});
					itemValue = itemValue.substring(0,itemValue.length-1);
				}else{
					itemValue=jQuery("#" + origTR.attr("id") + "_" + columnModel[i],origTR).val();
				}
				if(jQuery("#"+ origTR.attr("id") + "_" + columnModel[i]).val()==null){
					itemValue='';
				}
				record[columnModel[i]] = itemValue;
			}
		}
	}
	return record;
}

function _getRecordByRefreshTR(origTR) {
	var record = {};
	if (origTR) {
		record.id = origTR.attr("id");
		var editor;
		for (var i = 0; i < columnModel.length; i++) {
			if(columnModel[i].indexOf("$") < 0)
				editor = jQuery("#"+ origTR.attr("id") + "_" + columnModel[i]);
			if (editor && columnModel[i].indexOf("$") < 0) {
				var itemValue = '';
				var formType = jQuery("[name='" + origTR.attr("id") + "_" + columnModel[i] + "']").attr("type");
				var fieldType = editor.attr("fieldtype");
				if(fieldType == 'SelectField'){
					itemValue=jQuery("#" + origTR.attr("id") + "_" + columnModel[i]).val();
				}else if(formType == 'radio' || formType == 'checkbox'){
					jQuery("[name='" + origTR.attr("id") + "_" + columnModel[i] + "']:checked").each(function(){
						itemValue += jQuery(this).val() + ";";
					});
					itemValue = itemValue.substring(0,itemValue.length-1);
				}else{
					itemValue=jQuery("#" + origTR.attr("id") + "_" + columnModel[i],origTR).val();
				}
				
				if(editor.attr("value")==null){
					itemValue='';
				}
				record[columnModel[i]] = itemValue;
			}
		}
	}
	return record;
}

function createRow(config) {
	var oTR =jQuery("<tr id=" + config.id + " class=" + config.cssClass + "></tr>");
	return oTR;
}

function createColumn(config, content) {
	var cssclass="";
	var cssstyle="";
	if(config.cssClass){
		cssclass = " class=" + config.cssClass + "";
	};
	if(config.style){
		cssstyle=" style=" + config.style + "";
	};
	var oTD = jQuery("<td " + cssclass + " " + cssstyle + "></td>");
	oTD.html(content);
	return oTD;
}


/**
* 删除行
* 
* @param {}
*            oTR
*/
function removeRow(oTR) {
	if(oTR != null){
		oTable.removeChild(oTR);
		editingRows=jQuery.grep(editingRows,function(val,key){
			return val==oTR.id;
		},true);
	}
	ev_resize4IncludeViewPar();
}


/**
* 保存操作
* 
* @param {}
*            activityId 按钮ID
*/
function doSave(activityId) {
	var saveRecords = [];
	for (var i = 0; i < editingRows.length; i++) {
		var record = getRecordById(editingRows[i]);
		saveRecords.push(record);
	}
	DocumentUtil.doSave(activityId, JSON.stringify(saveRecords), subGridView.getGridViewParams(),function(rtn) {
		if (rtn) {
			if(rtn.indexOf("obpm:") == 0){
				rtn = rtn.substring(5);
				showError(rtn);
				return false;
			}else{
				eval(rtn);
			}
		} else {
			for (var i = 0; i < saveRecords.length; i++) {
				doAfterRowEdit(saveRecords[i].id);
			}
			//刷新list
			var qs ='';
			if(parentid.length>0){
				qs ='&parentid='+parentid+'&isRelate='+isRelate;
			}
			var _currpage = document.getElementsByName('_currpage')[0].value;
			var _divid = document.getElementsByName('divid')[0].value;
		}
		jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","none");
		setFieldValChanged(false);
		subGridView.renderGridView();
		var viewParams = subGridView.getGridViewParams();
		parent.$("#"+viewParams._viewid).trigger("load");
	});
}

function modifyActionBack(){
	//showLoading();
	$("input[name='_currpage']").val(1);
	
	//设置查询参数
	var defaultParams = subGridView.config.params;
	var $search = $("#searchFormTableSub");
	var searchParams = decodeURIComponent($search.find('input,select,textarea').serialize(),true);
	searchParams = searchParams.replace(/&/g,"\",\"");
	searchParams = searchParams.replace(/=/g,"\":\"");
	searchParams = JSON.parse("{\""+searchParams+"\"}");
	searchParams._currpage = 1;
	searchParams.isQueryButton = true;
	var params = $.extend({},defaultParams,searchParams);

	$("#isPagination").find("#pagination-panel").html("");
	doCancelAll();
	subGridView.renderGridViewTable(params);
	subGridView.renderPagination();
	subGridView.resizeGridViewTable();
	//hideLoading();
}
/**
* 刷新操作
* 
* @param {}
*            editorId
*/

function doRefresh(editorId) {
	var record = getRecord(jQuery("#"+ editorId));
	DocumentUtil.doRefresh(jQuery.obj2Str(record), subGridView.getGridViewParams(),
			function(rtn) {
				if(rtn.indexOf("obpm:") == 0){
					rtn = rtn.substring(5);
					showError(rtn);
				}else{
					eval(rtn);
				}
				//jquery重构按钮和控件
				jqRefactor();
			});
}


/**
* 取消所有操作, 还原表格行
* 
**/
function doCancelAll(){
	$("a.btn[autoBuild='true']").addClass("hide");
	if(editingRows.length>0){
		var tempEditingRows = editingRows;
		for (var i = 0; i <=tempEditingRows.length; i++) {
			doCancel(tempEditingRows[i]);
		}
	}
	jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","none");
	subGridView.resizeGridViewTable();

	/*if($("#obpm-view__table").find("tr").size()<=0){
		$("#gridview-container").addClass("obpm-placeholder");
		$("#gridView__box").hide();
	}*/
}

/**
* 取消操作, 还原表格行
* 
* @param {}
*            rowId
*/
function doCancel(rowId) {
	if(editingRows.length==1){
		$("#VIEW_OPEN_TYPE_GRID_BTN").css("display","none");
		$("a.btn[autoBuild='true']").addClass("hide");	
	}
	var currentTR = document.getElementById(rowId);
	if (jQuery.inArray(rowId,newRows) != -1) { // 新建行取消操作
		var application = document.getElementsByName("application")[0].value;
		removeRow(document.getElementById(rowId));
	} else if (jQuery.inArray(rowId,editingRows) != -1) { // 编辑行取消操作
		var origTR = origTRs[rowId];

		// 还原模型
		subGridView.insertRow(origTR, currentTR.rowIndex);
		oTable.removeChild(currentTR);
		// 清空temp元素
		fieldsTemp = {};
		divsTemp = {};
		// 还原数据
		var record = origRecords[rowId];
		for (var i = 0; i < columnModel.length; i++) {
			if(columnModel[i].indexOf("$") >= 0) break;	//列是系统字段名时，返回
			var editorId = rowId + "_" + columnModel[i];
			var $th = $("tr").find("[coltext='"+columnModel[i]+"']")
			var editorType = $th.attr("coltype"); 
			//判断脚本列
			if(editorType && editorType == "COLUMN_TYPE_SCRIPT"){
				var $_td = $("#"+rowId).find("td:eq("+$th.index()+")");
				$_td.find(".grid-column-show").show();
			}else{
				var data = record[columnModel[i]];
				if (jQuery("#"+ editorId)) {
					jQuery("#" + editorId).val(data);
				}
				if(jQuery("#"+ editorId).attr("fieldtype") == "SuggestField"){jQuery("#"+ editorId).parent().parent().parent().css("overflow","hidden");}
				var editDiv = jQuery("#" + rowId + "_" + columnModel[i]+ "_edit");
				var showDiv = jQuery("#" + rowId + "_" + columnModel[i] + "_show");
				showDiv.show();
				editDiv.hide();
			}
		}
		editingRows=jQuery.grep(editingRows,function(val,key){
			return val==rowId;
		},true);
		newRows=jQuery.grep(newRows,function(val,key){
			return val==rowId;
		},true);
		jQuery("#" + rowId).removeClass('grid-rowselected');
		ev_resize4IncludeViewPar();
	}
	showOrHideActionTd();	//当前表格是否要显示操作列
	subGridView.resizeGridViewTable();
	if($("#gridView__box").find("input[value='取消']:visible").size()<=0){
		$("a.btn[autoBuild='true']").addClass("hide");
	}
}

function showNotice(msg) {
	OBPM.message.showInfo(msg);
}

function showError(msg) {
	OBPM.message.showError(msg);
}

/*
* 视图打印(网格视图时)
*/
function ev_printview(actid) {
	var viewid = document.getElementsByName("_viewid")[0].value;
	var signatureExist = document.getElementById("signatureExist").value;
	
	var url = activityAction + '?_viewid=' + viewid;
	url += '&_signatureExist=' + signatureExist;
	url += '&_activityid=' + actid;
	url += '&application=' + application;
	
	if(ev_runbeforeScriptforgrid(actid)){
		if (parent != top) {
			parent.open(url);
		} else {
			window.open(url);
		}
	}
}


/**
* Dispatcher按钮
* @param actid
* @return
*/
function ev_dispatcherPage(actid){
	if(ev_runbeforeScriptforgrid(actid)){
		var url = activityAction + '?_activityid=' + actid;
 	document.forms[0].action = url;
 	//document.forms[0].target = '_blank';
 	document.forms[0].submit();
 	//document.forms[0].target = '';
	}
}


function dy_view_refresh(id){
	doRefresh(id);
}


//打开查询页面
function openSearch(obj){
	var $fromDiv = $('#searchFormTable_hide');
	$fromDiv.find("input,textarea,select").attr("isSubSearch",true);	//子表查询表单中的刷新识别用
	//只能用移动查询表单内容的方法，避免日期、下拉提示等控件事件丢失无法操作
	var $div = $('<div id="searchFormTableSub"></div>').append($fromDiv.children());
	var dialog = artDialog({
		title:'查询',
		content : $div,
		lock:true,
		fixed: true,
		width:800,
		height:'auto',
		button: [
					{
					    name: '查询',
					    callback: function () {
					    	modifyActionBack();
					         return false;
					     },
		                 focus: true
					},
					{
		                 name: '重置',
		                 callback: function () {
		                	 ev_resetAll();
		                     return false;
		                 }
		             },
					{
	            	    name: '取消',
	            	    callback: function(){
	            	    	$fromDiv.append($div.children());
	            	    }
	            	}
	            	]
	    }
	);
	if($("#searchFormTableSub").parents(".aui_state_focus").height() > $(window).height()){
		$("#searchFormTableSub").height($(window).height()-100-30)
		Common.Util.renderScroll($("#searchFormTableSub"),{cursorwidth: "10px"})
		dialog.size(800, $(window).height()-100);
	}
}
/**
 * 清空字段内容
 */
function ev_resetAll() {
	$("#searchFormTableSub").wrap("<form id='formTable'></form>");
	var elements =  document.getElementById('formTable').elements;
	for (var i = 0; i < elements.length; i++) {
		
		if(jQuery(elements[i]).attr('fieldType')=='TextAreaField'){
			elements[i].value = "";
		}
		if(jQuery(elements[i]).attr('fieldType')=='UserField'){
			elements[i].value = "";
			
			if(jQuery(elements[i]).attr('readonlyshowvalonly') == "true"){
				jQuery(elements[i]).text("");
			}
			
		}
		if(jQuery(elements[i]).attr('fieldType')=='SelectAboutField'){
			var	originalName = elements[i].name;
			var	idDx = originalName + "ms2side__dx";
			var	idSx = originalName + "ms2side__sx";
			jQuery("#" + idDx).children().appendTo(jQuery("#" + idSx));
			jQuery("#" + idDx).children().remove();
			jQuery(elements[i]).find('option').attr("selected", false);
			jQuery(elements[i]).find("[text='']").attr("selected", true);
		}
		if(elements[i].type == 'checkbox'){
			elements[i].checked = false;
		}
		if(elements[i].type == 'radio'){
			elements[i].checked = false;
		}
		if(jQuery(elements[i]).attr('fieldType')=='TreeDepartmentField'){
			elements[i].value = "";
			elements[i+1].value = "";
		}
		// alert(elements[i].id + ": "+elements[i].type + " resetable-->" +
		// elements[i].resetable);
		if (elements[i].type == 'text'|| elements[i].resetable) {
			elements[i].value = "";
			
		} else if (elements[i].type == 'select-one') {
			// 还原至第一个选项
			if (elements[i].options.length >= 1) {
				elements[i].options[0].selected = true;
			}
		}
		
		//清空只读值
		var readOnlySpanId = "#"+jQuery(elements[i]).attr('name')+"_show";
		if(jQuery(readOnlySpanId)){
			jQuery(readOnlySpanId).text("");
		}
	}

	//jQuery("#searchFormTableSub").find("input[type='hidden'][id!='dy_refreshObj']").val("");//清除隐藏文本框控件的值
	$("#searchFormTableSub").unwrap();
}
//查询按钮
function search(obj){
	var json = this.span2Json(obj);
	json['_currpage'] = 1;	//重置页码
	//添加控件参数
	$(document).find("#searchFormTableSub").find("input,select,textarea").each(function(){
		json[this.name] = this.value;
	});
	var url = contextPath + "/portal/dynaform/view/subFormView.action?isQueryButton=true";
	this.postForm(obj,url,json);
}


/*
 * 表单没有操作权限的时候，网格视图按钮隐藏
 */
function hiddenGridBtn(){
	var gridIsEdit = document.getElementsByName("isedit")[0].value;
	if(gridIsEdit=="false"){
		jQuery("#act .actBtn,#act .button-dis").hide();
	}
}
//给后台preview.jsp视图预览的时候判断页面是否重构完成
function getIsComplete(){
	return isComplete ;
}

function on_unload() {
	ev_reloadParent();
}


/**
 * 包含元素包含视图时调整iframe高度
 * from:blue/brisk/default/dwz/fresh/gentle
 */
function ev_resize4IncludeViewPar(){
	debugger
	var divid = document.getElementsByName("divid")[0].value;
	var _viewid = document.getElementsByName("_viewid")[0].value;
	ev_resize4IncludeView(divid,_viewid,'GRIDVIEW');

	if($("#table_gridView").find("table").height()>$(window).height()-54){
		$("#table_gridView").height($(window).height()-54)
		if($("#table_gridView").getNiceScroll().length <=0 ){
			Common.Util.renderScroll($("#table_gridView"),{cursorwidth: "10px",oneaxismousemode: false})
		}
	}
	
}

/**
 * 窗体变化时调整网格视图的宽度
 * for:所有皮肤
 */
function ev_resize4Change(){
	var bodyPW = jQuery("body").parent().width();
	jQuery("body").width(bodyPW);
	jQuery("#dspview_divid").width(bodyPW -6);
	//jQuery("#table_gridView").width(bodyPW-6);
	//jQuery("#acttable").width(bodyPW-6);
	if($("#table_gridView").find("table").width()>$("#table_gridView").width()){
		if($("#table_gridView").getNiceScroll().length <=0 ){
			Common.Util.renderScroll($("#table_gridView"),{cursorwidth: "10px",oneaxismousemode: false})
		}
	}
}


/**
 * 批量签章按钮对应的Function
 */
function DoBatchSignature() {
	if(navigator.userAgent.indexOf("MSIE")<0){
		alert("金格iSignature电子签章HTML版只支持IE，如果要签章请用IE浏览器");
		return;
	}
	var mLength = document.getElementsByName("_selects").length;
	var vItem;
	var DocumentList = "";
	for (var i = 0; i < mLength; i++) {
		vItem = document.getElementsByName("_selects")[i];
		if (vItem.checked) {
			if (i != mLength - 1) {
				DocumentList = DocumentList + vItem.value + ";";
			} else {
				DocumentList = DocumentList + vItem.value;
			}
		}
	}
	// alert(DocumentList);
	var ajax = null;

	if (window.ActiveXObject) {
		try {
			ajax = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {
			alert("创建Microsoft.XMLHTTP对象失败,AJAX不能正常运行.请检查您的浏览器设置.");
		}
	} else {
		if (window.XMLHttpRequest) {
			try {
				ajax = new XMLHttpRequest();
			} catch (e) {
				alert("创建XMLHttpRequest对象失败,AJAX不能正常运行.请检查您的浏览器设置.");
			}
		}
	}

	var url = document.getElementById("mGetBatchDocumentUrl").value;
	var mLoginname = document.getElementById("mLoginname").value;
	var DocumentID = document.getElementById("DocumentID").value;
	var ApplicationID = document.getElementById("ApplicationID").value
	var FormID = document.getElementById("FormID").value
	url = url + "?DocumentID=" + DocumentID + "&ApplicationID2="
			+ ApplicationID + "&FormID2=" + FormID;

	ajax.onreadystatechange = function() {

		if (ajax.readyState == 4 && ajax.status == 200) {

			if (ajax.responseText == "false") {

				return;
			}

			var documentName = ajax.responseText.split(',');
			// var buffer = [];
			var fildsList = "";
			for (var i = 0; i < documentName.length; i++) {

				if (i != documentName.length - 1) {
					// buffer.push(documentName[i]+"="+documentName[i]);
					fildsList = fildsList
							+ (documentName[i] + "=" + documentName[i] + ";");
				} else {
					// buffer.push(documentName[i]+"="+documentName[i]);
					fildsList = fildsList
							+ (documentName[i] + "=" + documentName[i]);
				}

			}
			// alert(fildsList);
			// buffer.join("");
			// alert(buffer);
			//alert(formList.SignatureControl);
			if (formList.SignatureControl != null) {
				if (DocumentList == "") {
					alert("请选择需要签章的文档。");
				}
				formList.SignatureControl.FieldsList = fildsList; // 所保护字段
				formList.SignatureControl.Position(460, 275); // 签章位置
				formList.SignatureControl.DocumentList = DocumentList; // 签章页面ID
				formList.SignatureControl.WebSetFontOther("True", "同意通过", "0",
						"宋体", "11", "000128", "True"); // 默认签章附加信息及字体,具体参数信息参阅技术白皮书
				formList.SignatureControl.SaveHistory = "false"; // 是否自动保存历史记录,true保存
				// false不保存
				// 默认值false
				formList.SignatureControl.UserName = "lyj"; // 文件版签章用户
				formList.SignatureControl.WebCancelOrder = 0; // 签章撤消原则设置,
				// 0无顺序 1先进后出
				// 2先进先出 默认值0
				// formList.SignatureControl.DivId = "contentTable"; //签章所在层
				formList.SignatureControl.AutoCloseBatchWindow = true;
				formList.SignatureControl.RunBatchSignature();
			} else {
				alert("请安装金格iSignature电子签章HTML版软件");
				document.getElementById("hreftest2").click();
			}

		}

	};
	ajax.open("POST", url);
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send(null);
}

(function($){
$.fn.obpmSubGridView = function(){
		return this.each(function(){
			Setting = {//
					TABLE_CLASS : 'listDataTable',		//表格class
					TH_CLASS : 'listDataTh',						//标题行class
					TH_FIRST_TD_CLASS : 'listDataThFirstTd',			//标题行第一个单元格class
					TH_TD_CLASS : 'listDataThTd',		//标题行其他单元格class
					TR_FIRST_TD_CLASS : 'listDataTrFirstTd',		//数据行第一个单元格class
					TR_TD_CLASS : 'listDataTrTd',		//数据行其他单元格class
					TR_CLASS : 'listDataTr',				//数据行class
					TR_OVER_CLASS : 'listDataTr_over'	//数据行滑过class
			};
			toFirstTdHtml = function($tdField){
				var tdHtml = "";
				var thAttrs = {};
				thAttrs.upImg = "<img border=\"0\" src='../../share/images/view/up.gif'/>";
				thAttrs.downImg = "<img border=\"0\" src='../../share/images/view/down.gif'/>";
				thAttrs.isVisible = $tdField.attr("isVisible");
				thAttrs.isHiddenColumn = $tdField.attr("isHiddenColumn");
				thAttrs.isBlank = $tdField.attr("isBlank");
				thAttrs.id = $tdField.attr("id");
				thAttrs.value = $tdField.attr("value");
				thAttrs.colWidth = $tdField.attr("colWidth");
				thAttrs.colText = $tdField.attr("colText");
				thAttrs.isEmpty = $tdField.attr("isEmpty");
				thAttrs.colType = $tdField.attr("colType");
				thAttrs.colFieldName = $tdField.attr("colFieldName");
				thAttrs.isOrderByField = $tdField.attr("isOrderByField");
				thAttrs.isVisible = (thAttrs.isVisible == "true");
				thAttrs.isHiddenColumn = (thAttrs.isHiddenColumn == "true");
				thAttrs.isBlank =(thAttrs.isBlank =="true");
				thAttrs.isEmpty =(thAttrs.isEmpty =="true");
				
				if(thAttrs.isVisible && !thAttrs.isHiddenColumn){
					if(thAttrs.colWidth != "0"){
						if(thAttrs.colWidth != "" && thAttrs.colWidth != "null"){
							isSetWidth = true;
						}
						if(!thAttrs.isBlank){
							tdHtml += "<td class=\"" + Setting.TH_TD_CLASS + "\" colText='"+thAttrs.colText+"' colType='"+thAttrs.colType+"' width=\"" 
							+ thAttrs.colWidth + "\" nowrap='nowrap' style='word-wrap: break-word; word-break: break-all;overflow: hidden;' >";
						}else{
							tdHtml += "<td class=\"" + Setting.TH_TD_CLASS + "\" colText='"+thAttrs.colText+"' coltype='"+thAttrs.colType+"' nowrap='nowrap' style=\"overflow: hidden;\">";
						}
						tdHtml +="<input id=\"" + thAttrs.id + "\" value=\"" + thAttrs.value + "\" type=\"hidden\"/>";
						
						if(thAttrs.colType == "COLUMN_TYPE_FIELD"){
							tdHtml += "<a style=\"cursor:pointer\" href=\"#\" onclick=\"sortTable('"+thAttrs.colFieldName+"')\">";
							if(_sortCol != "null"){
								if(_sortCol != "" && _sortCol.toUpperCase() == thAttrs.colFieldName.toUpperCase()){
									tdHtml += ""+thAttrs.colText +"";
									if(_sortStatus == "ASC"){
										tdHtml += ""+thAttrs.upImg+"";
									}else if(_sortStatus == "DESC"){
										tdHtml += ""+thAttrs.downImg+"";
									}
									tdHtml +="</a>";
								}else{
									if(thAttrs.isOrderByField != "null" && thAttrs.isOrderByField != "" && thAttrs.isOrderByField == "true"){
										tdHtml += ""+thAttrs.colText+"</a>";
									}else{//不勾选排序
										tdHtml += ""+ thAttrs.colText+"";
									}
								}
							}else{
								if(thAttrs.isOrderByField != "null" && thAttrs.isOrderByField != "" && thAttrs.isOrderByField == "true"){
									tdHtml +="" + thAttrs.colText + "";
									//可排序图标
									if(_sortStatus == "ASC"){
										tdHtml +=""+thAttrs.upImg + "";
									}else if(_sortStatus == "DESC"){
										tdHtml +=""+thAttrs.downImg+"";
									}
									tdHtml +="</a>";
								}else{//不勾选排序
									tdHtml +=""+thAttrs.colText+"";
								}
							}
						}else{//脚本不需要排序
							tdHtml +=""+thAttrs.colText+"";
						}
					}else{
						tdHtml +="<td class=\"" + Setting.TH_TD_CLASS + "\" style=\"display:none;\">" + thAttrs.colText + "</td>";
					}
				}
				return tdHtml;
			};//重构表头----end
			
			var $field = jQuery(this);
			var _sortCol = $field.attr("_sortCol");
			var _sortStatus = $field.attr("_sortStatus");
			var isSum = $field.attr("isSum");
			isSum = (isSum == "true");
			
			var $tableHtml = jQuery("<table class=\"table " + Setting.TABLE_CLASS + "\" id=\"gridTable\" style=\"" +
						"z-index:1;table-layout:auto;\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"></table>");
			$field.before($tableHtml);
			var sumTrIsHidden = true;
			var $tbodyHtml = $("<tbody id=\"dataBody\" ></tbody>");
			$tableHtml.append($tbodyHtml);
			var tfoot = "<tfoot>";
			//判断是否输出汇总行
			var $tdFootArray = $field.find("#sumTrId").find("td");
			for(var k=0;k<$tdFootArray.size();k++){
				if(jQuery(this).attr("isSum") == "true" || jQuery(this).attr("isTotal") == "true"){
					sumTrIsHidden = false;
					 break;
				}
			}
			var $trArray = $field.find("tr");
			for(var i=0;i<$trArray.size();i++){
				var $trField = jQuery($trArray[i]);
				if(i == 0){  //首行（列头）
					var trHtml ="<tr class=\"" + Setting.TH_CLASS + "\">";
					var $tdArray = $trField.find("td");
					for(var j=0;j<$tdArray.size();j++){
						var $tdField = jQuery($tdArray[j]);
						if(j == 0){//first td
							var tdHtml = "<td class=\"" + Setting.TH_FIRST_TD_CLASS + "\" scope=\"col\">";
								tdHtml += "<input type=\"checkbox\" />";
								tdHtml +="</td>";
							trHtml +=""+ tdHtml +"";
						}else if(j == $field.find("tr").eq(0).find("td").size()-1){//last td
							var actions = $tdField.attr("actions");
							var tdHtml = "<td class=\"" + Setting.TH_TD_CLASS + "\" style=\"width:120px\">" + actions + "</td>";
							trHtml +=""+ tdHtml +"";
						}else{//其他列
							//根据列头的显示隐藏值设置数据行对应列的显示和隐藏值
							$field.find("tr:gt(0)").each(function(){
								$(this).find(" td:eq("+j+")").attr("isHidden", $tdField.attr("isHiddenColumn"));
							});

							trHtml += toFirstTdHtml($tdField);
						}
					}
					trHtml +="</tr>";
					$tableHtml.prepend("<thead>" + trHtml + "</thead>");
				}else if(isSum && !sumTrIsHidden && (i == $field.find("tr").size()-1)){//末行(字段值汇总)
					var tdHtml = "";
					var $tdArray = $trField.find("td");
					for(var j=0;j<$tdArray.size();j++){
						var $tdField = jQuery($tdArray[j]);
						var sumTdAttrs = {};
						sumTdAttrs.isVisible = $tdField.attr("isVisible");
						sumTdAttrs.isHiddenColumn = $tdField.attr("isHiddenColumn");
						sumTdAttrs.isSum = $tdField.attr("isSum");
						sumTdAttrs.isTotal = $tdField.attr("isTotal");
						sumTdAttrs.colName = $tdField.attr("colName");
						sumTdAttrs.sumByDatas = $tdField.attr("sumByDatas");
						sumTdAttrs.sumTotal = $tdField.attr("sumTotal");
						sumTdAttrs.isVisible = (sumTdAttrs.isVisible == "true");
						sumTdAttrs.isHiddenColumn = (sumTdAttrs.isHiddenColumn == "true");
						sumTdAttrs.isSum = (sumTdAttrs.isSum == "true");
						sumTdAttrs.isTotal = (sumTdAttrs.isTotal == "true");	
						if(j == 0){//首列
							tdHtml += "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
							tdHtml += "&nbsp;</td>";
						}else if(j==$trField.find("td").size()-1){
							tdHtml += "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
							tdHtml += "&nbsp;</td>";
						}else{//其他列
							if(sumTdAttrs.isVisible && !sumTdAttrs.isHiddenColumn){
								tdHtml += "<td class=\"" + Setting.TR_TD_CLASS + "\" style=\"word-break: break-all;\">";
								if(sumTdAttrs.isSum || sumTdAttrs.isTotal)
									tdHtml += sumTdAttrs.colName;
								if(sumTdAttrs.isSum)
									tdHtml += sumTdAttrs.sumByDatas + "&nbsp;";
								if(sumTdAttrs.isTotal)
									tdHtml += sumTdAttrs.sumTotal + "&nbsp;";
								tdHtml += "</td>";
							}
						}
					}
					var trHtml = "<tr class=\"" + Setting.TR_CLASS + "\" onmouseover=\"this.className='" 
					+ Setting.TR_OVER_CLASS + "';\" onmouseout=\"this.className='" + Setting.TR_CLASS + "';\">";
						trHtml +="" + tdHtml;
						trHtml +="</tr>";
						$tableHtml.append("<tfoot>"+trHtml+"</tfoot>");
				}else if($trField.attr("trType") =="dataTr"){
					var id =$trField.attr("id");
					var trInnerHtml = "<tr id='" + id + "' class=\"" + Setting.TR_CLASS + "\" onmouseover='jQuery(this).addClass(\"" + Setting.TR_OVER_CLASS + "\")' onmouseout='jQuery(this).removeClass(\"" + Setting.TR_OVER_CLASS + "\")'>";

					var $tdArray = $trField.find("td");
					for(var j=0;j<$tdArray.size();j++){
						var $tdField = jQuery($tdArray[j]);
						var tdAttrs = {};
						tdAttrs.fieldType = $tdField.attr('fieldType');
						tdAttrs.colType = $tdField.attr('colType');
						tdAttrs.colWidth = $tdField.attr("colWidth");
						tdAttrs.colGroundColor = $tdField.attr('colGroundColor');
						tdAttrs.colFontSize = $tdField.attr('colFontSize');
						tdAttrs.colIsEdit = $tdField.attr('colIsEdit');
						tdAttrs.colDocId = $tdField.attr('colDocId');
						if(j==0){//首列
							trInnerHtml += "<td class=\"" + Setting.TH_FIRST_TD_CLASS + "\" scope=\"col\">" + $tdField.html() + "</td>";
						}else{//其它数据列
							tdAttrs.fieldType = $tdField.attr('fieldType');
							var tdWidth = "";
							var tdBackColor = "";
							var fontSize = "";
							//列宽
							if(tdAttrs.colWidth != "" && tdAttrs.colWidth != "null" && tdAttrs.colWidth != undefined) {
								tdWidth = "width: " + tdAttrs.colWidth + ";";
							} else if("COLUMN_TYPE_ROWNUM" == tdAttrs.colType){
								//序号列为固定列宽
								tdWidth = "width: 100px;";
							}
							//列字体颜色
							if(tdAttrs.colGroundColor != "FFFFFF"){
								tdBackColor = "background-color: " + tdAttrs.colGroundColor + ";";
							}
							//列字体大小
							if(tdAttrs.colFontSize != ""){
								fontSize = "font-size: " + tdAttrs.colFontSize + "px;";
							}
							trInnerHtml += "<td class=\"" + Setting.TR_TD_CLASS + "\" scope=\"col\" style=\"word-break: break-all;" + tdBackColor + tdWidth + fontSize + "overflow: hidden;\"";
							if(tdAttrs.colIsEdit != "" && tdAttrs.colIsEdit != "null" && tdAttrs.colIsEdit != undefined){
								if(tdAttrs.colIsEdit == true || tdAttrs.colIsEdit == "true"){
									trInnerHtml += "onclick=\"doRowEdit('" + tdAttrs.colDocId + "',this)\"";
								}
							}
							trInnerHtml +=">";

							var $tdGrid = $tdField.find("div");
							var $tdGridID = $tdGrid.attr("id");
							var $tdText = $tdField.context.innerText;
							var tdInnerHtml = "";
							
							//图片上传
							if(tdAttrs.fieldType == "imageupload"){
								//解析附件json数据生成html
								var $tdShow = $tdField.find(".grid-column-show");
								var value = $tdShow.html();
								if(value.trim()){
									var instances = JSON.parse(value);
									$tdShow.html('');
									$.each(instances,function(key,data){
										var attachmentObj = instances[key];
										var attachmentName = attachmentObj.name;
										var attachmentPath = attachmentObj.path;
										var _html = "<img src='"+contextPath+attachmentPath+"' width='100px'>";
										$tdShow.html(_html);
									})
								}
								tdInnerHtml = $tdField.html();
							}else if(tdAttrs.fieldType == "onlinetakephoto"){
								//解析附件json数据生成html
								var $tdShow = $tdField.find(".grid-column-show");
								var value = $tdShow.html();
								if(value.trim()){
									var _url = $(value).attr("url").replace(/\\'/g,"");
									var _picHtml = "<img style='max-height:50px;max-width:50px;' src='"+_url+"' />";
									$tdShow.html(_picHtml);
								}
								tdInnerHtml = $tdField.html();
							}else if($tdGridID && $tdGridID.indexOf("$StateLabel") >= 0 && $tdText.indexOf("[")==0){
								//解析json数据生成html
								var instances = JSON.parse($tdText);
								$.each(instances,function(name,value){
									var instance = instances[name];
									var instanceId = instance.instanceId;
									var nodes = instance.nodes;
									$.each(nodes,function(name,value){
										var node = nodes[name];
										var nodeId = node.nodeId;
										var stateLable = truncationText(node.stateLabel,tdAttrs.displayType,tdAttrs.colDisplayLength);
										tdInnerHtml = stateLable + " ; ";
									})
								})
								
							}else if($tdGridID && $tdGrid.attr("id").indexOf("$PrevAuditUser") >= 0 && $tdText.indexOf("[")==0){
								//解析json数据生成html
								var instances = JSON.parse($tdText);
								$.each(instances,function(name,value){
									var instance = instances[name];
									var instanceId = instance.instanceId;
									var prevAuditUser = instance.prevAuditUser;
									tdInnerHtml = truncationText(prevAuditUser,tdAttrs.displayType,tdAttrs.colDisplayLength) + " ; ";
								})
							}else if($tdText.indexOf("path") > 0 && $tdText.indexOf("[{")==0){
								//解析附件json数据生成html
								var dataStr = $tdText.substr(0,$tdText.indexOf("}]")+2);
								var instances = JSON.parse(dataStr);
								var $tdShow = $tdField.find(".grid-column-show");
								$.each(instances,function(key,data){
									var attachmentObj = instances[key];
									var attachmentName = attachmentObj.name;
									var attachmentPath = attachmentObj.path;
									$tdShow.html(attachmentName);
								})
								tdInnerHtml = $tdField.html();
							} else if("COLUMN_TYPE_ROWNUM" == tdAttrs.colType) {//序号列
								var $tdShow = $tdField.find(".grid-column-show");
								$tdShow.html(i);
								tdInnerHtml = $tdField.html();
							} else if("weixingpsfield" == tdAttrs.fieldType && $tdText.indexOf("{")==0) {//gps
								var location = JSON.parse($tdText);
								var $tdShow = $tdField.find(".grid-column-show");
								var $tdEdit = $tdField.find(".grid-column-edit");
								$tdShow.html(location.address);
								$tdEdit.html(location.address);
								tdInnerHtml = $tdField.html();
							} else if("weixinrecordfield" == tdAttrs.fieldType) {//录音控件
								var $tdShow = $tdField.find(".grid-column-show");
								var $tdEdit = $tdField.find(".grid-column-edit");
								$tdShow.html('<div class="weixin_record"><img src="../../share/images/view/voice.png" width="21px"/></div>');
								$tdEdit.html('<div class="weixin_record"><img src="../../share/images/view/voice.png" width="21px"/></div>');
								tdInnerHtml = $tdField.html();
							} else {
								tdInnerHtml = $tdField.html();
							}

							trInnerHtml += tdInnerHtml;
							trInnerHtml += "</td>";

						}
					}
					trInnerHtml +="</tr>";
					$tbodyHtml.append(trInnerHtml);
					if(isSetWidth){
						jQuery("#gridTable").css("table-layout","fixed");
						//膏药 table-layout=fixed时 为没设宽度的列设置最小宽度
						jQuery("#gridTable").find(".listDataTh").find(".listDataThTd").each(function(){
							var $this = $(this);
							if(!$this.attr("width") || $this.attr("width")==""){
								$this.attr("width","60px");
							}
						})
					}
				}
			}
			$field.remove();
			// 初始化表格 grid.js用到
			oTable = document.getElementById('dataBody');
		});
	};
})(jQuery);

function truncationText(input,displayType,displayLength){
	if(displayType == "01"){
		displayLength = displayLength.match("\\d+");
		if(displayLength){
			if(input.length > displayLength){
				input = input.substring(0,displayLength) + "...";
			}
		}
	}
	return input;
};
