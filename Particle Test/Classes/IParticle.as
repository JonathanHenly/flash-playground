package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	
	public interface IParticle {

		// Interface methods:
		function update(particles:Array):Boolean;
		
		function fall();
		
		function tooClose(particles:Array);
		
		function isRising():Boolean;
		
	}
	
}
