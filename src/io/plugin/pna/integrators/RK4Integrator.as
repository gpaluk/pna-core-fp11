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
	import io.plugin.math.algebra.HQuaternion;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class RK4Integrator implements IIntegrator
	{
		
		public function interpolate( previous: RK4State, current: RK4State, alpha: Number ): RK4State
		{
			
			var state: RK4State = current;
			
			var oneMinusAlpha: Number = ( 1 - alpha );
			
			
			// update position
			var previousPositionScaled: AVector = previous.position.scale( oneMinusAlpha );
			var currentPositionScaled: AVector = current.position.scale( alpha );
			state.position = previousPositionScaled.add( currentPositionScaled );
			
			// update momentum
			var previousMomentumScaled: AVector = previous.momentum.scale( oneMinusAlpha );
			var currentMomentumScaled: AVector = current.momentum.scale( alpha );
			state.momentum = previousMomentumScaled.add( currentMomentumScaled );
			
			// update orientation
			var previousOrientationScaled: HQuaternion = previous.orientation.scale( oneMinusAlpha );
			var currentOrientationScaled: HQuaternion = current.orientation.scale( alpha );
			state.orientation = previousOrientationScaled.add( currentOrientationScaled );
			
			// update angularMomentum
			var previousAngularMomentumScaled: AVector = previous.angularMomentum.scale( oneMinusAlpha );
			var currentAngularMomentumScaled: AVector = current.angularMomentum.scale( alpha );
			state.angularMomentum = previousAngularMomentumScaled.add( currentAngularMomentumScaled );
			
			// recalculate the new state values
			state.recalculate();
			
			return state;
			
		}
		
		public function evaluate( state: RK4State, t: Number, dt: Number = 0, derivative: Deritative = null ): Deritative
		{
			var output:Deritative = new Deritative();
			
			if ( !derivative )
			{
				output.velocity = state.velocity;
				output.spin = state.spin
				output.force = updateForce( state, t );
				output.toque = updateTorque( state, t );
			}
			else
			{
				state.position.addEq( derivative.velocity.scale( dt ) );
				state.momentum.addEq( derivative.force.scale( dt ) );
				state.orientation.addEq( derivative.spin.scale( dt ) );
				state.angularMomentum.addEq( derivative.toque.scale( dt ) );
				
				state.recalculate();
				
				output.velocity = state.velocity;
				output.spin = state.spin;
				output.force = updateForce( state, t + dt );
				output.toque = updateTorque( state, t + dt );
			}
			
			return output;
		}
		
		protected function updateForce( state: RK4State, t: Number ): AVector
		{
			
			//var force: AVector = new AVector()
			// attract toward the origin
			
			var force: AVector = state.position.scale( -10 );
			
			force.x += 10 * Math.sin( t * 0.9 + 0.5 );
			force.y += 11 * Math.sin( t * 0.5 + 0.4 );
			force.z += 12 * Math.sin( t * 0.7 + 0.9 );
			
			//TODO Look at position data (bug for sure)
			trace( ">>>>>>> " + state.position );
			
			return force;
		}
		
		protected function updateTorque( state: RK4State, t: Number ): AVector
		{
			
			var torque: AVector = new AVector( );
			torque.x = 1.0 * Math.sin( t * 0.9 + 0.5 );
			torque.y = 1.1 * Math.sin( t * 0.5 + 0.4 );
			torque.z = 1.2 * Math.sin( t * 0.7 + 0.9 );
			
			torque.subtractEq( state.angularVelocity.scale( 0.2 ) );
			
			return torque;
		}
		
		public function integrate( state:RK4State, t: Number, dt: Number ): void
		{
			
			var oneDivSix: Number = (1 / 6);
			var oneDivSixMulDT: Number = oneDivSix * dt;
			
			var a: Deritative = evaluate( state, t );
			var b: Deritative = evaluate( state, t, dt * 0.5, a );
			var c: Deritative = evaluate( state, t, dt * 0.5, b );
			var d: Deritative = evaluate( state, t, dt, c );
			
			//FIXME (PROBABLY SOMEWHERE AROUND HERE)
			
			/*
			// state position
			var bVelAddCVel: AVector = b.velocity.add( c.velocity );
			var twoBVelAddCVel:AVector = bVelAddCVel.scale( 2 );
			var twoBVelAddCVelAddAVelAddDVel: AVector = twoBVelAddCVel.add( a.velocity ).add( d.velocity );
			state.position.addEq( twoBVelAddCVelAddAVelAddDVel.scale( oneDivSixMulDT ) );
			
			// state momentum
			var bForceAddCForce: AVector = b.force.add( c.force );
			var twoBForceAddCForce:AVector = bForceAddCForce.scale( 2 );
			var twoBForceAddCForceAddAForceAddDForce: AVector = twoBForceAddCForce.add( a.force ).add( d.force );
			state.momentum.addEq( twoBForceAddCForceAddAForceAddDForce.scale( oneDivSixMulDT ) );
			
			// state orientation
			var bOrientAddCOrient: HQuaternion = b.spin.add( c.spin );
			var twoBOrientAddCOrient:HQuaternion = bOrientAddCOrient.scale( 2 );
			var twoBOrientAddCOrientAddAOrientAddDOrient: HQuaternion = twoBOrientAddCOrient.add( a.spin ).add( d.spin );
			state.spin.addEq( twoBOrientAddCOrientAddAOrientAddDOrient.scale( oneDivSixMulDT ) );
			
			// state angular orientation
			var bAngOriAddCAngOri: AVector = b.toque.add( c.toque );
			var twoBAngOriAddCAngOri:AVector = bAngOriAddCAngOri.scale( 2 );
			var twoBAngOriAddCAngOriAddAAngOriAddDAngOri: AVector = twoBAngOriAddCAngOri.add( a.toque ).add( d.toque );
			state.angularMomentum.addEq( twoBAngOriAddCAngOriAddAAngOriAddDAngOri.scale( oneDivSixMulDT ) );
			*/
			
			state.recalculate();
			
		}
	}

}

import io.plugin.math.algebra.AVector;
import io.plugin.math.algebra.HQuaternion;

internal class Deritative
{
	public var velocity: AVector = new AVector();
	public var force: AVector = new AVector();
	public var spin: HQuaternion = new HQuaternion();
	public var toque: AVector = new AVector();
}