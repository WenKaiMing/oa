Contacts.Router = {
	main : function (){
		var router = new Router({
		    container: '#contacts',
		    enterTimeout: 300,
		    leaveTimeout: 300
		});
		//main
		var main = {
		    url: '/:showtype',
		    className: 'contacts-main',
		    render: function () {
	        	var showtype = this.params.showtype.substring(1);
		    	Contacts.main.init(showtype);
		    	return $('#tpl_contacts_main').html();
		    },
		    after: function(){
		    	Contacts.selectList.init();
		    	Contacts.setScrollTop("","main");
		    },
		    bind: function () {
		    	Contacts.main.bindEven();
	        }
		};

		//list
		var list = {
		    url: '/list/:id/:type',
		    className: 'contacts-list',
		    render: function () {
	        	var id = this.params.id.substring(1);
	        	var type = this.params.type.substring(1);
		    	Contacts.list.init(id,type);
		    	return $('#tpl_contacts_list').html();
		    },
		    after: function(){
		    	var id = this.params.id.substring(1);
		    	Contacts.selectList.init();
		    	Contacts.setScrollTop(id,"list");
		    }
		};

		//show
		var show = {
		    url: '/show/:id/:type',
		    className: 'contacts-show',
		    render: function () {
		    	if($(".contacts-show").size() <= 0){
		    		return $('#tpl_contacts_show').html();
		    	}else{
		    		event.stopPropagation();
		    	}
		    	
		    },
		    bind: function(){
		    	Contacts.show.bindEven();
		    }
		};		
		router.push(main)
			.push(list)
			.push(show)
		    .setDefault('/')
		    .init();
	}
}