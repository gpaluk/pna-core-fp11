/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.utils.mappers 
{
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import io.plugin.core.interfaces.IDisposable;
	
	/**
	 * The KeyMapper utility class helps when binding methods to keyDown and keyUp events. The additional
	 * of chaining is supported but optional.
	 * 
	 * @usage
	 * <code>
	 * var keyMap: KeyMapper = new KeyMapper( stage );
	 * keyMap.addKeyDown( Keyboard.D, true, callBack1 )
	 * 		 .addKeyUp( Keyboard.D, callBack2 )
	 * 		 .addKeyDown( Keyboard.E, false, callBack3, callBack4, callBack5 )
	 * 		 .addKeyUp( Keyboard.E, callBack6 );
	 * </code>
	 * 
	 * @author Gary Paluk
	 */
	public class KeyMapper implements IDisposable
	{
		
		/**
		 * A reference to the stage
		 */
		protected var _stage: Stage;
		
		/**
		 * A Dictionary where the key is the keyCode and contents are the list of assiciated methods
		 * to be called on the keyDown Event.
		 */
		protected var _keyDownMap: Dictionary;
		
		/**
		 * A Dictionary where the key is the keyCode and contents are the list of assiciated methods
		 * to be called on the keyUp Event.
		 */
		protected var _keyUpMap: Dictionary;
		
		/**
		 * A Dictioary that holds Boolean values that indicates whether a method should be called
		 * iterativly when a key is held down.
		 */
		protected var _keyRepeat: Dictionary;
		
		/**
		 * A Dictionary the contains the pressed or released states of the keys
		 */
		protected var _keyStates:Dictionary;
		
		
		protected var _callbackDownParams: Dictionary;
		protected var _callbackUpParams: Dictionary;
		
		/**
		 * A Boolean indicating if the Object has been disposed by calling the dispose() method.
		 */
		protected var _isDisposed: Boolean;
		
		/**
		 * Creates a new KeyMapper object
		 * 
		 * @param	stage	The stage context object
		 */
		public function KeyMapper( stage: Stage ) 
		{
			_stage = stage;
			
			_keyDownMap = new Dictionary();
			_keyUpMap = new Dictionary();
			_keyRepeat = new Dictionary();
			_keyStates = new Dictionary();
			_callbackDownParams = new Dictionary();
			_callbackUpParams = new Dictionary();
			
			_stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		/**
		 * Maps a keyDown event to a single method or list of methods. If the autoRepeat parameter
		 * is set to TRUE, the BIOS keyboard repeat will casue the callback method to be called on
		 * each update. When the autoRepeat parameter is set to FALSE, the callback will be called
		 * only once, until the key is released.
		 * 
		 * @param	keyCode		The keycode to map, such as Keyboard.ENTER or Keyboard.B
		 * @param	autoRepeat	Callback executed on each keyboard BIOS update when TRUE, update only occurs once when FALSE
		 * @param	rest		A single method or list of methods to call
		 * 
		 * @return	This <code>KeyMapper</code> Object
		 */
		public function addKeyDown( keyCode: uint, autoRepeat: Boolean = false, callback: Function = null, ...rest ): KeyMapper
		{
			_keyDownMap[ keyCode ] = callback;
			_keyRepeat[ keyCode ] = autoRepeat;
			
			if ( rest.length > 0 )
			{
				_callbackDownParams[ keyCode ] = rest;
			}
			
			return this;
		}
		
		/**
		 * Removes a keyDown listener from a given key.
		 * 
		 * @param	keyCode	The keyCode to be removed
		 * 
		 * @return	this Object
		 */
		public function removeKeyDown( keyCode: uint ): KeyMapper
		{
			if ( _keyDownMap[ keyCode ] )
			{
				_keyDownMap[ keyCode ] = null;
				_keyRepeat[ keyCode ] = null;
				_keyStates[ keyCode ] = null;
				_callbackDownParams[ keyCode ] = null;
			}
			
			return this;
		}
		
		/**
		 * Handles the flash KeyboardEvent and iterativly calls the list of key associated methods.
		 * 
		 * @param	e	The KeyboardEvent passed by the event listener
		 */
		protected function onKeyDown( e: KeyboardEvent ): void
		{
			if ( !_keyDownMap[ e.keyCode ] )
			{
				return;
			}
			
			if ( _keyStates[ e.keyCode ] == true && _keyRepeat[ e.keyCode ] == false )
			{
				return;
			}
			
			if ( _callbackDownParams[ e.keyCode ] )
			{
				
				_keyDownMap[ e.keyCode ]( _callbackDownParams[ e.keyCode ] );
			}
			else
			{
				_keyDownMap[ e.keyCode ]();
			}
			
			_keyStates[ e.keyCode ] = true;
		}
		
		/**
		 * Maps a keyUp event to a single method or list of methods.
		 * 
		 * @param	keyCode	The keycode to map, such as Keyboard.ENTER or Keyboard.B
		 * @param	...rest	A single method or list of methods to call
		 * 
		 * @return	this Object
		 */
		public function addKeyUp( keyCode: uint, callback: Function, ...rest ): KeyMapper
		{
			
			_keyUpMap[ keyCode ] = callback;
			
			if ( rest.length > 0 )
			{
				_callbackUpParams[ keyCode ] = rest;
			}
			
			return this;
		}
		
		/**
		 * Removes a keyUp listener from a given key.
		 * 
		 * @param	keyCode	The keyCode to be removed
		 * 
		 * @return	this Object
		 */
		public function removeKeyUp( keyCode: uint ): KeyMapper
		{
			if ( _keyUpMap[ keyCode ] )
			{
				_keyUpMap[ keyCode ] = null;
				_callbackUpParams[ keyCode ] = null;
			}
			
			return this;
		}
		
		/**
		 * Handles the flash KeyboardEvent and iterativly calls the list of key associated methods.
		 * 
		 * @param	e	The KeyboardEvent passed by the event listener
		 */
		protected function onKeyUp( e: KeyboardEvent ): void
		{
			_keyStates[ e.keyCode ] = false;
			
			if ( !_keyUpMap[ e.keyCode ] )
			{
				return;
			}
			
			if ( _callbackUpParams[ e.keyCode ] )
			{
				_keyUpMap[ e.keyCode ]( _callbackUpParams[ e.keyCode ] );
			}
			else
			{
				_keyUpMap[ e.keyCode ]();
			}
			
			
			
		}
		
		/**
		 * Removes all keyDown event listeners
		 * 
		 * @return this Object
		 */
		public function removeKeyDownAll(): KeyMapper
		{
			for( var keyCode: String in _keyDownMap )
			{
				removeKeyDown( uint( keyCode ) )
			}
			
			return this;
		}
		
		/**
		 * Removes all keyUp event listeners
		 * 
		 * @return this Object
		 */
		public function removeKeyUpAll(): KeyMapper
		{
			for( var keyCode: String in _keyUpMap )
			{
				removeKeyUp( uint( keyCode ) );
			}
			
			return this;
		}
		
		/**
		 * Removes all keyUp and keyDown event listeners
		 * 
		 * @return this object
		 */
		public function removeAll(): KeyMapper
		{
			removeKeyDownAll();
			removeKeyUpAll();
			
			return this;
		}
		
		/**
		 * Removes all events associated with a key
		 * 
		 * @param	keyCode	The keyCode of the key to remove
		 * 
		 * @return	this Object
		 */
		public function removeKey( keyCode: uint ): KeyMapper
		{
			removeKeyDown( keyCode );
			removeKeyUp( keyCode );
			
			return this;
		}
		
		/**
		 * Returns the state of the key, TRUE if pressed, otherwise FALSE
		 * 
		 * @param	keyCode	The keyCode of the key to check
		 * 
		 * @return	The state of the key, TRUE if pressed, otherwise FALSE
		 */
		public function isKeyDown( keyCode: uint ): Boolean
		{
			if ( _keyDownMap[ keyCode ] )
			{
				return _keyStates[ keyCode ];
			}
			throw new Error( "You must apply the addKeyDown() method to track key states. KeyMapper::isKeyDown()" );
		}
		
		/**
		 * Disposes of this Object ready for the GC
		 */
		public function dispose(): void
		{
			removeKeyDownAll();
			removeKeyUpAll();
			
			_stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
			_isDisposed = true;
		}
		
		/**
		 * A Boolean that indicates if this <code>KeyMapper</code> Object has been disposed of by calling the dispose() method
		 */
		public function get isDisposed():Boolean 
		{
			return _isDisposed;
		}
		
	}

}