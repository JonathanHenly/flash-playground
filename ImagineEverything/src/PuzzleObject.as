package  
{
	import flash.display.Shape;
	import flash.ui.Mouse;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	
	import flash.events.*;
	import flash.filters.*;
	/**
	 * ...
	 * @author Jonathan
	 */
	public class PuzzleObject extends IEMovieClip 
	{	

		private const NUMBER_OF_PIECES:int = 6;
		private const RANDOM_NUMBER_MAX:int = 1238;
		private const RANDOM_NUMBER_MIN:int = 1;
		private const IMAGE_URL_PRE:String = "http://everyonesfavorites.com/images/";
		private const IMAGE_URL_POST:String = ".gif";
		private const HELP_AMOUNT:int = 15;
		
		private var randomNumber:int;
		private var imageLoader:Loader;
		private var imageURL:String;
		private var image:URLRequest;
		
		private var puzzleImage:Bitmap;
		
		private var puzzleArray:Array;
		private var puzzleBackgroundArray:Array;
		
		private var startNewPuzzle:Boolean = false;
		
		private var puzzleEffectDone:Boolean = false;
		
		private var shadowFilter:DropShadowFilter;
		private var shadowCount:int;
		
		public function PuzzleObject() 
		{
			super();
			
			shadowCount = 50;
			
			randomNumber = RANDOM_NUMBER_MIN + (Math.random() * (RANDOM_NUMBER_MAX - RANDOM_NUMBER_MIN));
			
			imageURL = IMAGE_URL_PRE + randomNumber.toString() + IMAGE_URL_POST;
			
			// imageURL = "../img/test.png";
			
			trace(imageURL);
			
			imageLoader = new Loader();
			
			// image = new URLRequest(imageURL);
			
			imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			
			imageLoader.load(new URLRequest(imageURL));

			
			puzzleArray = new Array();
			puzzleBackgroundArray = new Array();
		}
		
		public function onProgress(event:ProgressEvent):void
		{
			
		}
		
		private function onComplete(event:Event):void
		{
			this.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			this.removeEventListener(Event.COMPLETE, onComplete);
			
			var loadedBitmap:Bitmap = Bitmap(imageLoader.content);
			
			this.puzzleImage = new Bitmap(loadedBitmap.bitmapData);
			
			this.initialize();
		}
		
		private function initialize():void
		{
			/*
			while (puzzleImage.width > PuzzleMode.PUZZLE_DISPLAY_WIDTH) {
				puzzleImage.bitmapData.width *= 0.99;
			}
			
			while (puzzleImage.height > PuzzleMode.PUZZLE_DISPLAY_HEIGHT) {
				puzzleImage.bitmapData.height *= 0.99;
			}
			*/
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onPuzzleMouseUp);
			
			this.chopImage(this.drawScaled(puzzleImage.bitmapData, 450, 450));
		}
		
		public function drawScaled(obj:BitmapData, thumbWidth:Number, thumbHeight:Number):Bitmap {
			var m:Matrix = new Matrix();
			m.scale(450 / obj.width, 450 / obj.height);
			var bmp:BitmapData = new BitmapData(thumbWidth, thumbHeight, false);
			bmp.draw(obj, m);
			return new Bitmap(bmp);
		}
		
		private function chopImage(newBitmap:Bitmap):void
		{
			var peiceWidth:Number = PuzzleMode.PUZZLE_DISPLAY_WIDTH / NUMBER_OF_PIECES;
			var peiceHeight:Number = PuzzleMode.PUZZLE_DISPLAY_HEIGHT / NUMBER_OF_PIECES;
			var pieceID:int = 0;
			
			for(var i:int = 0; i < NUMBER_OF_PIECES; i++){
				for(var j:int = 0; j < NUMBER_OF_PIECES; j++){
					var newPuzzlePiece:PuzzlePiece;
					var peiceBackground:IEMovieClip;
					
					var bitmapByteArray:ByteArray = newBitmap.bitmapData.getPixels(new Rectangle(i*peiceWidth, j*peiceHeight, peiceWidth, peiceHeight));
					bitmapByteArray.position = 0;
					var bitmapData:BitmapData = new BitmapData(peiceWidth, peiceHeight, false, 0);
					bitmapData.setPixels(new Rectangle(0, 0, peiceWidth, peiceHeight), bitmapByteArray);
					var anotherNewBitmap:Bitmap = new Bitmap(bitmapData);
					
					newPuzzlePiece = new PuzzlePiece(anotherNewBitmap, pieceID);
					
					puzzleArray.push(newPuzzlePiece);
					
					this.addChild(newPuzzlePiece);
					newPuzzlePiece.x = ((i * peiceWidth) - 204);
					newPuzzlePiece.y = ((j * peiceHeight) - 202.5);
					
					peiceBackground = new IEMovieClip();
					peiceBackground.graphics.lineStyle(0.1, 0xDFDFDF);
					peiceBackground.graphics.drawRect(0, 0, peiceWidth, peiceHeight);
					peiceBackground.graphics.endFill();
					peiceBackground.x = newPuzzlePiece.x;
					peiceBackground.y = newPuzzlePiece.y;
					this.addChild(peiceBackground);
					
					puzzleBackgroundArray.push(peiceBackground);
					
					newPuzzlePiece.setOriginalPoint(newPuzzlePiece.x, newPuzzlePiece.y);
					
					if (newPuzzlePiece.getPieceID() >= ((NUMBER_OF_PIECES*NUMBER_OF_PIECES)/2)) {
						newPuzzlePiece.x += 253.5;
					} else {
						newPuzzlePiece.x -= 250;
					}
					
					newPuzzlePiece.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					newPuzzlePiece.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
					
					pieceID++;
				}
			}
			
			this.jumblePuzzle();
			this.giveALittleHelp();
		}
		
		private function jumblePuzzle():void
		{
			var numberCheck:Array = new Array();
			
			for (var x:int = 0; x < (NUMBER_OF_PIECES * NUMBER_OF_PIECES); x++) {
				var randIndex:int = 0 + Math.random() * ((NUMBER_OF_PIECES * NUMBER_OF_PIECES) - 0);
				if (numberCheck.length == 0) {
					var tmpPieceX:Number = puzzleArray[x].x;
					var tmpPieceY:Number = puzzleArray[x].y;
					
					puzzleArray[x].x = puzzleArray[randIndex].x;
					puzzleArray[x].y = puzzleArray[randIndex].y;
					puzzleArray[x].setNewPoint(puzzleArray[x].x, puzzleArray[x].y);
					
					puzzleArray[randIndex].x = tmpPieceX;
					puzzleArray[randIndex].y = tmpPieceY;
					puzzleArray[x].setNewPoint(puzzleArray[randIndex].x, puzzleArray[randIndex].y);
					
					numberCheck.push(randIndex);
				} else {
					var notInArray:Boolean = true;
					
					for (var y:int = 0; y < numberCheck.length; y++) {
						if (randIndex == numberCheck[y]) {
							notInArray = false;
							break;
						} else {
							notInArray = true;
						}
					}
					
					if (!notInArray) {
						x--;
					} else {
						var tmpPieceX:Number = puzzleArray[x].x;
						var tmpPieceY:Number = puzzleArray[x].y;
						
						puzzleArray[x].x = puzzleArray[randIndex].x;
						puzzleArray[x].y = puzzleArray[randIndex].y;
						puzzleArray[x].setNewPoint(puzzleArray[x].x, puzzleArray[x].y);
						
						puzzleArray[randIndex].x = tmpPieceX;
						puzzleArray[randIndex].y = tmpPieceY;
						puzzleArray[x].setNewPoint(puzzleArray[randIndex].x, puzzleArray[randIndex].y);
						
						numberCheck.push(randIndex);
					}
				}
			}
		}
		
		public function giveALittleHelp():void
		{
			var randomInts:Array = new Array();
			
			for (var x:int = 0; x < HELP_AMOUNT; x++) {
				var randIndex:int = 0 + Math.random() * ((NUMBER_OF_PIECES * NUMBER_OF_PIECES) - 0);
				var weAlreadyHaveIt:Boolean = false;
				if (x == 0) {
					randomInts.push(randIndex);
				} else {
					for (var y:int = 0; y < randomInts.length; y++) {
						if (randIndex == randomInts[y]) {
							x--;
							weAlreadyHaveIt = true;
							break;
						}
					}
					
					if(!weAlreadyHaveIt) {
						randomInts.push(randIndex);
					}
				}
			}
			
			for (var z:int = 0; z < randomInts.length; z++) {
				this.puzzleBackgroundArray[this.puzzleArray[randomInts[z]].getPieceID()].visible = false;
				puzzleArray[randomInts[z]].placePiece();
			}
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			var tmpPiece:PuzzlePiece = event.target as PuzzlePiece;
			tmpPiece.mouseDown = true;
			
			tmpPiece.ascendIndex();
			
			Mouse.hide();
			tmpPiece.addEventListener(Event.ENTER_FRAME, tmpPiece.onEnterFrame);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			var tmpPiece:PuzzlePiece = event.target as PuzzlePiece;
			
			tmpPiece.mouseDown = false;
			
			Mouse.show();
			
			this.puzzleBackgroundArray[tmpPiece.getPieceID()].visible = false;
			
			tmpPiece.ascendIndex();
			
			if(!startNewPuzzle) {
				for (var x:int = 0; x < puzzleArray.length; x++) {
					if (puzzleArray[x].ableToDrag) {
						startNewPuzzle = false;
						break;
					} else {
						if (x == puzzleArray.length - 1) {
							this.doneWithPuzzle();
						}
					}
				}
			} else {
				puzzleEffectDone = true;
			}
			
			if (startNewPuzzle && puzzleEffectDone) {
				this.newPuzzle();
			}
		}
		
		private function doneWithPuzzle():void
		{
			startNewPuzzle = true;
			puzzleEffectDone = false;
			shadowFilter = new DropShadowFilter();
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function solvePuzzle():void
		{
			for (var x:int = 0; x < puzzleArray.length; x++) {
				this.puzzleBackgroundArray[this.puzzleArray[x].getPieceID()].visible = false;
				this.puzzleArray[x].placePiece();
			}
			
			this.doneWithPuzzle();
		}
		
		private function onEnterFrame(event:Event):void
		{
			if (shadowCount > 0) {
				this.shadowFilter.alpha = 1;
				this.shadowFilter.blurX = shadowCount;
				this.shadowFilter.blurY = shadowCount;
				this.shadowFilter.color = 0xFFFFFF;
				this.shadowFilter.distance = 0.1;
				this.shadowFilter.inner = true;
				this.shadowFilter.quality = 4;
				this.shadowFilter.strength = 1;
				
				this.filters = [shadowFilter]
				
				this.shadowCount -= 2;
			} else {
				this.filters = [];
			}
		}
		
		private function newPuzzle():void
		{
			var tmpParent:PuzzleMode = parent as PuzzleMode;
			tmpParent.getNewPuzzle();
			
			parent.removeChild(this);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if((event.keyCode > 0)) {
				if(!this.startNewPuzzle) {
					this.solvePuzzle();
				} else {
					this.newPuzzle();
				}
			}
		}
		
		private function onPuzzleMouseUp(event:MouseEvent):void
		{
			Mouse.show();
		}
		
	}

}