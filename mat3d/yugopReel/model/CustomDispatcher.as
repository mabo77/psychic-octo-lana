package mat3d.yugopReel.model {
	import flash.events.EventDispatcher;
	import flash.events.Event;

	public class CustomDispatcher extends EventDispatcher {
		public static var ACTION : String = "action";

		public function doAction() : void {
			//trace("Dispatcher"+toString());
			dispatchEvent(new Event(CustomDispatcher.ACTION));
		}

		public override function toString() : String {
			return super.toString();
		}
	}
}
