<!-- 所有包含这个页面的页面，将会实现页面正在加载的提示信息，注意必须放在页面的最前面 author:kiral--> 
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/tags.jsp"%>
<o:MultiLanguage>
<%String ctx=request.getContextPath();%>
<link rel="stylesheet" type="text/css" href="<%=ctx%>/resource/css/style.css" />
<div id="loading">
	<div class="loading-indicator">
		Loading...
	</div>
</div>
<script type="text/javascript">
//判断页面是否加载完毕，如果加载完毕，就删除加载信息的DIV
function document.onreadystatechange()
{
	try
	{
		if (document.readyState == "complete") 
		{
	     	delNode("loading");
	    }
    }
    catch(e)
    {
    	alert("loading fail");
    }
}

//删除指定的DIV
function  delNode(nodeId)
{   
  try
  {   
	  var div =document.getElementById(nodeId);  
	  if(div !==null)
	  {
		  div.parentNode.removeChild(div);   
		  div=null;    
		  CollectGarbage(); 
	  }  
  }
  catch(e)
  {   
  	   alert("Delete ID:"+nodeId+"of node exception");
  }   
}
</script>
</o:MultiLanguage>
