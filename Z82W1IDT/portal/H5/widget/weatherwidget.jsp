<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<div class="widgetContent widget-weather-div" _type="weather">
	<div class="weather-today">
	    <div class="weather-icon">
	        <div class="weather-icon-title"></div>
	        <div class="weather-icon-pic">
	            <img src="">
	        </div>
	    </div>
	    <div class="weather-info">
	        <div style="height:30px"></div>
	        <ul>
	            <li class="weather-info-num"> </li>
	            <li class="weather-info-weather"> </li>
	            <li class="weather-info-quality"> </li>
	            <li class="weather-info-rank"> </li>
	            <li class="weather-info-time"> </li>
	        </ul>
	    </div>
	    <div class="weather-future">
	    	<div class="weather-city">
	    		<div id="weather-city-select">
			  		<select class="prov"></select> 
			    	<select class="city" disabled="disabled"></select>
			    	<select class="dist" disabled="disabled"></select>
			    	<button id="weather-city-btn">更换</button>
			    </div>
	        	<span class="weather-city-name"></span>
	        	<a class="weather-city-change">切换</a>
	        </div>
	    </div>
	</div>
	<div class="weather-today weather-small">
        <div class="weather-icon">
            <div class="weather-icon-pic">
                <img src="">
            </div>
        </div>
        <div class="weather-info">
            <ul>
                <li class="weather-icon-title"><span></span></li>
                <li class="weather-info-weather"></li>
                <li class="weather-info-num"></li>
                <li class="weather-info-time"></li>
            </ul>
        </div>
    </div>
	
</div>
</o:MultiLanguage>
