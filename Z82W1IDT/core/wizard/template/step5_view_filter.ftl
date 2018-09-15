
var w = ""; 
var doc= $CURRDOC.getCurrDoc();
<#list fields as field>
	<#if field.fieldtype == "VALE_TYPE_NUMBER">
		if (doc.getItemValueAsDouble(${field.fieldname})) > 0
	<#else>
		if (doc.getItemValueAsString("${field.fieldname}")!=null && doc.getItemValueAsString("${field.fieldname}").trim().length() > 0)
	</#if>
 w +=  " and ${field.fieldname} like '" + doc.getItemValueAsString("${field.fieldname}").trim() + "%'"; 
</#list>
<#if filterpendding == true>
	var u = $WEB.getWebUser(); 
	var userid = "'"+ u.getId() + "'" ;
	var rolelist = u.getRolelist() != ""? u.getRolelist(): "";
	w +=" and ($state.actors.actorid in (" + userid + "," +  rolelist + "))" ;
	w+=" and ($state.noderts.statelabel in ('Draft','Running'))";
</#if>
"$formname = '${formname}'"+w ;