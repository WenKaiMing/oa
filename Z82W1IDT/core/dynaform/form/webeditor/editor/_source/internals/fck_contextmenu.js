/*
 * FCKeditor - The text editor for Internet - http://www.fckeditor.net
 * Copyright (C) 2003-2010 Frederico Caldeira Knabben
 *
 * == BEGIN LICENSE ==
 *
 * Licensed under the terms of any of the following licenses at your
 * choice:
 *
 *  - GNU General Public License Version 2 or later (the "GPL")
 *    http://www.gnu.org/licenses/gpl.html
 *
 *  - GNU Lesser General Public License Version 2.1 or later (the "LGPL")
 *    http://www.gnu.org/licenses/lgpl.html
 *
 *  - Mozilla Public License Version 1.1 or later (the "MPL")
 *    http://www.mozilla.org/MPL/MPL-1.1.html
 *
 * == END LICENSE ==
 *
 * Defines the FCK.ContextMenu object that is responsible for all
 * Context Menu operations in the editing area.
 */

FCK.ContextMenu = new Object() ;
FCK.ContextMenu.Listeners = new Array() ;

FCK.ContextMenu.RegisterListener = function( listener )
{
	if ( listener )
		this.Listeners.push( listener ) ;
}

function FCK_ContextMenu_Init()
{
	var oInnerContextMenu = FCK.ContextMenu._InnerContextMenu = new FCKContextMenu( FCKBrowserInfo.IsIE ? window : window.parent, FCKLang.Dir ) ;
	oInnerContextMenu.CtrlDisable	= FCKConfig.BrowserContextMenuOnCtrl ;
	oInnerContextMenu.OnBeforeOpen	= FCK_ContextMenu_OnBeforeOpen ;
	oInnerContextMenu.OnItemClick	= FCK_ContextMenu_OnItemClick ;

	// Get the registering function.
	var oMenu = FCK.ContextMenu ;

	// Register all configured context menu listeners.
	for ( var i = 0 ; i < FCKConfig.ContextMenu.length ; i++ )
		oMenu.RegisterListener( FCK_ContextMenu_GetListener( FCKConfig.ContextMenu[i] ) ) ;
}

