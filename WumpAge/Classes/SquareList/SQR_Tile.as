package
{
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Matrix;
	
	public class SQR_Tile extends MovieClip implements SQR_ITile
	{
		private var northTile:SQR_ITile;
		private var southTile:SQR_ITile;
		private var eastTile:SQR_ITile;
		private var westTile:SQR_ITile;
		
		private var originalX:Number;
		private var originalY:Number;
		private var originalXScale:Number;
		private var originalYScale:Number;
		private var originalIndex:int;
		private var originalFrame:int;
		
		private var isSelected:Boolean;
		private var otherTileChosen:Boolean;
		
		private var enviroment:enviroment_Sun;
		
		private var tileGlow:TileGlow;
		
		private var terrain:Terrain;
		
		public function SQR_Tile()
		{
			this.northTile = null;
			this.southTile = null;
			this.eastTile = null;
			this.westTile = null;
			
			this.isSelected = false;
			this.otherTileChosen = false;
			
			this.originalFrame = 1;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/******************************************************************************************
		 * EVENT HANDLERS
		 **/
		public function onAddedToStage(event:Event):void
		{
			// Set variables
			this.originalXScale = this.scaleX;
			this.originalYScale = this.scaleY;
			this.originalIndex = parent.getChildIndex(this);
			
			this.tileGlow = new TileGlow();
			this.tileGlow.mouseChildren = false;
			this.tileGlow.mouseEnabled = false;
			this.tileGlow.x = 3.05;
			this.tileGlow.y = 0;
			
			// Add enviroment after terrain
			// this.addEnviroments();
			
			// Add event listeners to the tile
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			// Add TileEvent listeners to the stage
			stage.addEventListener(TileEvent.TILE_CHOSEN, onTileChosen);
			stage.addEventListener(TileEvent.TILE_UNCHOSEN, onTileUnChosen);
			
			// Remove ADDED_TO_STAGE event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/******************************************************************************************
		 * ACCESORS
		 **/
		public function getNorthTile():SQR_ITile
		{
			return this.northTile;
		}
		
		public function getSouthTile():SQR_ITile
		{
			return this.southTile;
		}
		
		public function getEastTile():SQR_ITile
		{
			return this.eastTile;
		}
		
		public function getWestTile():SQR_ITile
		{
			return this.westTile;
		}
		
		public function getXPos():Number
		{
			return this.x;
		}
		
		public function getYPos():Number
		{
			return this.y;
		}
		
		/******************************************************************************************
		 * MUTATORS
		 **/
		public function setNorthTile(tile:SQR_ITile):void
		{
			this.northTile = tile;
		}
		
		public function setSouthTile(tile:SQR_ITile):void
		{
			this.southTile = tile;
		}
		
		public function setEastTile(tile:SQR_ITile):void
		{
			this.eastTile = tile;
		}
		
		public function setWestTile(tile:SQR_ITile):void
		{
			this.westTile = tile;
		}
		
		public function setXPos(newX:Number):void
		{
			this.x = newX;
		}
		
		public function setYPos(newY:Number):void
		{
			this.y = newY;
		}
		
		/******************************************************************************************
		 * MAIN METHODS
		 **/
		public function calculatePosition():void
		{
			this.setXPos(this.getWestTile().getXPos() + Constants.HORIZONTAL_SPACING);
			this.setYPos(this.getWestTile().getYPos());
			
			this.originalX = this.x;
			this.originalY = this.y;
		}
		
		public function addToStage():DisplayObject
		{
			this.calculatePosition();
			
			return this;
		}
		
		public function addTerrainToTile():void
		{
			this.terrain = new Terrain();
			terrain.createTerrainTiles();
			
			
			var mtx:Matrix = new Matrix();
			mtx.b = Math.tan(0 * Math.PI / 180);
			mtx.c = Math.tan(45 * Math.PI / 180);
			mtx.concat(this.terrain.transform.matrix);
			this.terrain.transform.matrix = mtx;
			
			this.terrain.scaleY = 1.00;
			
			this.addChild(this.terrain);
		}	
		
		public function addEnviroments():void
		{
			this.enviroment = new enviroment_Sun();
			this.enviroment.mouseEnabled = false;
			this.enviroment.mouseChildren = false;
			this.enviroment.x = 0;
			this.enviroment.y = 0;
			this.enviroment.alpha = 1;
			
			this.addChild(this.enviroment);
		}
		
		public function onClick(event:MouseEvent)
		{
			if (!this.isSelected && !this.otherTileChosen)
			{
				this.isSelected = true;
				stage.dispatchEvent(new TileEvent(TileEvent.TILE_CHOSEN, true, false, this));
			}
			else
			{
				stage.dispatchEvent(new TileEvent(TileEvent.TILE_UNCHOSEN, true, false, this));
			}
		}
		
		public function onTileChosen(event:TileEvent)
		{
			if (this.isSelected)
			{
				this.x += 5;
				this.y -= 10;
				this.scaleX = 12;
				this.scaleY = 12;
				
				parent.setChildIndex(this, parent.numChildren - 1);
			}
			else if (!this.isSelected)
			{
				this.otherTileChosen = true;
			}
		}
		
		public function onTileUnChosen(event:TileEvent)
		{
			if (this.isSelected)
			{
				this.reset();
			}
			this.otherTileChosen = false;
		}
		
		public function reset():void
		{
			this.setXPos(originalX); // this.originalX;
			this.setYPos(originalY); // this.originalY;
			this.scaleX = this.originalXScale;
			this.scaleY = this.originalYScale;
			parent.setChildIndex(this, originalIndex);
			this.isSelected = false;
		}
		
		public function onMouseOver(event:MouseEvent)
		{
			this.addChild(this.tileGlow);
		}
		
		public function onMouseOut(event:MouseEvent)
		{
			this.removeChild(this.tileGlow);
		}
		
		override public function toString():String
		{
			return super.toString();
		}
		
		public function surroundingTilesToString():String
		{
			var s:String = "";
			
			s += (this.getNorthTile() != null) ? "N: " + this.getNorthTile() : "N: null";
			s += (this.getEastTile() != null) ? " E: " + this.getEastTile() : " E: null";
			s += (this.getWestTile() != null) ? " W: " + this.getWestTile() : " W: null";
			s += (this.getSouthTile() != null) ? " S: " + this.getSouthTile() : " S: null";
			
			return s;
		}
	
	}

}
