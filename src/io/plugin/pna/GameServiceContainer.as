/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna 
{
	import flash.utils.Dictionary;
	import io.plugin.pna.IServiceProvider;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class GameServiceContainer implements IServiceProvider 
	{
		
		private var mServices: Dictionary;
		
		public function GameServiceContainer() 
		{
			mServices = new Dictionary();
		}
		
		public function addService( type: Class, service: Object ): void
		{
			mServices[ type ] = service;
		}
		
		public function removeService( type: Class ): void
		{
			mServices[ type ] = null;
		}
		
		public function getService( type: Class ): Object
		{
			return mServices[ type ];
		}
		
		public function getAllServices(): Vector.<Object>
		{
			var v: Vector.<Object> = new Vector.<Object>();
			for each( var e: Object in mServices )
			{
				v.push( e );
			}
			return v;
		}
		
	}
	
}