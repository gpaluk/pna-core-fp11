pna-core-fp11
=============

PNA core library

WARNING
=======================
PNA is a port of XNA to AS3 - currently supported are some of the minimal structures required to get a simple game running. This project is NOT production ready or defined and is in development.

USAGE
=======================
- Your game class will extend the PluginGame class.
- In your document class create a new instance of your game class and call the run method()
- Override methods in the Game class.

PNA exposes a content loader, game loop, plugin manager and other utilities.

SIMPLE EXAMPLE
=======================

```actionscript
// Your game class
package io.plugin 
{
	import io.plugin.pna.PluginGame;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class MyGame extends PluginGame
	{
		
		public function MyGame() 
		{
			
		}
		
		override protected function update( t:Number, dt: Number ):void 
		{
			trace( "Update - t:" + t + ", dt: " + dt );
		}
		
		override protected function draw( t:Number ):void 
		{
			trace( "Draw - t:" + t );
		}
		
	}

}

//After the entry point in your Document class
var myGame: MyGame = new MyGame();
myGame.run();
```
