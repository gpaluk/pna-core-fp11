/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna
{
	import io.plugin.core.interfaces.IEquatable;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Color implements IEquatable 
	{
		
		private var mR: Number;
		private var mG: Number;
		private var mB: Number;
		private var mA: Number;
		
		public const opaqueMask: uint = 0xffffff00;
		
		public function Color( r: Number = 1, g: Number = 1, b: Number = 1, a: Number = 1 ) 
		{
			mR = r;
			mG = g;
			mB = b;
			mA = a;
		}
		
		public function get packedValue(): uint
		{
			return uint( ( packFloat( r ) << 24 ) | ( packFloat( g ) << 16 ) | ( packFloat( b ) << 8 ) | packFloat( a ) );
		}
		
		public function get r(): Number
		{
			return mR;
		}
		
		public function set r( value: Number ): void
		{
			mR = value;
		}
		
		public function get g(): Number
		{
			return mG;
		}
		
		public function set g( value: Number ): void
		{
			mG = value;
		}
		
		public function get b(): Number
		{
			return mB;
		}
		
		public function set b( value: Number ): void
		{
			mB = value;
		}
		
		public function get a(): Number
		{
			return mA;
		}
		
		public function set a( value: Number ): void
		{
			mA = value;
		}
		
		private static function packFloat( v: Number ): uint
		{
			v *= 255;
			if ( v < 0 )
			{
				v = 0
			}
			else if ( v > 255 )
			{
				v = 255;
			}
			
			return uint( Math.round( v ) );
		}
		
		public function equals( o: Object ): Boolean
		{
			if ( ( o is Color ) )
			{
				return o.packedValue == packedValue;
			}
			return false;
		}
		
		public function toString(): String
		{
			return "[object Color] ( r: " + r.toFixed( 7 ) + ", g: " + g.toFixed( 7 ) + ", b: " + b.toFixed( 7 ) + ", a: " + a.toFixed( 7 ) + " )";
		}
		
	}

}