echo ; > .\resource\common\homepage.js


echo ; >> .\resource\common\homepage.js
type .\resource\jquery\jquery-ui.min.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\resource\script\bootstrap.min.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\resource\script\swiper.min.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\resource\script\common.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\..\share\script\json\json2.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\resource\script\jquery.cityselect.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\resource\script\jquery.slimscroll.min.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\resource\component\artDialog\plugins\iframeTools.source.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\resource\component\artDialog\obpm-jquery-bridge.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js
type .\resource\homepage\js\Jh.js           		>> .\resource\common\homepage.js
echo ; >> .\resource\common\homepage.js



java -jar yuicompressor-2.4.8.jar .\resource\common\homepage.js -o .\resource\common\homepage.min.js


type .\resource\css\bootstrap.min.css        		>> .\resource\common\homepage.css
type .\resource\css\swiper.min.css        			>> .\resource\common\homepage.css
type .\resource\css\myapp.css         >> .\resource\common\homepage.css 
type .\resource\css\animate.css         >> .\resource\common\homepage.css 



java -jar yuicompressor-2.4.8.jar .\resource\common\homepage.css -o .\resource\common\homepage.min.css


@echo off
for %%i in (".\resource\common\homepage.min.js")do (
  set str=%%~ti%%~zi)
set "str=%str:/=%"
set "str=%str: =%"
set "str=%str::=%"


set script="<script type='text/javascript' src='<s:url value='/portal/H5/resource/common/homepage.min.js?v=%str%'/>'></script>"
set css="<link rel='stylesheet' href='<s:url value='/portal/H5/resource/common/homepage.min.css?v=%str%'/>'/>"

set /p=%script%<nul > ./resource/common/homepage_js.jsp
set /p=%css%<nul > ./resource/common/homepage_css.jsp

del .\resource\common\homepage.css, .\resource\common\homepage.js