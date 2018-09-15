var AddressList = {
	/**
	 * 初始化
	 */
	init : function() {
		this.department.init();
		this.user.init();
		this.bindEvent();
	},
	/**
	 * 绑定事件
	 */
	bindEvent : function() {
		
	},
	
	department:{
		
		init : function(){
    		$('#js_party_tree')
			.jstree({
				'core' : {
					'data' : {
						'url' : 'org/getDepartmentTree.action',
						'data' : function (node) {
							return { 'id' : node.id };
						}
					},
					'check_callback' : true,
					'themes' : {name:false,url:false,dir:false,icons:true,variant:false,stripes:false,responsive:true,dots:true}
				},
			  'contextmenu': {
	                    select_node: false,
	                    items: function() {
	                        if (g) {
	                            var a = $.jstree.defaults.contextmenu.items();
	                            return a.create.label = "添加子部门", a.create.action = function(a) {
	                                var c = $.jstree.reference(a.reference), d = c.get_node(a.reference);
	                                c.create_node(d, {
	                                    type: "default",
	                                    text: "新建部门"
	                                }, "last", function(a) {
	                                    setTimeout(function() {
	                                        c.edit(a);
	                                    }, 0);
	                                });
	                            }, a.rename.label = "重命名", a.remove.label = "删除", delete a.ccp, a;
	                        }
	                    }
	                },
                'types': {
	                    "default": {
	                        icon: "icon icon_folder_blue"
	                    }
	                },
				'plugins' : ['state','dnd','contextmenu','wholerow']
			})
			.on('delete_node.jstree', function (e, data) {
				$.getJSON("org/deleteDept.action",{ 'id' :  data.node.id },function(result){
					if(1==result.status){
						//data.instance.set_id(data.node, result.data);
					}else{
						data.instance.refresh();
					}
				});
			})
			.on("select_node.jstree", function(e, data) { 
				if("click"==data.event.type){
				//部门列表点击刷新
				var uri =window.location.href;
				var dd = uri.split("?");
				if(dd[1]==("deptId="+data.node.id))
					return;
				
				if(data.node.parent=="#")
					window.location.href="list.action";
				else
					window.location.href="list.action?deptId="+data.node.id;
				data.instance.set_id(data.node, data.node);
				}
			})
			.on('create_node.jstree', function (e, data) {
				//alert('create_node');
				$.getJSON("org/createDept.action",{ 'parent' : data.node.parent, 'position' : data.position, 'name' : data.node.text },function(result){
					if(1==result.status){
						data.instance.set_id(data.node, result.data);
					}else{
						data.instance.refresh();
					}
				});
				
				/**
				$.get('org/createDept.action', { 'parent' : data.node.parent, 'position' : data.position, 'name' : data.node.text })
					.done(function (d) {
						alert(d.id);
						data.instance.set_id(data.node, d.id);
					})
					.fail(function () {
						alert('fail');
						data.instance.refresh();
					});
				**/
			})
			.on('rename_node.jstree', function (e, data) {
				$.getJSON("org/renameDept.action",{ 'id' :  data.node.id,'name' : data.text },function(result){
					if(1==result.status){
						//data.instance.set_id(data.node, result.data);
					}else{
						data.instance.refresh();
					}
				});
				/**
				$.get('?operation=rename_node', { 'id' : data.node.id, 'text' : data.text })
					.fail(function () {
						data.instance.refresh();
					});
				**/
			})
			.on('move_node.jstree', function (e, data) {
				
			})
			.on('copy_node.jstree', function (e, data) {
			})
			.on('changed.jstree', function (e, data) {
				if(data && data.selected && data.selected.length) {
					$.get('?operation=get_content&id=' + data.selected.join(':'), function (d) {
						$('#data .default').html(d.content).show();
					});
				}
				else {
					$('#data .content').hide();
					$('#data .default').html('Select a file from the tree.').show();
				}
			});	
    		
   		   var g = $("#js_app_modal");
   		    g.length > 0 && function() {
   		        var a = g.data("show");
   		        a && setTimeout(function() {
   		            g.modal("show");
   		        }, 200);
   		    }(), window.attention = function(a) {
   		        var c = $("#js_attention_modal");
   		        $(".js_attention_number", c).html(a), c.modal("show");
   		    };
   		    
   		    this.bindEvent();
		},
		
		bindEvent : function() {
			
		},
	},
	
	user : {
		init : function() {
			
			this.bindEvent();
		},
		bindEvent : function() {
			$(".user-item").on("click",function(e){
				var id = $(this).data("id");
				var domainid = $(this).data("domainid");
				$("#user-edit-iframe").attr("src",contextPath+"/saas/weioa/org/editUser.action?id="+id+"&domain="+domainid);
				$("#user-edit-modal").modal({
				});
			});
			
			$("#user-edit-modal-btn-save").on("click",function(e){
				$.getJSON(contextPath+"/saas/weioa/org/saveUser.action",$(window.frames['user-edit-iframe'].document.forms[0]).serializeArray(),function(result){
					if(1==result.status){
						$("#user-edit-modal").modal('hide');
					    location.reload();
					}else{
//						$("#alert-danger").show();
//						$("#user-edit-result-iframe").attr("src",contextPath+"/saas/weioa/org/resultTip.action?result="+result.data);
//						setTimeout("$('#alert-danger').hide()",2000);
						Utils.showMessage(result.data[1][0],"error");
					}
				});
			});
			$("#user-edit-modal-btn-close").on("click",function(e){
				$(window.frames['user-edit-iframe'].document.body).html("");
				$("#user-edit-modal").modal('hide');
			});
			$("#user-btn-create").on("click",function(e){
				var domainid = USER.domainId;
				$("#user-edit-iframe").attr("src",contextPath+"/saas/weioa/org/newUser.action?domain="+domainid);
				$("#user-edit-modal").modal({
				});
			});
			$("#user-btn-delete").on("click",function(e){
				document.forms["user-list"].submit();
			});
		},
	}
};

