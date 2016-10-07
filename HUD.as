package  {
	
	import flash.display.MovieClip;
	
	
	public class HUD extends MovieClip {
		
		public function HUD() {
			// constructor code
			Score.text = "0";
			Hearts.text = "0";
			Ammo.text = "0";
		}
		
		public function update(score, hearts, ammo) {
			Score.text = score;
			Hearts.text = hearts;
			Ammo.text = ammo;
			
			if (hearts < 0) {
				Hearts.text = "0";
			}
		}
	}
	
}
