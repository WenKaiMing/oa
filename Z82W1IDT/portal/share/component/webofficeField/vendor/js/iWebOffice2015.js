var userAgent = navigator.userAgent, rMsie = /(msie\s|trident.*rv:)([\w.]+)/, rFirefox = /(firefox)\/([\w.]+)/, rOpera = /(opera).+version\/([\w.]+)/, rChrome = /(chrome)\/([\w.]+)/, rSafari = /version\/([\w.]+).*(safari)/;
var browser;
var version;
var ua = userAgent.toLowerCase();
function uaMatch(ua) {
	var match = rMsie.exec(ua);
	if (match != null) {
		return {
			browser : "IE",
			version : match[2] || "0"
		};
	}
	var match = rFirefox.exec(ua);
	if (match != null) {
		return {
			browser : match[1] || "",
			version : match[2] || "0"
		};
	}
	var match = rOpera.exec(ua);
	if (match != null) {
		return {
			browser : match[1] || "",
			version : match[2] || "0"
		};
	}
	var match = rChrome.exec(ua);
	if (match != null) {
		return {
			browser : match[1] || "",
			version : match[2] || "0"
		};
	}
	var match = rSafari.exec(ua);
	if (match != null) {
		return {
			browser : match[2] || "",
			version : match[1] || "0"
		};
	}
	if (match != null) {
		return {
			browser : "",
			version : "0"
		};
	}
}
var browserMatch = uaMatch(userAgent.toLowerCase());
if (browserMatch.browser) {
	browser = browserMatch.browser;
	version = browserMatch.version;
}

var str = '';

var copyright = "金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAHgBAACAAQAALAAAACdDTJtooi62AHLXvPQY0Q+ooHfrVYj7IxR0y7YzKyC5mo4xqQG4K6ZDQdeqEELeqy0Q9LrQWC6hBSSeRmC6CXedOii5O8zjL/nWDOXA7gTa5OLLes4ijhEXEjYsxh0MuWx9gMEMoSS2LdtO0OQ/MFHmAIz6IlwondqoBK2rY3QBsJyfNeFlriFQLnW6pldOOAm6B/otSQNxZKeS6zs3ljA2oJ5JY0yUSLJcEAvskpEIZN68I0fCyQEXyHMuquCAEiC7LepPaK5XXrOJ+tCrik6GnKj5UBJcn8FTR0DyYNVAQVe6hFjJnSHvgZRnkcV8P+NrMbYWidEPiIYqY/f8JBeiVLn1i1Jf18//pZdOb/7s2alJdzRRGEvO32/wUP1HuYYIus2sR2IF50JrkFr+7NbPL7PDZucCyxmqPePKVSysBNGcHcYzYqSfKJw+aI4SQACvpvkI8RIaaCmUnIZz/Gqa5ERbJ+AajAaEbwg+gTyQuNhCFGMd7f7ne5xvQUnklzecXxzYO35cYE6iJCp3+jo=";

// var
// copyright='金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAIEBAACQAQAALAAAAI19jtsurSQJbYZyn4lGvnQwq3Yymb0t54DN+Z6dDjpWEdN4v9sWGIql/6UGzdgh+xUAAEYfzW7YubfR1EB4vFVkGMsqUa9a16gfhIb1YVBQ1cDn0Kx6l9nsUObxWNl4htXW2jysfa8ioiHSnBvFm8YhPqKCdMhXECoPgnSDGGsPCGBTfB5I/t9E2tiv1AFFHMilMrYRCSDrwPpNI2A4rccsG8yB7oc2H5xotd/oDjgKmMmQIoW27aMI9R0kJI7v+hp9gx/wFG/D/i0p3xsAYReFREnjG/kDafiO200qf3/MDtp0ndCV9khpOH0w9I7SUbQaRaw48b0XueLNX1NOAWAoigD24vgygaa4qGEp4sCDtnTeB9/wchf2H6TxZuyZCjjejrAFHbzdyiby2whX/+8b2jOdPlvvooSqw5ltxf8wzhNw7XlLefhtLBbxH9Gw4+2oxtBRYeaaWxLDTucrqITNnbSCCbmhSGOFB3ovCrlRZTJKECSMkGRbyfWpXXA/deiDa5qI57se+fpjPE55beAQg4Jd9FONR8ujXrWy3idx';

str += '<object id="WebOffice2015" ';

str += ' width="100%"';
str += ' height="95%"';

if ((window.ActiveXObject != undefined) || (window.ActiveXObject != null)
		|| "ActiveXObject" in window) {
	if (window.navigator.platform == "Win32")
		str += ' CLASSID="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D025"  codebase="iWebOffice2015.cab#version=12,4,0,444"';
	if (window.navigator.platform == "Win64")
		str += ' CLASSID="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D024"  codebase="iWebOffice2015.cab#version=12,4,0,444"';
	str += '>';
	str += '<param name="Copyright" value="' + copyright + '">';
} else if (browser == "chrome") {
	str += ' clsid="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D025"';
	str += ' type="application/kg-plugin"';
	str += ' OnCommand="OnCommand"';
	str += ' OnRightClickedWhenAnnotate="OnRightClickedWhenAnnotate"';
	str += ' OnSending="OnSending"';
	str += ' OnSendEnd="OnSendEnd"';
	str += ' OnRecvStart="OnRecvStart"';
	str += ' OnRecving="OnRecving"';
	str += ' OnRecvEnd="OnRecvEnd"';
	str += ' OnFullSizeBefore="OnFullSizeBefore"';
	str += ' OnFullSizeAfter="OnFullSizeAfter"';
	str += ' Copyright="' + copyright + '"';
} else if (browser == "firefox") {
	str += ' clsid="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D025"';
	str += ' type="application/kg-activex"';
	str += ' OnCommand="OnCommand"';
	str += ' OnReady="OnReady"';
	str += ' OnOLECommand="OnOLECommand"';
	str += ' OnExecuteScripted="OnExecuteScripted"';
	str += ' OnQuit="OnQuit"';
	str += ' OnSendStart="OnSendStart"';
	str += ' OnSending="OnSending"';
	str += ' OnSendEnd="OnSendEnd"';
	str += ' OnRecvStart="OnRecvStart"';
	str += ' OnRecving="OnRecving"';
	str += ' OnRecvEnd="OnRecvEnd"';
	str += ' OnRightClickedWhenAnnotate="OnRightClickedWhenAnnotate"';
	str += ' OnFullSizeBefore="OnFullSizeBefore"';
	str += ' OnFullSizeAfter="OnFullSizeAfter"';
	str += ' Copyright="' + copyright + '"';
	str += '>';
}
str += '</object>';
document.write(str);
// alert(str);
// 谷歌中加载插件
function OnControlCreated() {
	if (browser == "chrome") {
		KGChromePlugin = document.getElementById('WebOffice2015');
		iWebOffice = KGChromePlugin.obj;
		WebOfficeObj.setObj(iWebOffice);
		Load();
	}
}