package {
	
	import flash.events.*;
	
	/**
	 * @author Jonathan Henly
	 */
	public interface IAsteroid {
		
		function createAsteroid():void;
		
		function updateAsteroid():void;
		
		function modifyHealth():void;
		
		function splitAsteroid():Array;
		
		function removeAsteroid():void;
		
		function enterOrbit(shipX:Number = 0, shipY:Number = 0):void;
		
		function updateOrbit(newShipX:Number = 0, newShipY:Number = 0):void;
		
		function exitOrbit():void;
	}
}
