package mat3d.yugopReel.view {
	/////////////////////////////////////////////
	//import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.events.*;
	import fl.containers.UILoader;
	import flash.display.*;
	import mat3d.yugopReel.model.events.YugopButtonEvent;

	/**
	 * @author mat
	 */
	/////////////////////////////////////////////
	public class YugopButton extends MovieClip {
		private var Reel;
		private var loader : Loader;
		private var Image : MovieClip;
		private var myBitmap : Bitmap;
		private var myNewBitmap : Bitmap;
		public var Url : String;
		public var Name:String;
		public var Text : String;
		private var RIG : Sprite;
		private var Projector : UILoader;

		/////////////////////////////////////////////
		public function YugopButton(url : String,name : String,text : String) {
			//var RIG = new Sprite();
			Url = url;
			this.name = name;
			Text = text;
			//trace(toString() + ">>>>> launched");
			super();
			drawButton(RIG);
		}

		/////////////////////////////////////////////

		private function drawButton(riG : Sprite) : void {
			//var newImage:MovieClip;
			var LeftBTN = new Sprite();
			LeftBTN.graphics.beginFill(0x556688);
			LeftBTN.graphics.lineStyle(1, 0xFFCC77);
			LeftBTN.graphics.drawRoundRect(0, 0, 90, 130, 15);
			LeftBTN.graphics.endFill();
			LeftBTN.name = "LeftBTN";
			addChild(LeftBTN);
			loader = new Loader();
			loader.load(new URLRequest(Url)); 
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
		}

		/////////////////////////////////////////////

		private function onLoaderInit(er : Event) : void {
			//trace(">>Init");
		}

		/////////////////////////////////////////////

		private function onLoaderComplete(ev : Event) : void {
			//trace("Complete");
			var Image = new MovieClip();  
			var myBitmap = Bitmap(loader.content).bitmapData; 
			loader.unload();  
			var myNewBitmap : Bitmap = new Bitmap(myBitmap);   
			myNewBitmap.smoothing = true;  
			addChild(myNewBitmap);
			dispatchEvent(new YugopButtonEvent(YugopButtonEvent.ON_COMPLETE, {param1: "", param2: ""})); 
		}

		/////////////////////////////////////////////

		public function setSize(w : int,h : int) : void {
			this.width = w;
			this.height = h;
		}

		/////////////////////////////////////////////

		public function move(x : int,y : int) : void {
			this.x = x;
			this.y = y;
		}

		/////////////////////////////////////////////

		override public function toString() : String {
			return super.toString();
		}
	}
	/////////////////////////////////////////////
}
