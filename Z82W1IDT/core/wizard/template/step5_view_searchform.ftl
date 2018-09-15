<TABLE cellSpacing=0 cellPadding=1 width="100%" border=0>
<TBODY>
<tr><td>
<#list v_searchForm as v>
${v.fieldname}: <INPUT id="${v.fieldid}" name="${v.fieldname}" refreshOnChanged="false" 
	valueScript="" calculateOnRefresh="false" 
	validateRule="" readonlyScript="" textType="text" 
	validateLibs=""  hiddenPrintScript="" hiddenScript="" 
	discript="" processDescription="[];[]" filtercondition="" editMode="01" mobile="true" authority="false" 
	
	<#switch v.fieldtype>
	<#case "00">
	<#case "04">
		 fieldtype="VALUE_TYPE_VARCHAR" popToChoose="false" 
		 selectDate="false" dialogView fieldkeyevent="Enterkey" 
		 className="cn.myapps.core.dynaform.form.ejb.InputField"  
		 datePattern numberPattern suggest mobile="true"
	<#break>
	<#case "01">
		 fieldtype="VALUE_TYPE_DATE" 
		 className="cn.myapps.core.dynaform.form.ejb.DateField"  
		 prev_Name="" datePattern="YMD" limit="false" 
		 isdatefield="true" mobile="true"
	<#break>
	<#default>
		fieldtype="VALUE_TYPE_VARCHAR" popToChoose="false" 
		 selectDate="false" dialogView fieldkeyevent="Enterkey" 
		 className="cn.myapps.core.dynaform.form.ejb.InputField"  
		 datePattern numberPattern suggest mobile="true"
	</#switch>
	/>
	</#list>
</td></tr>
</TBODY>
</TABLE>