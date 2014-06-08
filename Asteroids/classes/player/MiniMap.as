package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MiniMap extends MovieClip 
	{
		private const MINI_MAP_BORDER_COLOR:uint = 0xFFFFFF;
		private const MINI_MAP_BORDER_THICKNESS:Number = 0.1;
		private const MINI_MAP_MAX_SIZE:int = 100;
		private const MINI_MAP_MIN_SIZE:int = 0;
		
		private const ICON_COLOR:uint = 0xFF0000;
		private const ICON_SIZE:int = 1;
		
		private var miniMapMask:Shape;
		private var miniMapItems:Array;
		private var miniMapIcons:Array;
		
		public function MiniMap():void
		{
			miniMapMask = new Shape();
			miniMapItems = new Array();
			miniMapIcons = new Array();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.createDisplay();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function update():void
		{
			this.miniMapIcons[0].x = Asteroids.pOne.globalX / 100;
			this.miniMapIcons[0].y = Asteroids.pOne.globalY / 100;
			
			for (var iconCount:int = 1; iconCount < this.miniMapItems.length; iconCount++) {
				this.miniMapIcons[iconCount].x = this.miniMapItems[iconCount].x / 100;
				this.miniMapIcons[iconCount].y = this.miniMapItems[iconCount].y / 100;
			}
			
		}
		
		public function createDisplay():void
		{
			this.graphics.lineStyle(MINI_MAP_BORDER_THICKNESS, MINI_MAP_BORDER_COLOR);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.moveTo(MINI_MAP_MIN_SIZE, MINI_MAP_MIN_SIZE);
			this.graphics.lineTo(MINI_MAP_MAX_SIZE, MINI_MAP_MIN_SIZE);
			this.graphics.lineTo(MINI_MAP_MAX_SIZE, MINI_MAP_MAX_SIZE);
			this.graphics.lineTo(MINI_MAP_MIN_SIZE, MINI_MAP_MAX_SIZE);
			this.graphics.lineTo(MINI_MAP_MIN_SIZE, MINI_MAP_MIN_SIZE);
			this.graphics.endFill();
			
			miniMapMask.graphics.beginFill(0xFFFFFF, 1);
			miniMapMask.graphics.moveTo(MINI_MAP_MIN_SIZE, MINI_MAP_MIN_SIZE);
			miniMapMask.graphics.lineTo(MINI_MAP_MAX_SIZE+10, MINI_MAP_MIN_SIZE);
			miniMapMask.graphics.lineTo(MINI_MAP_MAX_SIZE+10, MINI_MAP_MAX_SIZE+10);
			miniMapMask.graphics.lineTo(MINI_MAP_MIN_SIZE, MINI_MAP_MAX_SIZE+10);
			miniMapMask.graphics.lineTo(MINI_MAP_MIN_SIZE, MINI_MAP_MIN_SIZE);
			miniMapMask.graphics.endFill();
			
			miniMapMask.x = this.x;
			miniMapMask.y = this.y;
			
			this.mask = miniMapMask;
			parent.addChild(miniMapMask);
		}
		
		public function addItemToMiniMap(item:MovieClip):void
		{
			this.miniMapItems.push(item);
			
			var newIcon:Shape = new Shape();
			
			newIcon.graphics.beginFill(ICON_COLOR, 1);
			newIcon.graphics.drawCircle(0, 0, ICON_SIZE);
			newIcon.graphics.endFill();
			
			newIcon.x = item.x / 100;
			newIcon.y = item.y / 100;
			
			this.miniMapIcons.push(newIcon);
			
			this.addChild(newIcon);
		}
		
		public function addPlayerToMiniMap():void
		{
			var PLAYER_ICON_COLOR:uint = 0xFFFFFF;
			
			var newIcon:Shape = new Shape();
			newIcon.graphics.beginFill(PLAYER_ICON_COLOR, 1);
			newIcon.graphics.drawCircle(0, 0, ICON_SIZE);
			newIcon.graphics.endFill();
			
			newIcon.x = Asteroids.pOne.globalX / 100;
			newIcon.y = Asteroids.pOne.globalY / 100;
			
			this.miniMapItems.push(Asteroids.pOne);
			
			this.miniMapIcons.push(newIcon);
			
			this.addChild(newIcon);
			
		}
		
		public function removeItemFromMiniMap(item:MovieClip):void
		{
			var itemIndex:int = this.miniMapItems.indexOf(item);
			
			this.removeChild(this.miniMapIcons[itemIndex]);
			this.miniMapItems.splice(itemIndex, 1);
			this.miniMapIcons.splice(itemIndex, 1);
		}
		
	}
	
}