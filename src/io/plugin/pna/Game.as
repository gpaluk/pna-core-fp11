/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna 
{
	import flash.display.Sprite;
	import io.plugin.core.errors.UnsupportedOperationError;
	import io.plugin.core.interfaces.IDisposable;
	//import io.plugin.core.TimeSpan;
	import io.plugin.pna.content.ContentManager;
	import io.plugin.pna.gfx.GraphicsDevice;
	import org.osflash.signals.Signal;
	import io.plugin.pna.loop.GameLoop;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Game implements IDisposable
	{
		
		public function Game() 
		{
			content = new ContentManager( services );
			
		}
		
		
		//{region Game Startup
		public function run(): void
		{
			if ( graphicsDeviceManager == null )
			{
				throw new Error( "Game requires that a GraphicsDeviceManager is created before calling run" );
			}
			//graphicsDeviceManager
			
			gameLoop.onDraw.add( draw );
			gameLoop.onUpdate.add( update );
			doStartup();
		}
		//}
		
		//{ region Disposal
		public var onDispose: Signal = new Signal( );
		private var mIsDisposed: Boolean = false;
		public function dispose(): void
		{
			
			// TODO dispose components
			
			var servicesToDispose:Vector.<IDisposable> = services.getAllServices() as Vector.<IDisposable>;
			for each ( var service: IDisposable in servicesToDispose )
			{
				service.dispose();
			}
			
			unloadContent();
			if ( onDispose != null )
			{
				onDispose.dispatch( this );
			}
			
			mIsDisposed = true;
		}
		
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		//}
		
		//{ region Components and Services
		
		private var mServices: GameServiceContainer = new GameServiceContainer();
		public function get services(): GameServiceContainer
		{
			return mServices;
		}
		
		//TODO add components collection
		
		//}
		
		//{ region Graphics Device Manager (use direct hookup)
		
		private var mGraphicsDeviceManager: GraphicsDeviceManager = null;
		
		/**
		 * Internal use only
		 */
		public function get graphicsDeviceManager(): GraphicsDeviceManager
		{
			return mGraphicsDeviceManager;
		}
		
		/**
		 * Internal use only
		 */
		public function set graphicsDeviceManager( value: GraphicsDeviceManager): void
		{
			mGraphicsDeviceManager = value;
		}
		
		
		public function get graphicsDevice(): GraphicsDevice
		{
			if ( graphicsDeviceManager == null )
			{
				throw new Error( "Cannot access the GraphicsDevice without a graphics device service." );
			}
			return graphicsDeviceManager.graphicsDevice;
		}
		
		//}
		
		//{ region Activation
		private var mIsActive: Boolean = true;
		
		public function get isActive(): Boolean
		{
			return mIsActive;
		}
		
		protected function set isActive( value: Boolean ): void
		{
			if ( mIsActive != value )
			{
				mIsActive = value;
				if ( mIsActive )
				{
					onActivated( this );
				}
				else
				{
					onDeactivated( this );
				}
			}
		}
		
		public var activated: Signal = new Signal();
		public var deactivated: Signal = new Signal();
		
		protected function onActivated( sender: Object ): void
		{
			if ( activated != null )
			{
				activated.dispatch( sender );
			}
		}
		
		protected function onDeactivated( sender: Object ): void
		{
			if ( deactivated != null )
			{
				deactivated.dispatch( sender );
			}
		}
		
		//}
		
		protected function doStartup(): void
		{
			loadContent();
			
			initialize();
			beginRun();
		}
		
		//{ region Exiting
		public var exiting: Signal = new Signal();
		protected function doTermination(): void
		{
			onExiting( this );
			endRun();
			dispose();
		}
		
		protected function onExiting( sender: Object ): void
		{
			if ( exiting != null )
			{
				exiting.dispatch( sender );
			}
		}
		//}
		
		//{ region Content
		private var mContent: ContentManager = null;
		
		public function get content(): ContentManager
		{
			return mContent;
		}
		
		/**
		 * internal use only
		 */
		public function set content( value: ContentManager ): void
		{
			mContent = value;
		}
		
		protected function loadContent(): void
		{
			// virtual method
		}
		
		protected function unloadContent(): void
		{
			// virtual method
		}
		//}
		
		//{ region Initialization
		protected function initialize(): void
		{
			// TODO components.initialize();
			
			if ( graphicsDevice != null )
			{
				loadContent();
			}
		}
		//}
		
		//{ region Running
		protected function beginRun(): void { };
		protected function endRun(): void { };
		
		protected function update( t: Number, dt: Number ): void
		{
			// TODO update components
			//components.update( gameTime );
		}
		//}
		
		//{ region Drawing
		protected function beginDraw(): Boolean
		{
			if ( graphicsDeviceManager != null )
			{
				return graphicsDeviceManager.beginDraw();
			}
			else
			{
				return true;
			}
		}
		
		protected function draw( t: Number ): void
		{
			// TODO draw the components
			
			// components.draw( gameTime );
		}
		
		protected function endDraw(): void
		{
			if ( graphicsDeviceManager != null )
			{
				graphicsDeviceManager.endDraw();
			}
		}
		
		
		// TODO check the necessity for suppressing draw frames
		/*
		private var mSuppressDrawCurrentFrame: Boolean;
		public function suppressDraw(): void
		{
			mSuppressDrawCurrentFrame = true;
		}
		
		protected function doDraw( gameTime: int ): void
		{
			if ( mSuppressDrawCurrentFrame )
			{
				mSuppressDrawCurrentFrame = false;
				return;
			}
			
			if ( beginDraw() )
			{
				draw( gameTime );
				endDraw();
			}
		}
		*/
		//}
			
		//{ region Timimg
		// TODO Loop region
		protected var gameLoop: GameLoop = new GameLoop( 20 );
		
		/*
		public function reset(): void
		{
			gameLoop.reset();
		}
		*/
		
		//}
		
		//{ region Miscelaneous
		//TODO check out stage reference and mouse show
		//}
		
	}

}