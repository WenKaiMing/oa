/**
 * PM 业务操作类
 * <p>封装与PM页面与后台进行数据交互的方法</p>
 * @author Happy
 */
Category = {
	/**
	 * 获取一级列表
	 * @params:{}
	 * 获取二级列表,id指定父条目的id，如果留空则获取根下的分类列表
	 * @params:{id}
	 */
	getTreeList : function(params,callback) {
		$.ajax({
			  type: 'POST',
			  url: "../../km/category/ajax/list.action",
			  dataType:"json",
			  data:params,
			  async:false,
			  success: function(result){
				  if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
					}
			  },
			});
	},
	/**
	 * 获取一级列表
	 * @params:{}
	 */
	addList : function(params,callback) {
		$.ajax({
			  type: 'POST',
			  url: "../../km/category/ajax/new.action",
			  dataType:"json",
			  data:params,
			  async:false,
			  success: function(result){
				  if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
							Utils.showMessage(result.message, "success");
						}
					}else{
						Utils.showMessage(result.message, "error");
					}
			  },
			});
	},
	editlist : function(params,callback) {
		$.ajax({
			  type: 'POST',
			  url: "../../km/category/ajax/update.action",
			  dataType:"json",
			  data:params,
			  async:false,
			  success: function(result){
				  if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
							Utils.showMessage(result.message, "success");
						}
					}else{
						Utils.showMessage(result.message, "error");
					}
			  },
			});
	},
	deletelist : function(params,callback) {
		$.ajax({
			  type: 'POST',
			  url: "../../km/category/ajax/delete.action",
			  dataType:"json",
			  data:params,
			  async:false,
			  success: function(result){
				  if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
							Utils.showMessage(result.message, "success");
						}
					}else{
						Utils.showMessage(result.message, "error");
					}
			  },
			});
	}
};