//添加意见
var CommonOpinions = {
		config : {
			status : "",	//设置保存状态，新建或编辑
			mode : "select"		//模式：编辑或选择
		},
		init : function(){
			this.doSearch();
		},
		//设置保存状态，新建或编辑
		setState : function(status){
			this.config.status = status;
		},
		//设置模式，新建或选择
		setMode : function(status){
			this.config.mode = status;
		},
		bindEvent : function($html){	//事件绑定

			$html.on("click", "li", function(e){
				e.stopPropagation();
				
				if(CommonOpinions.config.mode == "select"){
					CommonOpinions.addOpinion($(this), event);
				}
			}).on("click", ".del", function(e){	//删除
				e.stopPropagation();
				CommonOpinions.doDelete($(this));
			}).on("click", ".editSub", function(e){	//编辑
				e.stopPropagation();

				CommonOpinions.setState("edit");	//设置为编辑状态
				var $com = $(this).parents("#commonOpinions");
				var $edit = $com.find(".edit");		
				
				$edit.show();	//显示编辑框
				var $text = $(this).siblings(".text");
				var $input = $edit.find("input");
				$input.attr("_id", $text.attr("id")).val($text.text()).focus();	//设置编辑值
			}).on("click", ".addBtn", function(e){	//添加意见
				e.stopPropagation();

				CommonOpinions.setState("new");	//设置为新建状态
				var $com = $(this).parents("#commonOpinions");
				$com.find("ul li i").hide();
				$(this).hide();
				$com.find(".editBtn").hide();
				$com.find(".edit").show();
				var $input = $com.find(".edit").find("input");
				$input.val("").focus();
			}).on("click", ".editBtn", function(e){	//编辑意见
				e.stopPropagation();
				CommonOpinions.setMode("edit");		//设置为编辑模式
				CommonOpinions.setState("new");	//设置为新建状态
				$(this).hide();		//隐藏本身
				var $com = $(this).parents("#commonOpinions");
				$com.find(">ul").addClass("editOpinions");	//增加编辑状态，控制文本宽度
				$com.find("ul li i").hide();
				$com.find(".addBtn").hide();	//隐藏添加按钮
				$com.find(".editSub,.del").show();	//显示删除和编辑操作
				$com.find(".edit").show();		//显示编辑框
			}).on("click", ".cancel", function(e){	//取消
				e.stopPropagation();
				CommonOpinions.setMode("select");		//设置为选择模式
				var $com = $(this).parents("#commonOpinions");
				$com.find(">ul").removeClass("editOpinions");	//移除编辑状态，恢复文本宽度
				$com.find(".addBtn,.editBtn").show();	//隐藏添加和编辑按钮
				$com.find(".edit").hide();				//隐藏编辑框
				$com.find(".editSub, .del").hide();		//隐藏删除和编辑操作
			}).on("click", ".save", function(e){	//保存
				e.stopPropagation();
				CommonOpinions.doSave($(this));
				CommonOpinions.setState("new");	//设置为新建状态
			}).on("click", "input", function(e){	//单行文本
					e.stopPropagation();
			}).on("keydown",function(e){	//Enter时自动保存
				e.stopPropagation();
				if(e && e.keyCode == 13){
					CommonOpinions.doSave($(e.target));
				}
			});
			//隐藏常用意见
			$(document).click(function(){
				$html.hide();
			});
			//显示常用意见
			$("#fieldset_remark_usual").append($html).on("click",function(e){
				e.stopPropagation();
				$html.toggle();
			});
		},
		//点击添加常用意见
		addOpinion : function($me, event){

			var $atti = $("textarea[name=_attitude]");
			var _text = $me.find(".text").text();
			
			var oText = $atti.val();
			if(!oText){
				$atti.val(_text);
			}else{
				$atti.val($atti.val() + "," + _text);
			}

		},
		doSearch : function(){	//查询
			var params = {
					userId : WebUser.id
			};
			$.ajax({
				url : contextPath + "/portal/usersetup/getCommonOpinion.action",
				data : params,
				dataType : "json",
				success : function(result){

					if(result && result.status == 1){
						var _data = {
				    			list : result.data
				    	};
						
						var $html = $(template("commonOpitions-tmpl", _data));
						CommonOpinions.bindEvent($html);
					}
				}
			});
		},
		doCheck : function($me){
			var rtn = "";
			var $com = $me.parents("#commonOpinions");
			var $input = $com.find("input");
			var leng = $input.val().length;
			if(leng && leng>140){
				rtn = "字符长度不能超过140个!";
			}else if(leng == 0){
				rtn = "意见不能为空!";
			}
			return rtn;
		},
		doSave : function($me){	//保存
			var check = this.doCheck($me);
			if(check != ""){
				showMessage("danger", check);
				return false;
			}
			var $com = $me.parents("#commonOpinions");
			var $input = $com.find("input");
			var editType = this.config.status;
			if(editType == "new"){
				this.doCreate($me);
			}else if(editType == "edit"){
				this.doUpdate($me);
			}

			$input.removeAttr("_id").val("");	//重置文本值
		},
		doUpdate : function($me){	//更新
			var $com = $me.parents("#commonOpinions");
			var $input = $com.find("input");
			var id = $input.attr("_id");
			var content = $com.find("input").val();
			var params = {
					userId : WebUser.id,
					id : id,
					opinion : content
			};
			$.ajax({
				url : contextPath + "/portal/usersetup/updateCommonOpinion.action",
				data : params,
				dataType : "json",
				success : function(result){
					if(result && result.status == 1){
						$com.find("ul li #" + id).text(content);
					}
				}
			});
		},
		doCreate : function($me){	//添加意见
			var $com = $me.parents("#commonOpinions");
			var params = {
					userId : WebUser.id,
					opinion : $com.find("input").val()
			};
			$.ajax({
				url : contextPath + "/portal/usersetup/addCommonOpinion.action",
				data : params,
				dataType : "json",
				success : function(result){
					if(result && result.status == 1){
						var data = result.data;
						if(CommonOpinions.config.mode == "select"){
							data.showVal = "none";
						}
						$com.find(".edit").before($(template("commonOpitionsNew-tmpl",result.data)));
					}
				}
			});
		},
		doDelete : function($me){	//删除意见
			var $com = $me.parents("#commonOpinions");
			var id = $me.parent().find("a.text").attr("id");
			var params = {
					userId : WebUser.id,
					id : id
			};
			
			$.ajax({
				url : contextPath + "/portal/usersetup/deleteCommonOpinion.action",
				data : params,
				dataType : "json",
				success : function(result){
					
					if(result && result.status == 1){
						$me.parent().remove();
					}
				}
			});
		}
};