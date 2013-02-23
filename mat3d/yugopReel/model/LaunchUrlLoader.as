package mat3d.yugopReel.model {
	///////////////////////////////////////////////
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.Event;
	import flash.net.*;

	import mat3d.yugopReel.model.CustomDispatcher;

	///////////////////////////////////////////////
	public class LaunchUrlLoader extends Sprite {
		///////////////////////////////////////////////
		private var _manager : mat3d.yugopReel.model.XmlDrive;
		private var decorDispatcher : CustomDispatcher;
		private var dataDrive : String;
		private var _myFile : String;

		///////////////////////////////////////////////
		public function LaunchUrlLoader(manager,xmlFile) {
			_manager = manager;
			_myFile = xmlFile;
			var loader : URLLoader = new URLLoader();
			configureListeners(loader);
			var request : URLRequest = new URLRequest(_myFile);
			try {
				loader.load(request);
			} catch (error : Error) {
				trace("Unable to load requested document.");
			}
		}

		///////////////////////////////////////////////
		private function callManager(evt : Event) : void {
			_manager.onUrlLoaderResult(dataDrive);
		}

		///////////////////////////////////////////////
		private function configureListeners(dispatcher : IEventDispatcher) : void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}

		///////////////////////////////////////////////
		private function completeHandler(event : Event) : void {
			var loader : URLLoader = URLLoader(event.target);
			var decorDispatcher : CustomDispatcher = new CustomDispatcher();
			decorDispatcher.addEventListener("doSomething", callManager);
			var vars : URLVariables = new URLVariables(loader.data);
			dataDrive = loader.data;
			decorDispatcher.dispatchEvent(new Event("doSomething"));
		}

		///////////////////////////////////////////////
		private function openHandler(event : Event) : void {
			//trace("openHandler: " + event);
		}

		///////////////////////////////////////////////
		private function progressHandler(event : ProgressEvent) : void {
			//trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}

		///////////////////////////////////////////////
		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			//trace("securityErrorHandler: " + event);
		}

		///////////////////////////////////////////////
		private function httpStatusHandler(event : HTTPStatusEvent) : void {
			//trace("httpStatusHandler: " + event);
		}

		///////////////////////////////////////////////
		private function ioErrorHandler(event : IOErrorEvent) : void {
			//trace("ioErrorHandler: " + event);
		}

		///////////////////////////////////////////////
		public function triggerMenu(xml) {
		}
	}
}
