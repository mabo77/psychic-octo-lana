// Copyright 2007. Adobe Systems Incorporated. All Rights Reserved.
package fl.example {
	import flash.events.Event;

	public class MenuEvent extends Event {

		public static const ITEM_SELECTED : String = "itemSelected";

		private var _menuIndex : int;
		private var _menuLabel : String;
		private var _itemIndex : int;
		private var _itemLabel : String;

		public function MenuEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false,
		                           menuIndex : int = -1, menuLabel : String = null, itemIndex : int = -1, itemLabel : String = null ) {
			super(type, bubbles, cancelable);
			this.menuIndex = menuIndex;
			this.menuLabel = menuLabel;
			this.itemIndex = itemIndex;
			this.itemLabel = itemLabel;
		}

		public function get menuIndex() : int {
			return _menuIndex;
		}

		public function set menuIndex(value : int) : void {
			_menuIndex = value;
		}

		public function get menuLabel() : String {
			return _menuLabel;
		}

		public function set menuLabel(value : String) : void {
			_menuLabel = value;
		}

		public function get itemIndex() : int {
			return _itemIndex;
		}

		public function set itemIndex(value : int) : void {
			_itemIndex = value;
		}

		public function get itemLabel() : String {
			return _itemLabel;
		}

		public function set itemLabel(value : String) : void {
			_itemLabel = value;
		}

		override public function toString() : String {
			return formatToString("MenuEvent", "type", "bubbles", "cancelable", "eventPhase", "menuIndex", "menuLabel", "itemIndex", "itemLabel");
		}

		override public function clone() : Event {
			return new MenuEvent(type, bubbles, cancelable, menuIndex, menuLabel, itemIndex, itemLabel);
		}
	}
}
