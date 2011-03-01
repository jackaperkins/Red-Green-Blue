package  
{
	import adobe.utils.ProductManager;
	import flash.accessibility.Accessibility;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.ShaderParameter;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author jack
	 */
	public class Draw
	{
		public static var buffer:BitmapData;
		public static var noise:BitmapData;
		public static var width:int;
		public static var height:int;
		
		public static var startup:int; //title screen startup timer
		
		public static var red:uint;
		public static var green:uint;
		public static var blue:uint;
		
		public static var gameSpeed:Number;
		public static var floorHeight:int;
		
		public static var level:Array;
		
		public static var player:Player;
		public static var monsters:Vector.<Mover>;
		
		public static var color1:uint;
		public static var color2:uint;
		public static var wipe:Number;
		
		public static var bgArray:Array;
		public static var bgArray2:Array;
		
		public static var count:Number;
		
		public static var score:int;
		public static var highScore:int;
		
		public static var titleY:Number;
		
		public static var first:Boolean;

		public static function initialize(stage:Stage):void 
		{
			level = new Array();
			
			first = true;
			
			width = 200;
			height = 150;
			buffer = new BitmapData(width, height, false);
			var temp:Bitmap = new Bitmap(buffer);
			
			temp.scaleX = temp.scaleY = 4;
			stage.addChild(temp);
			
			noise = new BitmapData(150, 200);
			for (var i:int = 0; i < 340; i++) {
				for (var k:int = 0; k < 340; k++) {
					noise.setPixel(i, k, Math.round(Math.random()) * 0xFFFFFFFF);
				}
			}
			
			red = 0xFF0000;
			green = 0x00FF00;
			blue = 0x0000FF;
			
			gameSpeed = 1.5;
			floorHeight = 100;
			
			monsters = new Vector.<Mover>();
			
			player = new Player(60, 200);
			player.falling = true;
			player.dead = true;
			player.y = 200;
			
			color1 = red;
			color2 = green;
			wipe = 0;
			
			//timer for oscillating the floor
			count = 0;
			
			score = 0;
			highScore = 0;
			
			//flying in our title graphic
			titleY = -60;
			
			bgArray = [red, green, blue, red, green, blue];
			bgArray2 = [red, red, red, red, red, red];
			for (i = 0; i < bgArray.length; i++) {
				bgArray2[i] = getColor(bgArray[i]);
			}
		}
		
		// THE MAIN GAME LOOP:
		public static function frame(e:Event):void
		{	
			buffer.fillRect(new Rectangle(0, 0, 1, 1), 0xff0000);
			if (first) {
				SoundEffect.play(3);
				first = false;
			}
			
			gameSpeed = 1.5 + score / 300.0;
			
			var i:int;
			if(score > 50){
				count = (count + 0.018) % (Math.PI * 2);
			} else {
				count = 0;
			}
			floorHeight = 90 + Math.sin(count) * (int(score/50))*4;
			//floorHeight = 86;
			drawBackground();
			
			for (var m:int = 0; m < monsters.length; m++) {
				var monster:Mover = monsters[m];
				monster.go();
				monster.display();
				if (Mover.hit(monster, player)) {
					//kill the player
					player.falling = true;
					if (score > highScore) {
						highScore = score;
					}
					score = 0;
					SoundEffect.play(0);
					player.ySpeed = -2;
					monsters.splice(m, 1);
					
				}
				if (monster.remove) {
					monsters.splice(m, 1);
					if(!player.falling){
					score += 10;
					}
				}
			}
			
			player.go();
			player.display();
			
			if (player.dead) {
				if (titleY < 30) {
					titleY += 1.5;
				} else {
						for (i = 0; i < 1;i++){
					Text.print(54, 93+i*9, "PRESS START",i);
					}
					if (highScore < 50) {
					Text.print(40, 110, "JACK A PERKINS", bgArray2[1]*10);	
					} else {
					Text.print(54, 110, "BEST " + highScore.toString(), highScore);
					}
					if (Input.GetState(Input.JUMP)) {
						player.dead = false; 
						player.falling = false;
						player.x = 50;
						player.y = -8;
						player.ySpeed = 0;
						player.xSpeed = 3;
						titleY = -60;
					}
				}
				buffer.copyPixels(Blit.title, new Rectangle(0, 0, 100, 60), new Point(50, titleY));	
			} else {
				Text.print(5, 5, score.toString(), score);
			}
		}
		
		// GETCOLOR : return one of the two other colors different from the one we pass in
		public static function getColor(color1:uint):uint
		{
			
			var color2:uint;
			var temp:Number = Math.random() * 3;
			if (temp < 1) {
					color2 = red;
				} else if (temp > 1 && temp < 2) {
					color2 = green;
				} else {
					color2 = blue;
			}
			if (color2 != color1) {
				return color2;
			} else {
				return getColor(color1);
			}
		}
		
		// DRAWBACKGROUND moves the background arrays, checks to see if we need a new column
		// and adds monsters
		public static function drawBackground():void
		{
			//our array is x long, but we slice the screen up into x-1 slices so there's an extra segment
			var slices:int = bgArray.length - 1;
			if (wipe - gameSpeed < -width / slices) {
				wipe = 0;
				for (var q:int = 0; q < bgArray.length - 1; q++) {
					bgArray[q] = bgArray[q + 1];
					bgArray2[q] = bgArray2[q +1];
				}
				bgArray[bgArray.length - 1] = getColor(bgArray[bgArray.length - 1]); 
				if (Math.random() > 0.85 && !player.falling) {
					bgArray2[bgArray2.length - 1] = bgArray[bgArray.length - 1];
				} else {
					bgArray2[bgArray2.length - 1] = getColor(bgArray[bgArray.length - 1]);
				}
				if (!player.falling && monsters.length < 2 && Math.random() > 0.8) {
					if(score > 100){
						if(Math.random()>0.45){
							monsters.push(new Goblin(width + 10, 80));
						} else {
							monsters.push(new Bird(width + 10, 20));
						}
					} else {	
						monsters.push(new Goblin(width + 10, 80));
					}	
				}
			} else {
				wipe -= gameSpeed;
			}
			
			//color it
			for (var i:int = 0; i < slices +1; i++) {
				buffer.fillRect(new Rectangle(i * (width / slices) + wipe, 0, (i + 1) * (width / slices) + wipe, floorHeight), bgArray[i]);
				buffer.fillRect(new Rectangle(i * (width / slices) + wipe, floorHeight, (i + 1) * (width / slices) + wipe, height - floorHeight), bgArray2[i]);
			}
		}
		
		public static function floor(x:Number):Boolean { //return if there is floor here or not
			var slices:int = bgArray.length - 1;
			var wallX:Number = x - wipe;
			var index:int = int(wallX / (width/slices) );
			if (bgArray[index] == bgArray2[index]) {
				return true;
			}else {
				return false;
			}
		}
	}

}