function IsDigit(s,msg){
	//var patrn=/^[0-9]{1}$/; 
	var patrn = /^(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
	
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

function IsChar(s,msg){
	if (s && s != "") {
		var patrn=/^[1-9]{1}[0-9]*$/; 
		if (patrn.test(s)){
			return true;
		}
	}
	alert(msg);
	return false;
	} 

function createNotNullScript(fieldname){
	if(fieldname.length<=0){
	  alert("{*[page.name.notexist]*}")
	}
	var s = "";

	s+='var doc = $CURRDOC.getCurrDoc();\n';
	s+='var value = doc.getItemValueAsString("'+fieldname+'");\n';
	s+='var retvar = "";\n';
	s+='\n';
	s+='if(value==null || value.trim().length()<=0) {\n';
	s+='\n';
	s+='  retvar = "' + fieldname + '{*[page.content.notexist]*}";\n';
	s+='}\n';
	s+='\n';
	s+='retvar;\n';

	return s;
}

function modeChange(mode) { // Design?Code????
       
		for(var i=0;i<2;i++) {
			var content = document.all('editMode' + i);
			content.style.display = 'none';
		}
		//var formdisplay=document.all("Formdislay");
		switch (mode) {
		case '00':
			editMode0.style.display = '';
		    document.all("editMode")[0].checked = true;
		     //formdisplay.style.display="";
			break;
		case '01':
			 editMode1.style.display = '';
			 document.all("editMode")[1].checked = true;
			 //formdisplay.style.display="none";
			break;
		default:
			 editMode1.style.display = '';
			 document.all("editMode")[1].checked = true;
			 //formdisplay.style.display="none";
			break;
		}
		
		resize();
	}

function optionsEditModeChange(mode) { // Design?Code????
    
	for(var i=0;i<2;i++) {
		var content = document.all('optionsEditMode' + i);
		content.style.display = 'none';
	}

	switch (mode) {
	case '00':
		optionsEditMode0.style.display = '';
	    document.all("optionsEditMode")[0].checked = true;
		break;
	case '01':
		 optionsEditMode1.style.display = '';
		 document.all("optionsEditMode")[1].checked = true;
		break;
	default:
		 optionsEditMode1.style.display = '';
		 document.all("optionsEditMode")[1].checked = true;
		break;
	}
	
	resize();
}

	// ??element options
	function addOptions(elemName, options) {
		var elems = document.getElementsByName(elemName);
		for (var i=0; i<elems.length; i++) {
			var defVal = elems[i].value;
			DWRUtil.removeAllOptions(elems[i].id);
			DWRUtil.addOptions(elems[i].id, options);
			DWRUtil.setValue(elems[i].id, defVal);
		}
	}
	
	// orderby form????
	function initForm() {
		//var of = document.all('formlist');
		/*
		var of = document.getElementsByName("formlist")[0];
		of.onchange = function(defVal){
			FormHelper.getAllFields(of.value,'', function(options) {
				addOptions("field", options);
				  if (defVal) {
					DWRUtil.setValue("field", defVal);
				}
			});
		
		};
		of.onchange('<ww:property value="field" />');
		*/
		var of = document.getElementById("formid");
		if (of){
			FormHelper.getAllFields(of.value,'', function(options) {
				addOptions("field", options);
				  if (of.value) {
					DWRUtil.setValue("field", of.value);
				}
			});
			
		    var fields= document.all('field');
			
			    fields.onchange = function(defVal){
				FormHelper.getFieldType(of.value, fields.value,function(options) {
					addOptions("viewfieldtype", options);
				
					if (defVal) {
						DWRUtil.setValue("viewfieldtype", defVal);
						
					}
				});
			};
			fields.onchange('<ww:property value="viewfieldtype" />');
		}
 }
function RelStr(str){
	  var obj = eval(str);
	  if (obj instanceof Array) {
					return obj;
		} else {
		  return new Array();	
	   }
	}
		// ??mapping str??data array
	function parseRelStr(str) {
	    if(str!=""){
			var s = str.substring(0,str.indexOf(";"));
			 if(s.length>0){
			  var obj=RelStr(s);
			   var  fieldtoscript=document.all.fieldtoscript;
			  for(var j=0;j<obj.length;j++){
			     var Opt=document.createElement("option");
			     Opt.text=obj[j].text;
			     Opt.value=obj[j].value;
			      fieldtoscript.options.add(Opt);
			  }
			  
			 }
		    var filter = str.substring(str.indexOf(";")+1,str.length);
		    //alert("filter.length--->"+filter.length);
		    if(filter.length>0){
		     document.temp.processDescription.value=filter.substring(1,filter.length-1);
		    }
		    
	    }
  
	}
function addData(){
      
  	   
	        var fields=document.all.field;
	        var field;
	        for(var i=0;i<fields.length;i++){
	         if(fields.options[i].selected==true){
	             field=fields.options[i].value;
	     	     if(field!="" && field!=null && field!=undefined){
	     			    temp.processDescription.value+=field;
			        }
	          }
	       }  
     
   addItem();
  
  }

 function insertAtCursor(remarkValue){
   var processDiplay=document.getElementById("processDescription");
          if(document.selection){   
			 processDiplay.focus();   
			var sel  =  document.selection.createRange();   
             sel.text = remarkValue;  
					  
		}else if (processDiplay.selectionStart && processDiplay.selectionStart !== 0)  {   
		  var  startPos = processDiplay.selectionStart;   
	      processDiplay.value = processDiplay.value.substring(0,startPos)+remarkValue+processDiplay.value.substring(startPos, processDiplay.value.length);   
		 }else{
		    processDiplay.value+=remarkValue;
		 }
 }
 function changeRela(remark){
 var display=document.getElementById("processDescription");
   
   if(display.value==""){
      if(remark=="LEFT"){
	        insertAtCursor('(');
	   }
   }else{
     if(remark=="ADD"){
       
       insertAtCursor('+');
	  }else if(remark=="MINUS"){
        insertAtCursor('-');
      
    }else if(remark=="MULTIPLIED"){
        insertAtCursor('*');
     
    }else if(remark=="DIVIDED"){
       insertAtCursor('/');
     
    }else if(remark=="LEFT"){
        insertAtCursor('(');
      
    }else if(remark=="RIGHT"){
       insertAtCursor(')');
     
    }else if(remark=="CLEAR"){
       temp.processDescription.value="";
       
    }
   }
   
   
 }

 function createItems(){
    var iscreate=true;
  	var value=document.temp.processDescription.value;

    var str='';
	if(value!="" && value.length>0 ){
	
	  for(var i=0;i<value.length;){
	     if(value.charAt(i)=='(' || value.charAt(i)==')' || value.charAt(i)=='+' || value.charAt(i)=='-'|| value.charAt(i)=='*' || value.charAt(i)=='/'){
	        str+=";"+value.charAt(i)+";";
	          i++;
	     }else{
	       
	        str+=value.charAt(i);
	         i++;
	     }
	    
 	  }
 	iscreate=createScript(str);
 	
	}else {
	    document.temp.filtercondition.value='';
	}
	return iscreate;
}
 function createScript(value){
     var iscreatescript=true;
     var script='';
    if(value!="" && value.length>0){
         temp.filtercondition.value='';
         temp.filtercondition.value+='var doc= $CURRDOC.getCurrDoc();\n';
        var str=value.split(";");
       
          for(var j=0;j<str.length;j++){
             var s=str[j];
             if(s!=""){
               if(s=="("){
	               script+="(";
	             }else if(s==")"){
	               script+=")";
	             }else if(s=="+"){
	               script+="+";
	             }else if(s=="-"){
	               script+="-";
	             }else if(s=="*"){
	               script+="*";
	             }else if(s=="/"){
	               script+="/";
	             }else if(!isNaN(s)){
	                if(28+s.length<script.length){
	                   if(script.substring(script.length-3,script.length)==")!=" || script.substring(script.length-3,script.length)==")=="){
	                     var len=script.lastIndexOf("(");
	                   if(script.substring(len-20,len)=="getItemValueAsString"){
	                     script+='\''+s+'\'';
	                   }else{
	                     script+=s;
	                   }
	                 }
	                   else{
	                   script+=s;
	                  }
	                } else{
	                   script+=s;
	                  }
	             }else if(s.charAt(0)=='\''|| s.charAt(0)=='\"'){
	                     script+=s;
	              }else {
	                  var  fieldtoscript=document.all.fieldtoscript;
	                  if(fieldtoscript.length>0){
	                      for(var k=0;k<fieldtoscript.length;k++){
	                      if(fieldtoscript.options[k].text==s){
	                           if(fieldtoscript.options[k].value=="VALUE_TYPE_VARCHAR"){
	                              script+='(doc.getItemValueAsString(\''+s+'\'))';
	                          }else if(fieldtoscript.options[k].value=="VALUE_TYPE_NUMBER"){
	                              script+='(doc.getItemValueAsDouble(\''+s+'\'))';
	                           }else if(fieldtoscript.options[k].value=="VALUE_TYPE_DATE"){
	                              script+='(doc.getItemValueAsString(\''+s+'\'))';
	                          }else{
	                               script+='(doc.getItemValueAsString(\''+s+'\'))';
	                           }
	                      }
	                   } 
	                  }
	             }
            }
           }
          script+=';';
          temp.filtercondition.value+=script;
          iscreatescript=checkSatement(temp.filtercondition.value);
    }
    return iscreatescript;
 }
 function addItem(){ 
     var  fields= document.all.field;
     var  fieldType=document.all.viewfieldtype;
     var  fieldtoscript=document.all.fieldtoscript;
   for(var i=0;i<fields.length;i++)
	 {	 
         if(fields.options[i].selected==true ){
            var Opt=document.createElement("option");
            for(var j=0;j<fieldType.length;j++){
                if(fieldType.options[j].selected==true){
                  Opt.value=fieldType.options[j].value;
                }
            }
			Opt.text=fields.options[i].text;
			
			var k=0;
			for(var t=0;t<fieldtoscript.length;t++)
			{
			    if(fields.options[i].text==fieldtoscript.options[t].text)
				{
				   k=1;
				}

			}
				if(k==0)
			    {
			        fieldtoscript.options.add(Opt);
				    k=0;
			    }
		}	
     }
} 
function createRelStr() {
	 var  fieldtoscript=document.all.fieldtoscript;
		var str = '[';
		for (var i=0;i<fieldtoscript.length;i++) {
			if (fieldtoscript.options[i].value != '') {
				str += '{'
				str += '"text"' +':\''+fieldtoscript.options[i].text+'\',';
				str += '"value"' +':\''+fieldtoscript.options[i].value+'\'';
				str += '},';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
		str += ']';
		var processDescription=document.temp.processDescription.value ;
		str+=';['+processDescription+']';
		return  str;
}

function checkSatement(statement){
  var issucess=true;
  if(statement.length>0){
     var list=["+","-","*","/","("]
      for(var i=0;i<list.length;i++){
         if(list[i]==statement.substring(statement.length-2,statement.length-1)){
           alert("The condition expression is not correct!");
            temp.filtercondition.value="";
            issucess=false;
         }
      }
    
  }
  return issucess;
}