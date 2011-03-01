package  
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author jack
	 */
	public class Goblin extends Mover
	{
		public var centerY:Number;
		public var wobble:Number;
		public var animator:Number;
		
		
		public function Goblin(xx:Number,yy:Number) 
		{
			super(xx, yy);
			centerY = yy;
			wobble = 0;
			animator = 0;
		}
		
		public override function go():void
		{
			wobble = (wobble + 0.061) % (Math.PI * 2);
			animator = (animator + 0.08) % 2;
			
			
			x -= Draw.gameSpeed;
			
			if (x < -8) {
				remove = true;
			}
			y = centerY + Math.sin(wobble)*10;
		}
		
		public override function display():void
		{
			Blit.draw(int(animator+4), new Point(x-8, y-8));
			//		Draw.buffer.copyPixels(Blit.sprite[4], new Rectangle(0, 0, 16, 16), new Point(x, y));	
		}	
	}
}