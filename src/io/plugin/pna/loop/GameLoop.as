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
		
		// events
		public var onTick: Signal;
		public var onUpdate: Signal;
		public var onDraw: Signal;
		public var onAlpha: Signal;
		
		// timing
		protected var mTimer: Timer;
		protected var mT: int;
		protected var mDT: int;
		protected var mCurrentTime: int;
		protected var mAccumulator: int;
		
		// disposed flag
		private var mIsDisposed: Boolean;
		
		// loop states
		
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		
		public function GameLoop( timeStep: Number = 20 ) 
		{
			mDT = timeStep;
			mAccumulator = getTimer();
			
			onTick = new Signal( int );
			onUpdate = new Signal( int, int );
			onDraw = new Signal( int );
			onAlpha = new Signal( Number );
			
			mTimer = new Timer( timeStep );
			mTimer.addEventListener(TimerEvent.TIMER, tick );
			mTimer.start();
		}
		
		public function dispose(): void
		{
			mTimer.stop();
			mTimer.removeEventListener( TimerEvent.TIMER, tick );
			mTimer = null;
			
			onTick.removeAll();
			onUpdate.removeAll();
			onDraw.removeAll();
			onAlpha.removeAll();
			
			onTick = null;
			onUpdate = null;
			onDraw = null;
			onAlpha = null;
			
			mIsDisposed = true;
		}
		
		public function tick( e: TimerEvent ): void
		{
			
			var newTime: int = getTimer();
			var frameTime: int = newTime - mCurrentTime;
			
			onTick.dispatch( frameTime );
			
			mCurrentTime = newTime;
			mAccumulator += frameTime;
			
			// TODO limit max calls
			while ( mAccumulator >= mDT )
			{
				mT += mDT;
				mAccumulator -= mDT;
				
				onUpdate.dispatch( mT, mDT );
			}
			
			var alpha: Number = mAccumulator / mDT;
			
			onDraw.dispatch( mAccumulator );
			onAlpha.dispatch( alpha );
			
		}
		
	}

}