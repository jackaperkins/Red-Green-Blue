package  
{
	import flash.geom.Point;
	import flash.ui.ContextMenuItem;
	/**
	 * ...
	 * @author jack
	 */
	public class Bird extends Mover
	{
		public var diving:Boolean;
		public function Bird(xx:Number, yy:Number) 
		{
			super(xx, yy);
			diving = false;
		}
			
		public override function go():void {
			if (x - Draw.player.x < 40) {
				diving = true;
			}
			if (diving) {
				x -= Draw.gameSpeed;
				y += Draw.gameSpeed;
			} else {
			x -= Draw.gameSpeed * 0.8;
			}
			if (x < -8) {
				remove = true;
			}
		}
		
		public override function display():void {
		if (diving) {
			Blit.draw(7, new Point(x-8, y-8));
		} else {
		
			Blit.draw(6, new Point(x-8, y-8));
		}
		}
		
	}

}