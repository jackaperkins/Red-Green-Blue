package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author jack
	 */
	public class Player extends Mover
	{
		private var animator:Number;
		public var xSpeed:Number;
		public var ySpeed:Number;
		private var jumping:Boolean;
		private var released:Boolean;
		public var falling:Boolean; 
		public var dead:Boolean;
		private var soundTimer:Number;
	
		
		private static var maxSpeed:Number;
		
		public function Player(xx:Number, yy:Number) 
		{
			super(xx, yy);
			animator = 0;
			xSpeed = 0;
			ySpeed = 0;
			jumping = false;
			released = false;
			falling = false;
			dead = false;
			maxSpeed = 2.3;
			soundTimer = 0;
		}
		
		public override function go():void
		{
			if (x < 8 ) {
				x = 8;
			} else if (x > Draw.width - 8) {
				x = Draw.width - 8;
			}
			if (falling) {
				if (ySpeed < 6 ) {
					ySpeed += 0.2;
				}
				y += ySpeed;
				if (y > Draw.height*2) {
					dead = true;
				}
			
			} else {
				
			
			if (ySpeed < 6) {
				if (jumping && !released && !Input.GetState(Input.JUMP) && ySpeed < 0 && ySpeed > -3) {
					released = true;
					ySpeed = 0;
				}
				ySpeed += 0.2;
			}
			
			if (y+ySpeed < Draw.floorHeight - 8) {
				y += ySpeed;
			} else {
				if (Draw.floor(x)) {
					falling = true;
					if (Draw.score > Draw.highScore) {
						Draw.highScore = Draw.score;
					}
					if (ySpeed < 0) {
						ySpeed = 0;
					}
					Draw.score = 0;
					SoundEffect.play(2);
				
				} else {
				y = Draw.floorHeight - 8;
				ySpeed = 0;
				soundTimer = soundTimer + 1;
				if (soundTimer > 10) {
				soundTimer = 0;
				SoundEffect.play(1);
					Draw.score += 1;
				}
				if (jumping && !Input.GetState(Input.JUMP)) {
					jumping = false;
				}
				}
			}

			if (Input.GetState(Input.JUMP) && y == Draw.floorHeight-8 && !jumping)
			{
				ySpeed = -4;
				SoundEffect.play(4);
				jumping = true;
				released = false;
			}
			
			
			if (Input.GetState(Input.LEFT))
			{
				if( Math.abs(xSpeed) < maxSpeed || xSpeed > 0) {
					xSpeed -= .2;
				}
			} else if (Input.GetState(Input.RIGHT))
			{
				if( Math.abs(xSpeed) < maxSpeed || xSpeed < 0) {
					xSpeed += .2;
				}
			} else {
				xSpeed = xSpeed * 0.7;
			}
			
			}
			
			x += xSpeed;
			

			
			
		}
		
		public override function display():void
		{
			animator = (animator + 0.2) % 4;
			Blit.draw(int(animator), new Point(x-8, y-8));
		}
		
	}

}