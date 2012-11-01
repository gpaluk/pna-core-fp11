package io.plugin.pna.utils.mappers 
{
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class NativeTextKeyMapper extends KeyMapper
	{
		
		protected var _nativeText: NativeText;
		
		/**
		 * For the StageText-based skins, when only some keys are pressed and released. 
		 * ( NOTE: For safety, use TextFieldKeyMapper with Flex Spark or regular flash.text.TextField )
		 * 
		 * For the TextField-based skins, when all keys are pressed and released.
		 * 
		 * These events are not dispatched for all keys on all devices. Do not rely on
		 * these methods for capturing key input with soft keyboards unless you are using
		 * the TestField-based skins for controls that raise the keyboard.
		 * 
		 * @param	nativeText	A NativeText Object
		 */
		public function NativeTextKeyMapper(nativeText:NativeText, removeStageListsners:Boolean = false ) 
		{
			super( nativeText.stage );
			
			_nativeText = nativeText;
			_nativeText.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_nativeText.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
			if ( removeStageListeners )
			{
				textField.stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
				textField.stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void 
		{
			_nativeText.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_nativeText.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			_nativeText = null;
			super.dispose();
		}
	}

}