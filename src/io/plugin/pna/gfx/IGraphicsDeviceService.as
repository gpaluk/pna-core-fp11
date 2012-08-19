/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.gfx 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public interface IGraphicsDeviceService 
	{
		function get graphicsDevice(): GraphicsDevice;
		
		// events
		function get onDeviceCreated(): Signal;
		function get onDeviceDisposing(): Signal;
		function get onDeviceReset(): Signal;
		function get onDeviceResetting(): Signal;
		
	}
	
}