<%@ page pageEncoding="UTF-8"%>
<o:MultiLanguage>
<%@include file="/common/tags.jsp"%>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="mh" />

<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script language=JavaScript>
	var instance = '<%= request.getParameter("application")%>';
	// 添加dialog view元素的options
	function addViewOptions(modId, defValues, optionsDef) {
		DWREngine.setAsync(false);
		ApplicationUtil.getViewByModule(modId,instance, function(map) {
			var elem = document.getElementById('dv');
			DWRUtil.removeAllOptions(elem.id);
			DWRUtil.addOptions(elem.id, map);
			addAllColOptions('');
			
			if (defValues) {
				DWRUtil.setValue(elem.id, defValues);
				addAllColOptions(defValues, optionsDef);
			}
		});
		DWREngine.setAsync(true);
	}
	// 添加optionsValue、optionsText元素的options 
	function addAllColOptions(viewId, optionsDef) {
		ViewUtil.getFilterColsByView(viewId, function(map) {
			var valueObj = document.getElementById("optionsValue");
			var textObj = document.getElementById("optionsText");
			if(optionsDef){
				addOptionsToSelect(valueObj, map, optionsDef["value"]);
				addOptionsToSelect(textObj, map, optionsDef["text"]);
			}else{
				addOptionsToSelect(valueObj, map);
				addOptionsToSelect(textObj, map);
			}
		});
	}

	function addOptionsToSelect(obj, map, defValues){
		DWRUtil.removeAllOptions(obj.id);
		DWRUtil.addOptions(obj.id, map);
		if (defValues) {// 设置默认选项
			DWRUtil.setValue(obj.id, defValues);
		}
	}
	
	//检查选项脚本设计模式内容是否完成正确
	function checkOptionMapping(){
		if(document.getElementsByName("optionsEditMode")[0].checked){
			var value = document.getElementById("optionsValue").value;
			var text = document.getElementById("optionsText").value;
			if(value == null || value == '' || text == null || text == ''){
				return true;
			}
		}
		return false;
	}
</script>
<tr>
	<td><s:radio name="optionsEditMode"
		list="#{'00':'{*[Design]*}','01':'{*[cn.myapps.core.dynaform.form.iscript]*}'}"
		onclick="optionsEditModeChange(this.value)" theme="simple" /></td>
</tr>

<tr id="optionsEditMode0">
	<td colspan="2">
		<table width="510px" border=1 cellpadding=1 cellspacing=1 align="center">
			<tr>
				<td class="commFont commLabel" style="white-space: nowrap;">{*[Module]*}:</td>
				<td>
					<s:select name="module" list="#mh.getModuleSel(#parameters.application)" 
					theme="simple" cssStyle="width:275" onchange="addViewOptions(this.value)"/>
				</td>
			</tr>
			
			<tr>
				<td class="commFont commLabel" style="white-space: nowrap;">{*[View]*}:</td>
				<td> 
					<s:select id="dv" name="dialogView" list="#{'':'{*[Select]*}'}" theme="simple" cssStyle="width:275" 
					onchange="addAllColOptions(this.value)"/>
				</td>
			</tr>
			
			<tr>
				<td class="commFont commLabel" style="white-space: nowrap;">
					{*[Mapping]*}:
				</td>
				<td>
				<table border="0" width="100%">
					<tbody id="mapping">
					<tr>
						<th width="15%"></th>
						<th>{*[cn.myapps.core.dynaform.form.webeditor.tip.realvalue]*}</th>
						<th width="10%"></th>
						<th>{*[cn.myapps.core.dynaform.form.webeditor.tip.textvalue]*}</th>
						<th width="15%"></th>
					</tr>
					<tr>
						<th width="15%"></th>
						<th><span style="color:red">{*[Tips]*}：{*[page.realvalue.choose.field.unique]*}</span></th>
						<th width="10%"></th>
						<th></th>
						<th width="15%"></th>
					</tr>
					<tr>
						<th width="15%"></th>
						<th><s:select id="optionsValue" name="optionsValue" list="#{'':'{*[Select]*}'}" theme="simple" cssStyle="width:225" /></th>
						<th width="10%"></th>
						<th><s:select id="optionsText" name="optionsText" list="#{'':'{*[Select]*}'}" theme="simple" cssStyle="width:225" /></th>
						<th width="15%"></th>
					</tr>
					</tbody>
				</table>
				</td>
			</tr>
		</table>
	</td>
</tr>
<tr id="optionsEditMode1">
	<td>
		<textarea id="optionsScript" name="optionsScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_options_script]*}*/"  style="width: 96%" rows="10"></textarea>
		<button type="button" id="optionsScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
			<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
		</button>
	</td>
</tr>
</o:MultiLanguage>