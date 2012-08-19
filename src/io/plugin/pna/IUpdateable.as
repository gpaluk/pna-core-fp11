/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna 
{
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public interface IUpdateable 
	{
		function get enabled(): Boolean;
		function get updateOrder(): int;
		function update( gameTime: int ): void;
	}
	
}