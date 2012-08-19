/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.integrators 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class RK4Integrator 
	{
		
		public function interpolate( previous: RK4State, current: RK4State, alpha: Number ): RK4State
		{
			var state: RK4State = new RK4State();
			state.x = current.x * alpha + previous.x * (1 - alpha);
			state.v = current.v * alpha + previous.v * (1 - alpha);
			return state;
		}
		
		public function acceleration( state: RK4State, t: Number ): Number
		{
			var k: Number = 10;
			var b: Number = 1;
			return (-k * state.x - b * state.v);
		}
		
		public function evaluateFirst( initial: RK4State, t: Number ): Deritative
		{
			var output: Deritative = new Deritative();
			output.dx = initial.v;
			output.dv = acceleration( initial, t );
			return output;
		}
		
		public function evaluate( initial: RK4State, t: Number, dt: Number, d: Deritative ): Deritative
		{
			var state: RK4State = new RK4State();
			state.x = initial.x + d.dx * dt;
			state.v = initial.v + d.dv * dt;
			
			var output: Deritative = new Deritative();
			output.dx = state.v;
			output.dv = acceleration(state, t + dt);
			return output;
		}
		
		public function integrate( state: RK4State, t: Number, dt: Number ): void
		{
			var a: Deritative = evaluate(state, t);
			var b: Deritative = evaluate(state, t, dt * 0.5, a);
			var c: Deritative = evaluate(state, t, dt * 0.5, b);
			var d: Deritative = evaluate(state, t, dt, c);
			
			var dxdt: Number = 1 / 6 * (a.dx + 2 * (b.dx + c.dx) + d.dx);
			var dvdt: Number = 1 / 6 * (a.dv + 2 * (b.dv + c.dv) + d.dv);
			
			state.x = state.x + dxdt * dt;
			state.v = state.v + dvdt * dt;
		}
		
	}

}

internal class Deritative
{
	public var dx: Number = 0;
	public var dv: Number = 0;
}