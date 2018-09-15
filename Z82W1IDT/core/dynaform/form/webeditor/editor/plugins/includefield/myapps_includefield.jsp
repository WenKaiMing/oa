<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv=content-type content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/dialog.css" type="text/css">
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>

<script language=JavaScript src="../include/utility.js"></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>

<script language=JavaScript src="dialog/dialog.js"></script>
<script language=JavaScript src="dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script src='<s:url value="/script/jquery.placeholder.1.3.js"/>'></script>
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />

<script language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded();
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument;
var oActiveEl = dialog.Selection.GetSelectedElement();

function getCreateNamedElement() {
	var className = "cn.myapps.core.dynaform.form.ejb.IncludeField";

	var id = oActiveEl ? oActiveEl.getAttribute('id'): getFieldId();
	//alert(createRelStr());
	// HTMLEncode引用至util.js
	var str = temp.hiddenScript.value;
	return CreateNamedElement(
		oEditor, oActiveEl, 'img', {
		src:"plugins/includefield/includefield.gif",
		classname: className,
		id: id,
		includeType: temp.includeType.value,
		refreshOnChanged: HTMLEncode(temp.refreshOnChanged.checked+""),
		calculateOnRefresh:HTMLEncode(temp.calculateOnRefresh.checked+""),
		enabled: HTMLEncode(temp.enabled.checked+""),
		valueScript: HTMLEncode(temp.valueScript.value),
		hiddenScript:HTMLEncode(temp.hiddenScript.value),
		hiddenValue:HTMLEncode(temp.hiddenValue.value),
		hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript == null?"":temp.hiddenPrintScript.value),
		printHiddenValue:HTMLEncode(temp.printHiddenValue == null?"":temp.printHiddenValue.value),
		module: HTMLEncode(temp.module.value),
		viewid: HTMLEncode(temp.viewid.value),
		pageid: HTMLEncode(temp.pageid.value),
		name: HTMLEncode(temp.name.value),
		relate: HTMLEncode(temp.relate.checked+""),
		fixation: HTMLEncode(temp.fixation.checked+""),
		fixationHeight: HTMLEncode(temp.fixationHeight.value+"px")
	});
}

//选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<4;i++){
		obj=document.all("card"+i);
		obj.style.backgroundColor="#3A6EA5";
		obj.style.color="#FFFFFF";
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";
	
	for (var i=1;i<4;i++){
		obj=document.all("content"+i);
		obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}


// {*[Click exit]*}
function Ok(){	
	jQuery.Placeholder.cleanBeforeSubmit(); //清除表单控件的Placeholder提示
	if(ev_check()){
		if( document.getElementsByName("includeType")[0].value=="0"){
			
			if(temp.module.value=="none"){
				alert("{*[page.includefield.module]*}");
			    return false;
			}
			if(temp.viewid.value=="none"){
				alert("{*[page.includefield.view]*}");
			    return false;
				}
		}
		oEditor.FCKUndo.SaveUndoStep() ;
		//检查内容是否完成正确
		oActiveEl = getCreateNamedElement();
		return true;
	}
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	return false;
}

