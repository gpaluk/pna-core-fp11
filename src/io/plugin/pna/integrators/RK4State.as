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
		
		// secondry state
		public var velocity: AVector = new AVector();
		public var spin: HQuaternion = new HQuaternion();
		public var angularVelocity: AVector = new AVector();
		public var bodyToWorld: HMatrix = new HMatrix();
		public var worldToBody: HMatrix = new HMatrix();
		
		// constant state
		public var size: Number = 0;
		public var mass: Number = 0;
		public var inverseMass: Number = 0;
		public var inertialTensor: Number = 0;
		public var inverseInertialTensor: Number = 0;
		
		public function RK4State3D() 
		{
			
		}
		
		public function recalculate(): void
		{
			velocity = momentum.multiply( inverseMass );
			angularVelocity = angularMomentum.multiply( inertialTensor );
			orientation.normalize();
			spin = new HQuaternion( 0, angularVelocity.x * 0.5, angularVelocity.y * 0.5, angularVelocity.z * 0.5 ).multiply( orientation );
			
			var translation: HMatrix = new HMatrix().translateAVectorEq( position );
			bodyToWorld = translation.multiply( orientation.toRotationMatrix() );
			worldToBody = bodyToWorld.inverse();
		}
		
	}

}