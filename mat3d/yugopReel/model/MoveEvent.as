package mat3d.yugopReel.model {
	import flash.events.Event;

	public class MoveEvent extends Event {       

		public static const Move : String = "move";

		///////////////////////////////////////////////////////
		public var myDirection : String;

		///////////////////////////////////////////////////////

		public function MoveEvent(direction : String) {
			super(Move);
			this.myDirection = direction;
			trace("MoveEvent" + myDirection);
		}

		///////////////////////////////////////////////////////
		public override function clone() : Event {
			return new MoveEvent(myDirection);
		}

		///////////////////////////////////////////////////////
		public override function toString() : String {
			return formatToString("MoveEvent", "type", "bubbles", "cancelable", "eventPhase", "direction");
		}
		///////////////////////////////////////////////////////
	}
}
