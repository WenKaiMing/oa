<%@include file="/common/tags.jsp"%>
<o:MultiLanguage>
<tr style="display:none" >
<td id='TD<s:property value="#row.index" />'><table>
	<tr valign="top">
		<td class="commFont" align="right">{*[Hint]*}: </td>
		<td class="commFont" align="left">
		{*[Field]*}(<s:property value="oldFieldName" />) {*[has exsit]*}.<br/>
		{*[Please input other name and then click Yes]*}.
		</td>
	</tr>
	<tr>
		<td class="commFont" align="right">{*[Rename To]*}: </td>
		<td align="left">
			<s:textfield name="rename%{#row.index}" size="20"  theme="simple" />
		</td>
	</tr>
</table>
</td></tr>

<script type="text/javascript">
	var idx = '<s:property value="#row.index" />';
	var content = document.getElementById("TD" + idx).innerHTML;
	var func = function(){
		var index = '<s:property value="#row.index" />';
		var fieldID = '<s:property value="oldFieldId" />';
		
		return fldRename(index, fieldID);
	};
	document.getElementById("TD" + idx).innerHTML = "";
</script>
</o:MultiLanguage>
