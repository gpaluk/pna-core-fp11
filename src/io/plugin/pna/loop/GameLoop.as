/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.loop 
{
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import org.osflash.signals.Signal;
	import io.plugin.core.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class GameLoop implements IDisposable
	{
		
		/**
		 * returned params ( frameTime: int )
		 */
		public var onTick: Signal;
		
		/**
		 * returned params ( time: int, deltaTime: int )
		 */
		public var onUpdate: Signal;
		
		/**
		 * returned params ( mAccumulator: int )
		 */
		public var onDraw: Signal;
		
		/**
		 * returned params ( mAccumulator: int )
		 */
		public var onAlpha: Signal;
		
		/**
		 * returned params NONE
		 */
		public var onReset: Signal;
		
		// timing
		protected var mTimer: Timer;
		protected var mT: int;
		protected var mDT: int;
		protected var mCurrentTime: int;
		protected var mAccumulator: int;
		
		// disposed flag
		protected var mIsDisposed: Boolean;
		
		// loop states
		protected var mUpdateCount: int;
		protected var mDrawCount: int;
		
		protected var mStartTime: int;
		protected var mElapsed: int;
		
		protected var mLastTimePaused:int;
		protected var mTotalTimePaused: int;
		protected var mIsPaused: Boolean;
		
		/**
		 * Creates a game loop used to provide a fixed time step and alpha interpolation
		 * for use in games and other applications. Whilst fixed time steps are usful
		 * for many applications, their use in determanistic systems is essential. The
		 * Game loop class is useful but not limited to physics systems, data mining & 
		 * game replay data.
		 * 
		 * @param	timeStep The game loop update frequency
		 */
		public function GameLoop( timeStep: Number = 20 ) 
		{
			mDT = timeStep;
			
			onTick = new Signal( int );
			onUpdate = new Signal( int, int );
			onDraw = new Signal( int );
			onAlpha = new Signal( Number );
			onReset = new Signal();
		}
		
		/**
		 * Start the game loop
		 */
		public function start(): void
		{
			mStartTime = getTimer();
			
			mTimer = new Timer( mDT );
			mTimer.addEventListener( TimerEvent.TIMER, tick );
			mTimer.start();
		}
		
		/**
		 * Reset the game loop. Upon reseting, the game loop will cease to function.
		 * You must call the start() method to restart the game loop.
		 */
		public function reset(): void
		{
			mT = 0;
			mCurrentTime = 0;
			mStartTime = 0;
			mAccumulator = 0;
			
			mUpdateCount = 0;
			mDrawCount = 0;
			
			mStartTime = 0;
			mElapsed = 0;
			mIsPaused = false;
			
			mLastTimePaused = 0;
			mTotalTimePaused = 0;
			mIsPaused = false;
			
			mTimer.stop();
			mTimer.removeEventListener( TimerEvent.TIMER, tick );
			mTimer = null;
			
			onReset.dispatch();
		}
		
		
		/**
		 * Resumes the gameloop after being paused.
		 */
		public function resume(): void
		{
			if ( !mIsPaused )
			{
				return;
			}
			
			mIsPaused = false;
			var pausedTime: int = getTimer() - mLastTimePaused;
			
			mTotalTimePaused += pausedTime;
			mTimer.start();
		}
		
		/**
		 * Pauses the gameloop.
		 */
		public function pause(): void
		{
			if ( mIsPaused )
			{
				return;
			}
			
			mIsPaused = true;
			mLastTimePaused = getTimer();
			mTimer.stop();
		}
		
		/**
		 * Disposes of all data associated with this object ready for GC.
		 */
		public function dispose(): void
		{
			mTimer.stop();
			mTimer.removeEventListener( TimerEvent.TIMER, tick );
			mTimer = null;
			
			onTick.removeAll();
			onUpdate.removeAll();
			onDraw.removeAll();
			onAlpha.removeAll();
			onReset.removeAll();
			
			onTick = null;
			onUpdate = null;
			onDraw = null;
			onAlpha = null;
			onReset = null;
			
			mIsDisposed = true;
		}
		
		/**
		 * TRUE if the pause() method has been called and the gameloop is paused.
		 */
		public function get isPaused(): Boolean
		{
			return mIsPaused;
		}
		
		/**
		 * Called by the Timer to process the next tick of the gameloop.
		 * 
		 * @param	e	The TimerEvent passed by the Timer object.
		 */
		protected function tick( e: TimerEvent ): void
		{
			
			var newTime: int = getTimer() - ( mStartTime + mTotalTimePaused);
			
			var frameTime: int = newTime - mCurrentTime;
			
			onTick.dispatch( frameTime );
			
			mCurrentTime = newTime;
			mAccumulator += frameTime;
			
			// TODO limit max calls
			while ( mAccumulator >= mDT )
			{
				mUpdateCount++;
				
				mT += mDT;
				mAccumulator -= mDT;
				
				onUpdate.dispatch( mT, mDT );
			}
			
			var alpha: Number = mAccumulator / mDT;
			
			onDraw.dispatch( mAccumulator );
			onAlpha.dispatch( alpha );
			
			mDrawCount++;
		}
		
		/**
		 * Checks if the gameloop has been disposed, TRUE if the gameloop is desposed, FALSE if not.
		 */
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		
		
		/**
		 * Gets the current timestep aka delta time.
		 */
		public function get timeStep():int 
		{
			return mDT;
		}
		
		
		// TODO look at time management overall to extrapolate time data so one may perform reverse, jump, wrap and other possible function of time
		/*
		public function set timeStep(value:int):void 
		{
			mDrawCount = 0;
			mUpdateCount = 0;
			mDT = value;
			mTimer.delay = mDT;
		}
		*/
		
		/**
		 * An incremental value that provides the number of times that onUpdate signal has been dispatched.
		 */
		public function get updateCount():int 
		{
			return mUpdateCount;
		}
		
		/**
		 * An incremental value that provides the number of times that onDraw signal has been dispatched.
		 */
		public function get drawCount():int 
		{
			return mDrawCount;
		}
		
	}

}