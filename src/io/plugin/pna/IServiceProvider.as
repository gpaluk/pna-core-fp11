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
	public interface IServiceProvider 
	{
		function addService( type: Class, service: Object ): void;
		function removeService( type: Class ): void;
		function getService( type: Class ): Object;
		function getAllServices(): Vector.<Object>;
	}
	
}