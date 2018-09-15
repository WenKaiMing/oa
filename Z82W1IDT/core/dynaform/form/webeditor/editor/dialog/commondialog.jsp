<o:MultiLanguage>
<%@include file="/common/tags.jsp"%>
<script src="<s:url value='/script/util.js'/>"></script>
<tr>
	<td><s:radio name="editMode"
		list="#{'00':'{*[Design]*}','01':'{*[cn.myapps.core.dynaform.form.iscript]*}'}"
		onclick="modeChange(this.value)" theme="simple" /></td>
		<!-- 
	<td id="Formdislay">{*[Form]*}: <s:select
		 name="formlist" list="#fh.get_formList(#parameters.application)"
		 theme="simple"  /></td> -->
	<td>IsDefaultValue:<input type="checkbox" name="isDefaultValue" value="true"/></td>
</tr>

<tr id="editMode0">
	<td colspan="2">
	<table width="400px" cellpadding=0 cellspacing=0 align="center">
		<tr>
			<td align="center" valign="top">
			<table cellpadding=0 cellspacing=0 width="100%"  align="center">
				<tr>
					<td colspan="5" class="commFont"></td>
				</tr>
				<tr align="center">
					<td width="150" class="commFont">{*[Field]*}</td>
					<td></td>
					<td class="commFont">{*[cn.myapps.core.dynaform.form.label.show]*}</td>
					<td colspan="2"   class="commFont"></td>

				</tr>
				<tr align="center" valign="top">
					<td align="center" class="commFont"><select id="field" name="field" size="12"
						style="width:200" ondblclick="addData();" /></td>
					<td></td>
					<td align="left">
					<table cellpadding=0 cellspacing=0 >
						<tr>
							<td>
							<table border=0 cellpadding=0 cellspacing=0>
								<tr>
									<td>
									<input style="width:50px;height:25px;" type="button" value="+" onClick="changeRela('ADD');">
									</td>
								</tr>
								<tr>
									<td>
									<input style="width:50px;height:25px;" type="button" value="-" onClick="changeRela('MINUS');">
									</td>
								</tr>
								<tr>
									<td>
									<input style="width:50px;height:25px;" type="button" value="*" onClick="changeRela('MULTIPLIED');">
									</td>
								</tr>
								<tr>
									<td>
									<input style="width:50px;height:25px;" type="button" value="/" onClick="changeRela('DIVIDED');">
									</td>
								</tr>

								<tr>
									<td>
									<input style="width:50px;height:25px;" type="button" value="(" onClick="changeRela('LEFT');">
									</td>
								</tr>
								<tr>
									<td>
									<input style="width:50px;height:25px;"type="button" value=")" onClick="changeRela('RIGHT');">
									</td>
								</tr>
								<tr>
									<td>
									<input type="button"   style="width:50px;height:25px;" value="Clear" onClick="changeRela('CLEAR');">
									</td>
								</tr>
							</table>
							</td>
							<td></td>
							<td valign="top"><textarea name="processDescription"
								id="processDescription" style="width:150px;" rows="11"></textarea></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
			<td style="display:none;"><s:select id="viewfieldtype"
				name="viewfieldtype" list="{}" theme="simple" /></td>
		</tr>
	</table>
	</td>
</tr>
<tr id="editMode1">
	<td align="center" colspan="2"><textarea id="valueScript" name="valueScript" title="/*{*[cn.myapps.core.dynaform.activity.content.tips.button_value]*}*/" style="width:96%" rows="8"></textarea>
	<button type="button" id="valueScriptButton" style="border:0px;cursor: pointer;width:16px;padding:0px;" >
		<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
	</button>
	</td>
</tr>
<div style="display:none"><textarea id="filtercondition" name="filtercondition" cols="55" rows="3"></textarea></div>
<div style="display:none"><select id="selectid" name="fieldtoscript"
	style="width:100"></div>
</o:MultiLanguage>