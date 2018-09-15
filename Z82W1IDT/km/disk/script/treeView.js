
var curVal = "";	//当前选中的树形节点

var d = new dTree('d');
//初始化dtree
function initDtree(){
	var $node = jQuery("#obpmDtree");
	var curId = $node.attr("obpmId");
	d.add(curId,$node.attr("obpmPid"),$node.attr("obpmName"), $node.attr("obpmIsparent"));	//添加节点对象
	jQuery("#obpmDtree").html(d.toString());
	d.adjxAddNode(curId);
}

function getDimensions(){
	var bodyW ="";
	var mainLeftW = jQuery(".mainLeft").width();
	if(navigator.userAgent.indexOf("MSIE")>0) { 
	   	var browser = navigator.appName;
		var version = navigator.appVersion.split(";"); 
		var trim_Version = version[1].replace(/[ ]/g,"");
		
		if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
		{ 
			bodyW = jQuery(document).width();
			mainLeftW = mainLeftW + 3;
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
		{ 
			bodyW = jQuery(document).width()-3;
		}else{
			bodyW = jQuery(document).width()-2;
		}
	}else{
		bodyW = jQuery(document).width()-2;
	}
	var documentH = jQuery(document).height()-3;//2是border
	jQuery(".mainLeft").height(documentH);
	jQuery(".mainRight").height(documentH);
	jQuery(".mainRight").width(bodyW - mainLeftW);
}

/**
* 点击树形切换显示相应的内容
*/
function switchTreeList(){
	var curid = "";
	jQuery(".aElementClick").click(function(){
		if(curid=="" || curid != this.id){
			var dirFrame = document.getElementById("dirFrame");
			dirFrame.contentWindow.document.getElementById("ndirid").value = jQuery(this).attr("id");
			dirFrame.contentWindow.document.getElementById("_currpage").value = 1;
			dirFrame.contentWindow.document.forms[0].action = contextPath + '/km/disk/viewndir.action';
			dirFrame.contentWindow.document.forms[0].submit();
			curid = this.id;
		}
	});
}

//添加监听事件
function listenAction(){
	jQuery(".dTreeNode").each(function(){
		//添加鼠标滑过事件
		jQuery(this).bind("mouseover",function(){
			this.style.backgroundColor = "#ddd";
		}).bind("mouseout",function(){
			this.style.backgroundColor = "";
		}).bind("click",function(){
			if(curVal=="" || curVal != this.id){
				jQuery(".dTreeNode").each(function(){
					this.style.backgroundColor = "";
					//重新添加鼠标滑过事件
					jQuery(this).bind("mouseover",function(){
						this.style.backgroundColor = "#ccc";
					}).bind("mouseout",function(){
						this.style.backgroundColor = "";
					});
					
				});
				curVal = this.id;
				this.style.backgroundColor = "#ccc";
				jQuery(this).unbind("mouseover");
				jQuery(this).unbind("mouseout");
				
			}
		});
	});
}