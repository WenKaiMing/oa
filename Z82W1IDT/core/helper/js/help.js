/**
 * help function
 **/

var doclayout;
/**
 * init body layout
 * */
function initBodyLayOut(){
	doclayout=jQuery('body').layout({ 
		applyDefaultStyles: true 
	});
	doclayout.toggle("west");
}


function getHelpTreeIndex(){
	var parem=jQuery("#SHvalue").attr("value");
	jQuery.ajax({
		url:contextPath+"/core/helper/getHelpTreeIndex.action",
		type:"post",
		datatype:"jason",
		data:{"seachParem":parem},
		success:function(data){
			if(data){
				jQuery("#helpTree").html(data);
			}else{
				jQuery("#helpTree").html("<br>此页面暂无帮助信息！");
			}
		},
		error:function(data,status){
			alert("failling to visited...");
		}
	});	
}

/**点击右侧help 的一项时 跳转到详细页面**/
function showHelpContent(id){
	jQuery('#helpFrame').css('display','');
	jQuery('#helpcontenttitle').css('display','none');
	jQuery('#helpcontent').css('display','none');
	jQuery('#helpFrame').attr('src',contextPath+'/core/helper/helperIndex.jsp?id='+id);
}

/**点击右侧返回列表**/
function showHelpContentToBack(){
	jQuery('#helpFrame').css('display','none');
	jQuery('#helpcontenttitle').css('display','');
	jQuery('#helpcontent').css('display','');
}

/**
 * 详细页面内容
 **/
function initGetHelpTree(helpnodeid){
	jQuery.get(contextPath+'/core/helper/HelpMsg.xml', function(data){ 
		var html="<ul>";
		jQuery(data).find('helpnode').each(function(){ 
			var helpNode = jQuery(this);
			var id = helpNode.attr("id"); 
			var name = helpNode.attr("name");
			if(id==helpnodeid){
				var description = helpNode.find('description').text(); 
				html +=description; 
			}
		}); 
		jQuery('#helpTree').html(html); 
	});	
}	


/**
 *show help tips message
 **/
	function isShowSubHelpMenus(obj){
		var subobj=obj.next("img").next("a").next("ul");
		if(subobj.css("display")=="none"){
			subobj.css("display","");
			obj.attr("src","../../resource/imgnew/minus.gif");
			obj.next("img").attr("src","../../resource/imgnew/toc_open.gif");
		}else{
			subobj.css("display","none");
			obj.attr("src","../../resource/imgnew/plus.gif");
			obj.next("img").attr("src","../../resource/imgnew/toc_closed.gif");
		}
	}
