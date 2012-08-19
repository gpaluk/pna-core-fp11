/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.gfx 
{
	import flash.geom.Point;
	import io.plugin.core.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class SpriteBatch implements IDisplosable
	{
		
		private var mGraphicsDevice: GraphicsDevice;
		
		public function SpriteBatch( graphicsDevice: GraphicsDevice ) 
		{
			mGraphicsDevice = graphicsDevice;
		}
		
		
		public function get graphicsDevice(): GraphicsDevice
		{
			return mGraphicsDevice;
		}
		
		//TODO add sortmode, states, effect and transform
		public function begin(): void
		{
			throw new Error( "SpriteBatch::begin not yet implemented" );
		}
		
		//TODO draw(.......
		public function draw(): void
		{
			throw new Error( "Not implemented" );
		}
		
		public function end(): void
		{
			
		}
		
		private function set graphicsDevice( value: GraphicsDevice ): void
		{
			mGraphicsDevice = value;
		}
		
		public function dispose(): void
		{
			throw new Error("Not implemented");
		}
	}

}

import flash.geom.Point;
internal class SpriteVertex
	{
		public var position: Point;
		public var uv: Point;
	}