package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	

	
	/**
	 * This class converts input strings to blitted text, applied to Draw.buffer
	 * remember that lowercase 'a' converts to charcode 97
	 * and that '0' converts to 48
	 */
	
	public class Text
	{
		public static var colors:Array;
		public static var spacing:Number;
		
		//spritesheet bitmap
		private static var spriteSheet:BitmapData;
		//destination vector for sliced sprites
		public static var sprite:Vector.<BitmapData>;
		
		//fuggly importing
		[Embed(source = "../lib/alphabet.gif")]
		private static var spriteSheetClass:Class;
		
		public static function initialize():void
		{
			
			colors = [new BitmapData(10,10,false,0xFF0000), new BitmapData(10,10,false,0x00FF00), new BitmapData(10,10,false,0x0000FF)];
			// Prepare sprites
			spriteSheet = new spriteSheetClass().bitmapData;

			// Slice sprite sheet into sub-images
			sprite = new Vector.<BitmapData>();
			var sourceRectangle:Rectangle = new Rectangle(0, 0, 8, 8);
			var destinationPoint:Point = new Point(0, 0);
			var currentSprite:int = 0;
			for (var y:int = 0; y < spriteSheet.height / 8; y ++) {
				for (var x:int = 0; x < spriteSheet.width / 8; x ++) {
					sourceRectangle.x = x * 8;
					sourceRectangle.y = y * 8;
					sprite.push(new BitmapData(8, 8, true, 0x00ff8000));
					sprite[currentSprite].copyPixels(spriteSheet, sourceRectangle, destinationPoint);
					currentSprite ++;
				}
			}
			spacing = 9;
		}
		
		public static function print(x:Number, y:Number, text:String, ... altspacing):void
		{
			//optional spacing argument, otherwise default to 9px

			var shift:int;
			
			if (altspacing[0]) {
				shift = altspacing[0];
			} else {
				shift = 0;
			}
			
			
			
			
			//clean our unput string
			text = text.toLowerCase();
			
			for (var i:uint = 0; i < text.length; i++) {
				
				var character:uint;
				
				if (text.charCodeAt(i) > 47 && text.charCodeAt(i) < 59) {
					//a number, zero to 9
					character = text.charCodeAt(i) - 18;
				}
				else if (text.charCodeAt(i) < 97 || text.charCodeAt(i) > 123) {
					//for spaces or any other non alphanumeric char
					character = 26;
				} else {
					//this is a regular alphabet char
					character = text.charCodeAt(i)-97;
				}
				
				var temp:uint = 1;
				if (altspacing[1]) {
					temp = altspacing[1];
				}
				
				Draw.buffer.copyPixels(colors[(character+shift)%3],new Rectangle(0,0,16,16), new Point(x+ i * spacing, y),sprite[character]);
				
			}
			
		}
		
	}

}