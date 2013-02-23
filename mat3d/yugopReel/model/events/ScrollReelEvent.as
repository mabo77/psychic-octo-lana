package mat3d.yugopReel.model.events {
	import flash.events.*;

	/**
	 * @author Matthias Bode
	 */
	public class ScrollReelEvent extends Event {
		public static const DEFAULT_NAME : String = "com.mat3d.yugopReel.model.events.ScrollReelEvent";
		// event constants
		public static const ON_CLICKED : String = "onClicked";
		public static const ON_MOVED : String = "onMoved";	
		public static const ON_START:String = "onStart";	
		public var params : Object;		

		public function ScrollReelEvent($type : String, $params : Object, $bubbles : Boolean = false, $cancelable : Boolean = false) {

			super($type, $bubbles, $cancelable);
			this.params = $params;
		}

		public override function clone() : Event {

			return new ScrollReelEvent(type, this.params, bubbles, cancelable);
		}

		public override function toString() : String {

			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
	}
}

