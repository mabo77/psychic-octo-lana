package com.fg.display {
	import flash.display.*;

	public class DisplayObjectAdapter implements IDisplayObject {
		private var displayObject : DisplayObject;

		public function get x() : Number { 
			return displayObject.x; 
		}

		public function set x(value : Number) : void { 
			displayObject.x = value; 
		}

		public function get width() : Number { 
			return displayObject.x; 
		}

		public function set width(value : Number) : void { 
			displayObject.width = value; 
		}

		// etc for all display object properties

		public function DisplayObjectAdapter(displayObject : DisplayObject) {
			this.displayObject = displayObject;
		}
	}
}