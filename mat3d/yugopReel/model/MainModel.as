package mat3d.yugopReel.model {
	////////////////////////////////////////////////////////
	import fl.data.DataProvider;
	import fl.events.ComponentEvent;
	import fl.data.DataProvider;

	////////////////////////////////////////////////////////

	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.MouseEvent;

	////////////////////////////////////////////////////////

	import mat3d.yugopReel.model.*;
	import mat3d.yugopReel.model.events.*;
	import mat3d.yugopReel.view.*;

	////////////////////////////////////////////////////////
	public class MainModel extends EventDispatcher {
		public var VIEW : mat3d.yugopReel.view.GUI;
		private var REEL;
		private var dataProvider : DataProvider;
		private var Watcher : NavWatcher;
		public var myEvent : MoveEvent;
		private var XMLDrive : mat3d.yugopReel.model.XmlDrive;
		public var decorDispatcher : CustomDispatcher;
		public var MoveDispatcher : CustomDispatcher;
		public var decorDisp : CustomDispatcher;
		private var move : MoveEvent;
		public var myRIG : mat3d.yugopReel.view.BuildRig;
		public var NavState : String;
		public var directiion : String;
		private var Areax : Array;
		private var Areay : Number;

		////////////////////////////////////////////////////////

		public function MainModel(yR) : void {
			REEL = yR;
			REEL.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			var MoveDispatcher = new CustomDispatcher();
			MoveDispatcher.addEventListener("onMove", testTrace);
		}

		////////////////////////////////////////////////////////

		public function testTrace(event : Event) : void {
			trace(">>>>>>>>>>>>>> TestDispatcher");		}

		////////////////////////////////////////////////////////

		private function getNavSectors() : void {
			Areax = new Array();
			Areay = 100;
			var counter : Number = 3;
			for(var t : Number = 0;t < counter;t++) {
				var myNum : Number = Math.round((t + 1) * (REEL.width / counter));
				Areax.push(myNum);
			}
		}

		////////////////////////////////////////////////////////

		private function onNavChange(event : Event) : void {
			switch (NavState) {
				case "left":
					trace("is to the Left State");
					break;
				case "right":
					break;
				case "idle":
					break;
			}
		}

		////////////////////////////////////////////////////////

		public function handleData() : void {
			getNavSectors();
			var scope = this;
			switch(REEL.FileType) {
				case "XML":
					XMLDrive = new XmlDrive(REEL);
					XMLDrive.decorDispatcher = new CustomDispatcher();
					XMLDrive.decorDispatcher.addEventListener("onLoaderResult", onDataResult);
					break;
				case "DATAPROVIDER":
					if (dataProvider == null) {
						dataProvider = new DataProvider();
					}
					break;
			}
		}

		////////////////////////////////////////////////////////

		private function mouseMoveHandler(event : MouseEvent) : void {
			if(event.localX < Areax[0] && event.localY < Areay) {
				NavState = "left";
			}
			if(event.localX > Areax[0] && event.localX < Areax[1]) {
				if(event.localY < Areay) {
					NavState = "idle";
				}
			}
			if(event.localX > Areax[1] && event.localX < Areax[2]) {
				if(event.localY < Areay) {
					NavState = "right";
				}
			}
		}

		////////////////////////////////////////////////////////

		private function onDataResult(event : Event) : void {
			var scope = this;
			var myRIG = new BuildRig(REEL, this);
			myRIG.decorDisp = new CustomDispatcher();
			myRIG.decorDisp.addEventListener("onBuild", buildView);
		}

		////////////////////////////////////////////////////////

		public function onControlBtnInput(event : Event) : void {
			var myName = event.target.name;
			switch(myName) {
				case "LeftBTN":
					VIEW.stepMoveLeft();
					break;
				case "RightBTN":
					VIEW.stepMoveRight();
					break;
			}
		}

		////////////////////////////////////////////////////////
		public function onControlBtnInputOver(event : Event) : void {
			var myName = event.target.name;
			switch(myName) {
				case "LeftBTN":
					VIEW.hooverHandler("left");
					break;
				case "RightBTN":
					VIEW.hooverHandler("right");
					break;
			}
		}

		public function MoveLeft() {
			VIEW.MoveLeft();
		}

		public function MoveRight() {
			VIEW.MoveRight();
		}

		public function buildView() : void {
			VIEW = new GUI(REEL, REEL.root, REEL.myPropInit, REEL.ConfigData, this);
		}

		public function startMove() {
			VIEW.startMove();
		}

		public function stopMove() {
			VIEW.stopMove();
		}

		public function clickHandler(id : String,selector : String) {
			REEL.dispatchEvent(new ScrollReelEvent(ScrollReelEvent.ON_CLICKED, {param1: id, param2: selector})); 
		}

		public function moveHandler(id : String,selector : String) {
			REEL.dispatchEvent(new ScrollReelEvent(ScrollReelEvent.ON_MOVED, {param1: id, param2: selector})); 
		}

		public function startHandler(id : String,selector : String) {
			REEL.dispatchEvent(new ScrollReelEvent(ScrollReelEvent.ON_START, {param1: id, param2: selector})); 
		}

		public function jump(myVal : String) {
			//trace(toString() + myVal);
			VIEW.jumpTo(myVal);
		}

		////////////////////////////////////////////////////////

		public override function toString() : String {
			return super.toString();
		}	}
		////////////////////////////////////////////////////////
}

