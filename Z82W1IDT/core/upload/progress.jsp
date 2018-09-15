<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%    
    String path = request.getContextPath();    
 %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
	var xmlHttp;
	var xmlHttp2;
	function createXMLHttp(){
		if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		} else {
			xmlHttp = new XMLHttpRequest();
		}
	}

	function createXMLHttp2(){
		if (window.ActiveXObject) {
			xmlHttp2 = new ActiveXObject("Microsoft.XMLHTTP");
		} else {
			xmlHttp2 = new XMLHttpRequest();
		}
	}

	function ajaxSend(){    
	    createXMLHttp();    
	    var url ="<%=path%>/core/upload/getPercs.action?random=" + Math.random();
	    //alert(url);
	   xmlHttp.open("GET",url,true) ;
	    xmlHttp.onreadystatechange = handler ;    
	        
	    //xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");    
	    xmlHttp.send(null) ;    
	}    
	
	function handler(){    
	　if(xmlHttp.readyState == 4){    
	　　if(xmlHttp.status == 200){  
		
	        var percent = xmlHttp.responseText;
	        var t = setTimeout("ajaxSend()",200); 
	       
	        if(percent==0){
	        	 clearTimeout(t);
		        }else{
			        
	        var html = "<table align='left'><tr><td>进度：</td><td><table align='left' width='"+percent+"' height='10px' bgcolor='green'><tr><td>"+percent+"</td></tr></table><td><tr></table>";    
	        document.getElementById('pre').innerHTML = html;  
		        }
	        
	        if(percent == 100){   
	        	
	            //alert('上传完成');
	            clearTimeout(t);
	          // clearPerc();
	          setTimeout("window.close()",200);	
	          setTimeout("closeParentDiv()",200);	 
	         
			  
	          
	        }    
	        
	      
	　　}    
	　}    
	　return true;    
	}
	
	// 清空进度
	function clearPerc(){
		
		createXMLHttp2();
		var url ="<%=path%>/core/upload/clearPerc.action";
		xmlHttp2.open("GET",url,true);
		
	    xmlHttp2.onreadystatechange = clear;
	      
	    xmlHttp2.send(null) ;
	}

	 function clear(){
		    //alert(xmlHttp2.readyState+"bbb");
	    	if(xmlHttp2.readyState == 4){
	    		if(xmlHttp2.status == 200){ 
	    		//alert("aaa3");
				window.close();
	    		}
			}    	
	    }
	   
	window.onload = function(){  
	    ajaxSend();
	}    
		
</script>
<title>progress</title>
</head>
<body>

<div id="pre" align="center">
</div>
</body>
</html>