function FCK_ContextMenu_GetListener( listenerName )
{
	function getClassName(tag){
		var classname = '';
		
		if (tag) {
			if (tag.classname) {
				classname = tag.classname;
			} else {
				if (tag.attributes['className']){
					classname = tag.attributes['className'].nodeValue;
				}
			}
		}
		return classname;
	}
	
	switch ( listenerName )
	{
		case 'Generic' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				menu.AddItem( 'Cut'		, FCKLang.Cut	, 7, FCKCommands.GetCommand( 'Cut' ).GetState() == FCK_TRISTATE_DISABLED ) ;
				menu.AddItem( 'Copy'	, FCKLang.Copy	, 8, FCKCommands.GetCommand( 'Copy' ).GetState() == FCK_TRISTATE_DISABLED ) ;
				menu.AddItem( 'Paste'	, FCKLang.Paste	, 9, FCKCommands.GetCommand( 'Paste' ).GetState() == FCK_TRISTATE_DISABLED ) ;
			}} ;

		case 'Table' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				var bIsTable	= ( tagName == 'TABLE' ) ;
				var bIsCell		= ( !bIsTable && FCKSelection.HasAncestorNode( 'TABLE' ) ) ;

				if ( bIsCell )
				{
					menu.AddSeparator() ;
					var oItem = menu.AddItem( 'Cell'	, FCKLang.CellCM ) ;
					oItem.AddItem( 'TableInsertCellBefore'	, FCKLang.InsertCellBefore, 69 ) ;
					oItem.AddItem( 'TableInsertCellAfter'	, FCKLang.InsertCellAfter, 58 ) ;
					oItem.AddItem( 'TableDeleteCells'	, FCKLang.DeleteCells, 59 ) ;
					if ( FCKBrowserInfo.IsGecko )
						oItem.AddItem( 'TableMergeCells'	, FCKLang.MergeCells, 60,
							FCKCommands.GetCommand( 'TableMergeCells' ).GetState() == FCK_TRISTATE_DISABLED ) ;
					else
					{
						oItem.AddItem( 'TableMergeRight'	, FCKLang.MergeRight, 60,
							FCKCommands.GetCommand( 'TableMergeRight' ).GetState() == FCK_TRISTATE_DISABLED ) ;
						oItem.AddItem( 'TableMergeDown'		, FCKLang.MergeDown, 60,
							FCKCommands.GetCommand( 'TableMergeDown' ).GetState() == FCK_TRISTATE_DISABLED ) ;
					}
					oItem.AddItem( 'TableHorizontalSplitCell'	, FCKLang.HorizontalSplitCell, 61,
						FCKCommands.GetCommand( 'TableHorizontalSplitCell' ).GetState() == FCK_TRISTATE_DISABLED ) ;
					oItem.AddItem( 'TableVerticalSplitCell'	, FCKLang.VerticalSplitCell, 61,
						FCKCommands.GetCommand( 'TableVerticalSplitCell' ).GetState() == FCK_TRISTATE_DISABLED ) ;
					oItem.AddSeparator() ;
					oItem.AddItem( 'TableCellProp'		, FCKLang.CellProperties, 57,
						FCKCommands.GetCommand( 'TableCellProp' ).GetState() == FCK_TRISTATE_DISABLED ) ;

					menu.AddSeparator() ;
					oItem = menu.AddItem( 'Row'			, FCKLang.RowCM ) ;
					oItem.AddItem( 'TableInsertRowBefore'		, FCKLang.InsertRowBefore, 70 ) ;
					oItem.AddItem( 'TableInsertRowAfter'		, FCKLang.InsertRowAfter, 62 ) ;
					oItem.AddItem( 'TableDeleteRows'	, FCKLang.DeleteRows, 63 ) ;

					menu.AddSeparator() ;
					oItem = menu.AddItem( 'Column'		, FCKLang.ColumnCM ) ;
					oItem.AddItem( 'TableInsertColumnBefore', FCKLang.InsertColumnBefore, 71 ) ;
					oItem.AddItem( 'TableInsertColumnAfter'	, FCKLang.InsertColumnAfter, 64 ) ;
					oItem.AddItem( 'TableDeleteColumns'	, FCKLang.DeleteColumns, 65 ) ;
				}

				if ( bIsTable || bIsCell )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'TableDelete'			, FCKLang.TableDelete ) ;
					menu.AddItem( 'TableProp'			, FCKLang.TableProperties, 39 ) ;
				}
			}} ;

		case 'Link' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				var bInsideLink = ( tagName == 'A' || FCKSelection.HasAncestorNode( 'A' ) ) ;

				if ( bInsideLink || FCK.GetNamedCommandState( 'Unlink' ) != FCK_TRISTATE_DISABLED )
				{
					// Go up to the anchor to test its properties
					var oLink = FCKSelection.MoveToAncestorNode( 'A' ) ;
					var bIsAnchor = ( oLink && oLink.name.length > 0 && oLink.href.length == 0 ) ;
					// If it isn't a link then don't add the Link context menu
					if ( bIsAnchor )
						return ;

					menu.AddSeparator() ;
					menu.AddItem( 'VisitLink', FCKLang.VisitLink ) ;
					menu.AddSeparator() ;
					if ( bInsideLink )
						menu.AddItem( 'Link', FCKLang.EditLink		, 34 ) ;
					menu.AddItem( 'Unlink'	, FCKLang.RemoveLink	, 35 ) ;
				}
			}} ;

		case 'Image' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				var classname = getClassName(tag);
				//alert("menu-->"+menu+"   tag.classname-->"+tag.classname+"   tagName-->"+tagName);
				if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.ViewDialogField"){
					menu.AddSeparator() ;
					menu.AddItem( 'viewdialogfield', FCKLang.ViewDialogFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.CalctextField"){
					menu.AddSeparator() ;
					menu.AddItem( 'calctextfield', FCKLang.CalcTextFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.IncludeField"){
					menu.AddSeparator() ;
					menu.AddItem( 'includefield', FCKLang.includefieldprop, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.AttachmentUploadField"){
					menu.AddSeparator() ;
					menu.AddItem( 'attachmentuploadfield', FCKLang.AttachmentUploadFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.AttachmentUploadToDataBaseField"){
					menu.AddSeparator() ;
					menu.AddItem( 'attachmentuploadtodatabasefield', FCKLang.AttachmentUploadToDataBaseFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.ImageUploadField"){
					menu.AddSeparator() ;
					menu.AddItem( 'imageuploadfield', FCKLang.ImageUploadFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.ImageUploadToDataBaseField"){
					menu.AddSeparator() ;
					menu.AddItem( 'imageuploadtodatabasefield', FCKLang.ImageUploadToDataBaseFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.FileManagerField"){
					menu.AddSeparator() ;
					menu.AddItem( 'filemanagerfield', FCKLang.FileManagerFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.ReminderField"){
					menu.AddSeparator() ;
					menu.AddItem( 'reminderfield', FCKLang.reminderFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.MapField"){
					menu.AddSeparator() ;
					menu.AddItem( 'mapfield', FCKLang.mapFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.OnLineTakePhotoField"){
					menu.AddSeparator() ;
					menu.AddItem( 'onlinetakephotofield', FCKLang.onlinetakephotoFieldProp, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.WordField"){
					menu.AddSeparator() ;
					menu.AddItem( 'wordfield', FCKLang.wordfieldprop, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.GenericWordField"){
					menu.AddSeparator() ;
					menu.AddItem( 'genericwordfield', FCKLang.genericwordfieldprop, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.HTMLEditorField"){
					menu.AddSeparator() ;
					menu.AddItem( 'htmleditorfield', FCKLang.htmleditorfieldprop, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.TabField"){
					menu.AddSeparator() ;
					menu.AddItem( 'tabfield', FCKLang.tabfieldprop, 37 ) ;
				}else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.FlowHistoryField"){
					menu.AddSeparator() ;
					menu.AddItem( 'flowhistoryfield', FCKLang.flowhistoryfieldprop, 37 ) ;
				}else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.WeixinGpsField"){
					menu.AddSeparator() ;
					menu.AddItem( 'weixingpsfield', FCKLang.weixingpsfieldprop, 37 ) ;
				}
				else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.SurveyField"){
					menu.AddSeparator() ;
					menu.AddItem( 'surveyfield', FCKLang.surveyfieldprop, 37 ) ;
				}else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.FlowReminderHistoryField"){
					menu.AddSeparator() ;
					menu.AddItem( 'flowreminderhistoryfield', FCKLang.flowreminderhistoryfieldprop, 37 ) ;
				}else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.WeixinRecordField"){
					menu.AddSeparator() ;
					menu.AddItem( 'weixinrecordfield', FCKLang.weixinrecordfieldprop, 37 ) ;
				}else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.InformationFeedbackField"){
					menu.AddSeparator() ;
					menu.AddItem( 'informationfeedbackfield', FCKLang.informationfeedbackfieldprop, 37 ) ;
				}else if ( tagName == 'IMG' && classname=="cn.myapps.core.dynaform.form.ejb.QRCodeField"){
					menu.AddSeparator() ;
					menu.AddItem( 'qrcodefield', FCKLang.qrcodefieldprop, 37 ) ;
				}
				else if ( tagName == 'IMG'){
					menu.AddSeparator() ;
					menu.AddItem( 'Image', FCKLang.ImageProperties, 37 ) ;
				}
				
			}} ;

		case 'Anchor' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				// Go up to the anchor to test its properties
				var oLink = FCKSelection.MoveToAncestorNode( 'A' ) ;
				var bIsAnchor = ( oLink && oLink.name.length > 0 ) ;

				if ( bIsAnchor || ( tagName == 'IMG' && tag.getAttribute( '_fckanchor' ) ) )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'Anchor', FCKLang.AnchorProp, 36 ) ;
					menu.AddItem( 'AnchorDelete', FCKLang.AnchorDelete ) ;
				}
			}} ;

		case 'Flash' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( tagName == 'IMG' && tag.getAttribute( '_fckflash' ) )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'Flash', FCKLang.FlashProperties, 38 ) ;
				}
			}} ;

		case 'Form' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( FCKSelection.HasAncestorNode('FORM') )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'Form', FCKLang.FormProp, 48 ) ;
				}
			}} ;

		case 'Checkbox' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( tagName == 'INPUT' && tag.type == 'checkbox' )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'Checkbox', FCKLang.CheckboxProp, 49 ) ;
				}
			}} ;

		case 'Radio' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( tagName == 'INPUT' && tag.type == 'radio' )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'Radio', FCKLang.RadioButtonProp, 50 ) ;
				}
			}} ;

		case 'TextField' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				var classname = getClassName(tag);
				
				if ( tagName == 'INPUT' && classname=="cn.myapps.core.dynaform.form.ejb.DateField" ){
					menu.AddSeparator() ;
					menu.AddItem( 'datefield', FCKLang.datefieldtitleprop, 51 ) ;
				}
				else if(tagName == 'INPUT' && classname=="cn.myapps.core.dynaform.form.ejb.SuggestField"){
					menu.AddSeparator() ;
					menu.AddItem( 'suggestfield', FCKLang.suggestfieldprop, 51 ) ;
				}
				else if ( tagName == 'INPUT' && ( tag.type == 'text' || tag.type == 'password' ) )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'TextField', FCKLang.TextFieldProp, 51 ) ;
				}
			}} ;

		case 'HiddenField' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( tagName == 'IMG' && tag.getAttribute( '_fckinputhidden' ) )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'HiddenField', FCKLang.HiddenFieldProp, 56 ) ;
				}
			}} ;

		case 'ImageButton' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( tagName == 'INPUT' && tag.type == 'image' )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'ImageButton', FCKLang.ImageButtonProp, 55 ) ;
				}
			}} ;

		case 'Button' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				var classname = getClassName(tag);
				if(tagName == 'BUTTON' && classname=="cn.myapps.core.dynaform.form.ejb.ButtonField" ){
					menu.AddSeparator() ;
					menu.AddItem( 'Button', FCKLang.ButtonProp, 54 ) ;
				}
				else if ( tagName == 'INPUT' && ( tag.type == 'button' || tag.type == 'submit' || tag.type == 'reset' ) )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'Button', FCKLang.ButtonProp, 54 ) ;
				}
			}} ;

		case 'Select' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				var classname = getClassName(tag);
				
				if(tagName == 'SELECT' && classname=="cn.myapps.core.dynaform.form.ejb.SelectAboutField"){
					menu.AddSeparator() ;
					menu.AddItem( 'selectaboutfield', FCKLang.selectaboutfieldprop, 53 ) ;
				}
				else if(tagName == 'SELECT' && classname=="cn.myapps.core.dynaform.form.ejb.UserField"){
					menu.AddSeparator() ;
					menu.AddItem( 'userfield', FCKLang.userfieldfieldprop, 53 ) ;
				}
				else if ( tagName == 'SELECT' && classname=="cn.myapps.core.dynaform.form.ejb.TreeDepartmentField"){
					menu.AddSeparator() ;
					menu.AddItem( 'treedepartmentfield', FCKLang.treedepartmentfieldfieldprop, 53 ) ;
				}
				else if(tagName == 'SELECT' && classname=="cn.myapps.core.dynaform.form.ejb.DepartmentField"){
					menu.AddSeparator() ;
					menu.AddItem( 'departmentfield', FCKLang.departmentfieldprop, 53 ) ;
				}
				else if(tagName == 'SELECT' && classname=="cn.myapps.core.dynaform.form.ejb.SelectField"){
					menu.AddSeparator() ;
					menu.AddItem( 'Select', FCKLang.SelectionFieldProp, 53 ) ;
				}
			}} ;

		case 'Textarea' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( tagName == 'TEXTAREA' )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'Textarea', FCKLang.TextareaProp, 52 ) ;
				}
			}} ;

		case 'BulletedList' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( FCKSelection.HasAncestorNode('UL') )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'BulletedList', FCKLang.BulletedListProp, 27 ) ;
				}
			}} ;

		case 'NumberedList' :
			return {
			AddItems : function( menu, tag, tagName )
			{
				if ( FCKSelection.HasAncestorNode('OL') )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'NumberedList', FCKLang.NumberedListProp, 26 ) ;
				}
			}} ;

		case 'DivContainer':
			return {
			AddItems : function( menu, tag, tagName )
			{
				var currentBlocks = FCKDomTools.GetSelectedDivContainers() ;

				if ( currentBlocks.length > 0 )
				{
					menu.AddSeparator() ;
					menu.AddItem( 'EditDiv', FCKLang.EditDiv, 75 ) ;
					menu.AddItem( 'DeleteDiv', FCKLang.DeleteDiv, 76 ) ;
				}
			}} ;

	}
	return null ;
}

function FCK_ContextMenu_OnBeforeOpen()
{
	// Update the UI.
	FCK.Events.FireEvent( 'OnSelectionChange' ) ;

	// Get the actual selected tag (if any).
	var oTag, sTagName ;

	// The extra () is to avoid a warning with strict error checking. This is ok.
	if ( (oTag = FCKSelection.GetSelectedElement()) )
		sTagName = oTag.tagName ;

	// Cleanup the current menu items.
	var oMenu = FCK.ContextMenu._InnerContextMenu ;
	oMenu.RemoveAllItems() ;

	// Loop through the listeners.
	var aListeners = FCK.ContextMenu.Listeners ;
	for ( var i = 0 ; i < aListeners.length ; i++ )
		aListeners[i].AddItems( oMenu, oTag, sTagName ) ;
}

function FCK_ContextMenu_OnItemClick( item )
{
	// IE might work incorrectly if we refocus the editor #798
	if ( !FCKBrowserInfo.IsIE )
		FCK.Focus() ;

	FCKCommands.GetCommand( item.Name ).Execute( item.CustomData ) ;
}
