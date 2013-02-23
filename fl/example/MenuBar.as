// Copyright 2007. Adobe Systems Incorporated. All Rights Reserved.
package fl.example {
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import fl.controls.listClasses.CellRenderer;
	import fl.controls.listClasses.ICellRenderer;
	import fl.controls.List;
	import fl.controls.TileList;
	import fl.core.UIComponent;
	import fl.data.DataProvider;
	import fl.events.DataChangeEvent;

	import fl.example.*;

	public class MenuBar extends UIComponent {

		// storage for dataProvider property--using the property
		// name preceded by an underscore is a common practice.
		protected var _dataProvider : DataProvider;

		// keepMenuOpen is used to signal to the stage listener events
		// that they should not close the menus if the event was received
		// by the TileList menu bar or List drop down menu first
		protected var keepMenuOpen : Boolean = false;

		// a TileList for the menu bar
		protected var myMenuBar : TileList;

		// list of Lists for drop down menus
		protected var myMenus : Array;

		/*
		 * constructor
		 */
		public function MenuBar() {
			// initialize to an empty Array to avoid annoying null checks
			myMenus = new Array();
			trace("Menu Bar Implied >> UP");

			// initialize dataProvider to non-null to save us from null checks later
			if (dataProvider == null) {
				dataProvider = new DataProvider();
			}
		}

		/*
		 * configUI() is called by the fl.core.UIComponent constructor
		 * after the style and invalidation infrastructure for the component
		 * is initialized.  This is the place to create display objects
		 * and add them to the display list, not the constructor.
		 */
		override protected function configUI() : void {
			// always call super.configUI() in your implementation
			super.configUI();

			// dynamically create myMenuBar
			myMenuBar = new TileList();
			addChild(myMenuBar);

			// turning off selectable makes the TileList instance behave more like a menu bar
			myMenuBar.selectable = false;

			// The default cellRenderer style for TileList is fl.controls.listClasses.ImageCell, which
			// lays out a label below an image.  In our case this lay out is pushing the label toward
			// the top of the cell, not the center, so we use fl.controls.listClasses.CellRenderer
			// instead, which centers the label in the cell.
			myMenuBar.setStyle("cellRenderer", CellRenderer);

			// need to listen for a mouseDown event on the menu bar TileList
			// to start the menu handling.  Other mouse event handlers will
			// be added after the initial mouseDown on the TileList menu bar
			// and removed when the menus are closed.
			myMenuBar.addEventListener(MouseEvent.MOUSE_DOWN, menuBarMouseHandler);
		}

		/*
		 * With the dynamic component version of MenuBar, we need a dataProvider property
		 * to populate the menu bar and the drop downs.  To keep it simple and to make
		 * it work well with the collection dialog, the dataProvider uses SimpleCollectionItem,
		 * the same as List, which is a label and data pair.  In our case, label is the
		 * menu bar item and data is a comma delimited list of drop down menu items.
		 *
		 * This function was adapted from the SelectableList.as implementation with a few
		 * changes.  The component code is a great reference when creating your own components!
		 */
		[Collection(collectionClass="fl.data.DataProvider", collectionItem="fl.data.SimpleCollectionItem", identifier="item")]

		public function set dataProvider(value : DataProvider) : void {
			if (_dataProvider != null) {
				_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange);
			}
			_dataProvider = value;
			_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange, false, 0, true);
			invalidate();
		}

		public function get dataProvider() : DataProvider {
			return _dataProvider;
		}

		/*
		 * When the DataProivder is changed, we call invalidate()
		 * to force an eventual call of draw().
		 */
		protected function handleDataChange(e : DataChangeEvent) : void {
			invalidate();
		}

		/*
		 * draw() clears out the menu, lays it out based on its
		 * height and width and fills it with data based on the dataProvider.
		 * This method is called when the height, width or dataProvider
		 * properties are set.
		 */
		override protected function draw() : void {
			// first clear out everything.
			clearMenus();

			// resize the menu bar
			myMenuBar.width = width;
			myMenuBar.height = height;
			myMenuBar.rowHeight = height;

			// fill the menu bar and create the drop down menus for each dataProvider entry
			for (var i : int = 0;i < _dataProvider.length; i++) {
				initMenu(_dataProvider.getItemAt(i));
			}

			// if we have menus, then we set up the rowHeights, heights, widths and locations of everything
			if (myMenus.length > 0) {
				// distribute the menus evenly across the menu bar
				myMenuBar.columnWidth = (myMenuBar.width / myMenus.length);
				// make each drop down menu below the corresponding menu bar cell,
				// make it the same width as the the cell and match its height to
				// its contents
				for (var j : int = 0;j < myMenus.length; j++) {
					var theMenu : List = (myMenus[j] as List);
					theMenu.x = (myMenuBar.columnWidth * j);
					theMenu.y = myMenuBar.height;
					theMenu.width = myMenuBar.columnWidth;
					theMenu.height = theMenu.dataProvider.length * theMenu.rowHeight;
					// This line is very important!  Invalidating a subcomponent during a validate() or
					// call to draw() can leave things in a funky state where the subcomponent is never
					// validated.  When things are not updating as they should, try calling drawNow()!
					theMenu.drawNow();
				}
			}
			// see previous comment on use of drawNow()
			myMenuBar.drawNow();
			
			// always call super.draw() at the end
			super.draw();
		}

		/*
		 * removes all event listeners, wipes the data from the menu bar
		 * and destroys all drop down Lists from myMenus array
		 */
		protected function clearMenus() : void {
			closeMenuBar();
			myMenuBar.dataProvider = new DataProvider();
			while (myMenus.length > 0) {
				var theMenu : List = (myMenus.shift() as List);
				removeChild(theMenu);
			}
		}

		/*
		 * sets up the menu item for given index.  Grabs the dataProvider
		 * element for that instance, uses label for the item label in
		 * the menu bar, creates a drop down menu and parses the comma
		 * delimited data to populate the drop down menu.
		 */
		protected function initMenu(item : Object) : void {
			myMenuBar.dataProvider.addItem({label:item.label});
			var str : String = item.data;
			var tokens : Array = str.split(",");
			var theMenu : List = createMenu();
			for (var i : int = 0;i < tokens.length; i++) {
				theMenu.dataProvider.addItem({label:tokens[i]});
			}
		}

		/*
		 * creates drop down List instance.
		 */
		protected function createMenu() : List {
			var theMenu : List = new List();
			theMenu.visible = false;
			theMenu.selectable = false;
			myMenus.push(theMenu);
			addChildAt(theMenu, 0);
			return theMenu;
		}

		/*
		 * Handler for mouse events for TileList menu bar.
		 */
		protected function menuBarMouseHandler(e : MouseEvent) : void {
			var cellRenderer : ICellRenderer = e.target as ICellRenderer;
			if (cellRenderer == null) return;

			var theMenu : List;
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					theMenu = myMenus[cellRenderer.listData.index] as List;
					openMenuBar(theMenu);
					// see MOUSE_UP handling below for discussion of keepMenuOpen
					keepMenuOpen = true;
					break;
				case MouseEvent.MOUSE_OVER:
					theMenu = myMenus[cellRenderer.listData.index] as List;
					hideAllMenusExcept(theMenu);
					break;
				case MouseEvent.MOUSE_UP:
					// this event will only be hit on the first mouseUp after the
					// first mouseDown which opened the menus.  We need to handle
					// this to prevent the stage mouseUp listener from closing the
					// menus.  We could stop the stage listener from getting the
					// event at all by calling e.stopPropagation(), but since this
					// will eventually become component code that could be used in
					// an arbitrary application, it seems dangerous to stop event
					// propagation since we do not know what sort of event handling
					// the user might be coding on top of ours.  So instead we use
					// the keepMenuOpen:Boolean.
					myMenuBar.removeEventListener(MouseEvent.MOUSE_UP, menuBarMouseHandler);
					keepMenuOpen = true;
					break;
			}
		}

		/*
		 * Handler for mouse events for List drop down menus.
		 */
		protected function menuMouseHandler(e : MouseEvent) : void {
			var cellRenderer : ICellRenderer = e.target as ICellRenderer;
			if (cellRenderer == null) return;

			switch (e.type) {
				case MouseEvent.MOUSE_UP:
					// we will dispatch an event!
					// first get the list this was selected from, so we can use it to determine
					// which menu bar item this drop down menu comes from
					var theMenu : List = cellRenderer.listData.owner as List;
					// the menu bar index matches the index of the List in myMenus array
					var menuIndex : int = myMenus.indexOf(theMenu);
					// menuIndex to get the label from myMenuBar's dataProvider
					var menuLabel : String = myMenuBar.dataProvider.getItemAt(menuIndex).label;
					// the drop down menu index is in the listData property
					var itemIndex : int = cellRenderer.listData.index;
					// the drop down menu label is in the data property
					var itemLabel : String = cellRenderer.data.label;
					// dispatch an event of type itemSelected with bubbles and cancelable both false
					dispatchEvent(new MenuEvent(MenuEvent.ITEM_SELECTED, false, false, menuIndex, menuLabel, itemIndex, itemLabel));											             
					closeMenuBar();
					break;
				case MouseEvent.MOUSE_DOWN:
					// keep stage listener from closing the menus
					// more on use of keepMenuOpen in comment
					// for mouseUp event in menuBarMouseHandler()
					keepMenuOpen = true;
					break;
			}
		}

		/*
		 * handler for stage mouse events.  mouseUp or mouseDown
		 * on the stage closes the menus, unless the event hit
		 * the TileList menu bar or a List drop down menu first.
		 */
		protected function stageMouseHandler(e : MouseEvent) : void {
			if (keepMenuOpen) {
				// keepMenuOpen is used by the TileList menu bar mouseUp event
				// to signal that the next stage mouseUp event should not close
				// the menus.  We set it to false, so that the subsequent stage
				// mouseUp event WILL close the menus, and do nothing else.
				keepMenuOpen = false;
			} else {
				closeMenuBar();
			}
		}

		/*
		 * Shows the drop down menu passed in as a parameter and adds
		 * all the events used to track the open menus and decide when
		 * to close them.  Only the mouseDown event listener on the
		 * TileList menu bar is active until the menus are active.
		 */
		protected function openMenuBar(menuToOpen : List) : void {
			// open the List drop down menu
			hideAllMenusExcept(menuToOpen);

			// we need to handle mouseOver once a menu is opened to switch
			// which menu is dropped down
			myMenuBar.addEventListener(MouseEvent.MOUSE_OVER, menuBarMouseHandler);

			// we want to handle the first mouseUp event after the first
			// mouseDown on the TileList menu bar to prevent the stage
			// mouseUp listener from closing the menus
			myMenuBar.addEventListener(MouseEvent.MOUSE_UP, menuBarMouseHandler);

			// if we get a mouseDown anywhere on the stage aside
			// from the TileList menu bar or the List drop down menus
			// we will close the menus
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseHandler);

			// if the first mouseUp after the initial mouseDown to
			// open the menu is not over the TileList menu bar or
			// the List drop down menus, we should close the menus
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseHandler);

			for (var i : int = 0;i < myMenus.length; i++) {
				var theMenu : List = myMenus[i] as List;
				// When we get a mouseUp on a List drop down menu, this means
				// the user has made a selection which we must handle
				theMenu.addEventListener(MouseEvent.MOUSE_UP, menuMouseHandler);
				// we just need to handle mouseDown on the List drop down
				// menus to prevent the stage listener from closing the menus
				theMenu.addEventListener(MouseEvent.MOUSE_DOWN, menuMouseHandler);
			}
		}

		/*
		 * hide all List drop down menus and remove all of the event
		 * listeners added in openMenuBar()
		 */
		protected function closeMenuBar() : void {
			// close all menus
			hideAllMenusExcept(null);
			// reset the state of keepMenuOpen, just to make sure it isn't left funky
			keepMenuOpen = false;
			// remove all the event listeners we added in openMenuBar()
			myMenuBar.removeEventListener(MouseEvent.MOUSE_UP, menuBarMouseHandler);
			myMenuBar.removeEventListener(MouseEvent.MOUSE_OVER, menuBarMouseHandler);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseHandler);
			for (var i : int = 0;i < myMenus.length; i++) {
				var theMenu : List = myMenus[i] as List;
				theMenu.removeEventListener(MouseEvent.MOUSE_UP, menuMouseHandler);
				theMenu.removeEventListener(MouseEvent.MOUSE_DOWN, menuMouseHandler);
			}
		}

		/*
		 * takes a parameter indicating which List drop down menu
		 * should be open.  All the other menus will be made
		 * invisible.  Pass in null to hide all of the drop down menus.
		 */
		protected function hideAllMenusExcept(except : List) : void {
			for (var i : int = 0;i < myMenus.length; i++) {
				var theMenu : List = myMenus[i] as List;
				theMenu.visible = (theMenu == except);
			}
		}
	}
}
