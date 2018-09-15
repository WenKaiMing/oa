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
 * Plugin to insert "datefields" in the editor.
 */

// Register the related command.
function getUrl(){
	var url;
	//var moduleid = document.getElementById('moduleid').value;
	//var applicationid = document.getElementById('applicationid').value;
	var moduleid = parent.document.getElementById('moduleid').value;
	var applicationid = parent.document.getElementById('application').value;
	var formid = parent.document.forms[0].elements['content.id'].value;
	
	url = 'myapps_datefield.jsp?';
	/*if (isTabFieldSelected()){
		url = 'dialog/datefield.jsp?action=modify';
		url += '&moduleid=' + moduleid + '&application='+applicationid;
	}
	else {
		url = 'dialog/datefield.jsp?action=new';
		url += '&moduleid=' + moduleid + '&application='+applicationid;
	}*/
	url += '&moduleid=' + moduleid + '&application='+applicationid + '&formid=' +formid;
	return FCKPlugins.Items['datefield'].Path + url;
}
FCKCommands.RegisterCommand( 'datefield', new FCKDialogCommand( 'datefield', FCKLang.datefieldtitle, getUrl(), 600, 400 ) ) ;
// Create the "Plaholder" toolbar button.
var odatefieldItem = new FCKToolbarButton( 'datefield', FCKLang.datefield ) ;
odatefieldItem.IconPath = FCKPlugins.Items['datefield'].Path + 'datefield.gif' ;
FCKToolbarItems.RegisterItem( 'datefield', odatefieldItem ) ;

// The object used for all datefield operations.
var FCKdatefields = new Object() ;

// Add a new placeholder at the actual selection.
FCKdatefields.Add = function( name )
{
	var oSpan = FCK.InsertElement( 'INPUT' ) ;
	this.SetupSpan( oSpan, name ) ;
}

FCKdatefields.SetupSpan = function( INPUT, name )
{
	INPUT.innerHTML = '[[ ' + name + ' ]]' ;

	INPUT.style.backgroundColor = '#ffff00' ;
	INPUT.style.color = '#000000' ;

	if ( FCKBrowserInfo.IsGecko )
		INPUT.style.cursor = 'default' ;

	INPUT._fckplaceholder = name ;
	INPUT.contentEditable = false ;

	// To avoid it to be resized.
	INPUT.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the INPUT when clicking on it.
FCKdatefields._SetupClickListener = function()
{
	FCKdatefields._ClickListener = function( e )
	{
		if ( e.target.tagName == 'INPUT' && e.target._fckplaceholder )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKdatefields._ClickListener, true ) ;
}

// Open the datefield dialog on double click.
FCKdatefields.OnDoubleClick = function( INPUT )
{
	if ( INPUT.tagName.toUpperCase() == 'INPUT' && INPUT.classname=="cn.myapps.core.dynaform.form.ejb.DateField" )
		FCKCommands.GetCommand( 'datefield' ).Execute() ;
}

FCK.RegisterDoubleClickHandler( FCKdatefields.OnDoubleClick, 'INPUT' ) ;

// Check if a Placholder name is already in use.
FCKdatefields.Exist = function( name )
{
	var aSpans = FCK.EditorDocument.getElementsByTagName( 'INPUT' ) ;

	for ( var i = 0 ; i < aSpans.length ; i++ )
	{
		if ( aSpans[i]._fckplaceholder == name )
			return true ;
	}

	return false ;
}

if ( FCKBrowserInfo.IsIE )
{
	FCKdatefields.Redraw = function()
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
				oRange.pasteHTML( '<INPUT style="color: #000000; background-color: #ffff00" contenteditable="false" _fckplaceholder="' + sName + '">' + aPlaholders[i] + '</INPUT>' ) ;
			}
		}
	}
}
else
{
	FCKdatefields.Redraw = function()
	{
		if ( FCK.EditMode != FCK_EDITMODE_WYSIWYG )
			return ;

		var oInteractor = FCK.EditorDocument.createTreeWalker( FCK.EditorDocument.body, NodeFilter.SHOW_TEXT, FCKdatefields._AcceptNode, true ) ;

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

						var oSpan = FCK.EditorDocument.createElement( 'INPUT' ) ;
						FCKdatefields.SetupSpan( oSpan, sName ) ;

						aNodes[n].parentNode.insertBefore( oSpan, aNodes[n] ) ;
					}
					else
						aNodes[n].parentNode.insertBefore( FCK.EditorDocument.createTextNode( aPieces[i] ) , aNodes[n] ) ;
				}
			}

			aNodes[n].parentNode.removeChild( aNodes[n] ) ;
		}

		FCKdatefields._SetupClickListener() ;
	}

	FCKdatefields._AcceptNode = function( node )
	{
		if ( /\[\[[^\[\]]+\]\]/.test( node.nodeValue ) )
			return NodeFilter.FILTER_ACCEPT ;
		else
			return NodeFilter.FILTER_SKIP ;
	}
}

FCK.Events.AttachEvent( 'OnAfterSetHTML', FCKdatefields.Redraw ) ;

// We must process the INPUT tags to replace then with the real resulting value of the placeholder.
FCKXHtml.TagProcessors['INPUT'] = function( node, htmlNode )
{
	if ( htmlNode._fckplaceholder )
		node = FCKXHtml.XML.createTextNode( '[[' + htmlNode._fckplaceholder + ']]' ) ;
	else
		FCKXHtml._AppendChildNodes( node, htmlNode, false ) ;

	return node ;
}
