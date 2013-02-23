package mat3d.yugopReel.model {

	public class Observer {
		private var _handler : Function;
		private var _source : Object;
		private var handlerInitialized : Boolean = false;
		private var sourceInitialized : Boolean = false;

		public function get handler() : Function {
			return _handler;
			trace("ObserverPing");
		}

		public function set handler(value : Function) : void {
			_handler = value;
			if (value != null) {
				handlerInitialized = true;
				if (handlerInitialized && sourceInitialized) {
					callHandler();
				}
			}
		}

		public function get source() : Object {
			return _source;
		}

		public function set source(value : Object) : void {
			_source = value;
			sourceInitialized = true;
			if (handlerInitialized && sourceInitialized) {
				callHandler();
			}
		}

		private function callHandler() : void {
			try {
				_handler.call(null, _source);
			} catch (error : Error) {
				throw error;
			}
		}
	}
}

