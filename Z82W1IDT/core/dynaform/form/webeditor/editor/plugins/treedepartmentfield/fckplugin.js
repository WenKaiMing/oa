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
 * Plugin to insert "treedepartmentfields" in the editor.
 */

// Register the related command.

function getUrl(){
	var url;
	var moduleid = parent.document.getElementById('moduleid').value;
	var applicationid = parent.document.getElementById('application').value;
	url = 'myapps_treedepartment.jsp?';
	/*if (istreedepartmentfieldSelected()){
		url = 'dialog/treedepartmentfield.jsp?action=modify';
		url += '&moduleid=' + moduleid + '&application='+applicationid;
	}
	else {
		url = 'dialog/treedepartmentfield.jsp?action=new';
		url += '&moduleid=' + moduleid + '&application='+applicationid;
	}*/
	url += '&moduleid=' + moduleid + '&application='+applicationid;
	//alert("URL----->"+url);
	return FCKPlugins.Items['treedepartmentfield'].Path+url;
}
FCKCommands.RegisterCommand( 'treedepartmentfield', new FCKDialogCommand( 'treedepartmentfield', FCKLang.treedepartmentfieldtitle, getUrl(), 600, 400 ) ) ;

// Create the "Plaholder" toolbar button.
var otreedepartmentfieldItem = new FCKToolbarButton( 'treedepartmentfield', FCKLang.treedepartmentfield ) ;
otreedepartmentfieldItem.IconPath = FCKPlugins.Items['treedepartmentfield'].Path + 'treedepartmentfield.gif' ;

FCKToolbarItems.RegisterItem( 'treedepartmentfield', otreedepartmentfieldItem ) ;


// The object used for all treedepartmentfield operations.
var FCKtreedepartmentfields = new Object() ;

// Add a new placeholder at the actual selection.
FCKtreedepartmentfields.Add = function( name )
{
	var oSpan = FCK.InsertElement( 'SELECT' ) ;
	this.SetupSpan( oSpan, name ) ;
}

FCKtreedepartmentfields.SetupSpan = function( SELECT, name )
{
	SELECT.innerHTML = '[[ ' + name + ' ]]' ;

	SELECT.style.backgroundColor = '#ffff00' ;
	SELECT.style.color = '#000000' ;

	if ( FCKBrowserInfo.IsGecko )
		SELECT.style.cursor = 'default' ;

	SELECT._fckplaceholder = name ;
	SELECT.contentEditable = false ;

	// To avoid it to be resized.
	SELECT.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the SELECT when clicking on it.
FCKtreedepartmentfields._SetupClickListener = function()
{
	FCKtreedepartmentfields._ClickListener = function( e )
	{
		if ( e.target.tagName == 'SELECT' && e.target._fckplaceholder )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKtreedepartmentfields._ClickListener, true ) ;
}

// Open the treedepartmentfield dialog on double click.
FCKtreedepartmentfields.OnDoubleClick = function( SELECT )
{
	if ( SELECT.classname=="cn.myapps.core.dynaform.form.ejb.TreeDepartmentField" ){
		FCKCommands.GetCommand( 'treedepartmentfield' ).Execute() ;
	}
}

FCK.RegisterDoubleClickHandler( FCKtreedepartmentfields.OnDoubleClick, 'SELECT' ) ;

// Check if a Placholder name is already in use.
FCKtreedepartmentfields.Exist = function( name )
{
	var aSpans = FCK.EditorDocument.getElementsByTagName( 'SELECT' ) ;

	for ( var i = 0 ; i < aSpans.length ; i++ )
	{
		if ( aSpans[i]._fckplaceholder == name )
			return true ;
	}

	return false ;
}

if ( FCKBrowserInfo.IsIE )
{
	FCKtreedepartmentfields.Redraw = function()
	{
		if ( FCK.EditMode != FCK_EDITMODE_WYSIWYG )
			return ;

		var aPlaholders = FCK.EditorDocument.body.innerText.match( /\[\[[^\[\]]+\]\]/g ) ;
		if ( !aPlaholders )
			return ;

		var oRange = FCK.EditorDocument.body.createTextRange() ;

		for ( var i = 0 ; i < aPlaholders.length ; i++ )
		{
			if ( oRange.findText( aPlaholders[i] ) )
			{
				var sName = aPlaholders[i].match( /\[\[\s*([^\]]*?)\s*\]\]/ )[1] ;
				oRange.pasteHTML( '<SELECT style="color: #000000; background-color: #ffff00" contenteditable="false" _fckplaceholder="' + sName + '">' + aPlaholders[i] + '</SELECT>' ) ;
			}
		}
	}
}
else
{
	FCKtreedepartmentfields.Redraw = function()
	{
		if ( FCK.EditMode != FCK_EDITMODE_WYSIWYG )
			return ;

		var oInteractor = FCK.EditorDocument.createTreeWalker( FCK.EditorDocument.body, NodeFilter.SHOW_TEXT, FCKtreedepartmentfields._AcceptNode, true ) ;

		var	aNodes = new Array() ;

		while ( ( oNode = oInteractor.nextNode() ) )
		{
			aNodes[ aNodes.length ] = oNode ;
		}

		for ( var n = 0 ; n < aNodes.length ; n++ )
		{
			var aPieces = aNodes[n].nodeValue.split( /(\[\[[^\[\]]+\]\])/g ) ;

			for ( var i = 0 ; i < aPieces.length ; i++ )
			{
				if ( aPieces[i].length > 0 )
				{
					if ( aPieces[i].indexOf( '[[' ) == 0 )
					{
						var sName = aPieces[i].match( /\[\[\s*([^\]]*?)\s*\]\]/ )[1] ;

						var oSpan = FCK.EditorDocument.createElement( 'SELECT' ) ;
						FCKtreedepartmentfields.SetupSpan( oSpan, sName ) ;

						aNodes[n].parentNode.insertBefore( oSpan, aNodes[n] ) ;
					}
					else
						aNodes[n].parentNode.insertBefore( FCK.EditorDocument.createTextNode( aPieces[i] ) , aNodes[n] ) ;
				}
			}

			aNodes[n].parentNode.removeChild( aNodes[n] ) ;
		}

		FCKtreedepartmentfields._SetupClickListener() ;
	}

	FCKtreedepartmentfields._AcceptNode = function( node )
	{
		if ( /\[\[[^\[\]]+\]\]/.test( node.nodeValue ) )
			return NodeFilter.FILTER_ACCEPT ;
		else
			return NodeFilter.FILTER_SKIP ;
	}
}

FCK.Events.AttachEvent( 'OnAfterSetHTML', FCKtreedepartmentfields.Redraw ) ;

// We must process the SELECT tags to replace then with the real resulting value of the placeholder.
FCKXHtml.TagProcessors['SELECT'] = function( node, htmlNode )
{
	if ( htmlNode._fckplaceholder )
		node = FCKXHtml.XML.createTextNode( '[[' + htmlNode._fckplaceholder + ']]' ) ;
	else
		FCKXHtml._AppendChildNodes( node, htmlNode, false ) ;

	return node ;
}
