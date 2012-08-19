/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.gfx 
{
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.pna.Color;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class GraphicsDevice implements IDisposable
	{
		
		private var mPresentationParameters: PresentationParameters;
		private var mViewport: Viewport;
		private var mIsDisposed: Boolean;
		private var mGraphicsContext: IGraphicsContext;
		
		public function GraphicsDevice( context: IGraphicsContext ) 
		{
			mGraphicsContext = context;
			mPresentationParameters = new PresentationParameters();
			mViewport = new Viewport( mPresentationParameters.bounds );
			
			mIsDisposed = false;
		}
		
		public function get presentationParameters(): PresentationParameters
		{
			return mPresentationParameters;
		}
		
		public function get viewport(): Viewport
		{
			return mViewport;
		}
		
		public function set viewport( value: Viewport ): void
		{
			mViewport = value;
		}
		
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		
		/**
		 * Internal use only
		 */
		public function set isDisposed( value: Boolean ): void
		{
			mIsDisposed = value;
		}
		
		public function dispose(): void
		{
			isDisposed = true;
		}
		
		public function setupClientProjection(): void
		{
			throw new Error( "Not yet implemented." );
		}
		
		public function get graphicsContext(): IGraphicsContext
		{
			return mGraphicsContext;
		}
		
		public function clear( color: Color ): void
		{
			graphicsContext.clear( color.r, color.g, color.b, color.a );
		}
		
		
	}

}