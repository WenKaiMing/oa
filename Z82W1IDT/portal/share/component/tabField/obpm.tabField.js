(function($){
	$.fn.obpmTabNormalField =function(){
		return this.each(function(){
			var $field = jQuery(this);
			$field.removeAttr("moduleType");
			
			//选项卡嵌套时递归重构
			$field.find("[moduleType='TabNormal']").filter(function(){
				return (jQuery(this).parents("[moduleType='TabNormal']").size() == 0);
			}).obpmTabNormalField();  		//页签选项卡
			//选项卡嵌套时递归重构
			$field.find("[moduleType='TabCollapse']").filter(function(){
				return (jQuery(this).parents("[moduleType='TabCollapse']").size() == 0);
			}).obpmTabCollapseField();  		//折叠选项卡
			
			var html = "";
			// title
			var $fieldTitle = $field.find("[id='title']");

			var tabId=$field.attr("tabId");
			var fieldId=$fieldTitle.attr("fieldId");
			var titleDiv = "<div id='" + fieldId + "' class='basictab'>";
			var titleUl = "<table cellSpacing='0' cellPadding='0'><tr>";
			$fieldTitle.find("div").each(function(){
				var formId=$(this).attr("formId");
				var isHidden=$(this).attr("isHidden");
				var isRefreshOnChanged=$(this).attr("isRefreshOnChanged");
				var name=$(this).attr("name");
				isRefreshOnChanged = (isRefreshOnChanged == "true");
				isHidden = (isHidden == "true");
				
				// <li>
				var liHtml = "";
				liHtml += "<td><div id='li_" + formId + "'";
				if(isHidden){
					liHtml += " style='display:none'";
				}
				liHtml += ">";
				
				// <a>
				var aHtml = "";
				aHtml += "<a style='cursor:pointer'";
				if(isRefreshOnChanged){
					//aHtml += " callback=dy_refresh('" + formId + "')";
				}
				aHtml += " id='" + formId + "'";
				aHtml += " rel='content_" + formId + "'";
				aHtml += " title='" + name + "'>";
				aHtml += name + "</a>";
				liHtml += aHtml;
				liHtml += "</div></td>";
				titleUl += liHtml;
			});
			titleUl += "</tr></table>";
			titleDiv += titleUl;
			titleDiv += "</div>";
			

			// content
			$field.find("#tabcontainer > div").each(function(){
				var formId=$(this).attr("formId");
				var isHidden=$(this).attr("isHidden");
				isHidden = (isHidden == "true");
				jQuery(this).attr("id","content_" + formId + "").addClass("tabcontent");
				if(isHidden){
					jQuery(this).css("display","none");	
				}
			});
			jQuery(titleDiv).replaceAll($fieldTitle);
			//初始化
			ddtabmenu.definemenu(fieldId,tabId);
		});
	};
	
	$.fn.obpmTabCollapseField =function(){
		return this.each(function(){
			var $field = jQuery(this);
			$field.removeAttr("moduleType");
			
			//选项卡嵌套时递归重构
			$field.find("[moduleType='TabNormal']").filter(function(){
				return (jQuery(this).parents("[moduleType='TabNormal']").size() == 0);
			}).obpmTabNormalField();  		//页签选项卡
			//选项卡嵌套时递归重构
			$field.find("[moduleType='TabCollapse']").filter(function(){
				return (jQuery(this).parents("[moduleType='TabCollapse']").size() == 0);
			}).obpmTabCollapseField();  		//折叠选项卡
			
			var fieldId = $field.attr("fieldId");
			var tabIdList = $field.find("#tabIdList").text();
			//字符串转数组
			tabIdList = eval(tabIdList);
			$field.find("#tabIdList").remove();
			var html = "";
			$field.find("li").each(function(){
				jQuery(this).css("listStyle","none");
				//title
				$(this).find("#title").each(function(){
					var formId = $(this).attr("formId");
					var isHidden = $(this).attr("isHidden");
					var fieldId = $(this).attr("fieldId");
					var tabName = $(this).attr("tabName");
					var isOpen = $(this).attr("isOpen");
					isHidden = (isHidden == "true");
					isOpen = (isOpen == "true");
					//div
					var titleDivHtml = "";
					titleDivHtml += "<div id='li_" + formId + "'";
					if(isHidden){
						titleDivHtml += " style='display:none'";
						this.parentNode.style.display = "none";	//ie下面当有选项卡隐藏后，中间还是留有间隔，所以隐藏。
					}
					titleDivHtml += ">";
					
					//table
					var tableHtml = "";
					var imgId = "img_" + formId;
					tableHtml += "<table width='100%' height='22' align='center' cellPadding='0' cellSpacing='0' id='" + formId
						+ "' class='margin' onclick=toggleCollapse('" + fieldId + "',this.id)>";
					tableHtml += "<tr>";

					var imagePath = "../../share/component/tabField/collapse/images";
					tableHtml += "<td width='5' align='left'><img src='" + imagePath + "/left_l_bar.gif'/></td>";
					tableHtml += "<td width='30' align='center' background='" + imagePath + "/left_bar.gif'>";
					tableHtml += "<img id='" + imgId + "' src='" + imagePath + "/";
					if(isOpen)
						tableHtml += "left_open";
					else
						tableHtml += "left_dot";
					tableHtml += ".gif' /></td>";
					tableHtml += "<td class='white' background='" + imagePath + "/left_bar.gif'>" + tabName + "</td>";
					tableHtml += "<td width='5' align='right'><img src='" + imagePath + "/left_r_bar.gif'/></td>";
					tableHtml += "</tr>";
					tableHtml += "</table>";
					
					titleDivHtml += tableHtml;
					titleDivHtml += "</div>";
					html += titleDivHtml;
					jQuery(titleDivHtml).replaceAll(jQuery(this));
				});
				//content
				$(this).find("#content").each(function(){
					var formId=$(this).attr("formId");
					var isHidden=$(this).attr("isHidden");
					isHidden = (isHidden == "true");
					jQuery(this).attr("id","content_" + formId + "");
					if(isHidden){
						jQuery(this).css("display","none");	
					}
				});
			});
			//初始化
			defineCollapse(fieldId,tabIdList);
		});
	};
})(jQuery);