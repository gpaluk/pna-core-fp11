/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.gfx 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class PresentationParameters 
	{
		
		private var mBackBufferWidth: int;
		private var mBackBufferHeight: int;
		private var mBounds: Rectangle;
		private var mIsFullScreen: Boolean;
		private var mOrientation: int;
		
		public function PresentationParameters() 
		{
			
		}
		
		public function get backBufferWidth(): int
		{
			return mBackBufferWidth;
		}
		
		public function set backBufferWidth( value: int ): void
		{
			mBackBufferWidth = value;
		}
		
		public function get backBufferHeight(): int
		{
			return mBackBufferHeight;
		}
		
		public function set backBufferHeight( value: int ): void
		{
			mBackBufferHeight = value;
		}
		
		public function get bounds(): Rectangle
		{
			return new Rectangle( 0, 0, mBackBufferWidth, mBackBufferHeight );
		}
		
		public function get isFullScreen(): Boolean
		{
			return mIsFullScreen;
		}
		
		public function set isFullScreen( value: Boolean ): void
		{
			mIsFullScreen = value;
		}
		
	}

}