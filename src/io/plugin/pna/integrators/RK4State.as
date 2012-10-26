/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.integrators 
{
	import io.plugin.math.algebra.AVector;
	import io.plugin.math.algebra.HMatrix;
	import io.plugin.math.algebra.HQuaternion;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class RK4State implements IState 
	{
		// primary state
		public var position: AVector = new AVector();
		public var momentum: AVector = new AVector();
		public var orientation: HQuaternion = new HQuaternion();
		public var angularMomentum: AVector = new AVector();
		
		// secondary state
		public var velocity: AVector = new AVector();
		public var spin: HQuaternion = new HQuaternion();
		public var angularVelocity: AVector = new AVector();
		public var bodyToWorld: HMatrix = new HMatrix();
		public var worldToBody: HMatrix = new HMatrix();
		
		// constant state
		public var size: Number = 0;
		public var mass: Number = 0;
		public var inverseMass: Number = 0;
		public var inertiaTensor: Number = 0;
		public var inverseInertiaTensor: Number = 0;
		
		public function RK4State() 
		{
		}
		
		public function recalculate(): void
		{
			velocity = momentum.scale( inverseMass );
			angularVelocity = angularMomentum.scale( inverseInertiaTensor );			
			orientation.normalize();
			
			//trace( angularMomentum );
			
			spin = new HQuaternion( 0, angularVelocity.x, angularVelocity.y, angularVelocity.z ).multiply( orientation ).scale( 0.5 );
			
			var translation: HMatrix = new HMatrix()
			translation.translateAVectorEq( position );
			
			bodyToWorld = translation.multiply( orientation.toRotationMatrix() );
			worldToBody = bodyToWorld.inverse();
		}
		
	}

}