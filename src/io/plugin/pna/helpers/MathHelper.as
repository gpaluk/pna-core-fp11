/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.helpers
{
	
	/**
	 * Math helper class
	 * 
	 * @author Gary Paluk
	 */
	public class MathHelper 
	{
		
		/**
		 * Returns the Cartesian coordinate for one axis of a point that is defined by a given triangle and two normalized barycentric (areal) coordinates.
		 * 
		 * @param	value1	The coordinate on one axis of vertex 1 of the defining triangle.
		 * @param	value2	The coordinate on the same axis of vertex 2 of the defining triangle.
		 * @param	value3	The coordinate on the same axis of vertex 3 of the defining triangle.
		 * @param	amount1	The normalized barycentric (areal) coordinate b2, equal to the weighting factor for vertex 2, the coordinate of which is specified in value2.
		 * @param	amount2	The normalized barycentric (areal) coordinate b3, equal to the weighting factor for vertex 3, the coordinate of which is specified in value3.
		 * 
		 * @return	Cartesian coordinate of the specified point with respect to the axis being used.
		 */
		public static function barycentric( value1: Number, value2: Number, value3: Number, amount1: Number, amount2: Number ): Number
		{
			return ((value1 + (amount1 * (value2 - value1))) + (amount2 * (value3 - value1)));
		}
		
		/**
		 * Performs a Catmull-Rom interpolation using the specified positions.
		 * 
		 * @param	value1	The first position in the interpolation.
		 * @param	value2	The second position in the interpolation.
		 * @param	value3	The third position in the interpolation.
		 * @param	value4	The fourth position in the interpolation.
		 * @param	ammount	Weighting factor.
		 * 
		 * @return	A position that is the result of the Catmull-Rom interpolation.
		 */
		public static function catmullRom( value1: Number, value2: Number, value3: Number, value4: Number, amount: Number ): Number
		{
			var num: Number = amount * amount;
			var num2: Number = amount * num;
			
			return (0.5 * ((((2 * value2) + ((-value1 + value3) * amount)) + (((((2 * value1) - (5 * value2)) + (4 * value3)) - value4) * num)) + ((((-value1 + (3 * value2)) - (3 * value3)) + value4) * num2)));
		}
		
		/**
		 * Restricts a value to be within a specified range.
		 * 
		 * @param	value	The value to clamp.
		 * @param	min		The minimum value. If value is less than min, min will be returned.
		 * @param	max		The maximum value. If value is greater than max, max will be returned.
		 * 
		 * @return	The clamped value.
		 */
		public static function clamp( value: Number, min: Number, max: Number ): Number
		{
			if ( value < min )
			{
				value = min;
			}
			else if ( value > max )
			{
				value = max;
			}
			
			return value;
		}
		
		/**
		 * Calculates the absolute value of the difference of two values.
		 * 
		 * @param	value1	Source value.
		 * @param	value2	Source value.
		 * 
		 * @return	Distance between the two values.
		 */
		public static function distance( value1: Number, value2: Number ): Number
		{
			return Math.abs( value1 - value2 );
		}
		
		/**
		 * Performs a Hermite spline interpolation.
		 * 
		 * @param	value1		Source position.
		 * @param	tangent1	Source tangent.
		 * @param	value2		Source position.
		 * @param	tangent2	Source tangent.
		 * @param	amount		Weighting factor.
		 * 
		 * @return	The result of the Hermite spline interpolation.
		 */
		public static function hermite( value1: Number, tangent1: Number, value2:Number, tangent2: Number, amount: Number ): Number
		{
			var num3: Number = amount;
			var num: Number = num3 * num3;
			var num2: Number = num3 * num;
			var num7: Number = ((2 * num2) - (3 * num)) + 1;
			var num6: Number = (-2 * num2) + (3 * num);
			var num5: Number = (num2 - (2 * num)) + num3;
			var num4: Number = num2 - num;
			
			return ((((value1 * num7) + (value2 * num6)) + (tangent1 * num5)) + (tangent2 * num4));
		}
		
		/**
		 * Linearly interpolates between two values.
		 * 
		 * @param	value1	Source value.
		 * @param	value2	Source value.
		 * @param	amount	Value between 0 and 1 indicating the weight of value2.
		 * 
		 * @return	Interpolated value.
		 */
		public static function lerp( value1: Number, value2: Number, amount: Number ): Number
		{
			return (value1 + ((value2 - value1) * amount));
		}
		
		/**
		 * Interpolates between two values using a cubic equation.
		 * 
		 * @param	value1	Source value.
		 * @param	value2	Source value.
		 * @param	amount	Weighting value.
		 * 
		 * @return	Interpolated value.
		 */
		public static function smoothStep( value1: Number, value2: Number, amount: Number ): Number
		{
			var num: Number = clamp(amount, 0, 1);
			
			return lerp( value1, value2, (num * num) * (3 - (2 * num)));
		}
		
		/**
		 * Converts radians to degrees.
		 * 
		 * @param	radians		The angle in radians.
		 * @return	The angle in degrees.
		 */
		public static function toDegrees( radians:Number ): Number
		{
			return ( radians * ( 180/Math.PI ) );
		}
		
		/**
		 * Converts degrees to radians.
		 * 
		 * @param	degrees		The angle in degrees.
		 * @return	The angle in radians.
		 */
		public static function toRadians( degrees: Number ): Number
		{
			return ( degrees * ( Math.PI / 180 ) );
		}
		
	}

}