/**
 * Theme Plugins
 * @author ZhangHuihua@msn.com
 */
(function($){
	$.fn.extend({
		theme: function(options){
			var op = $.extend({themeBase:"themes"}, options);
			var _themeHref = op.themeBase + "/#theme#/style.css";
			
			return this.each(function(){
				var jThemeLi = $(this).find(">li[theme]");
				
				var count=0;
				var setIframeContentTheme = function(iframe, themeName) {
					count++;
					$link = $(iframe.contentWindow.document).find("link[href*='main-front.css']");
					
					_href = $link.attr("href");
					if (_href) {
						$link.after("<link rel='stylesheet' href='" + contextPath +"/portal/dwz/themes/" + themeName + "/main-front.css' /> ");
						$link.remove();
					}
					
					$(iframe.contentWindow.document).find("iframe").each(function(){
						setIframeContentTheme(this, themeName);
					});
					
				};
				
				var setTheme = function(themeName){
					$("head").find("link[href$='style.css']").attr("href", _themeHref.replace("#theme#", themeName));
					jThemeLi.find(">div").removeClass("selected");
					jThemeLi.filter("[theme="+themeName+"]").find(">div").addClass("selected");
				
					var frames = document.getElementsByTagName("iframe");
					
					if ($.isFunction($.cookie)) $.cookie("dwz_theme", themeName, {path:"/"});
					$("iframe").each(function(){
						setIframeContentTheme(this, themeName);
					});
				};
				
				jThemeLi.each(function(index){
					var $this = $(this);
					var themeName = $this.attr("theme");
					$this.addClass(themeName).click(function(){
						setTheme(themeName);
					});			
				});
					
				if ($.isFunction($.cookie)){
					var themeName = $.cookie("dwz_theme");
					if (themeName) {
						setTheme(themeName);
					}
				}
				
			});
		}
	});
})(jQuery);
