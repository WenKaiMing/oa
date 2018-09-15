QM.Router = {
	pendlist : function(){
		var router = new Router({
		    container: '#container',
		    enterTimeout: 250,
		    leaveTimeout: 250
		});
		//待填问卷
		var qm_pendlist = {
		    url: '/',
		    className: 'qm_pendlist',
		    render: function () {
		    	QM.pendList.init();
		    	return $('#tpl_qm_pendlist').html();
		    },
		    bind: function(){
		    	QM.pendList.bindEven();
		    }
		};
		//填写问卷
		var qm_write = {
		    url: '/qm-write/:listId',
		    className: 'qm_write',
		    render: function () {
		    	var _listId = this.params.listId
	        	var listId = _listId.substring(1);
		    	QM.write.init(listId);
		    	return $('#tpl_qm_write').html();
		    },
		    bind: function (){
		    	QM.write.bindEven();
		    }
		};
		//消息页面
		var qm_msg = {
		    url: '/qm-msg',
		    className: 'qm_msg',
		    render: function () {
		    	return $('#tpl_qm_msg').html();
		    }
		};
		router.push(qm_pendlist)
		    .push(qm_write)
		    .push(qm_msg)
		    .setDefault('/')
		    .init();
	},
	center : function(){
		var router = new Router({
		    container: '#container',
		    enterTimeout: 250,
		    leaveTimeout: 250
		});
		//问卷中心
		var qm_center = {
		    url: '/',
		    className: 'qm_center',
		    render: function () {
		    	QM.center.init();
	            return $('#tpl_qm_center').html();
		    },
		    bind: function(){
		    	QM.center.bindEven();
		    }
		};
		//填写问卷
		var qm_write = {
		    url: '/qm-write/:listId',
		    className: 'qm_write',
		    render: function () {
		    	var _listId = this.params.listId
	        	var listId = _listId.substring(1);
		    	QM.write.init(listId);
		    	return $('#tpl_qm_write').html();
		    },
		    bind: function (){
		    	QM.write.bindEven();
		    }
		};
		//问卷统计
		var qm_show = {
		    url: '/qm-show/:listId',
		    className: 'qm_show',
		    render: function () {
		    	var _listId = this.params.listId
	        	var listId = _listId.substring(1);
		    	QM.show.init(listId);
		    	return $('#tpl_qm_show').html();
		    },
		    after: function(){
		    	QM.show.initChart();
		    },
		    bind: function(){
		    	QM.show.bindEven();
		    }
		};
		//填空题数据页面
		var qm_showInput = {
		    url: '/qm-showInput/:id/:qId',
		    className: 'qm_showInput',
		    render: function () {
		    	$("#container").scrollTop(0);
		    	var _id = this.params.id
		    	var id = _id.substring(1);
		    	var _qid = this.params.qId
	        	var qid = _qid.substring(1);
		    	QM.showInput.init(id,qid);
		    	return $('#tpl_qm_showInput').html();
		    },
		    bind: function(){
		    	QM.showInput.bindEven();
		    }
		};
		//名单页面
		var qm_answerName = {
		    url: '/qm-answerName',
		    className: 'qm_answerName',
		    render: function () {
		    	return $('#tpl_qm_answerName').html();
		    }
		};
		//消息页面
		var qm_msg = {
		    url: '/qm-msg',
		    className: 'qm_msg',
		    render: function () {
		    	return $('#tpl_qm_msg').html();
		    }
		};
		router.push(qm_center)
		    .push(qm_write)
		    .push(qm_show)
		    .push(qm_showInput)
		    .push(qm_answerName)
		    .push(qm_msg)
		    .setDefault('/')
		    .init();
	}
}