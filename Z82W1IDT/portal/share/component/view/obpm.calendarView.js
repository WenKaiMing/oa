/**
 * 	后台预览的时候判断页面是否重构完成
 */
var isComplete = false; 

/**
 * 日历视图公用初始化方法
 */
function initCaleComm(){
	jqRefactor();	//表单控件jquery重构
	jqRefactor4ListView(); //日历视图重构
	ev_resize4IncludeViewPar();	//包含元素包含视图时调整iframe高度
	isComplete = true; //后台预览的时候判断页面是否重构完成
}
//给后台preview.jsp视图预览的时候判断页面是否重构完成
function getIsComplete(){
	return isComplete ;
}
/**
 * 
 * @param activityid
 * @return
 */
function createDoc(activityid) {
	// 查看/script/view.js
	if(openType == 277){
		var action = activityAction + "?_activityid=" + activityid;
		openWindowByType(action,selectStr, VIEW_TYPE_SUB,activityid);
	} else {
		var action = activityAction + "?_activityid=" + activityid;
		openWindowByType(action,selectStr, VIEW_TYPE_NORMAL,activityid);
	}
}

/**
 * 查看表单内容
 * @param docid
 * @param formid
 * @param signatureExist
 * @param templateForm
 * @return
 */
function viewDoc(docid, formid ,signatureExist,templateForm) {
	// 查看/script/view.js
	var url = docviewAction;
	url += '?_docid=' + docid;
	if (formid) {
		url += '&_formid=' +  formid;
	}
	if (templateForm) {
		url += '&_templateForm=' +  templateForm;
	}
	if(signatureExist){
		url += '&signatureExist=' +  signatureExist;
	}
		//url += '&application=' + top.application;
	openWindowByType(url,selectStr, VIEW_TYPE_NORMAL); 
}

/**
 * 日历视图点击更多
 * @param currDate
 */
function ShowDayView(currDate) {
	url = '../dynaform/view/displayView.action?_viewid='
		+ document.getElementById("displayView__viewid").value + '&currentDate='
		+ currDate + '&isinner=true';
	params = $('form[name="formList"]').serialize();
	
	OBPM.dialog.show({
		maximization : true,
		width : 800,
		height : 600,
		url : url,
		args : params,
		title : '日历视图更多',
		close : function(result) {
			location.reload();
		}
	});
}
/**
 * 包含元素包含视图时调整iframe高度
 * from:blue/brisk/default/dwz/fresh/gentle
 */
function ev_resize4IncludeViewPar(){
	var divid = document.getElementsByName("divid")[0].value;
	var _viewid = document.getElementsByName("_viewid")[0].value;
	ev_resize4IncludeView(divid,_viewid,'CALENDARVIEW');
}

/**
 * 重构日历视图
 */
