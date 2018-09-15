<TABLE borderColor=#C0C0C0 cellSpacing=1 cellPadding=1 width="100%" border=1 height="">
<TBODY>
<TR><TD>
	<#list f_templatecontext as f>
${f.fieldname}:
		<#switch f.fieldtype>
			<#case "00"><input texttype="text" className="cn.myapps.core.dynaform.form.ejb.InputField" fieldType="VALUE_TYPE_VARCHAR" validateLibs="" filtercondition="" dialogView="" selectDate="false" textType="text" readonlyScript="" hiddenPrintScript="" hiddenScript="" validateRule="" valueScript="" discript="" 
			<#break>
			<#case "01"><input type="text" className="cn.myapps.core.dynaform.form.ejb.DateField" fieldType="VALUE_TYPE_DATE" datePattern="YMD"}" isdatefield="true" filtercondition="" discript="" hiddenScript="" hiddenPrintScript="" validateLibs="" textType="text" readonlyScript="" validateRule="" valueScript="" 
			<#break>
			<#case "02"><select className="cn.myapps.core.dynaform.form.ejb.SelectField" fieldType="VALUE_TYPE_VARCHAR" validateLibs="" filtercondition="" textType="text" readonlyScript="" hiddenPrintScript="" hiddenScript="" validateRule="" valueScript="" discript="" type="text" 
			<#break>
			<#case "03"><input type="radio" className="cn.myapps.core.dynaform.form.ejb.RadioField" fieldType="VALUE_TYPE_VARCHAR" validateLibs="" filtercondition="" textType="text" readonlyScript="" hiddenPrintScript="" hiddenScript="" validateRule="" valueScript="" discript=""
			<#break>
			<#case "04"><textarea className="cn.myapps.core.dynaform.form.ejb.TextareaField" fieldType="VALUE_TYPE_TEXT" validateLibs="" filtercondition="" hiddenPrintScript="" hiddenScript="" validateRule="" valueScript="" discript="" readonlyScript=""
			<#break>
			<#case "05"><input type="checkbox" className="cn.myapps.core.dynaform.form.ejb.CheckboxField" fieldType="VALUE_TYPE_VARCHAR" validateLibs="" filtercondition textType="text" hiddenPrintScript="" hiddenScript="" validateRule="" valueScript="" discript="" readonlyScript=""
			<#break>
			<#case "06"><input texttype="text" className="cn.myapps.core.dynaform.form.ejb.InputField" fieldType="VALUE_TYPE_NUMBER" validateLibs="" filtercondition="" dialogView="" selectDate="false" textType="text" readonlyScript="" hiddenPrintScript="" hiddenScript="" validateRule="" valueScript="" discript="" 
			<#break>
			<#default>
		</#switch> 
	 id="${f.fieldid}" name="${f.fieldname}" editMode="01" authority="false" processDescription="[];[]" calculateOnRefresh="false" refreshOnChanged="false" fieldkeyevent="Tabkey" mobile="true"
			<#if f.fieldoption != "">
				optionsScript="@quot;${f.fieldoption}@quot;"
			<#else>
				optionsScript=""
			</#if>
			
			<#if f.fieldformat != "">
				numberPattern="${f.fieldformat}"
			</#if>
			
			<#if f.fieldtype == "03" || f.fieldtype == "05">
				layout="horizontal"
			</#if>
			<#if f.fieldtype == "02">
				></select>
			<#elseif f.fieldtype == "04">
				></textarea>
			<#else>
				/>
			</#if>
			<#if f_style == '0'>
				<#if f_has_next>
					</TD></TR><TR><TD>
				</#if>
			</#if>
			<#if f_style == '1'>
				<#if f_has_next>
					</TD><TD>
				</#if>
			</#if>
			<#if f_style == '2' && f_index % 2 != 0>
				<#if f_has_next>
					</TD></TR><TR><TD>
				</#if>
			</#if>
			<#if f_style == '2' && f_index % 2 == 0>
				<#if f_has_next>
					</TD><TD>
				</#if>
			</#if>
	</#list>
</TD></TR>
</TBODY>
</TABLE>