package mat3d.yugopReel.view {
	///////////////////////////////////////////////////////////////
	/**BuildRig ScrollReel[VIEW]
	 * @author mat
	 */
	///////////////////////////////////////////////////////////////
	import flash.display.*;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import	flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;

	import mat3d.yugopReel.model.Observer;
	import mat3d.yugopReel.model.CustomDispatcher;
	import mat3d.yugopReel.view.RIG;
	import mat3d.yugopReel.ScrollReel;
	import mat3d.yugopReel.model.MainModel;

	public class BuildRig extends CustomDispatcher {
		///////////////////////////////////////////////////////////////
		private var _yugopReel : ScrollReel;
		private var _Manager : mat3d.yugopReel.model.MainModel;
		private var _mc : MovieClip;
		private var RIG : Sprite;
		private var LeftBTN : Sprite;
		private var RightBTN : Sprite;
		private var btnWidth : Number;
		private var btnHeight : Number;
		public var decorDisp : CustomDispatcher ;
		public var VIEW : mat3d.yugopReel.view.GUI;
		private var Projector : Sprite;

		///////////////////////////////////////////////////////////////

		public function BuildRig(yR,manager) : void {
			var _yugopReel = yR;
			_mc = _yugopReel.root;
			_Manager = manager;
			btnWidth = 20;
			btnHeight = 20;
			//_mc = mc;
			trace("RIG>>>> " + _yugopReel);
			var RIG = new Sprite();
			RIG.graphics.beginFill(0xFFFFFF);
			RIG.graphics.lineStyle(1, 0xFFFFFF);
			RIG.graphics.drawRect(0, 0, _yugopReel.width, _yugopReel.height);
			RIG.graphics.endFill();
			RIG.name = "RIG";
			_yugopReel.addChild(RIG);
			buildControlButtons(_yugopReel);
		}

		///////////////////////////////////////////////////////////////
		private function buildControlButtons(yR) : void {
			var scope = yR;
			var LeftBTN = new Sprite();
			LeftBTN.graphics.beginFill(0x556688);
			LeftBTN.graphics.lineStyle(1, 0xFFCC77);
			LeftBTN.graphics.drawRoundRect(0, -100, btnWidth, btnHeight, 15);
			LeftBTN.graphics.endFill();
			LeftBTN.name = "LeftBTN";
			LeftBTN.addEventListener(MouseEvent.CLICK, scope.myModel.onControlBtnInput);
			LeftBTN.addEventListener(MouseEvent.MOUSE_OVER, scope.myModel.onControlBtnInputOver);
			scope.addChild(LeftBTN);
			var RightBTN = new Sprite();
			RightBTN.graphics.beginFill(0x774422);
			RightBTN.graphics.lineStyle(1, 0xFFCC77);
			RightBTN.graphics.drawRoundRect(scope.width - 20, -100, btnWidth, btnHeight, 15);
			RightBTN.graphics.endFill();
			RightBTN.name = "RightBTN";
			RightBTN.addEventListener(MouseEvent.CLICK, scope.myModel.onControlBtnInput);
			RightBTN.addEventListener(MouseEvent.MOUSE_OVER, scope.myModel.onControlBtnInputOver);
			scope.addChild(RightBTN);
			buildView(scope);
		}

		///////////////////////////////////////////////////////////////

		public function drawMask() : void {
			var 	scope = this;
			trace(this + ">>>>>>>>>>>>>>");
			var myMask = new Shape();
			myMask.graphics.beginFill(0x556688);
			myMask.graphics.lineStyle(1, 0xFFCC77);
			myMask.graphics.drawRoundRect(-50, 0, btnWidth, btnHeight, 15);
			myMask.graphics.endFill();
			myMask.name = "MASKER";
			//LeftBTN.addEventListener(MouseEvent.CLICK, scope.myModel.onControlBtnInput);
			scope._yugopReel.mask = myMask;
			scope._yugopReel.addChild(myMask);
		}

		///////////////////////////////////////////////////////////////

		private function maskRig() : void {
		}

		///////////////////////////////////////////////////////////////
		private function buildView(yR) : void {
			//drawMask();
			_Manager.buildView();
		}
		
		///////////////////////////////////////////////////////////////
	}
}
