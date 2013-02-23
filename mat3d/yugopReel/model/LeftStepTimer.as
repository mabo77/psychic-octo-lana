package mat3d.yugopReel.model {
	

	/**
	 * @author Matthias Bode
	 */
	import flash.events.*;
	import flash.utils.Timer;

	import mat3d.yugopReel.view.GUI;

	public class LeftStepTimer {
		private var _Manager;
		private var _myTime : Number;
		private var _myLoop : Number;
		public var decorDispatcher : CustomDispatcher;

		public function LeftStepTimer(man,time : Number,loop : Number) {
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
			_Manager.stepMoveLeft();
		}

		public function startTimer() : void {
			_Manager.XTimer.start();
		}

		public function stopTimer() : void {
			_Manager.XTimer.stop();
			_Manager.XTimer.reset();
		}
	}
}
