package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	
	public interface ICoin {

		// Interface methods:
		// Method to handle Event.ADDED_TO_STAGE
		function stageAddHandler(e:Event);
		// Setter for the coin's instance name
		function setName(what:String);
		// Setter for the coin's yVel
		function setYVel(newYV:Number);
		// Setter for the coin's xVel
		function setXVel(newXV:Number);
		// Setter for the coin's onPlatform boolean
		function setOnPlatform(isOn:Boolean);
		// Getter for the coin's onPlatform boolean
		function getOnPlatform():Boolean;
		// Main method to update coins
		function update(coins:Array):Boolean;
		// Method to replicate gravity
		function fall();
		// Method to spread the coins out
		function tooClose(coins:Array);
		// Method to move the coin by it's x and y velocities each frame
		function move():Boolean;
		// Method to handle friction in the x direction
		function friction();
		// Method that returns true if the coin is rising and false if it is falling
		function isRising():Boolean;
		// Method to return a coin's amount
		function amount():int;
		// Method to remove a coin
		function remove(e:Event);
		// Method to remove everything
		function removeEverything();
		
	}
	
}
