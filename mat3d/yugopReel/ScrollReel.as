package mat3d.yugopReel {
	////////////////////////////////////////////////////////
	import flash.display.*;
	import flash.text.TextField;
	import flash.events.*;
	import flash.events.MouseEvent;

	////////////////////////////////////////////////////////

	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.data.DataProvider;
	import fl.events.DataChangeEvent;
	import fl.events.ComponentEvent;
	import fl.containers.UILoader;

	////////////////////////////////////////////////////////

	import mat3d.yugopReel.model.CustomDispatcher;
	import mat3d.yugopReel.model.*;

	import nl.demonsters.debugger.MonsterDebugger;

	import caurina.transitions.*;

	////////////////////////////////////////////////////////
	public class ScrollReel extends UIComponent {
		private var debugger : MonsterDebugger;
		////////////////////////////////////////////////////////

		protected var _dataProvider : DataProvider;

		public var RIG : Sprite;
		public var LeftBTN : Sprite;
		public var RightBTN : Sprite;
		public var MASKER : Shape;
		public var RISER : MovieClip;
		public var MASKone : MovieClip;
		public var decorDispatcher : CustomDispatcher;
		public var myModel : mat3d.yugopReel.model.MainModel;
		public var yugopButton : UILoader;
		private var _Manager;
		////////////////////////////////////////////////////////
		private var _background : Sprite;  
		private var _Xmc : MovieClip;
		////////////////////////////////////////////////////////
		private var _tf : TextField;
		////////////////////////////////////////////////////////
		public var _buttonWidth : Number;
		public var _buttonHeight : Number;
		public var _AutoScroll : Boolean;
		public var _StepControl : Boolean;
		////////////////////////////////////////////////////////
		private var _FileType : String;
		public var _File : String;
		private var _text : String;
		public var _ScrollInit : String;
		public var _StepBehaviour : String;
		public var _PictureSize : String;
		////////////////////////////////////////////////////////
		public var _ScrollTime : Number;
		public var abstand_x : Number = 90;
		public var abstand_y : Number = 125;
		//public var INDEX : Number;

		public var myPropInit : Object;
		public var ConfigData : Array;

		
		////////////////////////////////////////////////////////

		public function ScrollReel() {
			//debugger = new MonsterDebugger(this);
			super();
			myPropInit = new Object();
			myPropInit.AutoScroll = false;
			myPropInit.FileType = false;
			myPropInit.File = false;
			myPropInit.Width = false;
			myPropInit.Height = false;
			myPropInit.ScrollTime = false;
			myPropInit.ScrollInit = false;
			myPropInit.StepControl = false;
			myPropInit.StepBehaviour = false;
			myPropInit.PictureSize = false;
			alpha = 0;
			if (dataProvider == null) {
				dataProvider = new DataProvider();
			}
			myModel = new mat3d.yugopReel.model.MainModel(this);
		}

		////////////////////////////////////////////////////////  >> start get set INSPECTABLES
		//////////////////////////////////////////////////////// AutoScroll start
		public function get buttonWidth() : Number {
			return _buttonWidth;
		}

		public function set buttonWidth(value : Number) : void {
			_buttonWidth = value;
		}

		[Inspectable(name="buttonWidth",defaultValue="0",type="Number")]

		public function get buttonHeight() : Number {
			return _buttonHeight;
		}

		public function set buttonHeight(value : Number) : void {
			_buttonHeight = value;
		}

		[Inspectable(name="buttonHeight",defaultValue="0",type="Number")]

		public function get AutoScroll() : Boolean {
			return _AutoScroll;
			myPropInit.AutoScroll = true;
		}

		public function set AutoScroll(value : Boolean) : void {
			_AutoScroll = value;
			myPropInit.AutoScroll = true;
		}

		[Inspectable(name="AutoScroll",defaultValue="false",type="Boolean")]

		//////////////////////////////////////////////////////// AutoScroll end
		//////////////////////////////////////////////////////// FileType start
		public function get FileType() : String {
			return _FileType;
			myPropInit.FileType = true;
		}

		public function set FileType(value : String) : void {
			_FileType = value;
			myPropInit.FileType = true;
		}

		[Inspectable(name="FileType",defaultValue="XML",type="String")]

		//////////////////////////////////////////////////////// FileType end
		//////////////////////////////////////////////////////// Filestart
		public function get File() : String {
			return _File;
			myPropInit.File = true;
		}

		public function set File(value : String) : void {
			_File = value;
			myPropInit.File = true;
			////////////////////////////////////////////////////////
			init();
		}

		[Inspectable(name="File",defaultValue="",type="String")]

		//////////////////////////////////////////////////////// File end
		//////////////////////////////////////////////////////// Width start
		public function get Width() : Number {
			return width;
			myPropInit.Width = true;
		}

		public function set Width(value : Number) : void {
			width = value;
			//trace("setWidth >>>" + width);
			myPropInit.Width = true;
		}

		[Inspectable(name="Width",defaultValue="250",type="Number")]

		//////////////////////////////////////////////////////// Width end
		//////////////////////////////////////////////////////// Height start
		public function get Height() : Number {
			return  height;
			myPropInit.Height = true;
		}

		public function set Height(value : Number) : void {
			height = value;
			trace("setHeight >>>" + height);
			myPropInit.Height = true;
		}

		[Inspectable(name="Height",defaultValue="50",type="Number")]

		//////////////////////////////////////////////////////// Height end
		//////////////////////////////////////////////////////// ScrollTime start
		public function get ScrollTime() : Number {
			return  _ScrollTime;
			myPropInit.ScrollTime = true;
		}

		public function set ScrollTime(value : Number) : void {
			_ScrollTime = value;
			myPropInit.ScrollTime = true;
		}

		[Inspectable(name="ScrollTime",defaultValue="0.2",type="Number")]

		//////////////////////////////////////////////////////// ScrollTime end
		//////////////////////////////////////////////////////// ScrollInit start
		public function get ScrollInit() : String {
			return  _ScrollInit;
			myPropInit.ScrollInit = true;
		}

		public function set ScrollInit(value : String) : void {
			_ScrollInit = value;
			myPropInit.ScrollInit = true;
		}

		[Inspectable(name="ScrollInit",defaultValue="_x",type="String")]

		//////////////////////////////////////////////////////// ScrollInit end
		//////////////////////////////////////////////////////// PicSize start
		public function get PictureRatio() : String {
			return  _PictureSize;
			myPropInit.PictureSize = true;
		}

		public function set PictureRatio(value : String) : void {
			_PictureSize = value;
			myPropInit.PictureSize = true;
		}

		[Inspectable(name="PictureSize",defaultValue="",type="String")]

		//////////////////////////////////////////////////////// PictureSize end
		//////////////////////////////////////////////////////// Step Controll start
		public function get StepControl() : Boolean {

			return  _StepControl;
			myPropInit.StepControl = true;
		}

		public function set StepControl(value : Boolean) : void {
			_StepControl = value;
			myPropInit.StepControl = true;
		}

		[Inspectable(name="StepControl",defaultValue="false",type="Boolean")]

		//////////////////////////////////////////////////////// Step Controll end
		//////////////////////////////////////////////////////// Step Behaviour start
		public function get StepBehaviour() : String {
			return  _StepBehaviour;
			myPropInit.StepBehaviour = true;
		}

		public function set StepBehaviour(value : String) : void {
			_StepBehaviour = value;
			myPropInit.StepBehaviour = true;
		}

		[Inspectable(name="StepBehaviour",defaultValue="easeInOutQuad",type="String")]

		//////////////////////////////////////////////////////// Step Behaviour end
		//////////////////////////////////////////////////////// DataProviderstart
		[Collection(collectionClass="fl.data.DataProvider", collectionItem="fl.data.SimpleCollectionItem", identifier="item")]

		public function set dataProvider(value : DataProvider) : void {
			if (_dataProvider != null) {
				_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange);
			}
			_dataProvider = value;
			_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange, false, 0, true);
			invalidate();
		}

		public function get dataProvider() : DataProvider {
			return _dataProvider;
		}

		protected function handleDataChange(e : DataChangeEvent) : void {
			invalidate();
		}

		//////////////////////////////////////////////////////// DataProvider  end
		////////////////////////////////////////////////////////  >> end get set INSPECTABLES

		private function init() : void {
			myModel .handleData();
		}

		public function onClicked(e : Event) {
			dispatchEvent(new Event("onClicked"));
		}

		public function onStart(e : Event) {
			dispatchEvent(new Event("onStart"));
		}

		public function startScroll() {
			myModel.startMove();
		}

		public function stopScroll() {
			myModel.stopMove();
		}

		public function Jump(myVal : String) {
			trace("jumper" + myVal);
			myModel.jump(myVal);
		}

		public function  MoveLeft() : void {
			myModel.MoveLeft();
		}

		public function MoveRight() : void {
			myModel.MoveRight();
		}

		////////////////////////////////////////////////////////
		protected function getSkinName() : String {
			return "MyComponentSkin1";
		}

		////////////////////////////////////////////////////////
		public override function toString() : String {
			return super.toString();
		}
	}
}