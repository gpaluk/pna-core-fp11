/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.components 
{
	import io.plugin.pna.Game;
	import io.plugin.pna.IUpdateable;
	import io.plugin.core.interfaces.IDisposable;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class GameComponent implements IUpdateable, IGameComponent, IDisposable
	{
		
		private var mGame: Game;
		private var mIsDisposed: Boolean;
		private var mEnabled: Boolean;
		private var mUpdateOrder: int;
		
		private var mOnEnabledChanged: Signal;
		private var mOnUpdateOrderChanged: Signal;
		
		
		public function GameComponent( game: Game ) 
		{
			mGame = game;
			mEnabled = true;
			mUpdateOrder = 0;
			
			mOnEnabledChanged = new Signal( Object, Array );
			mOnUpdateOrderChanged = new Signal( Object, Array );
		}
		
		public function get game(): Game
		{
			return mGame;
		}
		
		public function set game( value: Game ): void
		{
			mGame = game;
		}
		
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		
		public function dispose(): void
		{
			// TODO dispose of references
			onEnabledChanged.removeAll();
			mOnEnabledChanged = null;
			
			onUpdateOrderChanged.removeAll();
			mOnUpdateOrderChanged = null;
			
			mIsDisposed = true;
		}
		
		protected function handleOnEnabled( sender: Object, args: Array ): void
		{
			if ( onEnabledChanged != null )
			{
				onEnabledChanged.dispatch( sender, args );
			}
		}
		
		public function get onEnabledChanged(): Signal
		{
			return mOnEnabledChanged;
		}
		
		public function get enabled(): Boolean
		{
			return mEnabled;
		}
		
		
		public function set enabled( value: Boolean ): void
		{
			if ( mEnabled != value )
			{
				mEnabled = value;
				handleOnEnabled( this, [] );
			}
		}
		
		protected function handleOnUpdateOrderChanged( sender: Object, args: Array ): void
		{
			if ( onUpdateOrderChanged != null )
			{
				onUpdateOrderChanged.dispatch( sender, args );
			}
		}
		
		private function get onUpdateOrderChanged(): Signal
		{
			return mOnUpdateOrderChanged;
		}
		
		
		public function get updateOrder(): int
		{
			return mUpdateOrder;
		}
		
		public function set updateOrder( value: int ): void
		{
			if ( mUpdateOrder != value )
			{
				mUpdateOrder = value;
				handleOnUpdateOrderChanged( this, [] );
			}
		}
		
		public function initialize(): void
		{
			// virtual method
		}
		
		
		public function update( gameTime: int ): void
		{
			// vitual method
		}
		
	}

}