// {*[Initial value]*}
function InitDocument(){
	// {*[Get value when modifying status]*}
	if (oActiveEl){

		if(oActiveEl.getAttribute('viewid') && oActiveEl.getAttribute('viewid') != 'none' && oActiveEl.getAttribute('viewid').length>0){
			DWREngine.setAsync(false);
			ApplicationUtil.getModuleByViewId(oActiveEl.getAttribute('viewid'),function(str) {oActiveEl.setAttribute('module',str);});
			DWREngine.setAsync(true);
		}
		var tmp = oActiveEl.getAttribute('valueScript');
		var tval = oActiveEl.getAttribute('includeType');
		temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";
		temp.calculateOnRefresh.checked = oActiveEl.getAttribute('calculateOnRefresh') == "true";
		temp.enabled.checked = oActiveEl.getAttribute('enabled') == "true";
		temp.relate.checked = oActiveEl.getAttribute('relate') == "true";
		
		if(tmp!=null){
			temp.valueScript.value = HTMLDencode(tmp);
		}
		
		temp.includeType.value = tval;
		
		if(oActiveEl.getAttribute('hiddenScript')!=null){
			temp.hiddenScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenScript'));
		}

		if(oActiveEl.getAttribute('hiddenValue')!=null){
			temp.hiddenValue.value = HTMLDencode(oActiveEl.getAttribute('hiddenValue'));
		}
		if(oActiveEl.getAttribute('hiddenPrintScript')!=null){
			temp.hiddenPrintScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenPrintScript'));
		}

		if(oActiveEl.getAttribute('printHiddenValue')!=null){
			temp.printHiddenValue.value = HTMLDencode(oActiveEl.getAttribute('printHiddenValue'));
		}
		
		ev_setVal(temp.module, oActiveEl.getAttribute('module'));
		ev_setVal(temp.viewid, oActiveEl.getAttribute('viewid'));
	    ev_setVal(temp.pageid,oActiveEl.getAttribute('pageid'));
		temp.name.value = oActiveEl.getAttribute('name');
		temp.fixation.checked = oActiveEl.getAttribute('fixation') == "true";
		//处理固定高度值，去掉px
		var fixationHeight = oActiveEl.getAttribute('fixationHeight');
		if(fixationHeight && fixationHeight.length>2){
			fixationHeight = fixationHeight.substring(0,fixationHeight.length-2);
		}
		temp.fixationHeight.value = fixationHeight;
		if(temp.fixation.checked){
			jQuery("span[name=fixationHSpan]").css("display","");
		}
	}
	
	ev_init();
	
	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	SelectField( 'name' ) ;
	window.top.toThisHelpPage("application_module_form_info_advance_include");
	jQuery.Placeholder.init(); //表单控件显示的Placeholder提示
	cleanPromptVal();

	//固定高度点击切换
	jQuery("input[name=fixation]").bind("click",function(event){
		if(jQuery(this).attr("checked")){
			jQuery("span[name=fixationHSpan]").css("display","");
		}else {
			jQuery("span[name=fixationHSpan]").css("display","none");
		}
	});
}
 
