function resources(id,type){
	var applicationid=document.getElementsByName("content.applicationid")[0].value;
	var url = contextPath + '/core/privilege/res/jquerytree.jsp?id='
	+ id+'&type='+type+'&applicationid='+applicationid;
	var oField = document.getElementsByName("content.name")[0];
	wy = '200px';
	wx = '200px';
	var value= uploadshowframe('select resources', url);
	if(value == null || value == 'undefined' || value == ''){
		
	}else{
		if(value=='clear'){
			oField.value='';
		}else{
			oField.value=value;
		}
	}
}