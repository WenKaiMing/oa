/**!
 * Widget that extend jQuery Dialog one.
 *
 * Created to augment dialog's functionnality. Mainly, 
 * maximize, minimize need.
 *
 * @module widget-dialog
 * @class ExtDialog
 * @author mk
 */
(function($){
    
    var Config = {
        maximizeIcon: 'ui-icon-extlink',
        restoreIcon: 'ui-icon-newwin',
        buttonPaneHeight: 34
    };

    
    var MaxDialog = $.extend({}, $.ui.dialog.prototype, {
        _init: function(){
            $.ui.dialog.prototype._init.apply(this, arguments);
            
            var self = this;
            var options = this.options;
            var uiDialogTitlebar = this.uiDialogTitlebar;
            var trigger = $('<a />')
                .addClass('ui-dialog-titlebar-max ui-corner-all');
            
            var triggerIcon = $('<span />')
                .addClass('ui-icon ' + Config.maximizeIcon)
                .attr('role', 'button');
           	
            triggerIcon.appendTo(trigger).text(options.maxText);
            
            // Change widgetEventPrefix for further use with custom events
            this.widgetEventPrefix = "dialog";
         
            // Adding maximize button.
            if (self.options.maximized) {               
                uiDialogTitlebar.append(trigger);
                this.uiDialogTitlebarMaxText = triggerIcon;
                this.uiDialogTitlebarMax = trigger.hover(function(){
                    $(this)
                        .addClass('ui-state-hover')
                        .css('cursor', 'pointer');
                    
                }, function(){
                    $(this).removeClass('ui-state-hover');
                })
                .focus(function() {
                    $(this).addClass('ui-state-focus');
                })
                .blur(function() {
                    $(this).removeClass('ui-state-focus');
                })
                .mousedown(function(ev){
                    ev.stopPropagation();
                })
                .click(function(){
                    if(self.maximized) {
                        self.restore();
                    } else {
                        self.maximize();    
                    }
                    return false;
                });
                
                //Allow titlebar doubleclick to maximize/restore the dialog.
                uiDialogTitlebar.bind("dblclick", function() {
                    if(self.maximized) {
                        self.restore();
                    } else {
                        self.maximize();
                    }
                }); 
            }

            //弹出层时最大化窗口
            window.setTimeout(function(){
            	if(self.options.maximization){
                    self.maximize();
            	}
            }, 200);
        },
        
        open: function(){
            $.ui.dialog.prototype.open.apply(this, arguments);
            
            if(this.maximized){
                this.maximize();
            }
        },
        
        restore: function() {
            // reset both states (restored)
            this.maximized = false;
            this.minimized = false;
            var win = $("body");
            var left = (win.width() - this.options.width)/2;
            var top = (win.height() - this.options.height)/2;
            // 还原大小
            this.uiDialog.css({position:'absolute', width: this.options.width, height:this.options.height});
            this.uiDialog.css({left:left,top:top});
//            this._position(this.options.position);
            
            this._makeResizable();
            this._makeDraggable();
            //this._setData("draggable", true);
            //this._setData("resizable", true);

            this._originalSize();
            this._changeIcon();
            //this._changeSize();
            this._adjustScrollContent(true);
        },  
              
        maximize: function() {
            var marginHDialog = 25; 
            var marginWDialog  = 25;
            var win = $("body");
            
            
            // reset both states (restored)
            this.maximized = true;
            this.minimized = false;
            
            this.uiDialog.resizable('destroy');
            this.uiDialog.draggable('destroy');
            //this._setData("draggable", false);
            //this._setData("resizable", false);
            this._originalSize();
            this._setupButtonPaneHeight();
            
            if ($.browser.msie && $.browser.version === 8) {marginHDialog = 25; marginWDialog  = 52;}
            marginHDialog = win.height() - marginHDialog;
            marginWDialog = win.width() - marginWDialog;
            // 设置dialog位置
            this.uiDialog.css({left: 10, top: $(document).scrollTop() + 5 , width: marginWDialog + "px" , height: marginHDialog + "px"});
            this._size();
            this.uiDialog.css('position','absolute');
            this._changeIcon();
            this._adjustScrollContent();
        },
        
        _originalSize: function() {
            this.options.height = this.uiDialog.height() + 8; // 奇怪的缺少8px
            this.options.width = this.uiDialog.width() + 8;
        },
        
        _changeSize: function() {
            var marginH = 11;
            var marginW = 17; 
            
            // Handle cross browser issue with heights and width
            if ($.browser.msie) {marginH = 10; marginW = 18; }
            if ($.browser.safari) {marginH = 12; marginW  = 16;}
            
            this.uiDialog.css('width', (this.uiDialog.width()-3) + "px");
        },
        
        _changeIcon: function(){
            if(this.maximized){
                this.uiDialogTitlebarMaxText.removeClass(Config.maximizeIcon).addClass(Config.restoreIcon);
            } else {
                this.uiDialogTitlebarMaxText.removeClass(Config.restoreIcon).addClass(Config.maximizeIcon);
            }
        },
        /**
         * 调整内容高度和宽度
         */
        _adjustScrollContent: function (isRestored) {
            var heightDelta = isRestored ? 0 : 72;
            //var heightDialog = (this.uiDialog.height() - (this.options.buttonPaneHeight)) + 'px';
            var heightDialog = (this.uiDialog.height() - (this.options.buttonPaneHeight))-50 + 'px';
            var widthDialog = (this.uiDialog.width() - 65) + 'px';
            
            this.element.css({width: "auto", height: heightDialog});
        },
        
        _size: function() {
            var container = this.element,
                titlebar = this.uiDialogTitlebar,
                tbMargin = parseInt(container.css('margin-top'),10) + parseInt(container.css('margin-bottom'),10),
                lrMargin = parseInt(container.css('margin-left'),10) + parseInt(container.css('margin-right'),10);
    
            container.height(container.height() - titlebar.outerHeight() - tbMargin - 8);
            container.width(container.width() - lrMargin);
        },
        
        _setupButtonPaneHeight: function(){
            if(this.options.buttonPaneHeight) return;
            this.options.buttonPaneHeight = this.uiDialog.find('.ui-dialog-buttonpane').height();
        }
    });
    
    $.widget('mk.dialog', MaxDialog);
    
    //Don't forget to copy all of regular dialog's default
    $.mk.dialog.options = $.extend({}, $.ui.dialog.options, {
        maximized: true,
        maxText: "Maximize",
        restoreText: "Restore"
    });
    
    //... and getters...
    $.mk.dialog.getter = $.ui.dialog.getter;
    
})(jQuery);