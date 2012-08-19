/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna 
{
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.pna.gfx.GraphicsDevice;
	import io.plugin.pna.gfx.IGraphicsContext;
	import io.plugin.pna.gfx.IGraphicsDeviceService;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class GraphicsDeviceManager implements IGraphicsDeviceManager, IGraphicsDeviceService, IDisposable 
	{
		
		public static const DEFAULT_BACK_BUFFER_WIDTH: int = 800;
		public static const DEFAULT_BACK_BUFFER_HEIGHT: int = 600;
		
		//{ region Configuration
		private var mIsFullScreen: Boolean;
		private var mPreferedBackBufferWidth: int;
		private var mPreferedBackBufferHeight: int;
		private var mSupportedOrientations: int;
		
		private var mIsDisposed: Boolean = false;
		
		public function get isFullScreen(): Boolean
		{
			return mIsFullScreen;
		}
		
		public function set isFullScreen( value: Boolean ): void
		{
			mIsFullScreen = value;
		}
		
		public function get preferedBackBufferHeight(): int
		{
			return mPreferedBackBufferHeight;
		}
		
		public function set preferedBackBufferHeight( value: int ): void
		{
			mPreferedBackBufferHeight = value;
		}
		
		public function get preferedBackBufferWidth(): int
		{
			return mPreferedBackBufferWidth;
		}
		
		public function set preferedBackBufferWidth( value: int ): void
		{
			mPreferedBackBufferWidth = value;
		}
		
		private function setDefaultProperties(): void
		{
			mIsFullScreen = false;
			preferedBackBufferHeight = DEFAULT_BACK_BUFFER_HEIGHT;
			preferedBackBufferWidth = DEFAULT_BACK_BUFFER_WIDTH;
		}
		//}
		
		//{ region Creation (create link to Game )
		private var mGame: Game;
		
		public function GraphicsDeviceManager( game: Game ) 
		{
			if ( game.services.getService( IGraphicsDeviceService ) != null )
			{
				throw new Error( "Instance of Game already has an IGraphicsDeviceService" );
			}
			
			setDefaultProperties();
			isFullScreen = false; // set this to false and later request to fullscreen mode
			
			// attach the Game
			mGame = game;
			game.services.addService( IGraphicsDeviceManager, this );
			game.services.addService( IGraphicsDeviceService, this );
			
			//TODO graphicsDeviceManager hookup
			game.graphicsDeviceManager = this;
			
		}
		//}
		
		//{ region Disposal
		private var mOnDeviceDisposing: Signal = new Signal();
		
		public function get onDeviceDisposing(): Signal
		{
			return mOnDeviceDisposing;
		}
		
		public function dispose(): void
		{
			if ( mGraphicsDevice )
			{
				mGraphicsDevice.dispose();
				mGraphicsDevice = null;
			}
			if ( mOnDeviceDisposing )
			{
				onDeviceDisposing.dispatch( this, [] );
				onDeviceDisposing.removeAll();
				mOnDeviceDisposing = null;
			}
			
			mIsDisposed = true;
		}
		
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		//}
		
		//{ region Events
		
		// created
		private var mOnDeviceCreated: Signal = new Signal();
		public function get onDeviceCreated(): Signal
		{
			return mOnDeviceCreated;
		}
		
		protected function handleDeviceCreated( sender: Object, args: Array ): void
		{
			if ( mOnDeviceCreated )
			{
				onDeviceCreated.dispatch( sender, args );
			}
		}
		
		// reset
		private var mOnDeviceReset: Signal = new Signal();
		
		public function get onDeviceReset(): Signal
		{
			return mOnDeviceReset;
		}
		
		protected function handleDeviceReset( sender: Object, args: Array ): void
		{
			if ( mOnDeviceReset )
				onDeviceReset.dispatch( sender, args );
		}
		
		// resetting
		private var mOnDeviceResetting: Signal = new Signal();
		
		public function get onDeviceResetting(): Signal
		{
			return mOnDeviceResetting;
		}
		
		protected function handleDeviceResetting( sender: Object, args: Array ): void
		{
			if ( mOnDeviceResetting )
				onDeviceResetting.dispatch( sender, args );
		}
		//}
		
		//{ region Toggle Full Screen
		public function toggleFullScreen(): void
		{
			isFullScreen = !isFullScreen;
			// TODO applyChanges();
		}
		//}
		
		
		
		
		
		// device
		
		protected var mGraphicsDevice: GraphicsDevice;
		
		public function createDevice(): void
		{
			throw new Error( "GraphicsDeviceManager::CreateDevice is not supported." );
		}
		
		public function get graphicsDevice(): GraphicsDevice
		{
			return mGraphicsDevice;
		}
		
		private function set graphicsDevice( value: GraphicsDevice ): void
		{
			mGraphicsDevice = value;
		}
		
		protected function internalDeviceReady( context: IGraphicsContext, height: int, width: int ): void
		{
			mGraphicsDevice = new GraphicsDevice( context );
		}
		
		public function beginDraw(): Boolean
		{
			return true;
		}
		
		public function endDraw(): void
		{
			throw new Error( "Not yet implemented." );
		}
		
		
		
	}

}