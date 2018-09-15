<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tags.jsp"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.ValueStoreField" %>
<html>
<o:MultiLanguage>
<head>
<title></title>
<script language="javascript">
  function cball() {
	  var all=document.getElementById("allcheck");
	  var fields = document.getElementsByName("afield");
	  if(all.checked){
		  for(var i=0;i<fields.length;i++){
			  fields[i].checked = true;
		  }
	  }else{
		  for(var i=0;i<fields.length;i++){
			  fields[i].checked = false;
		  }
	  }
  }

  function odd() {
	  var all=document.getElementById("allcheck");
	  var fields = document.getElementsByName("afield");
	  var numOfChecked = 0;
	  for(var i=0;i<fields.length;i++){
		  if(fields[i].checked)numOfChecked++;
	  }
	  if(numOfChecked==fields.length){
		  all.checked = true;
	  }else{
		  all.checked = false;
	  }
  }

  function checkSelect(){
	  var all = document.getElementById("allcheck");
	  var fields = document.getElementsByName("afield");
	  var numOfChecked = 0;
	  var str = "";
	  for(var i=0;i<fields.length;i++){
		  if(fields[i].checked){
			  str += fields[i].value + ", ";
			  numOfChecked++;
		  }
	  }
	  str = str.substring(0, str.lastIndexOf(","));
	  if(!all.checked && numOfChecked == 0){
		  alert("请至少选择一项!");
		  return false;
	  }else{
		  if(all.checked){
			  if(confirm("{*[confirm.clear.data]*}")){
				  return true;
			  }
		  }else{
			  if(confirm("确定清除 " + str + " 字段所有数据?")){
				  return true;
			  }
		  }

		  return false;
	  }
  }
</script>
</head>

<body  onload="" bgcolor="#FFFFFF" text="#000000">

  <s:actionmessage/>
  <s:actionerror/>
  <s:fielderror/>
  
  <s:form action="cleardata" method="post" onsubmit="return checkSelect()">
  <input type="hidden" name="content.id" value="<s:property value='content.id'/>"/>
  <table align="center">
    <tr>
      <td align="center">
      </td>
    </tr>
    <tr>
      <td>
        <table id="column" border=1>
          <tr>
            <td align="center" bgcolor="gray"  width="40">
              <input type="checkbox" onclick="cball()" id="allcheck"/>
            </td>
            <td align="center" bgcolor="gray"><b>所有</b></td>
          </tr>
          <s:iterator id="field" status="st" value="content.valueStoreFields">
          <tr>
            <td align="center">
              <input type="checkbox" name="afield" value="<s:property value="name"/>" onclick="odd()"/>
            </td>
            <td align="center">
              <s:property value="#field.name"/>
            </td>
          </tr>
          </s:iterator>
        </table>
      </td>
    </tr>
    <tr>
      <td align="center">
        <s:submit theme="simple" value="提交"/>&nbsp;&nbsp;<s:reset theme="simple" value="重置"/>
      </td>
    </tr>
  </table>
  </s:form>

</body>
</o:MultiLanguage>
</html>