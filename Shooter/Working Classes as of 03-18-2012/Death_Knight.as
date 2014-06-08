package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class Death_Knight extends MovieClip {
		
		
		public function Death_Knight() {
			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}
		
		private function stageAddHandler(e:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}
		
		private function stage_onEnterFrame(event:Event):void
		{
			var player:Object = parent.getChildByName("p1");
			
			if(this.x < player.x) {
				if(this.scaleX == -1) {
					this.scaleX *= -1;
				}
				this.x++;
			} else {
				if(this.scaleX == 1) {
					this.scaleX *= -1;
				}
				this.x--;
			}
		}
	}
	
}
