<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Examples</title>
    <meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link href="css/ratchet.min.css" rel="stylesheet">
    <link href="css/global.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/checkBox.min.css" rel="stylesheet" >
    <script src="js/jquery.min.js"></script>
    <script src="js/ratchet.min.js"></script>
    <script type="text/javascript">
    $(function() {

        $(window).resize(function() {
            $("#card_space_topfix_height").css("height", $(".card_space_topfix").height());
            $("#card_space_fix_height").css("height", $(".card_space_fix").height() + 20);
        });
        $("#card_space_topfix_height").css("height", $(".card_space_topfix").height());
        $("#card_space_fix_height").css("height", $(".card_space_fix").height() + 20);
        
    })
    </script>
</head>

<body>
    <div class="card_space_topfix">
        <div class="segmented-control">
            <a class="control-item active" href="#item1mobile">
    部门
  </a>
            <a class="control-item" href="#item2mobile">
    常用联系人
  </a>
            <a class="control-item" href="#item3mobile">
    全部
  </a>
        </div>
        <div class="selectuser-search">
            <div class="search-box">
                <input class="search pull-left" type="text" name="sm_name">
                <button class="btn search-btn pull-left" id="btn-search">
                    <span class="icon icon-search"></span>
                </button>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div id="card_space_topfix_height"></div>
    <div class="selectuser">
        <span id="item1mobile" class="control-content active">

    <div class="card_app">


<div class="deptlist" id="contacts-list-deptlist" style="display: block;">
    </div>
    </div>
    </span>
    <span id="item2mobile" class="control-content">
    
    <div class="card_app">
 
<div id="slider2">
  <div class="slider-content">
    <ul>
      <li>
        <ul id="favorite-contacts-listview">

        </ul>
      </li>

    </ul>
  </div>
</div>




 </div>
  </span>
    <span id="item3mobile" class="control-content">
    
    <div class="card_app">
 
<div id="slider3">
  <div class="slider-content">
    <ul>
      <!-- <li id="a"><a name="a" class="list-title">A</a> -->
        <ul id="all-contacts-listview">
        </ul>
      </li>
    </ul>
  </div>
</div>




 </div>
  </span>
    <div id="card_space_fix_height"></div>
    <div class="card_space_fix">
        <div class="selected-list">
            <div class="table text-center">
                <div class="tr" id="selected-list">
    			</div>
    		</div>
    	</div>
    <a class="btn btn-positive btn-block " href="#" data-transition="fade" id="btn-success">确定</a>
    </div>
    </div>
    
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery.tmpl.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="components.mobile.js"></script>
	<script src="js/component.userselect.mobile.js"></script>
	<script type="text/javascript">
		var contextPath = '<%=request.getContextPath()%>';
		var domainid=''; 
	</script>
	<script id="tmpl-contacts-listview-item-with-checkbox" type="text/x-jquery-tmpl">
		    <li class="user-item" data-id="{{= id}}" data-name="{{= name}}" data-email="{{= email}}" data-mobile="{{= mobile}}" data-deptname="{{= deptname}}" data-loginno="{{= loginNo}}" data-deptid="{{= deptId}}" data-avatar="{{= avatar}}" data-domainid="{{= domainId}}">
            <table class="list-box">
              <tr>
                <td class="check"><input type="checkbox" name="contact" value="{{= id}}" ></td>
                <td class="face"><img src="{{= avatar}}"></td>
                <td class="text"><p>{{= name}}</p></td>
                <td class="other">{{= deptname}}</td>
              </tr>
            </table>
          </li>
	</script>
	
	<script id="tmpl-contacts-listview-item" type="text/x-jquery-tmpl">
		    <li class="user-item" data-id="{{= id}}" data-name="{{= name}}" data-email="{{= email}}" data-mobile="{{= mobile}}" data-deptname="{{= deptname}}" data-loginno="{{= loginNo}}" data-deptid="{{= deptId}}" data-avatar="{{= avatar}}" data-domainid="{{= domainId}}">
            <table class="list-box">
              <tr>
                <td class="face"><img src="{{= avatar}}"></td>
                <td class="text"><p>{{= name}}</p></td>
                <td class="other">{{= deptname}}</td>
              </tr>
            </table>
          </li>
	</script>
	
	<script id="tmpl-selected-list-item" type="text/x-jquery-tmpl">
	
	    <span class="td animated bounceInDown selected-item" data-id="{{= id}}" data-name="{{= name}}" data-email="{{= email}}" data-mobile="{{= mobile}}" data-deptname="{{= deptname}}" data-loginno="{{= loginNo}}" data-deptid="{{= deptId}}" data-avatar="{{= avatar}}" data-domainid="{{= domainId}}">
        	<div class="face">
        		<span class="face-box">
     				<img src="{{= avatar}}">
       			</span>
        	</div>
        	<div>{{= name}}</div>
        </span>
	</script>
</body>
</html>