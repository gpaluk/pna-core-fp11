/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.gfx 
{
	import flash.display3D.Context3D;
	import io.plugin.pna.Color;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Stage3DGraphicsContext implements IGraphic
	{
		
		public var mContext: Context3D;
		
		public function Stage3DGraphicsContext( context: Context3D ) 
		{
			mContext = context;
		}
		
		public function clear( color: Color ): void
		{
			mContext.clear( color.r,
							color.g,
							color.b,
							color.a );
		}
		
	}

}