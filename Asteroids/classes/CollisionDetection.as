/**
* CollisionDetection by Grant Skinner. Aug 1, 2005
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
*
* Copyright (c) 2011 Grant Skinner
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
**/

package {
	
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	
	public class CollisionDetection {
		public static const MAX_INTERSECTION_WIDTH:uint = 50;
		public static const MAX_INTERSECTION_HEIGHT:uint = 50;
		
		protected static var _bitmapData:BitmapData;
		
		public static function check(clip1:DisplayObject,clip2:DisplayObject,alphaTolerance:Number=255):Rectangle {
			
			// get bounds:
			var bounds1:Rectangle = clip1.getBounds(clip1.stage);
			var bounds2:Rectangle = clip2.getBounds(clip1.stage);
			
			// determine test area boundaries:
			var bounds:Rectangle = new Rectangle();
			bounds.x = Math.max(bounds1.x,bounds2.x);
			bounds.width = Math.min(bounds1.x+bounds1.width,bounds2.x+bounds2.width)-bounds.x;
			bounds.y = Math.max(bounds1.y,bounds2.y);
			bounds.height = Math.min(bounds1.y+bounds1.height,bounds2.y+bounds2.height)-bounds.y;
			
			// rule out anything that we know can't collide:
			if (bounds.width < 1 || bounds.height < 1) { return null; }
			
			// set up the image to use:
			var img:BitmapData = bitmapData;
			
			var clipRect:Rectangle = new Rectangle(0,0,bounds.width,bounds.height);
			
			// draw in the first image:
			var mat:Matrix = clip1.transform.concatenatedMatrix;
			mat.tx -= bounds.x;
			mat.ty -= bounds.y;
			img.draw(clip1,mat, new ColorTransform(0,0,0,1,255,0,0,alphaTolerance),"normal",clipRect);
			
			// overlay the second image:
			mat = clip2.transform.concatenatedMatrix;
			mat.tx -= bounds.x;
			mat.ty -= bounds.y;
			img.draw(clip2,mat, new ColorTransform(0,0,0,1,255,255,255,alphaTolerance),"difference",clipRect);
			
			// find the intersection:
			var intersection:Rectangle = img.getColorBoundsRect(0xFFFFFFFF,0xFF00FFFF);
			
			// if there is no intersection, return null:
			if (intersection.width == 0) { return null; }
			
			// adjust the intersection to account for the bounds:
			intersection.x += bounds.x;
			intersection.y += bounds.y;
			
			return intersection;
			
		}
		
		public static function get bitmapData():BitmapData {
			if (_bitmapData == null) { _bitmapData = new BitmapData(MAX_INTERSECTION_WIDTH,MAX_INTERSECTION_HEIGHT,false,0xFFFFFF); }
			else { _bitmapData.fillRect(_bitmapData.rect,0xFFFFFF); }
			return _bitmapData;
		}
	}
	
}