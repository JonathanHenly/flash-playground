package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class weaponList extends MovieClip {
		private var originalX, originalY:int = 0;


		public function weaponList() {
			this.addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}
		
		public function stageAddHandler(e:Event):void {
			this.originalX = this.x;
			this.originalY = this.y;
			

			this.removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}
		
		public function moveListUp() {
			this.y -= 30;
		}
		
		public function moveListDown() {
			this.y += 30;
		}
		
		public function resetListTop() {
			this.x = this.originalX;
			this.y = this.originalY;
		}
		
		public function resetListBottom() {
			this.x = this.originalX;
			trace(this.originalY, this.height, this.originalY - this.height/2);
			this.y = this.originalY - this.height + 20;
		}
	}
	
}
