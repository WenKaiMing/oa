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
 * Plugin to insert "suggestfields" in the editor.
 */

// Register the related command.

function getUrl(){
	var moduleid = parent.document.getElementById('moduleid').value;
	var applicationid = parent.document.getElementById('application').value;
	var formid = parent.document.forms[0].elements['content.id'].value;
	var url = 'myapps_suggestfield.jsp';
	url += '?moduleid=' + moduleid + '&application='+applicationid + '&formid='+formid;
	//alert("URL----->"+FCKPlugins.Items['suggestfield'].Path + url);
	return FCKPlugins.Items['suggestfield'].Path + url;
}
FCKCommands.RegisterCommand( 'suggestfield', new FCKDialogCommand( 'suggestfield', FCKLang.suggestfieldtitle, getUrl(), 600, 400 ) ) ;

// Create the "Plaholder" toolbar button.
var osuggestfieldItem = new FCKToolbarButton( 'suggestfield', FCKLang.suggestfield ) ;
osuggestfieldItem.IconPath = FCKPlugins.Items['suggestfield'].Path + 'suggestfield.gif' ;

FCKToolbarItems.RegisterItem( 'suggestfield', osuggestfieldItem ) ;


// The object used for all suggestfield operations.
var FCKsuggestfields = new Object() ;

// Add a new placeholder at the actual selection.
FCKsuggestfields.Add = function( name )
{
	var oSpan = FCK.InsertElement( 'input' ) ;
	this.SetupSpan( oSpan, name ) ;
}

FCKsuggestfields.SetupSpan = function( img, name )
{
	img.innerHTML = '[[ ' + name + ' ]]' ;

	img.style.backgroundColor = '#ffff00' ;
	img.style.color = '#000000' ;

	if ( FCKBrowserInfo.IsGecko )
		img.style.cursor = 'default' ;

	img._fckplaceholder = name ;
	img.contentEditable = false ;

	// To avoid it to be resized.
	img.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the img when clicking on it.
FCKsuggestfields._SetupClickListener = function()
{
	FCKsuggestfields._ClickListener = function( e )
	{
		if ( e.target.tagName == 'input' && e.target._fckplaceholder )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKsuggestfields._ClickListener, true ) ;
}

// Open the suggestfield dialog on double click.
FCKsuggestfields.OnDoubleClick = function( input )
{
	if ( input.tagName.toUpperCase() == 'INPUT' 
			&& input.classname == 'cn.myapps.core.dynaform.form.ejb.SuggestField' )
		FCKCommands.GetCommand( 'suggestfield' ).Execute() ;
}

FCK.RegisterDoubleClickHandler( FCKsuggestfields.OnDoubleClick, 'input' ) ;

// Check if a Placholder name is already in use.
FCKsuggestfields.Exist = function( name )
{
	var aSpans = FCK.EditorDocument.getElementsByTagName( 'input' ) ;

	for ( var i = 0 ; i < aSpans.length ; i++ )
	{
		if ( aSpans[i]._fckplaceholder == name )
			return true ;
	}

	return false ;
}

if ( FCKBrowserInfo.IsIE )
{
	FCKsuggestfields.Redraw = function()
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
				oRange.pasteHTML( '<img style="color: #000000; background-color: #ffff00" contenteditable="false" _fckplaceholder="' + sName + '">' + aPlaholders[i] + '</img>' ) ;
			}
		}
	}
}
else
{
	FCKsuggestfields.Redraw = function()
	{
		if ( FCK.EditMode != FCK_EDITMODE_WYSIWYG )
			return ;

		var oInteractor = FCK.EditorDocument.createTreeWalker( FCK.EditorDocument.body, NodeFilter.SHOW_TEXT, FCKsuggestfields._AcceptNode, true ) ;

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

						var oSpan = FCK.EditorDocument.createElement( 'input' ) ;
						FCKsuggestfields.SetupSpan( oSpan, sName ) ;

						aNodes[n].parentNode.insertBefore( oSpan, aNodes[n] ) ;
					}
					else
						aNodes[n].parentNode.insertBefore( FCK.EditorDocument.createTextNode( aPieces[i] ) , aNodes[n] ) ;
				}
			}

			aNodes[n].parentNode.removeChild( aNodes[n] ) ;
		}

		FCKsuggestfields._SetupClickListener() ;
	}

	FCKsuggestfields._AcceptNode = function( node )
	{
		if ( /\[\[[^\[\]]+\]\]/.test( node.nodeValue ) )
			return NodeFilter.FILTER_ACCEPT ;
		else
			return NodeFilter.FILTER_SKIP ;
	}
}

FCK.Events.AttachEvent( 'OnAfterSetHTML', FCKsuggestfields.Redraw ) ;

// We must process the img tags to replace then with the real resulting value of the placeholder.
FCKXHtml.TagProcessors['input'] = function( node, htmlNode )
{
	if ( htmlNode._fckplaceholder )
		node = FCKXHtml.XML.createTextNode( '[[' + htmlNode._fckplaceholder + ']]' ) ;
	else
		FCKXHtml._AppendChildNodes( node, htmlNode, false ) ;

	return node ;
}
