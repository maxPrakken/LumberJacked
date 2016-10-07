package  {
	
	import flash.display.MovieClip;
	
	
	public class Spectre extends MovieClip {
		
		var position:Vector2;
		var velocity:Vector2;
		var acceleration:Vector2;
		var topSpeed:Number;
		var jackRef:Jack;
		var player:Vector2;
		var plX:int;
		var plY:int;
		
		var isEnabled:Boolean = true;
		
		public function Spectre() {
			// constructor code
			
			position = new Vector2(0, 0);
			velocity = new Vector2(0, 0);
			acceleration = new Vector2(0, 0);
			
			topSpeed = 9;
		}
		
		public function update(plX, plY):void {
			move(plX, plY);
			
			x = position.x;
			y = position.y;
		}
		
		public function move(plX, plY):void {
			
			var player:Vector2 = new Vector2(plX, plY);
			var direction:Vector2 = Vector2.sub(player, position);
			this.rotation = this.position.getAngelRelTo(player)+90;
			//direction.normalize();
			
			direction.multS(0.5);
			acceleration.add(direction);
			velocity.add(acceleration);
			velocity.limit(topSpeed);
			position.add(velocity);
			acceleration.multS(0);
			
		}
	}
	
}
