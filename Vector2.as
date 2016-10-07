package  {
	
	public class Vector2 {
		
		public var x:Number;
		public var y:Number;
		
		public function Vector2(x_:Number = 0, y_:Number = 0) {
			x = x_;
			y = y_;
		}
		
		public function calDis(from:Vector2, to:Vector2) {
			x = to.x - from.x;
			y = to.y - from.y;
		}
		
		public function add(vector:Vector2) {
			x = x + vector.x;
			y = y + vector.y;
		}
		
		static function add(v1:Vector2, v2:Vector2) {
			var v3:Vector2 = new Vector2(v1.x + v2.x, v1.y + v2.y);
			return v3;
		}
		
		public function sub(vector:Vector2) {
			x = x - vector.x;
			y = y - vector.y;
		}
		
		static function sub(v1:Vector2, v2:Vector2) {
			var v3:Vector2 = new Vector2(v1.x - v2.x, v1.y - v2.y);
			return v3;
		}
		
		public function div(vector:Vector2) {
			x = x / vector.x;
			y = y / vector.y;
		}
		
		public function mult(vector:Vector2) {
			x = x * vector.x;
			y = y * vector.y;
		}
		
		public function multS(scale:Number) {
			x = x * scale;
			y = y * scale;
		}
		
		public function mag() :Number {
			var mag:Number = Math.sqrt(x*x + y*y);
			return mag;
		}
		
		public function normalize() {
			var lenghtS:Number = mag();
			if (lenghtS != 0) {
				divS(lenghtS);
			}
		}
		
		public function divS(scale:Number) {
			x = x / scale;
			y = y / scale;
		}
		
		public function limit(max:Number) {
			if (mag() > max) {
				normalize();
				multS(max);
			}
		}
		
		public function getAngle()
		{
			var Radians:Number = Math.atan2(y,x);
			var Degrees = Radians * 180 / Math.PI;
			return Degrees;
		}
		
		public function getAngelRelTo(v:Vector2):Number {
			var angle:Number = Math.atan2(v.y - y, v.x - x);
			var degrees:Number = angle * 180 / Math.PI;
			return degrees;
		}
		
		public function copy():Vector2 {
			var v: Vector2 = new Vector2(this.x, this.y);
			return v;
		}
	}
}


