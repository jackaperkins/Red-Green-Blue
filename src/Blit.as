package  
{
	import adobe.utils.CustomActions;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author jack
	 */
	public class Blit
	{
		[Embed(source = "../lib/sprites.png")]
		private static var spriteSheetClass:Class;
		public static var spriteSheet:BitmapData;
		public static var sprite:Vector.<BitmapData>;
		
		[Embed(source = "../lib/title.gif")]
		private static var titleClass:Class;
		public static var title:BitmapData;
		
		public static function initialize():void 
		{
			// Prepare sprites

			spriteSheet = new spriteSheetClass().bitmapData;

			// Slice sprite sheet into sub-images
			sprite = new Vector.<BitmapData>();
			var sourceRectangle:Rectangle = new Rectangle(0, 0, 16, 16);
			var destinationPoint:Point = new Point(0, 0);
			var currentSprite:int = 0;
			for (var y:int = 0; y < spriteSheet.height /16 ; y ++) {
				for (var x:int = 0; x < spriteSheet.width / 16; x ++) {
					sourceRectangle.x = x *16;
					sourceRectangle.y = y * 16;
					sprite.push(new BitmapData(16, 16, true, 0x00ff8000));
					sprite[currentSprite].copyPixels(spriteSheet, sourceRectangle, destinationPoint);
					currentSprite ++;
				}
			}
			
			title = new titleClass().bitmapData;
		}
		
		public static function draw(spriteNumber:int, point:Point):void
		{
			Draw.buffer.copyPixels(sprite[spriteNumber], new Rectangle(0, 0, 16, 16), point);
		}
		
	}

}