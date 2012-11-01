package io.plugin.pna.utils.mappers 
{
	import flash.display.InteractiveObject;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class TextFieldKeyMapper extends KeyMapper 
	{
		
		protected var _textField: InteractiveObject;
		
		/**
		 * Send your textfield as an InteractiveObject so that one can listen to any object
		 * that might dispatch a Keyboard event, including components such as the flex 
		 * spark components etc.
		 * 
		 * @param	textField
		 */
		public function TextFieldKeyMapper( textField: InteractiveObject, removeStageListeners: Boolean = false ) 
		{
			super( textField.stage );
			
			_textField = textField;
			_textField.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_textField.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
			if ( removeStageListeners )
			{
				textField.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown );
				textField.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void 
		{
			_textField.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_textField.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			_textField = null;
			super.dispose();
		}
		
	}

}