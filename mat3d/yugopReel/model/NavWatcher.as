package mat3d.yugopReel.model {
	/**
	 * @author Matthias Bode 
	 */
	 import mat3d.yugopReel.*;

	import flash.display.*;

	public class NavWatcher {
		private var REEL : ScrollReel;

		public function NavWatcher(yR) {
			REEL = yR;
			trace("NAVWATCHER");
		}

		public function get NavState() : String {
			return NavState;
		}

		public function set NavState(param_name : String) {
			trace("NavState has Changed");
		}
	}
}
