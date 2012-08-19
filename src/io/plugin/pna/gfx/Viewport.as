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
	 * @author Gary Paluk
	 */
	public class Viewport 
	{
		
		private var mX: int;
		private var mY: int;
		private var mWidth: int;
		private var mHeight: int;
		
		public function Viewport( bounds: Rectangle ) 
		{
			mX = bounds.x;
			mY = bounds.y;
			mWidth = bounds.width;
			mHeight = bounds.height;
		}
		
		public function get bounds(): Rectangle
		{
			return new Rectangle( mX, mY, mWidth, mHeight );
		}
		
		public function set bounds( value: Rectangle ): void
		{
			mX = bounds.x;
			mY = bounds.y;
			mWidth = bounds.width;
			mHeight = bounds.height;
		}
		
		public function get aspectRatio(): Number
		{
			return mHeight != 0 ? (mWidth / mHeight) : 0;
		}
		
	}

}