package mat3d.yugopReel.model {

	/**
	 * @author Matthias Bode
	 */
	import flash.events.*;
	import flash.utils.Timer;

	import mat3d.yugopReel.view.GUI;

	public class MoveCallbackTimer {
		private var _Manager;
		private var _myTime : Number;
		private var _myLoop : Number;
		public var decorDispatcher : CustomDispatcher;

		public function MoveCallbackTimer(man,time : Number,loop : Number) {
			_Manager = man;
			_myTime = time;
			_myLoop = loop;
		}

		public function getTimer() : void {
			_Manager.XTTimer = new Timer(_myTime, _myLoop);
			_Manager.XTTimer.addEventListener("timer", timerHandler);
			_Manager.XTTimer.start();
		}

		public function timerHandler(event : TimerEvent) : void {
			//trace("timerHandler: " + event);
			_Manager.moveCallback();
		}

		public function startTimer() : void {
			_Manager.XTTimer.start();
		}

		public function stopTimer() : void {
			_Manager.XTTimer.stop();
			_Manager.XTTimer.reset();
		}
	}
}
