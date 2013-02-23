package mat3d.yugopReel.model {
	import flash.events.Event;
	import flash.display.Sprite;

	import mat3d.yugopReel.model.CustomDispatcher;

	public class ReelDispatcher  extends Sprite {
		public function ReelDispatcher() {
			var dispatcher : CustomDispatcher = new CustomDispatcher();
			dispatcher.addEventListener(CustomDispatcher.ACTION, actionHandler);
			dispatcher.doAction();
		}

		private function actionHandler(event : Event) : void {
			trace("actionHandler: " + event);
		}
	}
}


