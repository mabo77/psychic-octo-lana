package mat3d.yugopReel.model {
	import flash.events.*;
	import flash.utils.Timer;

	import mat3d.yugopReel.view.GUI;

	public class ObsTimer {
		private var _Manager;
		private var _myTime : Number;
		private var _myLoop : Number;
		public var decorDispatcher : CustomDispatcher;

		public function ObsTimer(man,time : Number,loop : Number) {
			_Manager = man;
			_myTime = time;
			_myLoop = loop;
		}

		public function getTimer() : void {
			_Manager.XTimer = new Timer(_myTime, _myLoop);
			_Manager.XTimer.addEventListener("timer", timerHandler);
			_Manager.XTimer.start();
		}

		public function timerHandler(event : TimerEvent) : void {
			//trace("timerHandler: " + event);
			_Manager.arrangeBeacon();
		}
	}
}