function cleanPromptVal(){
	jQuery("#hiddenScriptButton").click(function(){
		if(jQuery("#hiddenScript").val() == jQuery("#hiddenScript").attr("title"))
			jQuery("#hiddenScript").val("");
		openIscriptEditor('hiddenScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	jQuery("#hiddenPrintScriptButton").click(function(){
		if(jQuery("#hiddenPrintScript").val() == jQuery("#hiddenPrintScript").attr("title"))
			jQuery("#hiddenPrintScript").val("");
		openIscriptEditor('hiddenPrintScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Print_Script]*}','name','{*[Save]*}{*[Success]*}');
	});
	
}


function ev_setVal(el, val) {
	if (el) {
		var opt = document.createElement("OPTION");
		opt.value = val;
		opt.selected = true;
		el.add(opt);
	}
}

function ev_onchange(val) {
	val='"'+val+'"';
	temp.valueScript.value=val;
	
}

function ev_select(module,view,page) {
	var _includeType = document.getElementsByName("includeType")[0].value;
	var av = '<s:property value="#parameters.application" />';
	var mv = document.getElementsByName(module)[0].value;
	var vv = document.getElementsByName(view)[0].value;
	var pv = document.getElementsByName(page)[0].value;
	if (document.getElementsByName(module)[0].value=='none') {
		vv = 'none';
		pv = document.getElementsByName(page)[0].value;
	
	}
	
	var func = new Function("ev_select('"+module+"','"+view+"','"+page+"')");
	document.getElementsByName(module)[0].onchange = func;
	
	ApplicationUtil.creatModule(module,av,mv,function(str) {var func=eval(str);func.call();});
	ApplicationUtil.createView4IncludeField(view,av,mv,vv,function(str) {var func=eval(str);func.call();});
	ApplicationUtil.creatPage4Included(page,av,pv,function(str) {var func=eval(str);func.call();});
}

function ev_init() {
	var type = document.getElementsByName("includeType")[0];
	var func = new Function("ev_showElems(this.value);document.getElementsByName('valueScript')[0].value='';");
	type.onchange = func;
	ev_showElems(type.value);
}

function ev_showElems(type) {
	if (document.getElementsByName("module")[0].options[0]) {
		document.getElementsByName("module")[0].options[0].selected = true;
	}
	
	ev_select('module','viewid','pageid');
	if (type != null && type != '') {
		type == '0' ? viwtr.style.display = '' : viwtr.style.display = 'none';
		type == '0' ? moduletr.style.display = '' : moduletr.style.display = 'none';
		type == '1' ? pagtr.style.display = '' : pagtr.style.display = 'none';
	}
}
function ev_check(){
	if(temp.name.value==''){
	 	alert("{*[page.name.notexist]*}");
		return false;
	}else{
	   //非法字符校验 
		var name = temp.name.value;
		var  p =new Array ( "﹉", "＃", "＠", "＆", "＊", "※", "§", "〃", "№", "〓", "○",
		"●", "△", "▲", "◎", "☆", "★", "◇", "◆", "■", "□", "▼", "▽",
		"㊣", "℅", "ˉ", "￣", "＿", "﹍", "﹊", "﹎", "﹋", "﹌", "﹟", "﹠",
		"﹡", "♀", "♂", "?", "⊙", "↑", "↓", "←", "→", "↖", "↗", "↙",
		"↘", "┄", "—", "︴", "﹏", "（", "）", "︵", "︶", "｛", "｝", "︷",
		"︸", "〔", "〕", "︹", "︺", "【", "】", "︻", "︼", "《", "》", "︽",
		"︾", "〈", "〉", "︿", "﹀", "「", "」", "﹁", "﹂", "『", "』", "﹃",
		"﹄", "﹙", "﹚", "﹛", "﹜", "﹝", "﹞", "\"", "〝", "〞", "ˋ",
		"ˊ", "≈", "≡", "≠", "＝", "≤", "≥", "＜", "＞", "≮", "≯", "∷",
		"±", "＋", "－", "×", "÷", "／", "∫", "∮", "∝", "∧", "∨", "∞",
		"∑", "∏", "∪", "∩", "∈", "∵", "∴", "⊥", "∥", "∠", "⌒", "⊙",
		"≌", "∽", "√", "≦", "≧", "≒", "≡", "﹢", "﹣", "﹤", "﹥", "﹦",
		"～", "∟", "⊿", "∥", "㏒", "㏑", "∣", "｜", "︱", "︳", "|", "／",
		"＼", "∕", "﹨", "¥", "€", "￥", "£", "®", "™", "©", "，", "、",
		"。", "．", "；", "：", "？", "！", "︰", "…", "‥", "′", "‵", "々",
		"～", "‖", "ˇ", "ˉ", "﹐", "﹑", "﹒", "·", "﹔", "﹕", "﹖", "﹗",
		"-", "&", "*", "#", "`", "~", "+", "=", "(", ")", "^", "%",
		"$", "@", ";", ",", ":", "'", "\\", "/", ".", ">", "<",
		"?", "!", "[", "]", "{", "}" );
		for (var j = 0; j < p.length; j++) {
			if (name.indexOf(p[j]) != -1) {
				alert("{*[Name]*}{*[can.not.exist.invalidchar]*}");
				return false;
			}
		}
	}
	if(temp.fixation.checked && temp.fixationHeight.value == ""){
		alert("固定高度值不能为空!");
		return false;
	}
  	return !checkStartChar(temp.name.value);
}

function checkStartChar(value){
	return IsDigit(value,"{*[page.name.check]*}");
}
function IsDigit(s,msg){
    var patrn = /^(?![0-9])[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
                 
	if(s=="action"){
		if (!patrn.exec(s)) alert(msg);
	   	alert("action为关键字，不能作为字段名！");
	   	return true;
   	}else if (!patrn.exec(s)){
		alert(msg);
		return true;
	}
	return false;
}

/**
 *  当输入的内容不是数字0-9和"-,."的时候，不能输入;
 */
function isNumeric(event) {
	var keyCode = event.keyCode?event.keyCode:event.which;
	//当键盘输入的是0-9或",.-",回退键tab键的时候，允许输入
	if((keyCode >= 48 && keyCode <= 57) || (keyCode >= 44 && keyCode <= 46) || keyCode == 8 || keyCode == 9 || keyCode == 118){
		event.returnValue = true;
	}else {
		//!+"\v1"判断是不是ie浏览器
		if(!+"\v1"){
			event.returnValue = false;
		}else{
			event.preventDefault();
		}
	}
}

</script>
</head>
<body bgcolor="menu"  onload="InitDocument()">
<s:form name="temp" method="post" theme="simple">
<table border=0 cellpadding=3 cellspacing=0 width="520px">
			<tr align=center>
				<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(2)" id="card2">{*[Hidden_Script]*}</td>
				<td width=2></td>
				<td class="card" onclick="cardClick(3)" id="card3">{*[Hidden_Print_Script]*}</td>
				<td width=2></td>
			</tr>
			<tr>
				<td valign=middle colspan=12 bgcolor=#ffffff align=center
					width="100%">
				<table border=1 cellpadding=3 cellspacing=1  class="content" id="content1" bgcolor=#ffffff width="520px" height="250px">

					<tr>
						<td class="commFont commLabel">{*[Name]*}:</td>
						<td><s:textfield name="name" id="name" cssStyle="width:200"/></td>
					</tr>
					
					<tr>
						<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.webeditor.label.includeType]*}:</td>
						<td><s:select cssClass="input-cmd" name="includeType" list="#{'0':'{*[View]*}'}" cssStyle="width:90px;float:left;"/>
						<div id="HomePageTips" style="display:none;float:right;">
							<p style="font-family:verdana;font-size:11px;color:red">
								HomePage类型只能选择首页定义类型为自定义的
							</p>
						</div>
						</td>
					</tr>
					
					<tr id="moduletr">
						<td class="commFont commLabel">{*[Module]*}:</td>
						<td><s:select  cssClass="input-cmd" name="module" list="{}" cssStyle="width:200"/></td>
					</tr>
								
					<tr id="viwtr">
						<td class="commFont commLabel">{*[View]*}:</td>
						<td><s:select  cssClass="input-cmd" name="viewid" list="{}" cssStyle="width:200" onchange="ev_onchange(this.value)"/></td>
					</tr>
					
					<tr id="pagtr">
						<td class="commFont commLabel">{*[HomePage]*}:</td>
						<td><s:select  cssClass="input-cmd" name="pageid" list="{}" cssStyle="width:200" onchange="ev_onchange(this.value)"/></td>
					</tr>
					
					<tr>
						<td colspan="2" align="left" style="padding-left: 140px;">
							<input type=checkbox name="relate" value="true" checked="checked">{*[cn.myapps.core.dynaform.form.webeditor.label.isRelate]*}<br/>
							<input type=checkbox name="refreshOnChanged" value="true">{*[cn.myapps.core.dynaform.activity.reflash]*}<br/>
							<input type=checkbox name="calculateOnRefresh" value="true">{*[cn.myapps.core.dynaform.activity.recalculate]*}<br/>
							<div style="display:none">
							<input type=checkbox name="enabled" value="true">{*[ShowView]*}&nbsp;
							</div>
							<input type=checkbox name="fixation" value="true" />{*[固定高度]*}
							<span name="fixationHSpan" style="display:none;">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<s:textfield name="fixationHeight" id="fixationHeight" cssStyle="width:50px" onkeypress="isNumeric(event)"/>&nbsp;px
							</span>
						</td>
					</tr>
					
					<tr style="display:none">
						<td colspan=2  align="center">
						  <textarea name="valueScript"  readonly="readonly" cols="50" rows="10" style="width:96%"></textarea>
						  <button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('valueScript','{*[Script]*}{*[Editor]*}','{*[Value_Script]*}','name','{*[Save]*}{*[Success]*}');">
						  	<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
						  </button>
						</td>
					</tr>
				</table>
				<table border=1 cellpadding=3 cellspacing=1 class="content"
					id="content2">
					<tr>
						<td>
							<textarea id="hiddenScript" name="hiddenScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/" style="width:96%" rows="10"></textarea>
							<button type="button" id="hiddenScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
							</button>
						</td>
					</tr>
					<tr>
						<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
					</tr>
				</table>
				<table border=1 cellpadding=3 cellspacing=1 class="content"
					id="content3">
					<tr>
						<td><textarea id="hiddenPrintScript" name="hiddenPrintScript"
							title="/*{*[cn.myapps.core.dynaform.activity.content.tips.return_boolean_value]*}（true/false）*/"
							style="width: 96%" rows="10"></textarea>
						<button type="button" id="hiddenPrintScriptButton"
							style="border: 0px; cursor: pointer; width: 16px; padding: 0px;">
						<img alt="{*[page.Open_with_IscriptEditor]*}"
							src="<s:url value='/resource/image/editor.png' />" /></button>
					</td>
				</tr>
				<tr>
					<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input
						type="text" name="printHiddenValue" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
</s:form>
<script language=javascript>
cardClick(1);
</script>
</BODY>
</o:MultiLanguage>
</HTML>
