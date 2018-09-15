/**
 * QM 核心类
 * 封装QM界面渲染与交互行为
 */
;
var QM = QM || {
	/**
	 * 待填写列表
	 */
	pendList : {
		init : function() {
			QM.service.getPendList({"_pagelines":50},function(result){
				QM.pendList.renderPendLIst(result);
			});
		},
		/**
		 * 渲染列表部分
		 */
		renderPendLIst : function(result){
			var $pendListPanel = $('#tpl_qm_pendlist');
        	var $pendListHtml = $($('#tpl_qm_pendlist').html());
        	var listHtml = ""; 	
        	var listTemplate = '<li><a href="#/qm-write/:{listId}">'
			        		+'<div class="qm-item-box weui_cell">'
			        		+'<div class="weui_cell_hd">{listAvatar}</div>'
			        		+'<div class="weui_cell_bd weui_cell_primary">'
			        		+'<div class="qm-item-title">{listTitle}</div> '
		                    +'<div class="qm-item-txt">'
		                    +'<div class="qm-item-person">{listUserName}[{listUserDept}]</div>'
		                    +'<div class="qm-item-date">{listDate}</div>'
		                    +'</div></div></div></a></li>';
        	
        	
        	$.each(result.datas,function(key,data){
        		var _id = data.id;
        		var _creator = data.creatorName;
        		var _creatorId = data.creator;
        		var _creatorDept = data.creatorDeptName;
        		var _creatorDeptId = data.creatorDeptId;
        		var _creatorDate = data.createDate;
        		var _title = data.title;
        		var _explains = data.explains;
        		var _status = data.status;
        		var _avatar;
        		
        		var avatar = QM.Util.getAvatar(_creatorId);
        		if(avatar!="" && avatar!=undefined){
					_avatar = "<img src ="+avatar+">";
				}else{
					_avatar = "<div class='noAvatar'>"+ _creator.substr(_creator.length-2, 2) +"</div>";
				}
        		
        		var _listHtmlLi = QM.Util.format(listTemplate , {'listAvatar' : _avatar});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listTitle' : _title});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listUserName' : _creator});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listUserDept' : _creatorDept});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listDate' : _creatorDate});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listId' : _id});
        		
        		listHtml += _listHtmlLi;
        	})
        	$pendListHtml.find(".qm-list-box").find("ul").html(listHtml);
        	$pendListPanel.html($pendListHtml);
		},
		/**
		 * 筛选动作
		 */
		pendlistSearch : function(){
			var title = QM.cache.searchTitle;
			var params = {
				"title"	: title == undefined ? title = "" : title ,
				"_pagelines":50
			}
			
			QM.service.getPendList(params,function(result){
				QM.pendList.renderPendLIst(result);
				var $ul = $("#tpl_qm_pendlist").find(".qm-list-box").find("ul");
				var _listHtml = $ul.html()
				$("#container").find(".qm-list-box").find("ul").html(_listHtml);
			});	
		},
		bindEven : function(){
			
			var $container = $("#container");
			
			$container.on('click', '.search-box .search-btn', function (){
        		var _title = $(".search-box").find("input").val();
        		QM.cache.searchTitle = _title;        		
        		QM.pendList.pendlistSearch();
        	})
        	
		}
	},
	/**
	 * 问卷填写页面
	 */
	write : {
		/**
		 * 初始化普通问卷
		 * @param listId
		 */
		init : function(listId) {
			var params = {"listId":listId};
			QM.service.getWrite(params,function(result){
				QM.write.renderWrite(result);
				var answerParams = {"id":listId};
				QM.service.getAnswer(answerParams,function(result){				
					if(result && result !=""){
						QM.write.renderAnswer(result);	
					}
				});
			});
		},
		/**
		 * 渲染空白问卷
		 */
		renderWrite : function(result){
			var writeJson = result;
			//var reg = new RegExp("\n","g");
			//var writeConJson = JSON.parse(writeJson.content.replace(reg,"\\n"))
			var writeConJson = JSON.parse(writeJson.content);
			QM.cache.writeJson = writeJson;
			QM.cache.writeConJson = writeConJson;
			
        	var _template = {
        			writePanel : '<form><div class="page"><h1>{writeTitle}</h1>'
        						+'<div class="qm-write-title-remark">{writeRemark}</div></div></form>',
    				//单选题
    				radio : '<div class="weui_cells_title">{questionNo} {questionTitle}{questionCode}{questionTips}{questionIswill}</div>'
    						+'<div id="{questionId}" class="weui_cells weui_cells_radio"></div>',	
    				radioOption : '<label class="weui_cell weui_check_label" for="{optionId}">'
							+'<div class="weui_cell_hd">'
							+'<input type="radio" class="weui_check" name="{questionId}" value="{optionValue}" id="{optionId}">'
							+'<span class="weui_icon_checked"></span></div>'
							+'<div class="weui_cell_bd weui_cell_primary"><span>{optionName}</span>{optionVote}{optionisText}</div>'
							+'</label>',
					//多选题
					check : '<div class="weui_cells_title">{questionNo} {questionTitle}{questionCode}{questionTips}{questionIswill}</div>'
							+'<div id="{questionId}" class="weui_cells weui_cells_checkbox"></div>',
					checkOption : '<label class="weui_cell weui_check_label" for="{optionId}">'
							+'<div class="weui_cell_hd">'
							+'<input type="checkbox" class="weui_check" name="{questionId}" value="{optionValue}" id="{optionId}">'
							+'<span class="weui_icon_checked"></span></div>'
							+'<div class="weui_cell_bd weui_cell_primary"><span>{optionName}</span>{optionVote}{optionisText}</div>'
							+'</label>',
					//图片单选题
					radioPic : '<div class="weui_cells_title">{questionNo} {questionTitle}{questionCode}{questionTips}{questionIswill}</div>'
    						+'<div id="{questionId}" class="weui_cells weui_cells_radio_pic"></div>',
					radioPicRow : '<div class="qm_check_pic_con"></div>', 	
					radioPicOptionNull : '<label class="weui_cell weui_check_label qm_check_pic_odd"></label>',
    				radioPicOption : '<label class="weui_cell weui_check_label" for="{optionId}">'
    						+'<div class="qm_check_pic"><img src="{optionPic}" /></div>'
							+'<div class="qm_check_pic_txt"><div class="weui_cell_hd">'
							+'<input type="radio" class="weui_check" name="{questionId}" value="{optionValue}" id="{optionId}">'
							+'<span class="weui_icon_checked"></span></div>'
							+'<div class="weui_cell_bd weui_cell_primary"><p>{optionName}</p>{optionVote}</div>'
							+'</div></label>',			
					
					//图片多选题
					checkPic : '<div class="weui_cells_title">{questionNo} {questionTitle}{questionCode}{questionTips}{questionIswill}</div>'
    						+'<div id="{questionId}" class="weui_cells weui_cells_checkbox_pic"></div>',
    				checkPicRow : '<div class="qm_check_pic_con"></div>', 	
    				checkPicOptionNull : '<label class="weui_cell weui_check_label qm_check_pic_odd"></label>',
    				checkPicOption : '<label class="weui_cell weui_check_label" for="{optionId}">'
    						+'<div class="qm_check_pic"><img src="{optionPic}" /></div>'
							+'<div class="qm_check_pic_txt"><div class="weui_cell_hd">'
							+'<input type="checkbox" class="weui_check" name="{questionId}" value="{optionValue}" id="{optionId}">'
							+'<span class="weui_icon_checked"></span></div>'
							+'<div class="weui_cell_bd weui_cell_primary"><p>{optionName}</p>{optionVote}</div>'
							+'</div></label>',

					//填空题
					form : '<div class="weui_cells_title">{questionNo} {questionTitle}{questionCode}{questionTips}{questionIswill}</div>'
							+'<div id="{questionId}" class="weui_cells weui_cells_form">'
							+'<div class="weui_cell"><div class="weui_cell_bd weui_cell_primary">'
							//+'<input class="weui_input" type="text" value="{optionValue}">
							+'<textarea class="weui_textarea" rows="{heightValue}" name="{questionId}" placeholder="{questionDefaultValue}"></textarea>'
							+'</div></div></div>',
					//矩阵题
					matrix : '<div class="weui_cells_title">{questionNo} {questionTitle}{questionTips}{questionIswill}</div>'
							+'<div id="{questionId}" class="weui_cells_matrix"></div>',
					//标题
					head : '<div id="{questionId}" class="weui_cells_title">{questionTitle}{questionCode}{questionIswill}</div>'
            }
			
			
			var $writePanel = $('#tpl_qm_write');
        	var $writeHtml = "";
        	var qNum = 0;

        	$writePanel.html("");
        	
        	$writeHtml = QM.Util.format(_template.writePanel,{'writeTitle' : writeJson.title});
        	$writeHtml = QM.Util.format($writeHtml,{'writeRemark' : writeJson.explains || ""});
        	
        	$writePanel.append($writeHtml);

            $.each(writeConJson,function(key,data){
            	var dataType = data.type;
            	switch(dataType){
            		case "radio":  
            		case "coderadio":
            		case "testradio":	
            		case "voteradio":
            			var _Id = data.id;
            			var _code = data.code;
            			var _tips = data.tips;
            			if(_code && _code != undefined){
            				var _codeHtml = "<span>(分数:"+data.code+")</span>"
            			}else{
            				var _codeHtml = "";
            			}
            			
            			if(_tips && _tips != undefined){
            				var _tipsHtml = "<span class='title_tips'>提示:"+_tips+"</span>";
            			}else{
            				var _tipsHtml = "";
            			}
            			
            			if(data.isWill){
            				var _isWillHtml = "<span style='color:red;'>*</span>";
            			}else{
            				var _isWillHtml = "";
            			}
            			
            			if(data.isPic){
            				var _radioExercises = QM.Util.format(_template.radioPic,{'questionTitle' : data.topic});
            			}else{
            				var _radioExercises = QM.Util.format(_template.radio,{'questionTitle' : data.topic});
            			}

            			_radioExercises = QM.Util.format(_radioExercises,{'questionNo' : qNum+1});
            			_radioExercises = QM.Util.format(_radioExercises,{'questionId' : _Id});
            			_radioExercises = QM.Util.format(_radioExercises,{'questionCode' : _codeHtml});
            			_radioExercises = QM.Util.format(_radioExercises,{'questionTips' : _tipsHtml});
            			_radioExercises = QM.Util.format(_radioExercises,{'questionIswill' : _isWillHtml});
            			            			
            			$writePanel.find(".page").append(_radioExercises);
            			
            			$.each(data.options,function(key,value){
            				var _optionName = value.name;
            				var _optionId = _Id + "_" + key;
            				var radioOption = "";

            				if(data.isPic){
            					radioOption = QM.Util.format(_template.radioPicOption,{'optionId' : _optionId});
            					radioOption = QM.Util.format(radioOption,{'optionPic' : value.pic});
                			}else{
                				radioOption = QM.Util.format(_template.radioOption,{'optionId' : _optionId});
                			}
            				//TODO 带填空选项
            				var _isTextHtml = '<div class="qm-write-input"><input type="text" name="'+_Id+'" id="'+_optionName+'" /></div>';
            				if(value.isText){
            					radioOption = QM.Util.format(radioOption,{'optionisText' : _isTextHtml});
            				}else{
            					radioOption = QM.Util.format(radioOption,{'optionisText' : ''});
            				}
            				
            				radioOption = QM.Util.format(radioOption,{'optionName' : _optionName});
            				radioOption = QM.Util.format(radioOption,{'optionValue' : _optionName});
            				radioOption = QM.Util.format(radioOption,{'questionId' : _Id});
	            				
            				var _otherHtml = "";
            				if(dataType == "voteradio"){
            					var params = {
        							'id' : writeJson.questionnaire_id ? writeJson.questionnaire_id : writeJson.id,
        							'holder_id' : _Id
        						};    
            					_otherHtml = QM.write.returnVoteNumber(params,_optionName);
            				}else if(dataType == "coderadio"){
            					if(value.isNull){
            						_otherHtml = "<span class='qm-write-vote pull-right'>(不计分)</span>";
            					}else{
            						_otherHtml = "<span class='qm-write-vote pull-right'>(分数:"+ value.code +")</span>";
            					}	
            				}else if(dataType == "testradio"){
            					if(value.isAnswer){
            						_otherHtml = "<span class='qm-write-right qm-write-vote pull-right' style='display:none'>正确答案</span>";
            					}else{
            						_otherHtml = "";
            					}	
            				}else{
            					var _otherHtml = "";		
            				}
            				
            				radioOption = QM.Util.format(radioOption,{'optionVote' : _otherHtml});
            				            				
            				if(data.isPic){
            					if(key % 2 == 0){
            						$writePanel.find("#"+_Id).append(_template.radioPicRow);
            					}
            					$writePanel.find("#"+_Id).find(".qm_check_pic_con:last").append(radioOption);
            					
            					if(key % 2 != 0 && key == data.options.length){
            						$writePanel.find("#"+_Id).find(".qm_check_pic_con:last").append(_template.radioPicOptionNull);
        						}
                			}else{
                				$writePanel.find("#"+_Id).append(radioOption);
                			}
            			})
            			qNum++;
            			break;
            		case "check":
            		case "codecheck":
            		case "testcheck":
            		case "votecheck":
            			var _Id = data.id;
            			var _code = data.code;
            			var _tips = data.tips;
            			if(_code && _code != undefined){
            				var _codeHtml = "<span>(分数:"+data.code+")</span>"
            			}else{
            				var _codeHtml = "";
            			}
            			
            			if(_tips && _tips != undefined){
            				var _tipsHtml = "<span class='title_tips'>提示:"+_tips+"</span>";
            			}else{
            				var _tipsHtml = "";
            			}
            			
            			if(data.isWill){
            				var _isWillHtml = "<span style='color:red;'>*</span>";
            			}else{
            				var _isWillHtml = "";
            			}
            			
            			if(data.isPic){
            				var _checkExercises = QM.Util.format(_template.checkPic,{'questionTitle' : data.topic});
            			}else{
            				var _checkExercises = QM.Util.format(_template.check,{'questionTitle' : data.topic});
            			}
            			_checkExercises = QM.Util.format(_checkExercises,{'questionNo' : qNum+1});
            			_checkExercises = QM.Util.format(_checkExercises,{'questionId' : _Id});
            			_checkExercises = QM.Util.format(_checkExercises,{'questionCode' : _codeHtml});
            			_checkExercises = QM.Util.format(_checkExercises,{'questionTips' : _tipsHtml});
            			_checkExercises = QM.Util.format(_checkExercises,{'questionIswill' : _isWillHtml});
            			$writePanel.find(".page").append(_checkExercises);
            			
            			$.each(data.options,function(key,value){
            				
            				
            				
            				var _optionName = value.name;
            				var _optionId = _Id + "_" + key;
            				
            				if(data.isPic){
            					var checkOption = QM.Util.format(_template.checkPicOption,{'optionId' : _optionId});
            					checkOption = QM.Util.format(checkOption,{'optionPic' : value.pic});
                			}else{
                				var checkOption = QM.Util.format(_template.checkOption,{'optionId' : _optionId});
                			}
            				var _isTextHtml = '<div class="qm-write-input"><input type="text" name="'+_Id+'" id="'+_optionName+'" /></div>';
            				if(value.isText){
            					checkOption = QM.Util.format(checkOption,{'optionisText' : _isTextHtml});
            				}else{
            					checkOption = QM.Util.format(checkOption,{'optionisText' : ''});
            				}
            				
            				checkOption = QM.Util.format(checkOption,{'optionName' : _optionName});
            				checkOption = QM.Util.format(checkOption,{'optionValue' : _optionName});
            				checkOption = QM.Util.format(checkOption,{'questionId' : _Id});

            				var _otherHtml = "";
            				if(dataType == "votecheck"){
            					var params = {
        							'id' : writeJson.questionnaire_id ? writeJson.questionnaire_id : writeJson.id,
        							'holder_id' : _Id
        						};    
            					_otherHtml = QM.write.returnVoteNumber(params,_optionName);
            				}else if(dataType == "codecheck"){
            					if(value.isNull){
            						_otherHtml = "<span class='qm-write-vote pull-right'>(不计分)</span>";
            					}else{
            						_otherHtml = "<span class='qm-write-vote pull-right'>(分数:"+ value.code +")</span>";
            					}	
            				}else if(dataType == "testcheck"){
            					if(value.isAnswer){
            						_otherHtml = "<span class='qm-write-right qm-write-vote pull-right' style='display:none'>正确答案</span>";
            					}else{
            						_otherHtml = "";
            					}	
            				}else{
            					var _otherHtml = "";		
            				}
            				
            				checkOption = QM.Util.format(checkOption,{'optionVote' : _otherHtml});
            				
            				if(data.isPic){
            					if(key % 2 == 0){
            						$writePanel.find("#"+_Id).append(_template.checkPicRow);
            					}
            					$writePanel.find("#"+_Id).find(".qm_check_pic_con:last").append(checkOption);
            					
            					if(key % 2 != 0 && key == data.options.length){
            						$writePanel.find("#"+_Id).find(".qm_check_pic_con:last").append(_template.checkPicOptionNull);
        						}
                			}else{
                				$writePanel.find("#"+_Id).append(checkOption);
                			}
            			})
            			qNum++;
            			break;
            		case "input":
            		case "testinput":
            			var _Id = data.id;
            			var _code = data.code;
            			var _tips = data.tips;
            			var _height = data.heightValue;
            			var _defaultValue = data.defaultValue;
            			var _underlineStyle = data.underlineStyle;
            			var _standardanswer = data.standardanswer;

            			if(_code && _code != undefined){
            				var _codeHtml = "<span>(分数:"+data.code+")</span>"
            			}else{
            				var _codeHtml = "";
            			}

            			if(_tips && _tips != undefined){
            				var _tipsHtml = "<span class='title_tips'>提示:"+_tips+"</span>";
            			}else{
            				var _tipsHtml = "";
            			}
            			
            			if(data.isWill){
            				
            				var _isWillHtml = "<span style='color:red;'>*</span>";
            			}else{
            				var _isWillHtml = "";
            			}
            			
            			var _inputExercises = QM.Util.format(_template.form,{'questionTitle' : data.topic});
            			_inputExercises = QM.Util.format(_inputExercises,{'questionNo' : qNum+1});
            			_inputExercises = QM.Util.format(_inputExercises,{'questionId' : _Id});
            			_inputExercises = QM.Util.format(_inputExercises,{'questionCode' : _codeHtml});
            			_inputExercises = QM.Util.format(_inputExercises,{'heightValue' : _height});
            			_inputExercises = QM.Util.format(_inputExercises,{'questionTips' : _tipsHtml});
	            		_inputExercises = QM.Util.format(_inputExercises,{'questionDefaultValue' : _defaultValue})
	            		_inputExercises = QM.Util.format(_inputExercises,{'questionIswill' : _isWillHtml});
            			$writePanel.find(".page").append(_inputExercises);
	            		
            			if(_standardanswer && _standardanswer != ""){
            				var standardanswer = "<div class='qm-write-right' style='margin-top: 10px;display:none'>标准答案:" +_standardanswer + "</div>"
            				$writePanel.find("#"+_Id).find(".weui_cell_bd").append(standardanswer);
            			}
            			
            			if(_underlineStyle){
            				$writePanel.find("#"+_Id).css({"border-width":"0px 0px 1px","border-bottom-style":"solid","border-bottom-color":"rgb(127, 157, 185)","border-radius":"0px"})
            			}	
            			qNum++;
            			break;
            		case "matrixradio":
            		case "codematrix":
            			var _Id = data.id;  
            			var _tips = data.tips;
            			if(_tips && _tips != undefined){
            				var _tipsHtml = "<span class='title_tips'>提示:"+_tips+"</span>";
            			}else{
            				var _tipsHtml = "";
            			}
            			if(data.isWill){
            				var _isWillHtml = "<span style='color:red;'>*</span>";
            			}else{
            				var _isWillHtml = "";
            			}
            			var _matrixExercises = QM.Util.format(_template.matrix,{'questionTitle' : data.topic});
            			_matrixExercises = QM.Util.format(_matrixExercises,{'questionNo' : qNum+1});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionId' : _Id});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionTips' : _tipsHtml});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionIswill' : _isWillHtml});
            			$writePanel.find(".page").append(_matrixExercises);
            			
            			var leftLabelArr = data.leftLabel.split(/[\n]/);
            			$.each(leftLabelArr,function(key,value){
            				
            				var _matrixChildId = _Id + "_" + value;
            				var _matrixChildCode = value.code;
                			if(_matrixChildCode && _matrixChildCode != undefined){
                				var _matrixChildCodeHtml = "<span>(分数:"+data.code+")</span>"
                			}else{
                				var _matrixChildCodeHtml = "";
                			}
                			
                			var _matrixChildExercises = QM.Util.format(_template.radio,{'questionTitle' : value});
                			_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionNo' : ''});
            				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionId' : _matrixChildId});
            				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionCode' : _matrixChildCodeHtml});
            				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionTips' : ''});
            				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionIswill' : ''});
                			$writePanel.find("#"+_Id).append(_matrixChildExercises);
                			
                			$.each(data.options,function(key,value){
                				var _matrixChildOptionName = value.name;
                				var _matrixChildOptionId = _matrixChildId + "_" + _matrixChildOptionName;
                				var matrixChildOption = QM.Util.format(_template.radioOption,{'optionId' : _matrixChildOptionId});

                				var _otherHtml = "";
                				if(dataType == "codematrix"){
                					if(value.isNull){
                						_otherHtml = "<span class='qm-write-vote pull-right'>(不计分)</span>";
                					}else{
                						_otherHtml = "<span class='qm-write-vote pull-right'>(分数:"+ value.code +")</span>";
                					}	
                				}else{
                					var _otherHtml = "";		
                				}
                				
                				matrixChildOption = QM.Util.format(matrixChildOption,{'optionName' : _matrixChildOptionName});
                				matrixChildOption = QM.Util.format(matrixChildOption,{'optionValue' : _matrixChildOptionName});
                				matrixChildOption = QM.Util.format(matrixChildOption,{'questionId' : _matrixChildId});
                				matrixChildOption = QM.Util.format(matrixChildOption,{'optionVote' : _otherHtml});
                				matrixChildOption = QM.Util.format(matrixChildOption,{'optionisText' : ''});
                				$writePanel.find("#"+_matrixChildId).append(matrixChildOption);
                			})

            			})
            			qNum++;
            			break;
            		case "matrixcheck":
            			var _Id = data.id;
            			var _tips = data.tips;
            			if(_tips && _tips != undefined){
            				var _tipsHtml = "<span class='title_tips'>提示:"+_tips+"</span>";
            			}else{
            				var _tipsHtml = "";
            			}     
            			
            			if(data.isWill){
            				var _isWillHtml = "<span style='color:red;'>*</span>";
            			}else{
            				var _isWillHtml = "";
            			}
            			
            			var _matrixExercises = QM.Util.format(_template.matrix,{'questionTitle' : data.topic});
            			_matrixExercises = QM.Util.format(_matrixExercises,{'questionNo' : qNum+1});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionId' : _Id});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionTips' : _tipsHtml});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionIswill' : _isWillHtml});
            			$writePanel.find(".page").append(_matrixExercises);
            			
            			var leftLabelArr = data.leftLabel.split(/[\n]/);
            			$.each(leftLabelArr,function(key,value){
            				
            				var _matrixChildId = _Id + "_" + value;
            				var _matrixChildCode = value.code;
            				if(_matrixChildCode && _matrixChildCode != undefined){
                				var _matrixChildCodeHtml = "<span>(分数:"+data.code+")</span>"
                			}else{
                				var _matrixChildCodeHtml = "";
                			}
                			var _matrixChildExercises = QM.Util.format(_template.check,{'questionTitle' : value});
                			_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionNo' : ''});
            				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionId' : _matrixChildId});
            				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionCode' : _matrixChildCodeHtml});
            				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionTips' : ''});
            				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionIswill' : ''});
                			$writePanel.find("#"+_Id).append(_matrixChildExercises);
                			
                			$.each(data.options,function(key,value){
                				var _matrixChildOptionName = value.name;
                				var _matrixChildOptionId = _matrixChildId + "_" + _matrixChildOptionName;
                				var matrixChildOption = QM.Util.format(_template.checkOption,{'optionId' : _matrixChildOptionId});
                					matrixChildOption = QM.Util.format(matrixChildOption,{'optionName' : _matrixChildOptionName});
                					matrixChildOption = QM.Util.format(matrixChildOption,{'optionValue' : _matrixChildOptionName});
                					matrixChildOption = QM.Util.format(matrixChildOption,{'questionId' : _matrixChildId});
                					matrixChildOption = QM.Util.format(matrixChildOption,{'optionVote' : ''});
                					matrixChildOption = QM.Util.format(matrixChildOption,{'optionisText' : ''});
                				$writePanel.find("#"+_matrixChildId).append(matrixChildOption);
                			})

            			})
            			qNum++;
            			break;
            		case "matrixinput":
            			var _Id = data.id;
            			var _tips = data.tips;

            			if(_tips && _tips != undefined){
            				var _tipsHtml = "<span class='title_tips'>提示:"+_tips+"</span>";
            			}else{
            				var _tipsHtml = "";
            			}       
            			if(data.isWill){
            				var _isWillHtml = "<span style='color:red;'>*</span>";
            			}else{
            				var _isWillHtml = "";
            			}
            			var _matrixExercises = QM.Util.format(_template.matrix,{'questionTitle' : data.topic});
            			_matrixExercises = QM.Util.format(_matrixExercises,{'questionNo' : qNum+1});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionId' : _Id});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionTips' : _tipsHtml});
        				_matrixExercises = QM.Util.format(_matrixExercises,{'questionIswill' : _isWillHtml});
            			$writePanel.find(".page").append(_matrixExercises);
            			
            			var leftLabelArr = data.leftLabel.split(/[\n]/);
            			$.each(leftLabelArr,function(key,value){
            				var _matrixChildId = _Id + "_" + value;
            				var _matrixChildCode = value.code;
                			if(_matrixChildCode && _matrixChildCode != undefined){
                				var _matrixChildCodeHtml = "<span>(分数:"+data.code+")</span>"
                			}else{
                				var _matrixChildCodeHtml = "";
                			}
                			var _matrixChildExercises = QM.Util.format(_template.form,{'questionTitle' : value});
                			_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionNo' : ''});
	        				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionId' : _matrixChildId});
	        				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionCode' : _matrixChildCodeHtml});
	        				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'heightValue' : ''});
	        				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionTips' : ''});
	        				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionDefaultValue' : ''})
	        				_matrixChildExercises = QM.Util.format(_matrixChildExercises,{'questionIswill' : ''})
	        				$writePanel.find("#"+_Id).append(_matrixChildExercises);
            			})
            			qNum++;
            			break;
            		case "head":
            			var _Id = data.id;
            			var _code = data.code;
            			var _height = data.heightValue;
            			if(_code && _code != undefined){
            				var _codeHtml = "<span>(分数:"+data.code+")</span>"
            			}else{
            				var _codeHtml = "";
            			}
            			if(data.isWill){
            				var _isWillHtml = "<span style='color:red;'>*</span>";
            			}else{
            				var _isWillHtml = "";
            			}
            			var _inputExercises = QM.Util.format(_template.head,{'questionTitle' : data.topic});
            			_inputExercises = QM.Util.format(_inputExercises,{'questionId' : _Id});
            			_inputExercises = QM.Util.format(_inputExercises,{'questionCode' : _codeHtml});
            			_inputExercises = QM.Util.format(_inputExercises,{'questionIswill' : _isWillHtml});
            			$writePanel.find(".page").append(_inputExercises);
            			break;
            	}
                
            })
            var writeSubmit = '<div class="bd spacing"><a  class="weui_btn weui_btn_primary qm-write-submit">提交</a></div>';
            $writePanel.find(".page").append(writeSubmit);
		},
		/**
		 * 获取投票数据
		 * @params {'id':'','holder_id':''}
		 */
		returnVoteNumber : function(params,optionName){
			var showVotePercent = false;
			var _voteHtml = "";
			QM.service.getVoteNumber(params,function(result){
				if (result) {
					var charts = $.parseJSON(result);
					var t = {};
					$.each(charts,function(key,value){
						t[value.name] = t[value.name] || {name:value.name,count:0};
						t[value.name].count++;
					})
					Object.keys(t).map(function(key) {
						var name = t[key].name;
						var count = t[key].count;
						var sum = charts.length;
						var percent = (Math.round(count / sum * 10000) / 100.00 + "%");
						
						_voteHtml = "<span class='qm-write-vote pull-right'";
						if(!showVotePercent){
							_voteHtml += "style='display:none;'";
						}
						if(optionName == name){
							_voteHtml += ">"+ count + "票("+ percent + ")</span>";
						}else{
							_voteHtml += ">0票(0.00%)</span>";
						}
					});
				}
			})
			return _voteHtml;
		},
		/**
		 * 渲染问卷已填数据
		 */
		renderAnswer : function(result){
			
			var reg = new RegExp("\n","g");
			var answerJson = JSON.parse(result.answer.replace(reg,"\\n"))
			var $writePanel = $('#tpl_qm_write');
			$writePanel.find("input,textarea").attr("readonly","readonly");
			$.each(answerJson,function(key,data){
				switch (data.type) {
					case "radio":
					case "check":
					case "coderadio":
					case "codecheck":
					case "testradio":	
					case "testcheck":	
					case "voteradio":	
					case "votecheck":	
						if (data.options) {
							for (var i = 0; i < data.options.length; i++) {
								var option = data.options[i];
								var $option = $writePanel.find("#"+data.id).find("input[name='"+data.id+"']").not("[type='text']").eq(option.index);
								var $optionInput = $writePanel.find("#"+data.id).find("input[name='"+data.id+"'][type='text']").eq(option.index);
								
								$option.attr("checked","checked");
								$optionInput.attr("value",option.explains);
								$optionInput.parent(".qm-write-input").css("display","block");
								if (data.type == "testradio" || data.type == "testcheck") {
									$writePanel.find("#"+data.id).find(".qm-write-right").show();
								}
							}
						}
						break;
					case "input":
					case "testinput":	
						var $input = $writePanel.find("#"+data.id).find("textarea[name='"+data.id+"']");
						$input.text(data.value);
						if (data.type == "testinput") {
							$writePanel.find("#"+data.id).find(".qm-write-right").show();
						}
						break;
					case "matrixradio":
					case "matrixcheck":	
					case "codematrix":
						if (data.options) {
							for (var i = 0; i < data.options.length; i++) {
								var optionVulue = data.options[i].index;
								var matrixTitle = optionVulue.substr(0,optionVulue.indexOf("_"))
								var $matrixPanel = $writePanel.find("#"+data.id+"_"+matrixTitle);
								var $input = $matrixPanel.find("input[name='"+data.id+"_"+matrixTitle+"'][value='"+data.options[i].value+"']");
								$input.attr("checked","checked");
							}
						}
						break;
					case "matrixinput":
						if (data.options) {
							for (var i = 0; i < data.options.length; i++) {
								var matrixTitle = data.options[i].name;
								var $matrixPanel = $writePanel.find("#"+data.id+"_"+matrixTitle);
								var $input = $matrixPanel.find("textarea[name='"+data.id+"_"+matrixTitle+"']");
								$input.text(data.options[i].value);
							}
						}
						break;
					
				}
				$writePanel.find(".qm-write-submit").parent().css("padding-bottom","15px");
				$writePanel.find(".qm-write-submit").hide();
			})
		},
		/**
		 * 绑定事件
		 */
		bindEven: function(){
			
			var $container = $("#container");
			
        	$container.on('click', 'a.qm-write-submit', function (){
            	if(confirm("是否提交案卷(提交后不可以再作答)?")){
        			var flag = QM.Util.checkRequired();
        			if(flag){
        				var json = QM.Util.encodeJson();  
        				var params =  {
		        			"content.questionnaire_id" : QM.cache.writeJson.id,
		        			"content.content" : QM.cache.writeJson.content,
		        			"content.answer" : json
		        		};
        				QM.service.saveAnswer(params,function(){
        					window.location.href='#/qm-msg';
        				})
        			}else{
        				alert("请填写带 * 必填题");
        			}
        		}
            });
        	
        	$container.on("click", ".qm-write-input input", function(){
        		return false;
        	});

        	$container.on("change", "input[type='radio'],input[type='checkbox'],input[type='text'],textarea[name]", function (){
        		var $this = $(this);
            	var name = $this.attr("name");
            	var holder
            	for(var i = 0,vlen = QM.cache.writeConJson.length; i < vlen; i++){ 
            		if($this.parents(".weui_cells_matrix").size() > 0){
            			
            		}else{
            			if(QM.cache.writeConJson[i].id == name){ 
                			holder = QM.cache.writeConJson[i];
                		}
            		}
            	}

            	if(holder && holder != undefined){
            		
            		//判断是否显示填空
                	if(holder.type=="radio" || holder.type=="check" || holder.type=="voteradio" || holder.type=="votecheck"){
                		for(var i = 0; i < holder.options.length; i++){	
            				if ($("#"+holder.id+"_"+i).prop('checked')) {
            				    if(holder.options[i].isText){
                    				$("#"+holder.id).find("[for='"+holder.id+"_"+i+"']").find(".qm-write-input").show();
                    			}
            				}else{
            					if(holder.options[i].isText){
                    				$("#"+holder.id).find("[for='"+holder.id+"_"+i+"']").find(".qm-write-input").hide();
                    			}
            				}
                		}
                	}

            		if(this.tagName == "TEXTAREA"){
        				holder.value = $(this).val();
	        		}else{
	        			if($(this).attr("type")=="text"){
	        				var $inputs = $container.find("input[name='" + name + "'][type='text']");
	        				$inputs.each(function(a) {
	        					var o = holder.options[a];
	        					o.explains = $(this).val();
	        				})
	        			}else{
	        				var $inputs = $container.find("input[name='" + name + "'][type='radio'],input[name='" + name + "'][type='checkbox']");
	        				$inputs.each(function(a) {
	        					var o = holder.options[a];
	        					o.selected = this.checked;
	        				})
	        			}
	        		}
            	}
            	
            });
		}
	},
	/**
	 * 问卷中心
	 */
	center : {
		init : function(){
			var params = {
				"type": QM.cache.searchType != null ? QM.cache.searchType : 1,
				 "_pagelines":50
			}
			QM.service.getCenterList(params,function(result){
				QM.center.renderCenterList(result);
			});			
		},
		/**
		 * 渲染问卷中心列表
		 */
		renderCenterList : function(result){
        	var $centerPanel = $('#tpl_qm_center');
        	var $centerHtml = $($('#tpl_qm_center').html());
        	
        	var $searchBoxMyPanel = $centerHtml.find(".search-box-my");
        	var $searchBoxMyHtml = $($centerHtml.find(".search-box-my").html());
        	
        	var listHtml = ""; 	
        	var listTemplate = '<li><a class="qm-center-listid" data-listid="{listId}" data-status="{listStatus}">'
			        		+'<div class="qm-item-box weui_cell">'
			        		+'<div class="weui_cell_hd">{listAvatar}</div>'
			        		+'<div class="weui_cell_bd weui_cell_primary">'
			        		+'<div class="qm-item-title"><span class="qm-item-title-txt">{listTitle}</span>{listStatusHtml}</div> '
		                    +'<div class="qm-item-txt">'
		                    +'<div class="qm-item-person">{listUserName}[{listUserDept}]</div>'
		                    +'<div class="qm-item-date">{listDate}</div>'
		                    +'</div></div></div></a></li>';
        	
        	$.each(result.datas,function(key,data){
        		var _id = data.id;
        		var _creator = data.creatorName;
        		var _creatorId = data.creator;
        		var _creatorDept = data.creatorDeptName;
        		var _creatorDeptId = data.creatorDeptId;
        		var _creatorDate = data.createDate;
        		var _title = data.title;
        		var _explains = data.explains;
        		var _status = data.status;
        		var _fillStatus = data.fillStatus;
        		var _avatar,_statusHtml;
        		var avatar = QM.Util.getAvatar(_creatorId);
        		if(avatar!="" && avatar!=undefined){
					_avatar = "<img src ="+avatar+">";
				}else{
					_avatar = "<div class='noAvatar'>"+ _creator.substr(_creator.length-2, 2) +"</div>";
				}
        		
        		if(QM.cache.searchType == "0"){
        			if(_status == "0"){
            			_statusHtml = '<span class="qm-item-title-status status-1">草稿</span>';
            		}else if(_status == "1"){
            			_statusHtml = '<span class="qm-item-title-status status-0">进行中</span>';
            		}else if(_status == "2"){
            			_statusHtml = '<span class="qm-item-title-status status-2">已完成</span>';
            		}
    			}else{
    				if(_fillStatus == "1"){
            			_statusHtml = '<span class="qm-item-title-status status-0">进行中</span>';
            		}else if(_fillStatus == "2"){
            			_statusHtml = '<span class="qm-item-title-status status-1">已完成</span>';
            		}
    			}
        		
        		
        		var _listHtmlLi = QM.Util.format(listTemplate , {'listAvatar' : _avatar});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listTitle' : _title});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listUserName' : _creator});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listUserDept' : _creatorDept});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listDate' : _creatorDate});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listStatus' : _fillStatus});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listStatusHtml' : _statusHtml});
        		_listHtmlLi = QM.Util.format(_listHtmlLi , {'listId' : _id});
        		
        		listHtml += _listHtmlLi;
        	})
        	
        	
        	if(QM.cache.searchType != null){
        		$searchBoxMyHtml.find("li").removeClass("active");
        		var $searchLi = $searchBoxMyHtml.find("li[data-type='"+QM.cache.searchType+"']");
        		$searchLi.addClass("active");
        		var text = $searchLi.text()
        		$searchBoxMyPanel.html($searchBoxMyHtml);
        		$centerHtml.find(".search-box-filter-item[data-filter='my']").html(text+' <i class="fa fa-caret-down" aria-hidden="true"></i>');
        	}
        	
        	
        	$centerHtml.find(".qm-list-box").find("ul").html(listHtml);
        	$centerPanel.html($centerHtml);
		},
		/**
		 * 渲染右侧筛选面板
		 */
		renderFilterRight : function(){
			var _filterRightHtml = ""
			var _filterRightStatus = $("#container .panel-cover .content-block").find(".panel-status");
			if(QM.cache.searchType == "0"){
				_filterRightHtml = '<span class="panel-right-tag panel-right-status" data-status="0">草稿</span>'
					+'<span class="panel-right-tag panel-right-status" data-status="1">进行中</span>'
					+'<span class="panel-right-tag panel-right-status" data-status="2">已完成</span>';
			}else{
				_filterRightHtml = '<span class="panel-right-tag panel-right-status" data-status="1">进行中</span>'
					+'<span class="panel-right-tag panel-right-status" data-status="2">已完成</span>';
			}
			_filterRightStatus.html(_filterRightHtml);
		},
		/**
		 * 筛选动作
		 */
		centerSearch : function(){
			var title = QM.cache.searchTitle;
			var type = QM.cache.searchType;
			var status = QM.cache.searchStatus;
			var params = {
				"title"	: title == undefined ? title = "" : title ,
				"type"	: type == undefined ? type = "" : type ,
				"status"	: status == undefined ? status = "" : status,
				"_pagelines" : 50
			}
			
			QM.service.getCenterList(params,function(result){
				QM.center.renderCenterList(result);
				var $ul = $("#tpl_qm_center").find(".qm-list-box").find("ul");
				var _listHtml = $ul.html()
				$("#container").find(".qm-list-box").find("ul").html(_listHtml);
			});	
		},
		/**
		 * 绑定事件
		 */
		bindEven : function(){
			var $container = $("#container");
			$container.on('click', '.search-box-filter-item', function (){
        		var $masks = $container.find(".qm-list-box-masks");
			    var $this = $(this);
			    var filter = $this.data("filter");
			    if(filter == "my"){
			    	$container.find(".search-box-my").slideToggle("fast",function(){
			    		var $thisIcon = $this.find("i.fa");
			    		if($thisIcon.hasClass("fa-caret-down")){
			    			$this.attr("_show","true");
			    			$thisIcon.removeClass("fa-caret-down").addClass("fa-caret-up");
			    			$masks.fadeIn("fast");
			    		}else{
			    			$this.attr("_show","false");
			    			$thisIcon.removeClass("fa-caret-up").addClass("fa-caret-down");
			    			$masks.fadeOut("fast");
			    		}
			    	});
			    }else if(filter == "filter"){
			    	var $filterPanel = $container.find(".search-box-filter");
			    	if($filterPanel.hasClass("active")){
			    		$filterPanel.removeClass("active");
		    			$this.attr("_show","false");
		    			$masks.css("z-index","1");
		    			$masks.fadeOut("fast");
			    	}else{
			    		$filterPanel.addClass("active");
		    			$this.attr("_show","true");
		    			$masks.css("z-index","10");
		    			$masks.fadeIn("fast");
			    	}
			    }
			    
			});
        	
        	$container.on('click', '.search-box-my li', function (){

        		var $this = $(this);
        		var $searchFilter = $container.find(".search-box-filter-item[data-filter='my']");
        		var _type = $this.data("type");

    			QM.cache.searchType = _type;
    			QM.cache.searchStatus = "";
    			
    			$container.find(".search-box-my li").removeClass("active");
        		$this.addClass("active");
        		QM.center.centerSearch();
        		QM.center.renderFilterRight();

        		$searchFilter.html($this.text()+'<i class="fa fa-caret-up" aria-hidden="true"></i>');
        		$searchFilter.trigger("click");
        	})
        	
        	$container.on('click', '.panel-right-status', function (){
        		var $this = $(this);
        		var _status = $this.data("status");        		
        		QM.cache.searchStatus = _status;	
        		$(".panel-right-status").removeClass("active");
        		$this.addClass("active");
        	})
        	
        	$container.on('click', '.panel-right-submit', function (){
        		QM.center.centerSearch();
        		$container.find(".qm-list-box-masks").trigger("click");
        	})
        	
        	$container.on('click', '.panel-right-reset', function (){
        		$("span.panel-right-tag").removeClass("active");
        		QM.cache.searchStatus = "";	
        	})
        	
        	$container.on('click', 'a.qm-center-listid', function (){
        		var $this = $(this);
        		var _listid = $this.data("listid");
        		var _liststatus = $this.data("status");
        		if(QM.cache.searchType == "0"){
        			$this.attr("href","#/qm-show/:"+_listid);
    			}else{
    				$this.attr("href","#/qm-write/:"+_listid);
    			}
        		
        	})
        	

        	$container.on('click', '.search-box .search-btn', function (){
        		var _title = $(".search-box").find("input").val();
        		QM.cache.searchTitle = _title;        		
        		QM.center.centerSearch();
        	})
        	
        	$container.on('click', '.qm-list-box-masks', function (){
        		var $masks = $container.find(".qm-list-box-masks");
        		$container.find(".search-box-filter-item[_show='true']").trigger("click");
        		$container.find(".search-box-filter-item[_show='true']").attr("_show","false");
        		$masks.css("z-index","1");
        	})
		}
	},
	/**
	 * 统计页面
	 */
	show : {
		init : function(listId){
			var params = {
				"id":listId	
			}
			QM.service.getShowResult(params,function(result){
	        	QM.show.renderShow(listId,result);
			});	
		},
		/**
		 * 渲染统计页面题目和答案
		 */
		renderShow: function(listId,result){

        	var _template = {
        			showPanel : '<div class="hd"><h1>{showTitle}</h1><p>{showRemark}</p></div>'
        					+'<div class="bd"><article class="weui_article"></article></div>',
    				//单选多选
    				input : '<section><h2 class="title text-center">{questionTitle}{questionCode}</h2>'
    						+'<section id="{chartId}" style="height:200px;width:100%" class="weui_article_item_panel"></section>'
    						+'<table class="table table-striped text-left" id="{tableId}"><thead></thead><tbody></tbody></table>'
    						+'</section>',	
    				inputOption : '<div id="{optionId}" class="weui_article_item">'
    						+'<div class="weui_article_item_name">{optionName}</div><div>'
    						+'<span class="weui_article_item_num">0</span> 个</div></div>',
    				inputTable : '',
					//图片单选题
					radioPic : '<div class="weui_cells_title text-center">{questionTitle}</div>'
    						+'<div class="weui_cells weui_cells_radio_pic"></div>',
					radioPicRow : '<div class="qm_check_pic_con"></div>', 	
					radioPicOptionNull : '<label class="weui_cell weui_check_label qm_check_pic_odd"></label>',
    				radioPicOption : '<label class="weui_cell weui_check_label" for="{optionId}">'
    						+'<div class="qm_check_pic"><img src="{optionPic}" /></div>'
							+'<div class="qm_check_pic_txt"><div class="weui_cell_hd">'
							+'<input type="radio" class="weui_check" name="{questionId}" value="{optionValue}" id="{optionId}">'
							+'<span class="weui_icon_checked"></span></div>'
							+'<div class="weui_cell_bd weui_cell_primary"><p>{optionName}</p></div>'
							+'</div></label>',			
					//图片多选题
					checkPic : '<div class="weui_cells_title text-center">{questionTitle}</div>'
    						+'<div class="weui_cells weui_cells_checkbox_pic"></div>',
    				checkPicRow : '<div class="qm_check_pic_con"></div>', 	
    				checkPicOptionNull : '<label class="weui_cell weui_check_label qm_check_pic_odd"></label>',
    				checkPicOption : '<label class="weui_cell weui_check_label" for="{optionId}">'
    						+'<div class="qm_check_pic"><img src="{optionPic}" /></div>'
							+'<div class="qm_check_pic_txt"><div class="weui_cell_hd">'
							+'<input type="checkbox" class="weui_check" name="{questionId}" value="{optionValue}" id="{optionId}">'
							+'<span class="weui_icon_checked"></span></div>'
							+'<div class="weui_cell_bd weui_cell_primary"><p>{optionName}</p></div>'
							+'</div></label>',
					//填空题
					form : '<section><h2 class="title text-center">{questionTitle}{questionCode}</h2>'
							+'<section id="{questionId}" class="weui_article_item_panel">'
							+'<table class="table table-striped" data-id="{resultId}" data-qid="{questionId}">'
							+'<thead><tr><th width="20%">答卷人</th><th width="30%">答卷时间</th><th width="50%">答案</th></tr></thead>'
							+'<tbody><tr name="showMore"><td colspan="3"><div class="answer-form-btn weui_cells_access"><a data-id="{resultId}" data-qid="{questionId}" class="weui_cell">'
							+'<div class="weui_cell_bd weui_cell_primary"><p>查看更多</p></div><div class="weui_cell_ft"></div>'
							+'</a></div></tbody></td></th></table>'
							+'</section></section>',
					//矩阵题
					matrix : '<section><h2 class="title text-center">{questionTitle}</h2>'
							+'<section id="{questionId}" class="weui_article_item_panel">'
							+'<div id="{chartId}" style="height:200px;width:100%"></div>'
							+'<table class="table table-striped text-left" id="{tableId}"><thead></thead><tbody></tbody></table>'
							+'</section></section>',
					//标题
					head : '<section><h2 class="title text-center">{questionTitle}</h2>'
							+'<section id="{questionId}" class="weui_article_item_panel"></section></section>'
            }

        	var reg = new RegExp("\n","g");
        	//var showJson = JSON.parse(result.content.replace(reg,"\\n"));
        	var showJson = JSON.parse(result.content);
        	var chartsJson = JSON.parse(result.chartJson);
        	var $showPanel = $('#tpl_qm_show');
        	var $showHtml = "";
        	
        	$showPanel.html("");
        	
        	$showHtml = QM.Util.format(_template.showPanel,{'showTitle' : result.title});
        	$showHtml = QM.Util.format($showHtml,{'showRemark' : result.explains || ""});
        	
        	$showPanel.append($showHtml);

        	$.each(showJson,function(key,data){
        		var dataType = data.type;
            	switch(dataType){
            		case "radio":  
            		case "coderadio":
            		case "testradio":	
            		case "voteradio":
            		case "check":
            		case "codecheck":
            		case "testcheck":
            		case "votecheck":
            			var _Id = data.id;
            			var _code = data.code;
            			if(_code && _code != undefined){
            				var _codeHtml = "<span>(分数:"+data.code+")</span>"
            			}else{
            				var _codeHtml = "";
            			}
            			var _exercises = QM.Util.format(_template.input,{'questionTitle' : data.topic});
            			_exercises = QM.Util.format(_exercises,{'questionId' : _Id});
            			_exercises = QM.Util.format(_exercises,{'questionCode' : _codeHtml});
            			_exercises = QM.Util.format(_exercises,{'chartId' : _Id+"_chart"});
            			_exercises = QM.Util.format(_exercises,{'tableId' : _Id+"_table"});
            			$showPanel.find("article.weui_article").append(_exercises);

            			for(var i = 0; i < data.options.length; i++){
            				
            				var optionNameHtml;
            				if(data.isPic){
    							optionNameHtml = "<a href='"+data.options[i].pic+"' style='display: inline-block;vertical-align: top;' target='_blank'><img src='"+data.options[i].pic+"' style='max-width:50px;max-height:50px;' /></a> "+data.options[i].name;
    						}else{
    							optionNameHtml = data.options[i].name;
    						}
            				
            				var optionHtml = '<tr class="holder-item-details" name="'+data.options[i].name+'"><td>'+optionNameHtml+'</td><td>0 个</td></tr>'
            				$showPanel.find("#"+_Id+"_table").append(optionHtml);
            			}
            			break;
            		
            		case "input":
            		case "testinput":
            		case "matrixinput":

            			var _Id = data.id;
            			var _code = data.code;
            			var _height = data.heightValue;
            			if(_code && _code != undefined){
            				var _codeHtml = "<span>(分数:"+data.code+")</span>"
            			}else{
            				var _codeHtml = "";
            			}
            			var _inputExercises = QM.Util.format(_template.form,{'questionTitle' : data.topic});
	            			_inputExercises = QM.Util.format(_inputExercises,{'questionId' : _Id});
	            			_inputExercises = QM.Util.format(_inputExercises,{'questionCode' : _codeHtml});
	            			_inputExercises = QM.Util.format(_inputExercises,{'resultId' : result.id});
	            			_inputExercises = QM.Util.format(_inputExercises,{'heightValue' : _height});
	            		$showPanel.find("article.weui_article").append(_inputExercises);
	            		
	            		//渲染前5条填空题
	            		var params = {
	            			"id":listId,
	            			"q_id":_Id,
	            			"pagelines": 5,
	            			"currpage": 1
	            		}

	            		QM.service.getInputValue(params,function(result){
	            			var inputHtml = QM.showInput.renderInputLine(_Id,result.datas);
	            			$showPanel.find("#"+_Id+" tr[name='showMore']").before(inputHtml);
	            		});	

            			break;
            		case "matrixradio":
            		case "codematrix":
            		case "matrixcheck":
            			var _Id = data.id;
            			var _matrixExercises = QM.Util.format(_template.matrix,{'questionTitle' : data.topic});
            				_matrixExercises = QM.Util.format(_matrixExercises,{'questionId' : _Id});
            				_matrixExercises = QM.Util.format(_matrixExercises,{'chartId' : _Id+"_chart"});
            				_matrixExercises = QM.Util.format(_matrixExercises,{'tableId' : _Id+"_table"});
            				
            			$showPanel.find("article.weui_article").append(_matrixExercises);
            			
            			//渲染首行
            			var leftLabelArr = data.leftLabel.split(/[\n]/);
            			var _matrixTH = "<tr><th></th>";
            			$.each(leftLabelArr,function(key,value){
            				var _matrixChildCode = value.code;
                			if(_matrixChildCode && _matrixChildCode != undefined){
                				var _matrixChildCodeHtml = "<span>(分数:"+data.code+")</span>"
                			}else{
                				var _matrixChildCodeHtml = "";
                			}
                			_matrixTH += '<th name="'+value+'">'+value+'</th>';
            			})
            			_matrixTH += '</tr>';
            			$showPanel.find("#"+_Id+"_table thead").append(_matrixTH);
            			//渲染首列
            			var _matrixTHNum = $showPanel.find("#"+_Id+"_table thead").find("th").size();  			
            			$.each(data.options,function(key,value){  
                			var _matrixTB = "<tr name='"+value.name+"'><td>"+value.name+"</td>";
            				for(var i = 1; i < _matrixTHNum; i++){
            					_matrixTB += "<td></td>";
            				}
            				_matrixTB += '</tr>';
            				$showPanel.find("#"+_Id+"_table tbody").append(_matrixTB);
                		});
            			if(dataType == "codematrix"){
            				{
                    			var _matrixTB = "<tr name='score'><td>总分</td>";
                				for(var i = 1; i < _matrixTHNum; i++){
                					_matrixTB += "<td></td>";
                				}
                				_matrixTB += '</tr>';
                				$showPanel.find("#"+_Id+"_table tbody").append(_matrixTB);
            				}
            				{
                    			var _matrixTB = "<tr name='average'><td>平均分</td>";
                				for(var i = 1; i < _matrixTHNum; i++){
                					_matrixTB += "<td></td>";
                				}
                				_matrixTB += '</tr>';
                				$showPanel.find("#"+_Id+"_table tbody").append(_matrixTB);
            				}
            			}
            			break;
            			
            		case "head":
            			var _Id = data.id;
            			var _code = data.code;
            			var _height = data.heightValue;
            			var _codeHtml = "";
            			var _inputExercises = QM.Util.format(_template.head,{'questionTitle' : data.topic});
	            			_inputExercises = QM.Util.format(_inputExercises,{'questionId' : _Id});
	            		$showPanel.find("article.weui_article").append(_inputExercises);
            			break;
            	}
        	})
        	
        	//缓存整理后的报表json
        	QM.cache.chartsJson = chartsJson;

        	if(chartsJson){
				for(var i=0;i<chartsJson.length;i++){
					var chart = chartsJson[i];
					var id = chart.id;
					var data = chart.data;
					var series = chart.series;
					var dataType = chart.type;
					var userName = chart.userName;
					
					if(data != null || series != null){
						switch(dataType){
							case "radio":  
		            		case "coderadio":
		            		case "testradio":	
		            		case "voteradio":
		            		case "check":
		            		case "codecheck":
		            		case "testcheck":
		            		case "votecheck":
		            			var $_table = $("#tpl_qm_show").find("#"+id+'_table');
		            			$.each(data,function(key,value){
		            				$_table.find("tr[name='"+key+"']>td:eq(1)").html(value+" 个");
		            			})
		            			//为选项tr添加"选择人员名单"
		            			$.each(userName,function(key,data){
		            				var $_tr = $_table.find("tr[name='"+key+"']");
		            				var answerNameStr = JSON.stringify(data);
		            				$_tr.attr("data-dataType",dataType).attr("data-answerName",answerNameStr);
		            			})
		            			break;
		            		case "matrixradio":
		            		case "codematrix":
		            		case "matrixcheck":
								var $_table = $("#tpl_qm_show").find("#"+id+'_table');
								for(var j = 0; j < series.length; j++){
									var _name = series[j].name;
									var _userName = series[j].userName;	
									var _index = $_table.find("th[name='"+_name+"']").index();
									if(_index >= 0){
										for(var v = 0; v < series[j].data.length; v++){
											var $_tr = $_table.find("tbody>tr:eq("+v+")");
											var _dataAnswerName = $_tr.data("answername");
											var _dataItemName = $_tr.data("itemname");
											var _userNameArr = [];
											var _itemNameArr = [];
											
											if(_dataAnswerName != undefined){
												_userNameArr = _dataAnswerName;
											}
											_userNameArr.push(_userName[v]);
											
											if(_dataItemName != undefined){
												_itemNameArr = _dataItemName;
											}
											_itemNameArr.push(_name);
											
											$_table.find("tbody>tr:eq("+v+")").attr("data-dataType",dataType)
											$_table.find("tbody>tr:eq("+v+")").attr("data-answername",JSON.stringify(_userNameArr));
											$_table.find("tbody>tr:eq("+v+")").attr("data-itemname",JSON.stringify(_itemNameArr));
											$_table.find("tbody>tr:eq("+v+")>td:eq("+_index+")").html(series[j].data[v]);
										}
				            			if(dataType == "codematrix"){
				            				$_table.find("tbody>tr:eq("+(series[j].data.length)+")>td:eq("+_index+")").html(series[j].code.score);
				            				$_table.find("tbody>tr:eq("+(series[j].data.length+1)+")>td:eq("+_index+")").html(series[j].code.average);
				            			}
									}
								}						
								break;
						}
					}
				}
			}
		},
		/**
		 * 渲染名单页面
		 */
		renderAnswerName: function(showtype,data){
			
		},
		/**
		 * 绑定事件
		 */
		bindEven : function(){
			var $container = $("#container");
			$container.on('click', '.answer-form-btn a', function (){
				var $this = $(this);
				var _qid = $this.data("qid");
				var _id = $this.data("id");
				window.location.href='#/qm-showInput/:'+_id+'/:'+_qid;
			});
			
			$container.on('click', 'tr[data-datatype]', function (){
				var $this = $(this);
				var dataType = $this.data("datatype");
				var $answerNamePanel = $('#tpl_qm_answerName');
				var answerNameHtml =  '<div class="bd"><article class="weui_article">'
									+ '<section class="weui_article_item_panel">'
									+ '<table class="table table-striped">'
									+ '<thead></thead><tbody></tbody>'
									+ '</table>'
									+ '</section>'
									+ '</article>'
									+ '</div>';
				
				
				var $answerNameHtml = $(answerNameHtml);
				
				switch(dataType){
					case "radio":  
	        		case "coderadio":
	        		case "testradio":	
	        		case "voteradio":
	        		case "check":
	        		case "codecheck":
	        		case "testcheck":
	        		case "votecheck":
	        			var _itemName = $this.attr("name");
	        			var _answerName = $this.data("answername");
	        			var _answerNameStr = "";
	        			for(var i = 0;i < _answerName.length;i++){
	        				_answerNameStr += _answerName[i].name + "(" + _answerName[i].department + "),"
	        			}
	        			var _thead = "<tr><th>"+_itemName+"</th></tr>";
	        			var _tbody = "<tr><td>"+_answerNameStr+"</td></tr>";
	        			$answerNameHtml.find("thead").append(_thead);
	        			$answerNameHtml.find("tbody").append(_tbody);
	        			$answerNamePanel.html($answerNameHtml);
	        			break;
            		case "matrixradio":
            		case "codematrix":
            		case "matrixcheck":
            			var _name = $this.attr("name");
            			var _itemNameArr = $this.data("itemname");
	        			var _answerNameArr = $this.data("answername");
	        			
	        			var _thead = "<tr>";
	        			for(var i=0; i<_itemNameArr.length; i++){
	        				var _itemName = _itemNameArr[i];
	        				_thead += "<th>" +_itemName+ "</th>";
	        			}
	        			_thead += "</tr>";
	        				
	        				
	        			var _tbody = "<tr class='text-center'>";
	        			for(var i=0; i<_answerNameArr.length; i++){
	        				var _answerName = _answerNameArr[i];
	        				var _answer = "";
	        				for(var j = 0; j < _answerName.length; ++j){
	        					_answer += _answerName[j].name + "(" + _answerName[j].department + ")<br/>";
	        				}
	        				_tbody += "<td>" + _answer + "</td>";
	        			}
	        			_tbody += "</tr>"
	        			
	        			$answerNameHtml.find("thead").append(_thead);
	        			$answerNameHtml.find("tbody").append(_tbody);
	        			$answerNamePanel.html($answerNameHtml);

            			break;
				}
				
				window.location.href='#/qm-answerName';
			});
		},
		/**
		 * 初始化报表(dom渲染完)
		 */
		initChart : function(){
			var chartsJson = QM.cache.chartsJson;
			if(chartsJson){
				for(var i=0;i<chartsJson.length;i++){
					var chart = chartsJson[i];
					var id = chart.id;
					var data = chart.data;
					var series = chart.series;
					var dataType = chart.type;
					if(data != null || series != null){
						switch(dataType){
							case "radio":  
		            		case "coderadio":
		            		case "testradio":	
		            		case "voteradio":
		            			var _labelNum = 0;
		            			var _labelLength;
		            			var _data = [];
		            			var _series = [];

		            			for(var each in data){_labelNum ++};
		            			_labelLength = parseInt((($(window).width() - 30) / _labelNum - 40 )  / 14);
		            			
		            			$.each(data,function(key,value){
		            				if(key.length > _labelLength){
		            					key = key.substr(0,_labelLength-1) + "...";
		            				}
		            				var _seriesObj = {"value":value,"name":key};
		            				_series.push(_seriesObj)
		            				_data.push(key);
		            			}) 
		            			var myChart = echarts.init(document.getElementById(id+'_chart'));
						        // 指定图表的配置项和数据
						        var option = {
						        		legend: {
						        			x : 'center',
						        	        y : 'bottom',
						        	        data: _data
						        	    },
						        		series : [
						        	        {
						        	            type:'pie',
						        	            radius : '65%',
						        	            center: ['50%', '45%'],
						        	            data:_series,
						        	            label: {
						        	                normal: {
						        	                    textStyle: {
						        	                        color: 'rgba(0, 0, 0, 0.5)'
						        	                    }
						        	                }
						        	            },
						        	            labelLine: {
						        	                normal: {
						        	                    lineStyle: {
						        	                    	color: 'rgba(0, 0, 0, 0.5)'
						        	                    },
						        	                    smooth: 0.2,
						        	                    length: 10,
						        	                    length2: 10
						        	                }
						        	            },
						        	            itemStyle: {
						        	            	emphasis: {
						        	                    shadowBlur: 10,
						        	                    shadowOffsetX: 0,
						        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
						        	                }
						        	            }
						        	        }
						        	    ]
						        };
						        // 使用刚指定的配置项和数据显示图表。
						        myChart.setOption(option);
								break;
		            		case "check":
		            		case "codecheck":
		            		case "testcheck":
		            		case "votecheck":
		            			var _labelNum = 0;
		            			var _labelLength;
								var _data = [];
		            			var _series = [{"data":[],"type":"bar","itemStyle":{
		                            normal: {
		                                color: function(){
		                                	return "#"+("00000"+((Math.random()*16777215+0.5)>>0).toString(16)).slice(-6); 
		                                }
		                            }
		                        }}];
		            			for(var each in data){_labelNum ++};
		            			_labelLength = parseInt(($(window).width() - 30) / _labelNum / 14);
		            			$.each(data,function(key,value){
		            				if(key.length > _labelLength){
		            					key = key.substr(0,_labelLength-1) + "...";
		            				}
		            				_series[0].data.push(value);
		            				_data.push(key);
		            			}) 
		            			
								var myChart = echarts.init(document.getElementById(id+'_chart'));
						        // 指定图表的配置项和数据
						        var option = {

						        	    grid: {
						        	        left: '3%',
						        	        right: '4%',
						        	        bottom: '5%',
						        	        containLabel: true
						        	    },
						        	    xAxis : [
						        	        {
						        	            type : 'category',
						        	            data : _data,
						        	            axisLabel :{  
						        	            	interval:0
						        	            }
						        	        }
						        	    ],
						        	    yAxis : [
						        	        {
						        	            type : 'value'
						        	        }
						        	    ],
						        	    series : _series
						        	};


						        // 使用刚指定的配置项和数据显示图表。
						        myChart.setOption(option);
								break;
		            		case "matrixradio":
		            		case "codematrix":
		            		case "matrixcheck":
		            			var _labelLength;
								var _legend = chart.legend;
								var _xAxis = chart.xAxis;
								var _yAxis = chart.yAxis;
								var _series = chart.series;
								for(var j = 0; j < _series.length; j++){
									_series[j].type = 'bar';
								}
								_labelLength = parseInt(($(window).width() - 30) / _xAxis.length / 14);
								for(var v = 0; v < _xAxis.length; v++){
									if(_xAxis[v].length > _labelLength){
										_xAxis[v] = _xAxis[0].substr(0,_labelLength-1) + "...";
		            				}
								}
								var myChart = echarts.init(document.getElementById(id+'_chart'));
						        // 指定图表的配置项和数据
						        var option = {
						        	    legend: _legend,
						        	    grid: {
						        	        left: '3%',
						        	        right: '4%',
						        	        bottom: '10%',
						        	        containLabel: true
						        	    },
						        	    xAxis : [
						        	        {
						        	            type : 'category',
						        	            data : _xAxis,
						        	            axisLabel :{  
						        	                interval:0   
						        	            } 
						        	         }
						        	    ],
						        	    yAxis : [
						        	        {
						        	            type : _yAxis
						        	        }
						        	    ],
						        	    series : _series
						        	};

						        // 使用刚指定的配置项和数据显示图表。
						        myChart.setOption(option);
								break;	
						}
						
						
					}
				}
			}
		}
	},
	/**
	 * 统计填空题页面
	 * qid 问题id
	 */
	showInput : {
		init : function(id,qid){
			
			var params = {
				"id":id,
				"q_id":qid,
				"pagelines": 15,
    			"currpage": 1
			}

			QM.service.getInputValue(params,function(result){
	        	QM.showInput.renderInputPanel(qid,result);
	        	QM.cache.scrollInputRowCount = result.rowCount;
			});	
			
			QM.cache.scrollInputHeight = 0;
			QM.cache.scrollInputParams = params;
		},
		bindEven : function(){
			$("#container").on("scroll",function() { 
				var qid = QM.cache.scrollInputParams.q_id;
				var trSize = $('#container').find("section#"+qid).find("tbody").find("tr").size();
				if($('#container').find('.qm_showInput').size() > 0 && trSize < QM.cache.scrollInputRowCount){
					QM.Util.controlLoading("show");
					//浏览器的高度加上滚动条的高度 
					QM.cache.scrollInputHeight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());     
				    //当文档的高度小于或者等于总的高度的时候，开始动态加载数据
				    if ($(document).height() <= QM.cache.scrollInputHeight){ 
				        //调整参数
				    	QM.cache.scrollInputParams.currpage = QM.cache.scrollInputParams.currpage + 1;
				    	//加载数据
				    	QM.service.getInputValue(QM.cache.scrollInputParams,function(result){
				    		var qid = QM.cache.scrollInputParams.q_id;
				    		var inputHtml = QM.showInput.renderInputLine(qid,result.datas);
							$('#container').find("section#"+qid).find("tbody").append(inputHtml);
						});	
				    }
				    setTimeout(function(){
				    	QM.Util.controlLoading("hide");
				    }, 1000);
				    
				}
			}); 
		},
		/**
		 * 渲染统计页面题目和答案
		 */
		renderInputPanel: function(qid,result){

			var _template = '<div class="bd"><article class="weui_article"><section id="{questionId}" class="weui_article_item_panel">'
							+'<table class="table table-striped">'
							+'<thead><tr><th width="20%">答卷人</th><th width="30%">答卷时间</th><th width="50%">答案</th></tr></thead>'
							+'<tbody></tbody></table>'
							+'</section></article></div>';

			var $showInputPanel = $('#tpl_qm_showInput');
        	var $showInputHtml = "";
        	$showInputPanel.html("");
        	
			$showInputHtml = QM.Util.format(_template,{'questionId' : qid});  
			$showInputHtml = QM.Util.format($showInputHtml,{'showTitle' : ""}); 
			$showInputPanel.append($showInputHtml);
			
			var inputHtml = QM.showInput.renderInputLine(qid,result.datas);
			$('#tpl_qm_showInput').find("tbody").append(inputHtml);
			
		},
		renderInputLine : function(qid,datas){
			var inputHtml = ""
			for(var v = 0; v < datas.length; v++){
				var showInputJson = JSON.parse(datas[v].answer);
				for(var i = 0; i < showInputJson.length; i++){
	        		var showInput = showInputJson[i];
					if(showInput.id == qid){
						inputHtml += "<tr>"
						var value = "";
						if(showInput.options && showInput.type == "matrixinput"){
							
							for(var j = 0; j < showInput.options.length; j++){
								var inputOption = showInput.options[j];
								value += inputOption.name + ":"+ inputOption.value + " ";
							}
						}else{
							value = showInput.value;
						}
						inputHtml += "<td>"+datas[v].userName+"</td><td>"+datas[v].date+"</td><td>"+value+"</td></tr>"
						
					}
	        	}
			}
			return inputHtml;
		}
		
	},
	cache : {
		scrollInputParams : null,//填空题页面参数
		scrollInputHeight : 0,//填空题页面总高度变量
		scrollInputRowCount : 0,//填空题页面数据总数
		searchType : 1, //搜索类型 1我参与的 0我发布的
		searchTitle : null,
		searchStatus : null,
		writeJson : null,
		writeContentJson : null,
		answerJson : null,
		chartsJson : null
	}
}