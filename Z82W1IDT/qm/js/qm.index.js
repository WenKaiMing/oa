var QM = {
		/**
		 * 初始化
		 */
		init : function() {
			
			this.homePage.init();
			
		},
		/**
		 * 首页模块
		 */
		homePage:{
			init:function(){
				this.bindEvent();
				this.randerhomePageList({"type":"1","status":"1"});
			},
			bindEvent:function(){
				$(".grid").on("click","#grid-title-top",function(e){//点击新建
					
					document.forms[0].action = contextPath+"/qm/questionnaire/new.action";
					document.forms[0].submit();
				});
				$(".grid").on("click","#grid-title",function() {
					var q_id = $(this).attr("q_id");
					document.forms[0].action = "new.action?id="+q_id;
					document.forms[0].submit();
				});
			},
			randerhomePageList:function(params){
				$.ajax({
		    		url: contextPath + "/qm/questionnaireservice/center.action",
		    		async: false,
		    		data:params,
		    		success: function(result){
		    			var $grid = $(".grid");
		    			for(var i = 0;i < result.data.datas.length;i++){
		    				
		    				var _avatar;
		    				var creator = result.data.datas[i].creator;//创建人的id
		    				var creatorName = result.data.datas[i].creatorName;
		    				var avatar = Common.Util.getAvatar(creator);//获取创建人头像的url
		    				if(avatar!="" && avatar!=undefined){
		    					_avatar = "<img src ="+avatar+">";
		    				}else{
		    					_avatar = "<div class='noAvatarGrid'>"+ creatorName.substr(creatorName.length-2, 2) +"</div>";
		    				}
		    				var $title ='<div id="grid-title" q_id="'+result.data.datas[i].id+'"><div class="top">'
										+'<div class="title">'+result.data.datas[i].title+'</div>'
										+'<div class="status"><span class="label  label-status1 ">进行中</span></div></div>'
										+'<div class="description">' + (result.data.datas[i].explains || "" ) + '</div>'
										+'<div class="grid-info"><div class="touxiang"><div class="touxiangDiv">'+_avatar +'</div></div>'
										+'<div class="grid-detail"><div class="info-name">'
										+'<div class="executor">'+result.data.datas[i].creatorName+'['+result.data.datas[i].creatorDeptName+']</div>'
										+'<div class="datetime">'+result.data.datas[i].createDate+'</div></div></div>'
										+'<div class="grid-completion"><div class="progress-title"><span>2</span>份&nbsp;参与率<span>12%</span></div>'
										+'<div class="progress progress-mini"><div style="width: 0%;" class="progress-bar"></div></div></div></div></div>'
							$grid.append($title);
		    			}
		    		}
				});
			},
		}
};