package  {
	
	import flash.display.MovieClip;
	
	public class Musket extends MovieClip{
		
		import flash.display.MovieClip;
		
		public function Musket() {
			// constructor code
		}
		
		public function moveLeft():void
		{
			this.x--;
		}
		
		public function moveRight():void
		{
			this.x++;
		}
		
		public function getDelay():int
		{
			return 500;
		}

	}
	
}
