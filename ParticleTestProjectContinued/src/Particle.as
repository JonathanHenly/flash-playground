/* ***********************************************************************
ActionScript 3 Effect by Dan Gries and Barbara Kaskosz

http://www.flashandmath.com/

Last modified: August 18, 2010
************************************************************************ */


package {
	
	import flash.geom.Point;
	
	/**
	 * The Particle class represents particles used in a linked list. Each particle has the following variables:
		 * next
		 * recycle
		 * color
		 * red
		 * green
		 * blue
		 * alpha
		 * wcX
		 * wcY
	 * <br />The particle class only contains one constructor and no other functions.
	 */
	public class Particle extends Point {
		//links:
		public var next:Particle = null;
		// Boolean used for recycling
		public var recycle:Boolean = true;
		
		//color attributes
		public var color:uint;
		public var red:uint;
		public var green:uint;
		public var blue:uint;
		public var alpha:uint;
		
		//remove time property
		public var time:uint = 0;
		// public var lum:Number;
		
		//A wildcard property that you can use in your application if you need it.
		public var VX:Number;
		public var VY:Number;
		
		/** *******************************************************************
		 * Constructor for the particle class.
		 * 
		 * @param	thisColor Hex value between 0xFFFFFFFF and 0x00000000,
		 *  for example the sequence 0xFF00AAFF is resembled by 
		 * [red:FF][green:00][blue:AA][alpha:FF].
		 ** ******************************************************************/
		public function Particle(thisColor:uint = 0xFFFFFFFF){
			
			this.color = thisColor;
			this.red = ((thisColor >> 16) & 0xFF);
			this.green = ((thisColor >> 8) & 0xFF);
			this.blue = (thisColor & 0xFF);
			this.alpha=((thisColor >> 24) & 0xFF);
		}
		
	}
}