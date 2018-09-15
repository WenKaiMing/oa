echo ; > .\resource\common\main.js


echo ; >> .\resource\common\main.js
type .\resource\js\bootstrap.min.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\js\jquery.slimscroll.min.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\script\template.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\script\common.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\js\obpm.main.core.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\js\obpm.main.service.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\component\artDialog\plugins\iframeTools.source.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\component\artDialog\obpm-jquery-bridge.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\component\showMessage\sweetalert\sweetalert.min.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\component\showMessage\toastr\toastr.min.js           		>> .\resource\common\main.js
echo ; >> .\resource\common\main.js
type .\resource\component\showMessage\obpm.showMessage.js           		>> .\resource\common\main.js



java -jar yuicompressor-2.4.8.jar .\resource\common\main.js -o .\resource\common\main.min.js


type .\resource\css\bootstrap.min.css        		>> .\resource\common\main.css

type .\resource\css\main.css         >> .\resource\common\main.css 
type .\resource\component\showMessage\sweetalert\sweetalert.css         >> .\resource\common\main.css 
type .\resource\component\showMessage\toastr\toastr.css         >> .\resource\common\main.css 



java -jar yuicompressor-2.4.8.jar .\resource\common\main.css -o .\resource\common\main.min.css

::压缩animate.css文件会使动画不生效,所以最后只合并该文件
type .\resource\css\animate.css        			>> .\resource\common\main.min.css

@echo off
for %%i in (".\resource\common\main.min.js")do (
  set str=%%~ti%%~zi)
set "str=%str:/=%"
set "str=%str: =%"
set "str=%str::=%"


set script="<script type='text/javascript' src='<s:url value='/portal/H5/resource/common/main.min.js?v=%str%'/>'></script>"
set css="<link rel='stylesheet' href='<s:url value='/portal/H5/resource/common/main.min.css?v=%str%'/>'/>"

set /p=%script%<nul > ./resource/common/main_js.jsp
set /p=%css%<nul > ./resource/common/main_css.jsp

del .\resource\common\main.css, .\resource\common\main.js