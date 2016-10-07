package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import fl.motion.MotionEvent;
	import flash.net.SharedObject;
	import flash.ui.Mouse;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class LumberJACKED extends MovieClip {
		
		//soundtranform
		var volume1:SoundTransform = new SoundTransform();
		var volume2:SoundTransform = new SoundTransform();
		var volume3:SoundTransform = new SoundTransform();
		var volume4:SoundTransform = new SoundTransform();
		
		//sounds
		var backgroundsound:Backroundsound;
		var bigguy:Bigguy;
		var spectresound:Spectresound;
		var spoder1:Spider;
		
		//sound channels
		var channel1:SoundChannel = new SoundChannel();
		var channel2:SoundChannel = new SoundChannel();
		var channel3:SoundChannel = new SoundChannel();
		var channel4:SoundChannel = new SoundChannel();
		
		//invisible walls
		var wall1:Wall;
		var wall2:Wall;
		var wall3:Wall;
		var wall4:Wall;
	
		//hud and such
		var isAlive: Boolean;
		var button1: Buttons;
		var startscreen: Start;
		var gamestart: Boolean;
		var background1: Background;
		var HUD1: HUD;
		var youDied: Youdied;

		//spectre spawn
		var spectreArray: Array = new Array();
		var spectreCounter: int = 15;

		//mini1 spawn
		var mini1Array: Array = new Array();
		var mini1Counter: int = 2;

		//mini2 spawn
		var mini2Array: Array = new Array();
		var mini2Counter: int = 2;

		//crosshair
		var crosshair1: Crosshair;

		//movement
		var shoot: Boolean;

		//player
		var jackA: Jack;
		var hearts: Number;
		var ammo: Number;
		var canfireAmmo: Boolean;
		var score: Number;

		//nails
		var nailArray: Array = new Array();

		//firetimer
		var fireTimer: Timer;
		var canFire: Boolean = true;

		//powerups
		var powerfast: PowerFast;
		var powerTimer: Boolean = true;
		var powerFrameCounter: Number;
		var canPower: Timer;
		var countdown: Boolean;
		var frameCounter: int;
		var powerframeCounter: int;
		var powerSpawnCounter: int;
		var powerSpawn: Boolean;
		var powerArray: Array = new Array();

		//boxes
		var ammoboxArray: Array = new Array();
		var ammoSpawn: Boolean;
		var ammoSpawnCounter: int;
		var ammoCountdown: Boolean;
		var ammoframeCounter: int;

		var heartboxArray: Array = new Array();
		var heartSpawn: Boolean;
		var heartSpawnCounter: int;
		var heartCountdown: Boolean;
		var heartframeCounter: int;


		public function LumberJACKED() {
			
			volume1.volume = 0.1;
			volume2.volume = 0.1;
			volume3.volume = 0.1;
			volume4.volume = 0.1;
			
			gamestart = true;

			gameStart();

			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		public function spectreSpawn() {
			if (spectreArray.length == 0) {
				this.spectreCounter *= 1.5;
				spawnEnemy(spectreCounter);
			}
		}

		public function mini1Spawn() {
			if (mini1Array.length == 0) {
				this.mini1Counter *= 1.5;
				spawnMini1(mini1Counter);
			}
		}

		public function mini2Spawn() {
			if (mini2Array.length == 0) {
				this.mini2Counter *= 1.1;
				spawnMini2(mini2Counter);
			}
		}

		public function spawnPowerFast(value: int) {
			for (var i: int = 0; i < value; i++) {
				var power1: PowerFast = new PowerFast();
				background1.addChild(power1);
				power1.x = Math.random() * 7000;
				power1.y = Math.random() * 4000;
				powerArray.push(power1);
				powerSpawn = true;
				powerSpawnCounter = 0;
			}
		}

		public function spawnHeartbox(value: int) {
			for (var i: int = 0; i < value; i++) {
				var heartBox1: Heartbox = new Heartbox();
				background1.addChild(heartBox1);
				heartBox1.x = Math.random() * 7000;
				heartBox1.y = Math.random() * 4000;
				heartboxArray.push(heartBox1);
				heartSpawn = true;
				heartSpawnCounter = 0;
			}
		}

		public function spawnAmmobox(value: int) {
			for (var i: int = 0; i < value; i++) {
				var ammoBox1: Ammobox = new Ammobox();
				background1.addChild(ammoBox1);
				ammoBox1.x = Math.random() * 7000;
				ammoBox1.y = Math.random() * 4000;
				ammoboxArray.push(ammoBox1);
				ammoSpawn = true;
				ammoSpawnCounter = 0;
			}
		}

		public function spawnEnemy(value: int) {
			for (var i: int = 0; i < value; i++) {
				var enemy: Spectre = new Spectre();
				background1.addChild(enemy);
				enemy.position.x = Math.random() * 7000 + 1280;
				enemy.position.y = Math.random() * 4000 + 768;
				var random:int = Math.floor(Math.random() * 4);
				if (random == 0) {
				}
				spectreArray.push(enemy);
			}
		}

		public function spawnMini1(value: int) {
			for (var i: int = 0; i < value; i++) {
				var miniboss1: mini1 = new mini1();
				background1.addChild(miniboss1);
				miniboss1.position.x = Math.random() * 7000 + 25;
				miniboss1.position.y = Math.random() * 4000 + 25;
				mini1Array.push(miniboss1);
			}
		}

		public function spawnMini2(value: int) {
			for (var i: int = 0; i < value; i++) {
				var miniboss2: mini2 = new mini2();
				background1.addChild(miniboss2);
				miniboss2.position.x = Math.random() * 7000 + 25;
				miniboss2.position.y = Math.random() * 4000 + 25;
				mini2Array.push(miniboss2);
			}
		}


		public function bulletHit(): int {
			spectresound = new Spectresound();
			
			for (var i: int = 0; i < nailArray.length; i++) {
				for (var j: int = 0; j < spectreArray.length; j++) {
					if (nailArray[i].isEnabled && nailArray[i].hitTestObject(spectreArray[j])) {
						nailArray[i].isEnabled = false;
						spectreArray[j].isEnabled = false;
						
						channel2 = spectresound.play();
						channel2.soundTransform = volume2;
					}
				}
			}
			return 1;
		}

		public function bulletHitMini1(): int {
			bigguy = new Bigguy;
			
			for (var i: int = 0; i < nailArray.length; i++) {
				for (var j: int = 0; j < mini1Array.length; j++) {
					if (nailArray[i].isEnabled && nailArray[i].hitTestObject(mini1Array[j])) {
						nailArray[i].isEnabled = false;
						mini1Array[j].isEnabled = false;
						
						channel3 = bigguy.play(10, 0);
						channel3.soundTransform = volume3;
					}
				}
			}
			return 1;
		}

		public function bulletHitMini2(): int {
			spoder1 = new Spider;
			
			for (var i: int = 0; i < nailArray.length; i++) {
				for (var j: int = 0; j < mini2Array.length; j++) {
					if (nailArray[i].isEnabled && nailArray[i].hitTestObject(mini2Array[j])) {
						nailArray[i].isEnabled = false;
						mini2Array[j].isEnabled = false;
						
						channel4 = spoder1.play();
						channel4.soundTransform = volume4;
					}
				}
			}
			return 1;
		}
		
		public function wall1Hit() {
			if (jackA.hitTestObject(wall1)){
				background1.left = false;
			}
		}
		
		public function wall2Hit() {
			if (jackA.hitTestObject(wall2)){
				background1.right = false;
			}
		}
		
		public function wall3Hit() {
			if (jackA.hitTestObject(wall3)){
				background1.up = false;
			}
		}
		
		public function wall4Hit() {
			if (jackA.hitTestObject(wall4)){
				background1.down = false;
			}
		}


		public function spectreHitJack() {
			for (var i: int = 0; i < spectreArray.length; i++) {
				if (spectreArray[i].hitTestObject(jackA)) {
					hearts -= 1;
					return (hearts);
				}
			}
		}

		public function mini1HitJack() {
			for (var j: int = 0; j < mini1Array.length; j++) {
				if (mini1Array[j].hitTestObject(jackA)) {
					hearts -= 3;
					return (hearts);
				}
			}
		}

		public function mini2HitJack() {
			for (var j: int = 0; j < mini2Array.length; j++) {
				if (mini2Array[j].hitTestObject(jackA)) {
					hearts -= 0.05;
					return (hearts);
				}
			}
		}

		private function fireTimerHandler(e: TimerEvent): void {
			canFire = true;
		}

		public function powerTimerHandler(e: TimerEvent): void {
			powerTimer = true;
		}

		//ammo handler
		public function shootNail(): void {
			if (canfireAmmo == false) {

			} else {
				if (canFire == true) {
					var nail = new Nail();
					nail.rotation = jackA.rotation;
					addChild(nail);
					nail.y = jackA.position.y;
					nail.x = jackA.position.x;
					nailArray.push(nail);
					fireTimer.start();
					ammo -= 1;
					canFire = false;
				}
			}
		}


		public function haveAmmo() {
			if (ammo <= 0) {
				canfireAmmo = false;
			}
		}

		public function spectreDespawn() {

			for (var l: int = 0; l < nailArray.length; l++) {
				if (!nailArray[l].isEnabled) {
					removeChild(nailArray[l]);
					nailArray[l] = null;
					nailArray.splice(l, 1);
				}
			}

			for (var k: int = 0; k < spectreArray.length; k++) {
				if (!spectreArray[k].isEnabled) {
					background1.removeChild(spectreArray[k]);
					spectreArray[k] = null;
					spectreArray.splice(k, 1);
					score += 100;
				}
			}
		}

		public function mini1Despawn() {


			for (var k: int = 0; k < mini1Array.length; k++) {
				if (!mini1Array[k].isEnabled) {
					background1.removeChild(mini1Array[k]);
					mini1Array[k] = null;
					mini1Array.splice(k, 1);
					score += 500;
				}
			}
		}

		public function mini2Despawn() {


			for (var k: int = 0; k < mini2Array.length; k++) {
				if (!mini2Array[k].isEnabled) {
					background1.removeChild(mini2Array[k]);
					mini2Array[k] = null;
					mini2Array.splice(k, 1);
					score += 500;
				}
			}
		}

		//-----------------------------------------------------------------------------------------------\\
		//gebruik hitTestPoint om rand te maken.
		//-----------------------------------------------------------------------------------------------\\

		public function gameStart() {
			
			this.startscreen = new Start();
			this.addChild(startscreen);
			this.startscreen.x = 0;
			this.startscreen.y = 0;
			this.startscreen.width = 1280;
			this.startscreen.height = 768;

			this.button1 = new Buttons();
			startscreen.addChild(button1);
			this.button1.x = 500;
			this.button1.y = 500;
			button1.alpha = 0.8;
		}

		public function setupGame() {

			cleanUp();
			this.youDied = new Youdied();

			isAlive = true;

			gamestart = false;
			powerSpawn = true;
			ammoSpawn = true;
			heartSpawn = true;

			hearts = 101;
			ammo = 150;
			
			canfireAmmo = true

			shoot = false;
			
			backgroundsound = new Backroundsound();
			channel1 = backgroundsound.play(0, 9999);
			channel1.soundTransform = volume1;
			
			this.background1 = new Background();
			spawnEnemy(10);
			addChild(background1);
			background1.position.x = -3840;
			background1.position.y = -2160;
			
			wall1 = new Wall;
			background1.addChild(wall1);
			wall1.x = 1324;
			wall1.y = 2500;
			wall1.height = 7000;
			wall1.alpha = 0;
			
			wall2 = new Wall;
			background1.addChild(wall2);
			wall2.x = 7050;
			wall2.y = 2500;
			wall2.height = 7000;
			wall2.alpha = 0;
			
			wall3 = new Wall;
			background1.addChild(wall3);
			wall3.y = 590;
			wall3.x = 4000;
			wall3.width = 9000;
			wall3.alpha = 0;
			
			wall4 = new Wall;
			background1.addChild(wall4);
			wall4.y = 4277;
			wall4.x = 4000;
			wall4.width = 9000;
			wall4.alpha = 0;
			
			this.HUD1 = new HUD;
			addChild(HUD1);
			this.HUD1.x = 250;
			this.HUD1.y = 75;

			this.jackA = new Jack;
			addChild(jackA);
			jackA.position.x = 640;
			jackA.position.y = 384;
			score = 0;

			fireTimer = new Timer(250, 1);
			canPower = new Timer(50000, 1);
			
			crosshair1 = new Crosshair();
			addChild(crosshair1);

		}

		public function cleanUp() {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			while (nailArray.length > 0) {
				nailArray.splice(0, 1);
			}
			while (spectreArray.length > 0) {
				spectreArray.splice(0, 1);
			}
			while (mini1Array.length > 0) {
				mini1Array.splice(0, 1);
			}
			while (mini2Array.length > 0) {
				mini2Array.splice(0, 1);
			}
		}
		public function gameOver() {

			isAlive = false;

			if (this.contains(this.jackA)) {
				removeChild(jackA);
			}
			if (!this.contains(youDied)) {

				addChild(youDied);
				this.youDied.x = 500;
				this.youDied.y = 350;				
			}
		}

		public function update(e: Event) {
			
			if (isAlive == false) {
				canFire = false;
			}

			if (gamestart) {
				if (button1.hasBeenClicked) {								
					trace("Boom");
					setupGame(); 
				}
			} else {
				HUD1.update(score, hearts, ammo);				

				haveAmmo();

				spectreHitJack();
				spectreDespawn();
				bulletHit();
				spectreSpawn();

				mini1HitJack();
				mini1Despawn();
				bulletHitMini1();
				mini1Spawn();

				mini2HitJack();
				mini2Despawn();
				bulletHitMini2();
				mini2Spawn();
				
				wall1Hit();
				wall2Hit();
				wall3Hit();
				wall4Hit();
				
				Mouse.hide();
				
				crosshair1.x = mouseX;
				crosshair1.y = mouseY;

				if (hearts <= 0) {
					gameOver();
				}

				for (var u = 0; u < spectreArray.length; u++) {
					spectreArray[u].update(jackA.x - background1.position.x, jackA.y - background1.position.y);
				}

				for (var m = 0; m < mini1Array.length; m++) {
					mini1Array[m].update(jackA.x - background1.position.x, jackA.y - background1.position.y);
				}

				for (var f = 0; f < mini2Array.length; f++) {
					mini2Array[f].update(jackA.x - background1.position.x, jackA.y - background1.position.y);
				}

				background1.update();

				//player rotates to mouse
				jackA.update(mouseX, mouseY);

				if (ammoCountdown == true) {
					ammoframeCounter++;
				}

				if (heartCountdown == true) {
					heartframeCounter++;
				}

				if (countdown == true) {
					powerframeCounter++;
				}

				if (powerSpawn == true) {
					powerSpawnCounter++;
				}

				if (heartSpawn == true) {
					heartSpawnCounter++;
				}

				if (ammoSpawn == true) {
					ammoSpawnCounter++;
				}

				//powerups trigger
				for (var j: int = 0; j < powerArray.length; j++) {
					if (powerArray[j].hitTestObject(jackA)) {
						powerframeCounter = 0;
						countdown = true;
						background1.speed = 35;
						powerArray[j].x = -10000000;
					}
				}

				for (var p: int = 0; p < ammoboxArray.length; p++) {
					if (ammoboxArray[p].hitTestObject(jackA)) {
						ammoframeCounter = 0;
						ammoCountdown = true;
						ammo += 100;
						ammoboxArray[p].x = -10000000;
					}
				}

				for (var o: int = 0; o < powerArray.length; o++) {
					if (heartboxArray[o].hitTestObject(jackA)) {
						heartframeCounter = 0;
						heartCountdown = true;
						hearts += 70;
						heartboxArray[o].x = -10000000;
					}
				}
				
				if (hearts > 100) {
					hearts = 100;
				}

				if (powerframeCounter > 48) {
					countdown = false;
				}

				if (powerSpawnCounter > 480) {
					powerSpawn = false;
				}

				if (ammoSpawnCounter > 480) {
					ammoSpawn = false;
				}

				if (heartSpawnCounter > 480 ) {
					heartSpawn = false;
				}

				if (powerSpawn == false) {
					spawnPowerFast(5);
				}

				if (heartSpawn == false) {
					spawnHeartbox(5);
				}

				if (ammoSpawn == false) {
					spawnAmmobox(5);
				}

				if (countdown == false) {
					background1.speed = 10;
				}

				if (shoot) {
					shootNail();
				}

				//nail shoot and shit
				for (var i: int = 0; i < nailArray.length; i++) {
					nailArray[i].update();
				}

				//firedelay
				frameCounter++;
				if (frameCounter > 6) {
					canFire = true;
					frameCounter = 0;
				}
			}
		}

		private function keyDownHandler(event: KeyboardEvent): void {
			if (isAlive) {
				switch (event.keyCode) {
					case Keyboard.W:
						background1.up = true;
						break;

					case Keyboard.S:
						background1.down = true;
						break;

					case Keyboard.A:
						background1.left = true;
						break;

					case Keyboard.D:
						background1.right = true;
						break;
					default:
						break;
				}
			}
			if (event.keyCode == Keyboard.R) {
				setupGame();
			}
		}


		private function keyUpHandler(event: KeyboardEvent): void {
			switch (event.keyCode) {
				case Keyboard.W:
					background1.up = false;
					break;

				case Keyboard.S:
					background1.down = false;
					break;

				case Keyboard.A:
					background1.left = false;
					break;

				case Keyboard.D:
					background1.right = false;
					break;
			}
		}

		private function mouseDownHandler(event: MouseEvent): void {
			switch (event.type) {
				case MouseEvent.MOUSE_DOWN:
					shoot = true;
					break;

				default:
					break;
			}
		}

		private function mouseUpHandler(event: MouseEvent): void {
			switch (event.type) {
				case MouseEvent.MOUSE_UP:
					shoot = false;
					break;
			}
		}

	}
}