(function($){
	$.fn.obpmCalendarView = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var calendarViewType = $field.attr("calendarViewType");
			
			var topTable = function(){
				var dayTitle = $field.attr("dayTitle");
				var dayAlt = $field.attr("dayAlt");
				var weekTitle = $field.attr("weekTitle");
				var weekAlt = $field.attr("weekAlt");
				var monthTitle = $field.attr("monthTitle");
				
				var html = "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='eventHead'>";
				html += "<td nowrap width=\"50%\" style='padding-top:3px;'>&nbsp;&nbsp;<a	href='javascript:showActions(\"DAYVIEW\")' class=\"link\" title=\""+ dayTitle +"\">"
								+ "<img src='"
								+ "../../share/icon/16x16_0180/calendar_view_day.png'	class='calen' width=\"16\" height=\"16\" border=\"0\" "
								+ " align=\"absmiddle\" alt=\""+ dayAlt +"\">"+ dayAlt +"</a>&nbsp;&nbsp;<a href='javascript:showActions(\"WEEKVIEW\")' class=\"link\" title=\""+ weekTitle +"\">"
								+ "<img src='"
								+ "../../share/icon/16x16_0180/calendar_view_week.png' class=\"nor-week\" width=\"16\" height=\"16\" border=\"0\""
								+ " align=\"absmiddle\" alt=\""+ weekAlt +"\">"+ weekAlt +"</a>&nbsp;&nbsp;<a href='javascript:showActions(\"MONTHVIEW\")' class=\"link\" title=\""+ monthTitle +"\">"
								+ "<img src='"
								+ "../../share/icon/16x16_0180/calendar_view_month.png' class=\"sel-month\" width=\"16\" height=\"16\" border=\"0\""
								+ " align=\"absmiddle\"  title=\""+ monthTitle +"\">"+ monthTitle +"</a></td>";
				html += "<td align=\"right\" nowrap></td>";
				html += "</tr>";
				html += "</table>";
				return html;
			};
			
			var tHead = function(){
				var $tHeadTable = $field.find("table[subTable='tHead']");
				var viewMode = $tHeadTable.attr("viewMode");
				var llab1 = $tHeadTable.attr("llab1");
				var lab1 = $tHeadTable.attr("lab1");
				var headString = $tHeadTable.attr("headString");
				var lab2 = $tHeadTable.attr("lab2");
				var llab2 = $tHeadTable.attr("llab2");
				var title1 = $tHeadTable.attr("title1");
				var alt1 = $tHeadTable.attr("alt1");
				var title2 = $tHeadTable.attr("title2");
				var alt2 = $tHeadTable.attr("alt2");
				var title3 = $tHeadTable.attr("title3");
				var alt3 = $tHeadTable.attr("alt3");
				var title4 = $tHeadTable.attr("title4");
				var alt4 = $tHeadTable.attr("alt4");
				
				
				var html = "<table width=\"220\" border=\"0\" cellspacing=\"0\" cellpadding=\"1\">";
				html += "<tr><td width=\"16\"><div align=\"center\"><a href=\"javascript:showAction('";
				html += viewMode + "','";
				html += llab1 + "')\"";
				html += "title=\""+ title1 +"\"><img src='";
				html += "../../share/icon/16x16_0060/arrow_left.png' class=\"backward\" width=\"16\" height=\"16\" ";
				html += "alt=\""+ alt1 +"\" width=\"16\" height=\"10\" border=\"0\" align=\"absmiddle\"></a></div></td><td width=\"16\">";
				html += "<div align=\"center\"><a href=\"javascript:showAction('";
				html += viewMode + "','";
				html += lab1 + "')\" title=\""+ title2 +"\"";
				html += ">";
				html += "<img src='";
				html += "../../share/icon/16x16_0760/resultset_previous.png' class=\"previous\" alt=\""+ alt2 +"\"";
				html += "width=\"16\" height=\"16\" border=\"0\"";
				html += " align=\"absmiddle\"></a></div></td><td class=\"eventTitle\"><div align=\"center\">";
				html += headString + "</div></td><td width=\"16\">";
				html += "<div align=\"center\"><a href=\"javascript:showAction('";
				html += viewMode + "','";
				html += lab2 + "')\" title=\""+ title3 +"\"";
				html += "><img src='";
				html += "../../share/icon/16x16_0760/resultset_next.png' class=\"next\" alt=\""+ alt3 +"\"";
				html += "width=\"16\" height=\"16\" border=\"0\" ";
				html += "align=\"absmiddle\"></a></div></td><td width=\"17\"><div align=\"center\"><a href=\"javascript:showAction('";
				html += viewMode + "','" + llab2 + "')\"" + " title=\""+ title4 +"\"><img src='";
				html += "../../share/icon/16x16_0060/arrow_right.png' class=\"fastfor\" alt=\""+ alt4 +"\"";
				html += " width=\"16\" height=\"16\" ";
				html += " border=\"0\" align=\"absmiddle\"></a></div></td></tr>";
				html += "</table>";
				return html;
			};
			
			if(calendarViewType == 'month'){
				var tMonthBody = function(){
					var $tMonthBodyTable = $field.find("[subTable='tMonthBody']");
					var Sunday = $tMonthBodyTable.attr("Sunday");
					var Monday = $tMonthBodyTable.attr("Monday");
					var Tuesday = $tMonthBodyTable.attr("Tuesday");
					var Wednesday = $tMonthBodyTable.attr("Wednesday");
					var Thursday = $tMonthBodyTable.attr("Thursday");
					var Friday = $tMonthBodyTable.attr("Friday");
					var Saturday = $tMonthBodyTable.attr("Saturday");
					
					html = "<table style='border:1px solid #e6e6e6;' width='100%' cellspacing='0' cellpadding='0' class=\"eventBg\">";
					html += "<tr class='weekDay'>";
					html += "<td align='center' width=\"14%\" nowrap class=\"eventDOW\">" + Sunday + "</td>";
					html += "<td align='center' width=\"14%\" nowrap class=\"eventDOW\">" + Monday + "</td>";
					html += "<td align='center' width=\"14%\" nowrap class=\"eventDOW\">" + Tuesday + "</td>";
					html += "<td align='center' width=\"14%\" nowrap class=\"eventDOW\">" + Wednesday + "</td>";
					html += "<td align='center' width=\"14%\" nowrap class=\"eventDOW\">" + Thursday + "</td>";
					html += "<td align='center' width=\"14%\" nowrap class=\"eventDOW\">" + Friday + "</td>";
					html += "<td align='center' width=\"14%\" nowrap class=\"eventDOW\">" + Saturday + "</td>";
					html += "</tr>";
					
					$field.find("[subTable='trBody']").each(function(){
						var $trBody = jQuery(this);
						html += "<tr height='100'>";
						$trBody.find("[subTable='tdBody']").each(function(){
							var $tdBody = jQuery(this);
							var day = $tdBody.attr("day");
							var maxIndex = $tdBody.attr("maxIndex");
							var viewType = $tdBody.attr("viewType");
							var viewAction = $tdBody.attr("viewAction");
							var monthIndex = $tdBody.attr("monthIndex");
							var yearIndex = $tdBody.attr("yearIndex");
							var isShowDayInfo = $tdBody.attr("isShowDayInfo");
							day = parseInt(day);
							maxIndex = parseInt(maxIndex);
							
							if (day > 0 && day <= maxIndex) {
								html += "<td style='border-left:1px solid #e6e6e6;border-top:1px solid #e6e6e6;' valign='top' onMouseOver=\"this.bgColor='#fefed8';\"";
								html += " onMouseOut=\"this.bgColor='transparent';\" id='cal" + day + "'>";
								html += "<table width='100%' border='0' cellspacing='0' cellpadding='0'>";
								html += "<tr style='height:16px;'>";
								html += "<td align='right'>";
								if(viewType == viewAction)
									html += day;
								else{
									html += "<a href=\"javascript:ShowDayView('" + yearIndex + "-" + monthIndex + "-"
												+ day + "')\" id='eventDateImg"+day+"'></a>";
									html += "<a href=\"javascript:ShowDayView('" + yearIndex + "-" + monthIndex + "-"
												+ day + "')\" class='eventDate'>" + day + "</a>";
								}
								html += "</td></tr><tr>";
								html += "<td valign='top' align='left'><div onclick='showTaskContent("+day+");' style='padding:2px;overflow:hidden;'>";
								if(isShowDayInfo){
									$tdBody.find("[moduleType='div1']").each(function(){
										var $div1Field = jQuery(this);
										var isReadonly = $div1Field.attr("isReadonly");
							    		var viewType = $div1Field.attr("viewType");
							    		var order = $div1Field.attr("order");
							    		var viewAction = $div1Field.attr("viewAction");
							    		var yearIndex = $div1Field.attr("yearIndex");
							    		var monthIndex = $div1Field.attr("monthIndex");
						    			var list = $div1Field.attr("list");
						    			var docGetid = $div1Field.attr("docGetid");
						    			var docGetFormid = $div1Field.attr("docGetFormid");
						    			var templateForm = $div1Field.attr("templateForm");
						    			var valuesMap = $div1Field.attr("valuesMap");
						    			var showTitle = $div1Field.attr("showTitle");
						    			viewType = parseInt(viewType);
							    		if(isReadonly == 'true'){
							    			html += "<div style='margin:1px;color:#4664a2;overflow:hidden;width:100%;height:100%;height: 19px;line-height: 19px;'>";
							    			html += "<a";
							    			if(showTitle == "true")
							    				html += " title='" + list + "'";
							    			html += ">"+ list +"</a></div>";
							    		}else{
							    			switch(viewType){
							    			case 1:{
							    				html += "<div style='margin:1px;color:#4664a2;overflow:hidden;width:100%;height: 19px;line-height: 19px;'>";
							    				html += "<a href=\"javascript:viewDoc('";
							    				html += docGetid + "','" + docGetFormid + "',"+ false + ",'" + templateForm + "')\" class='eventDate'";
							    				if(showTitle == "true")
							    					html += " title='" + list + "'";
							    				html += ">";
							    				html += list + "</a></div>";
							    			}
							    			break;
							    			case 2: {
							    				html += "<div style='margin:1px;color:#4664a2;overflow:hidden;width:100%;height: 19px;line-height: 19px;'>";
							    				html += "<a href=\"javascript:ev_selectone(" + valuesMap + ")\" class='eventDate'";
							    				if(showTitle == "true")
							    					html += " title='" + list + "'";
							    				html += ">" + list + "</a></div>";
							    			}
							    			break;
							    			default:
							    				;
							    			}
							    		}
							    		order++;
							    		if (order >= 4) {
							    			if (viewType != viewAction) {
							    				var $div2Field = $tdBody.find("[moduleType='div2']");
							    				var filterValue = $div2Field.attr("filterValue");
							    				html += "<div align='right'><a href=\"javascript:ShowDayView('";
							    				html += filterValue + "')\" class='eventDate'>More>></a></div>";
							    			}
							    		}
									});
								}
								html += "</div><div id='taskContent"+day+"' style='display:none'>";
								if(isShowDayInfo){
									var $divType = $tdBody.find("[moduleType='divType']");
									var Readonly = $divType.attr("Readonly");
									var yearIndex = $divType.attr("yearIndex");
									var monthIndex = $divType.attr("monthIndex");
									var day = $divType.attr("day");
									var list = $divType.attr("list");
									var getLoginno = $divType.attr("getLoginno");
									var viewType = $divType.attr("viewType");
									var getId = $divType.attr("getId");
									var getFormid = $divType.attr("getFormid");
									var templateForm = $divType.attr("templateForm");
									var valuesMap = $divType.attr("valuesMap");
									var showTitle = $divType.attr("showTitle");
									viewType = parseInt(viewType);
									if(Readonly == 'true'){
										html += "<div class='taskList'>";
										html += "<a href=\"javascript:ShowDayView('" + yearIndex + "-" + monthIndex + "-"	+ day + "')\"";
										if(showTitle == "true")
											html += " title='" + list + "'";
										html += ">";
										html += list;
										html += "</a><div style='color:#848484;font-size:11px;'>由";
										html += getLoginno + "</div></div>";
									}else{
										switch (viewType) {
										case 1: {
											html += "<div>";
											html += "<a href=\"javascript:viewDoc('";
											html += getId + "','" + getFormid + "'," + false + ",'" + templateForm + "')\" class='eventDate'";
											if(showTitle == "true")
												html += " title='" + list + "'";
											html += ">";
											html += list;
											html += "</a></div>";
										}
											break;
										case 2: {
											html += "<div>";
											html += "<a href=\"javascript:ev_selectone(" + valuesMap + ")\" class='eventDate'";
											if(showTitle == "true")
												html += " title='" + list + "'";
											html += ">";
											html += list;
											html += "</a></div>";
										}
											break;
										default:
											break;
										}
									}
								}
								html += "</div></td>";
								html += "</tr></table></td>";
							}else{
								html += "<td style='border-left:1px solid #e6e6e6;border-top:1px solid #ddd;' valign='top' class='eventTD'>&nbsp;</td>";
							}
						});
						html += "</tr>";
					});
					html += "</table>";
					return html;
				};
				
				var monthTableHtml = topTable();
				monthTableHtml += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
				monthTableHtml += "<tr>";
				monthTableHtml += "<td colSpan=\"7\" class=\"eventHead\">";
				monthTableHtml += tHead();
				monthTableHtml += "</td>";
				monthTableHtml += "</tr>";
				monthTableHtml += "<tr>";
				monthTableHtml += "<td colSpan=\"7\">";
				monthTableHtml += tMonthBody();
				monthTableHtml += "</td>";
				monthTableHtml += "</tr>";
				monthTableHtml += "</table>";
				
				var $monthTableHtml = jQuery(monthTableHtml);
				$monthTableHtml.replaceAll($field);
			}else if(calendarViewType == 'day'){
				var tDayBody = function(){
					var $tDayBodyTable = $field.find("[subTable='tDayBody']");
					var sTime = $tDayBodyTable.attr("sTime");
					var time = $tDayBodyTable.attr("time");
					var content = $tDayBodyTable.attr("content");
					var isShowInfo = $tDayBodyTable.attr("isShowInfo");
					var html = "<table border='1' cellpadding='1' cellspacing='0' bgcolor='#f8f8f8' frame='void' bordercolordark='#FFFFFF'"
								+ " bordercolorlight='#DDDDDD' style='border-top:1 #DDDDDD solid;border-left:1 #DDDDDD solid;' width=100%>";
					html += "<tr height=24>";
					html += "<td width='120' align='center' nowrap>"+ time +"</td>";
					html += "<td align='center' nowrap>"+ content +"</td>";
					html += "</tr></table>";
					html += "<table border='0' cellpadding='1' cellspacing='1' bgcolor='#EEEEEE' align='center' width='100%' style='line-height:15px'>";
					html += "<tr height=60>";
					html += "<td width='120' bgcolor='#FFFFEE' nowrap align='center'>00:00 -- 08:00</td>";
					html += "<td>";
					if(isShowInfo){
						var $tdFirld = $tDayBodyTable.find("[subTable='tdView1']");
						$tdFirld.find("[moduleType='div1']").each(function(){
							var $div1Field = jQuery(this);
							var isReadonly = $div1Field.attr("isReadonly");
							var list = $div1Field.attr("list");
							var viewType = $div1Field.attr("viewType");
							var getFormid = $div1Field.attr("getFormid");
							var templateForm = $div1Field.attr("templateForm");
							var getId = $div1Field.attr("getId");
							var valuesMap = $div1Field.attr("valuesMap");
							var order = $div1Field.attr("order");
							var showTitle = $div1Field.attr("showTitle");
							viewType = parseInt(viewType);
							if(isReadonly == 'true'){
								html += "<div ";
								if(showTitle == "true")
									html += "title='" + list + "'";
								html += ">"+ list +"</div>";
							}else{
								switch (viewType) {
								case 1:{
									html += "<a href=\"javascript:viewDoc('"
										+ getId + "','" + getFormid + "',"+ false + ",'"+ templateForm + "')\" class='eventDate'";
									if(showTitle == "true")
										html += " title='" + list + "'";
									html += ">" + list + "</a>";
								}
								break;
								case 2:{
									html += "<a href=\"javascript:ev_selectone(" + valuesMap
									+ ")\" class='eventDate'";
									if(showTitle == "true")
										html += " title='" + list + "'";
									html += ">" + list +"</a>";
								}
								break;
								}
							}
							order++ ;
							if(order >= 3){
								var $div2Field = $tdFirld.find("[moduleType='div2']");
								var filterValue1 = $div2Field.attr("filterValue1");
								html += "<div align='right'><a href=\"javascript:ShowDayView('" + filterValue1 + "')\" class='eventDate'>More>></a></div>";
							}
						});
					}
					html += "</td></tr>";
						
						$tDayBodyTable.find("[subTable='tdView2']").each(function(){
							var $tdFirld = jQuery(this);
							html += "<tr height=60>";
							html += "<td width='120' bgcolor='#FFFFEE' nowrap align='center'>" + (sTime++) + ":00 -- ";
							html += sTime + ":00</td>";
							html += "<td>";
							
							if(isShowInfo){
								$tdFirld.find("[moduleType='div1']").each(function(){
									var $div1Field = jQuery(this);
									var isReadonly = $div1Field.attr("isReadonly");
									var list = $div1Field.attr("list");
									var viewType = $div1Field.attr("viewType");
									var getFormid = $div1Field.attr("getFormid");
									var templateForm = $div1Field.attr("templateForm");
									var getId = $div1Field.attr("getId");
									var valuesMap = $div1Field.attr("valuesMap");
									var order = $div1Field.attr("order");
									var showTitle = $div1Field.attr("showTitle");
									viewType = parseInt(viewType);
									if(isReadonly == 'true'){
										html += "<div ";
										if(showTitle == "true")
											html += "title='" + list + "'";
										html += ">"+ list +"</div>";
									}else{
										switch (viewType) {
										case 1:{
											html += "<a href=\"javascript:viewDoc('"
												+ getId + "','" + getFormid + "',"+ false + ",'"+ templateForm + "')\" class='eventDate'";
											if(showTitle == "true")
												html += " title='" + list + "'";
											html += ">" + list + "</a>";
										}
										break;
										case 2:{
											html += "<a href=\"javascript:ev_selectone(" + valuesMap
											+ ")\" class='eventDate'";
											html += " title='" + list + "'>" + list +"</a>";
										}
										break;
										}
									}
									order++ ;
									if(order >= 3){
										var $div2Field = $tdFirld.find("[moduleType='div2']");
										var filterValue1 = $div2Field.attr("filterValue1");
										html += "<div align='right'><a href=\"javascript:ShowDayView('" + filterValue1 + "')\" class='eventDate'>More>></a></div>";
									}
								});
							}
							html += "</td></tr>";
						});
						
					html += "<tr height=60>";
					html += "<td width='120' bgcolor='#FFFFEE' nowrap align='center'>" + sTime + ":00 -- 00:00</td>";
					html += "<td bgcolor='#ffffff'>";
					if(isShowInfo){
						var $tdFirld = $tDayBodyTable.find("[subTable='tdView3']");
						$tdFirld.find("[moduleType='div1']").each(function(){
							var $div1Field = jQuery(this);
							var isReadonly = $div1Field.attr("isReadonly");
							var list = $div1Field.attr("list");
							var viewType = $div1Field.attr("viewType");
							var getFormid = $div1Field.attr("getFormid");
							var templateForm = $div1Field.attr("templateForm");
							var getId = $div1Field.attr("getId");
							var valuesMap = $div1Field.attr("valuesMap");
							var order = $div1Field.attr("order");
							var showTitle = $div1Field.attr("showTitle");
							viewType = parseInt(viewType);
							if(isReadonly == 'true'){
								html += "<div ";
								if(showTitle == "true")
									html += "title='" + list + "'";
								html += ">"+ list +"</div>";
							}else{
								switch (viewType) {
								case 1:{
									html += "<a href=\"javascript:viewDoc('"
										+ getId + "','" + getFormid + "',"+ false + ",'"+ templateForm + "')\" class='eventDate'";
									if(showTitle == "true")
										html += " title='" + list + "'";
									html += ">" + list + "</a>";
								}
								break;
								case 2:{
									html += "<a href=\"javascript:ev_selectone(" + valuesMap
									+ ")\" class='eventDate'";
									if(showTitle == "true")
										html += " title='" + list + "'";
									html += ">" + list +"</a>";
								}
								break;
								}
							}
							order++ ;
							if(order >= 3){
								var $div2Field = $tdFirld.find("[moduleType='div2']");
								var filterValue1 = $div2Field.attr("filterValue1");
								html += "<div align='right'><a href=\"javascript:ShowDayView('" + filterValue1 + "')\" class='eventDate'>More>></a></div>";
							}
						});
					}
					html += "</td></tr></table>";
					return html;
				};
				
				var dayTableHtml = topTable();
				dayTableHtml += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
				dayTableHtml += "<tr>";
				dayTableHtml += "<td class=\"eventHead\">";
				dayTableHtml += tHead();
				dayTableHtml += "</td>";
				dayTableHtml += "</tr>";
				dayTableHtml += "<tr>";
				dayTableHtml += "<td>";
				dayTableHtml += tDayBody();
				dayTableHtml += "</td>";
				dayTableHtml += "</tr>";
				dayTableHtml += "</table>";
				
				var $dayTableHtml = jQuery(dayTableHtml);
				$dayTableHtml.replaceAll($field);
			}else if(calendarViewType == 'week'){
				var tWeekBody = function(){
					var $tWeekBodyTable = $field.find("[subTable='tWeekBody']");
					var week = $tWeekBodyTable.attr("week");
					var content = $tWeekBodyTable.attr("content");
					var Sunday = $tWeekBodyTable.attr("sunday");
					var Monday = $tWeekBodyTable.attr("Monday");
					var Tuesday = $tWeekBodyTable.attr("Tuesday");
					var Wednesday = $tWeekBodyTable.attr("Wednesday");
					var Thursday = $tWeekBodyTable.attr("Thursday");
					var Friday = $tWeekBodyTable.attr("Friday");
					var Saturday = $tWeekBodyTable.attr("Saturday");
					
					var html = "<table border='1' cellpadding='1' cellspacing='0' bgcolor='#f8f8f8' frame='void' bordercolordark='#FFFFFF'";
				    html += " bordercolorlight='#DDDDDD' style='border-top:1 #DDDDDD solid;border-left:1 #DDDDDD solid;' width=100%>";
				    html += "<tr height=24>";
				    html += "<td width='120' align='center' nowrap>"+ week +"</td>";
				    html += "<td align='center' nowrap>"+ content +"</td>";
				    html += "</tr></table>";
				    html += "<table border='0' cellpadding='3' cellspacing='1' bgcolor='#f8f8f8' align='center' width='100%'>";
				    
					    for(var i = 0; i < 7; i++){
					    	html += "<tr height=80><td width='120' align='center' bgcolor='#FFFFEE' nowrap><font class='t9'>";
					    	switch (i) {
					    	case 0:
					    		var $tdField = $tWeekBodyTable.find("[dateUtil='Sd']");
					    		var timeFormat1 = $tdField.attr("timeFormat1");
					    		var isShowInfo = $tdField.attr("isShowInfo");
								html += Sunday + "<br/>" + timeFormat1;
								break;
							case 1:
								var $tdField = $tWeekBodyTable.find("[dateUtil='Md']");
								var timeFormat = $tdField.attr("timeFormat2");
								var isShowInfo = $tdField.attr("isShowInfo");
								html += Monday + "<br/>" + timeFormat;
								break;
							case 2:
								var $tdField = $tWeekBodyTable.find("[dateUtil='Td']");
								var timeFormat = $tdField.attr("timeFormat3");
								var isShowInfo = $tdField.attr("isShowInfo");
								html += Tuesday + "<br/>" + timeFormat;
								break;
							case 3:
								var $tdField = $tWeekBodyTable.find("[dateUtil='Wd']");
								var timeFormat = $tdField.attr("timeFormat4");
								var isShowInfo = $tdField.attr("isShowInfo");
								html += Wednesday +"<br/>" + timeFormat;
								break;
							case 4:
								var $tdField = $tWeekBodyTable.find("[dateUtil='T4d']");
								var timeFormat = $tdField.attr("timeFormat5");
								var isShowInfo = $tdField.attr("isShowInfo");
								html += Thursday + "<br/>" + timeFormat;
								break;
							case 5:
								var $tdField = $tWeekBodyTable.find("[dateUtil='Fd']");
								var timeFormat = $tdField.attr("timeFormat6");
								var isShowInfo = $tdField.attr("isShowInfo");
								html += Friday + "<br/>" + timeFormat;
								break;
							case 6:
								var $tdField = $tWeekBodyTable.find("[dateUtil='S6d']");
								var timeFormat = $tdField.attr("timeFormat7");
								var isShowInfo = $tdField.attr("isShowInfo");
								html += Saturday + "<br/>" + timeFormat;
								break;
					    	}
					    	html += "</font></td><td height='84'>";
					    	html += "<font size='2px'>";
					    	if(isShowInfo){
					    		$tdField.find("[moduleType='div1']").each(function(){
					    			var $div1Field = jQuery(this);
					    			var isReadonly = $div1Field.attr("isReadonly");
						    		var viewType = $div1Field.attr("viewType");
						    		var order = $div1Field.attr("order");
						    		var viewAction = $div1Field.attr("viewAction");
						    		var yearIndex = $div1Field.attr("yearIndex");
						    		var monthIndex = $div1Field.attr("monthIndex");
					    			var day = $div1Field.attr("day");
					    			var list = $div1Field.attr("list");
					    			var docGetid = $div1Field.attr("docGetid");
					    			var docGetFormid = $div1Field.attr("docGetFormid");
					    			var templateForm = $div1Field.attr("templateForm");
					    			var valuesMap = $div1Field.attr("valuesMap");
					    			var showTitle = $div1Field.attr("showTitle");
					    			viewType = parseInt(viewType);
						    		if(isReadonly == 'true'){
						    			html += "<div style='margin:1px;color:#4664a2;overflow:hidden;'>";
						    			html += "<a";
						    			if(showTitle == "true")
						    				html += " title='" + list + "'";
						    			html += ">"+ list +"</a></div>";
						    		}else{
						    			switch(viewType){
						    			case 1:{
						    				html += "<div style='margin:1px;color:#4664a2;overflow:hidden;'>";
						    				html += "<a href=\"javascript:viewDoc('";
						    				html += docGetid + "','" + docGetFormid + "',"+ false + ",'" + templateForm + "')\" class='eventDate'";
						    				if(showTitle == "true")
						    					html += " title='" + list + "'";
						    				html += ">";
						    				html += list + "</a></div>";
						    			}
						    			break;
						    			case 2: {
						    				html += "<div style='margin:1px;color:#4664a2;overflow:hidden;'>";
						    				html += "<a href=\"javascript:ev_selectone(" + valuesMap + ")\" class='eventDate'";
						    				if(showTitle == "true")
						    					html += " title='" + list + "'";
						    				html += ">" + list + "</a></div>";
						    			}
						    			break;
						    			default:
						    				;
						    			}
						    		}
						    		order++;
						    		if (order >= 4) {
						    			if (viewType != viewAction) {
						    				var $div2Field = $tWeekBodyTable.find("[moduleType='div2']");
						    				var filterValue = $div2Field.attr("filterValue");
						    				html += "<div align='right'><a href=\"javascript:ShowDayView('";
						    				html += filterValue + "')\" class='eventDate'>More>></a></div>";
						    			}
						    		}
					    		});
					    	}
					    	html += "</font></td></tr>";
					    }
					    html += "</table>";
					    return html;
				};
				
				var weekTableHtml = topTable();
				weekTableHtml += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
				weekTableHtml += "<tr>";
				weekTableHtml += "<td class=\"eventHead\">";
				weekTableHtml += tHead();
				weekTableHtml += "</td>";
				weekTableHtml += "</tr>";
				weekTableHtml += "<tr>";
				weekTableHtml += "<td>";
				weekTableHtml += tWeekBody();
				weekTableHtml += "</td>";
				weekTableHtml += "</tr>";
				weekTableHtml += "</table>";
				
				var $weekTableHtml = jQuery(weekTableHtml);
				$weekTableHtml.replaceAll($field);
			}
			
		});
	};
})(jQuery);

/**
 * jquery重构日历视图
 * for:日历视图
 */
function jqRefactor4ListView(){
	jQuery("[moduleType='calendarView']").obpmCalendarView();
}