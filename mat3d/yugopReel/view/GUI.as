package mat3d.yugopReel.view {
	/**
	 * /////////////////////////////////// mat3d.yugopReel.view.GUI //////////////////////////
	 * @author mat

	 * 
	 */
	import flash.display.*;

	import fl.controls.Button;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.containers.UILoader;

	////////////////////////////////////

	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.events.*;
	import flash.display.Shape;
	import flash.filters.*;

	////////////////////////////////////

	import mat3d.yugopReel.ScrollReel;
	import mat3d.yugopReel.model.ObsTimer;
	import mat3d.yugopReel.model.LeftStepTimer;
	import mat3d.yugopReel.model.MoveCallbackTimer;
	import mat3d.yugopReel.model.CustomDispatcher;
	import mat3d.yugopReel.model.MainModel;
	import mat3d.yugopReel.model.events.YugopButtonEvent;

	////////////////////////////////////

	import caurina.transitions.*;

	public class GUI {
		////////////////////////////////////
		private var _yugopReel : ScrollReel;
		public var _Manager : MainModel;
		private var myTimer : ObsTimer;
		private var myLTimer : LeftStepTimer;
		private var myMTimer : MoveCallbackTimer;
		public var decorDispatcher : CustomDispatcher;
		public var XTimer : Timer;
		public var XTTimer : Timer;
		////////////////////////////////////
		private var currentDirection : String;
		public var currentIndex : Number;
		private var  lcounter : Number = 0;
		private var btnWidth : Number;
		private var btnHeight : Number;
		private var realIndex : Number = 0;
		public var stepScrollLeft : Boolean;
		public var stepScrollRight : Boolean;
		///////////////////////////////////
		private var pictures : Array;
		public var myTrackArr : Array;
		public var myTrackXArr : Array;
		///////////////////////////////////
		private var myDirWatcher : Function;
		public var index : Number;
		public var ismoving : Boolean;
		public var moveDetect : Number = 0;
		public var ACTIVE : YugopButton;
		public var picturesLoaded : Boolean = false;
		private var Init : Boolean = false;
		public var isOver : Boolean = false;
		public var TARGET : String;
		public var tempNumber : String;

		///////////////////////////////////

		public function GUI(yR : ScrollReel,mc : MovieClip, initObj : Object,initArr : Array,manager : MainModel) : void {
			_yugopReel = yR;
			var _mc = mc;
			var pObj = initObj;
			var _buttons = new Array();
			var abstand_x = 5;
			index = 0;
			pictures = initArr;
			_Manager = manager;
			ismoving = false;
			createButtons();
			currentIndex = new Number(0);
			myTimer = new ObsTimer(this, 100, 0);
			myTimer.getTimer();
			myMTimer = new MoveCallbackTimer(this, 30, 1);
			myLTimer = new LeftStepTimer(this, 7000, 0);
		}

		///////////////////////////////////

		private function createButtons() : void {
			myTrackArr = new Array();
			myTrackXArr = new Array();
			var myRig : Sprite = _yugopReel.RIG;
			//trace(_yugopReel.buttonHeight + ">>>>>>" + _yugopReel.buttonWidth);
			btnHeight = _yugopReel.buttonHeight;
			btnWidth = _yugopReel.buttonWidth;
			var myMidHeight : Number = (_yugopReel.Height - btnHeight) / 2;
			for(var t : Number = 0;t < pictures.length;t++) {
				var myNewString = new String(pictures[t].Text);
				var yugopButton : YugopButton = new YugopButton(pictures[t].picUrl, "yugopButton" + t, myNewString);
				var myProperty = new Object();
				myProperty.ref = "yugopButton" + t;
				myProperty.src = yugopButton; 
				yugopButton.move((t * btnWidth), myMidHeight);
				yugopButton.alpha = 100;
				yugopButton.addEventListener(Event.ENTER_FRAME, onEnterFrameBeacon);
				yugopButton.addEventListener(YugopButtonEvent.ON_COMPLETE, completeHandler);
				yugopButton.addEventListener(MouseEvent.CLICK, clickHandler);
				yugopButton.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
				yugopButton.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
				_yugopReel.addChild(yugopButton);
				myTrackArr.push(myProperty);
				myTrackXArr.push(myProperty);
			}
			
			var myRiser = new MovieClip();
			myRiser.graphics.beginFill(0x000000);
			myRiser.graphics.lineStyle(1, 0x000000);
			myRiser.graphics.drawRect(0, 0, _yugopReel.Width, _yugopReel.Height);
			myRiser.graphics.endFill();
			myRiser.name = "RISER";
			_yugopReel.addChild(myRiser);
			_yugopReel.mask = myRiser;
		}

		///////////////////////////////////

		private function reelonMove(dir : String,size : Number) : void {
			if(Init == false) {
				switch(dir) {	
					case "left":
						currentDirection = "left";
						for (var q : Number = 0;q < myTrackArr.length;q++) {
							var mytempXXConCat : YugopButton = myTrackArr[q].src;
						
							//ismoving = false;
							if(ACTIVE == mytempConCat) {
								//Tweener.addTween(ACTIVE.content, {_blur_blurX:0, _blur_blurY:0, time:0.5, delay:0.8});	
							} else {
								//Tweener.addTween(mytempXXConCat.content, {_blur_blurX:15, _blur_blurY:15, time:0.2});
							}
							var myLXCar : Number = mytempXXConCat.x - (btnWidth * size);
							ismoving = true;
							Tweener.addTween(mytempXXConCat, {x:myLXCar, time:_yugopReel.ScrollTime, transition:_yugopReel._StepBehaviour, onComplete:setMoving});
						}
						break;
					case "right":
						currentDirection = "right";
						//var track : uint = myTrackArr.length;
						for (var w : Number = 0;w < myTrackArr.length;w++) {
							var myxtempXXConCat : YugopButton = myTrackArr[w].src;

							//ismoving = false;
							myxtempXXConCat.x -= 0;
							if(ACTIVE == myxtempXXConCat) {
								//Tweener.addTween(ACTIVE.content, {_blur_blurX:0, _blur_blurY:0, time:0.5, delay:0.8});	
							} else {
								//Tweener.addTween(myxtempXXConCat.content, {_blur_blurX:15, _blur_blurY:15, time:0.2});
							}
							var myRXCar : Number = myxtempXXConCat.x + (btnWidth * size);
							ismoving = true;
							Tweener.addTween(myxtempXXConCat, {x:myRXCar, time:_yugopReel.ScrollTime, transition:_yugopReel._StepBehaviour, onComplete:setMoving});
						}
						break;
				}
			} else {
				switch(dir) {	
					case "left":
						currentDirection = "left";
						for (var j : Number = 0;j < myTrackArr.length;j++) {
							var mytempConCat : YugopButton = myTrackArr[j].src;
						
							//ismoving = false;
							if(ACTIVE == mytempConCat) {
									//Tweener.addTween(ACTIVE.content, {_blur_blurX:0, _blur_blurY:0, time:0.5, delay:0.8});	
							} else {
								//Tweener.addTween(mytempConCat.content, {_blur_blurX:15, _blur_blurY:15, time:0.2});
							}
							var myLCar : Number = mytempConCat.x - (btnWidth * size);
							ismoving = true;
							Tweener.addTween(mytempConCat, {x:myLCar, time:_yugopReel._ScrollTime, transition:_yugopReel._StepBehaviour, onComplete:setMoving});
						}
						break;
					case "right":
						currentDirection = "right";
						var track : uint = myTrackArr.length;
						for (var g : Number = 0;g < myTrackArr.length;g++) {
							var myxtempConCat : YugopButton = myTrackArr[g].src;
							
							//ismoving = false;
							myxtempConCat.x -= 0;
							if(ACTIVE == myxtempConCat) {
									//Tweener.addTween(ACTIVE.content, {_blur_blurX:0, _blur_blurY:0, time:0.5, delay:0.8});	
							} else {
								//Tweener.addTween(myxtempConCat.content, {_blur_blurX:15, _blur_blurY:15, time:0.2});
							}
							var myRCar : Number = myxtempConCat.x + (btnWidth * size);
							ismoving = true;
							Tweener.addTween(myxtempConCat, {x:myRCar, time:_yugopReel._ScrollTime, transition:_yugopReel._StepBehaviour, onUpdate:setUpdate, onComplete:setMoving});
						}
						break;
				}
			}
		}	

		///////////////////////////////////

		private function setUpdate() {
			if(ismoving == false) {
				ismoving = true;
			}
		}

		///////////////////////////////////

		private function setMoving() : void {
			moveDetect += 1;
			if(moveDetect == pictures.length) {
				//trace("Motion Finished");
				myMTimer.getTimer();
			}
		}

		///////////////////////////////////

		public function moveCallback() : void {
			if(_yugopReel.alpha == 0) {
				Init = true;
			}
			ismoving = false;
			myMTimer.stopTimer();
			if(picturesLoaded == true && Init == true) {
				if(_yugopReel.alpha == 0) {
					ACTIVE = myTrackXArr[0].src;
					fadeScrollReel();
				}
			}
			if(TARGET != tempNumber) {
				trace(toString() + ">>>>>TNumber = " + tempNumber);
				if(tempNumber == "" || tempNumber == null) {
				} else {
					jumpTo(tempNumber);
				}
			}
			tempNumber = "";
		}

		///////////////////////////////////
		
		public function jump(myVal : String) : void {
			var myNum = new Number(myVal);
			currentIndex = myNum;
			var myNVal = new Number(myVal);
			switch(ismoving) {
				case true:
					break;
				case false:
					//trace("Jump called>>>");
					TARGET = myVal;
					if(myNVal > index) {
						if(myNVal > (pictures.length - 2) && index < 2) {
							currentDirection = "right";
							arrangeBeacon();
							arrangeBeacon();
							arrangeBeacon();
							moveDetect = 0;
							reelonMove("right", (pictures.length - myNVal) + index);
						} else {
							currentDirection = "left";
							arrangeBeacon();
							arrangeBeacon();
							arrangeBeacon();
							moveDetect = 0;
							reelonMove("left", myNVal - index);
						}
					} else {
						if(myNVal == 0 && index < (pictures.length - 2)) {
							currentDirection = "right";
							arrangeBeacon();
							arrangeBeacon();
							arrangeBeacon();
							moveDetect = 0;
							reelonMove("right", index);
						}else if(myNVal == 0 && index > pictures.length - 2) {
							currentDirection = "left";
							arrangeBeacon();
							arrangeBeacon();
							arrangeBeacon();
							moveDetect = 0;
							reelonMove("left", (pictures.length - index) + myNVal);
						} else if(myNVal < 2 && index > (pictures.length - 2)) {
							currentDirection = "left";
							arrangeBeacon();
							arrangeBeacon();
							arrangeBeacon();
							moveDetect = 0;
							reelonMove("left", (pictures.length - index) + myNVal);
						} else {
							currentDirection = "right";
							arrangeBeacon();
							arrangeBeacon();
							arrangeBeacon();
							moveDetect = 0;
							//trace("moveRight" + (index - myNVal));
							reelonMove("right", index - myNVal);
						}
					}

					index = myNVal;
					var myCurText = new String();
					for(var e : Number = 0;e < myTrackArr.length;e++) {
						if("yugopButton" + index.toString() == myTrackArr[e].src.name) {
							ACTIVE = myTrackArr[index].src;
							if(index == myTrackArr.length - 1) {
								myCurText = pictures[0].Text;
							}else if(index == 0 || index > 0 && index < (myTrackArr.length - 1)) {
								myCurText = pictures[index + 1].Text;
							}
						}
					}
					_Manager.startHandler(ACTIVE.name, myCurText);
					break;
			}
		}

		///////////////////////////////////
		
		public function arrangeBeacon() : void {			
			switch(currentDirection) {
				case "left":
					var mytrack : uint = myTrackArr.length;
					for (var g : Number = 0;g < myTrackArr.length;g++) {
						var mytempConCat : YugopButton = myTrackArr[g].src;
						if (mytempConCat.x < -580) {
							mytempConCat.x += mytrack * btnWidth;
							var myNewObject = new Object();
							myTrackArr.push(myTrackArr.shift());
						}
					}
					break;
				case "right":
					var track : uint = myTrackArr.length;
					for (var d : Number = 0;d < myTrackArr.length;d++) {
						var myxtempConCat : YugopButton = myTrackArr[d].src;
						if (myxtempConCat.x > _yugopReel.width) {
							var myXDist : Number = myxtempConCat.x + btnWidth;
							myxtempConCat.x -= track * btnWidth;
							myTrackArr.unshift(myTrackArr.pop());
						}
					}
					break;
				case "up":
					break;
				case "down":
					break;
			}
		}

		///////////////////////////////////

		public function stepMoveLeft() : void {
			if(isOver == true || ismoving == true) {
			} else {
				if(currentIndex < pictures.length - 1) {
					currentIndex += 1;
				}else if (currentIndex == pictures.length - 1) {
					currentIndex = 0;
				}
				if(realIndex < pictures.length - 1) {
					realIndex += 1;
				}else if(realIndex == pictures.length - 1) {
					realIndex = 0;
				}
				jump(currentIndex.toString());
			}
		}

		///////////////////////////////////

		public function stepMoveRight() : void {
		}

		///////////////////////////////////

		public function MoveLeft() {
			if(ismoving == true) {
			} else {
				if(currentIndex < pictures.length - 1) {
					currentIndex += 1;
					trace(">>>>" + currentIndex + "<<<<");
				}else if (currentIndex == pictures.length - 1) {
					currentIndex = 0;
				}
				if(realIndex < pictures.length - 1) {
					realIndex += 1;
				}else if(realIndex == pictures.length - 1) {
					realIndex = 0;
				}
				jump(currentIndex.toString());
			}
		}

		///////////////////////////////////

		public function MoveRight() {
			if(ismoving == true) {
			} else {
				if(currentIndex == 0) {
					currentIndex = pictures.length - 1;
					trace(">>>>" + currentIndex + "<<<<");
				}else if (currentIndex > 0) {
					currentIndex -= 1;
				}
				if(realIndex == 0) {
					realIndex = pictures.length - 1;
				}else if(realIndex > 0) {
					realIndex -= 1;
				}
				jump(currentIndex.toString());
			}
		}

		///////////////////////////////////

		public function clickHandler(event : MouseEvent) : void {
			if(ismoving == true) {
				tempNumber = event.target.parent.parent.name;
				trace("TRUE");
			} else {
			}
		}

		///////////////////////////////////
		
		public function overHandler(event : MouseEvent) : void {
			isOver = true;
		}

		///////////////////////////////////

		public function jumpTo(nbr : String) : void {
			if(ismoving == true) {
				tempNumber = nbr;
			} else {
				var myNumber = new Number(nbr);
				var myNewNumber = new Number();
				if(myNumber == 0) {
					myNewNumber = pictures.length - 3;
				}else if(myNumber == 1) {
					myNewNumber = pictures.length - 2;
				}else if(myNumber == 2) {
					myNewNumber = pictures.length - 1;
				} else {
					myNewNumber = myNumber - 3;	
				}
				var newString = new String(myNewNumber);
				for(var e : Number = 0;e < myTrackArr.length;e++) {
					if(myNumber.toString() == myTrackArr[e].src.name) {
						ACTIVE = myTrackArr[e].src;
					}
				}
				jump(newString);
				ismoving = true;
			}
		}

		///////////////////////////////////

		public function hooverHandler(dir : String) : void {
			switch(dir) {
				case "left":
					currentDirection = "left";
					break;
				case "right":
					currentDirection = "right";
					break;
			}
		}

		///////////////////////////////////

		private function outHandler(event : MouseEvent) : void {
			isOver = false;
		}

		///////////////////////////////////

		private function completeHandler(event : YugopButtonEvent) : void {
			var scope = this;
			lcounter += 1;
			event.target.setSize(btnWidth, btnHeight);
			if(lcounter == pictures.length) {
				picturesLoaded = true;
				var myNString : Number = pictures.length - 1;
				jump(myNString.toString());
				myLTimer.getTimer();
			}
		}

		///////////////////////////////////

		private function drawMask() {
			var scope = this;
		}

		///////////////////////////////////

		private function fadeScrollReel() : void {
			Tweener.addTween(_yugopReel, {alpha:1, time:0.5, transition:"easeInOutExpo", delay:1});
		}

		///////////////////////////////////

		private function progressHandler(event : Event) : void {
			//trace("[ PROGRESS ]Number of bytes loaded: " + event.bytesLoaded);
		}

		///////////////////////////////////

		private function onEnterFrameBeacon(event : Event) : void {
			//trace(event.target.x);
		}

		///////////////////////////////////

		public function startMove() : void {
			myLTimer.startTimer();
		}

		///////////////////////////////////

		public function stopMove() : void {
			myLTimer.stopTimer();
		}

		///////////////////////////////////

		public function toString() : String {
			return "mat3d.yugopReel.view.GUI";
		}
		
		///////////////////////////////////
	}
}



