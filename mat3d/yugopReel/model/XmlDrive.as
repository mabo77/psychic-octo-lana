package mat3d.yugopReel.model {
	////////////////////////////////////////////////////////////////////
	import flash.events.*;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;

	import mat3d.yugopReel.model.CustomDispatcher;
	import mat3d.yugopReel.ScrollReel;

	///////////////////////////////////////////////////////////////////

	/**
	 * @author mat handles xmlLoading
	 */
	public class XmlDrive {
		///////////////////////////////////////////////////////////////////
		private var _Reel : ScrollReel ;
		private var LaunchUrlLoader : mat3d.yugopReel.model.LaunchUrlLoader;
		public var decorDispatcher : CustomDispatcher ;
		private var myFile : XMLDocument;
		public var myData : Array;
		public var myXml : XML;

		///////////////////////////////////////////////////////////////////
		public function XmlDrive(reel) : void {
			_Reel = reel;
			var myXmlFile : String = _Reel._File;
			var LaunchUrlLoader : mat3d.yugopReel.model.LaunchUrlLoader = new mat3d.yugopReel.model.LaunchUrlLoader(this, myXmlFile);
		}

		///////////////////////////////////////////////////////////////////
		public function onUrlLoaderResult(xml) : void {
			var myFile = new XMLDocument(xml);
			var myArray = new Array();
			//var myXml = new XML(myFile);
			for (var x in myFile.childNodes[1].childNodes) {
				if(x % 2 == 0) {
				}else {
					var newLink = new Object();
					newLink.picUrl = myFile.childNodes[1].childNodes[x].attributes.URL;
					newLink.Lnk = myFile.childNodes[1].childNodes[x].attributes.LINK;
					newLink.FrLnk = myFile.childNodes[1].childNodes[x].attributes.TARGET;
					newLink.Text = myFile.childNodes[1].childNodes[x].childNodes[0].nodeValue;
					//trace(myFile.childNodes[1].childNodes[x].childNodes[0].nodeValue);
					myArray.push(newLink);
				}
			}
			var myData = myArray;
			_Reel.ConfigData = myArray;
			if(myData.length != 0) {
				_Reel.ConfigData = myArray;
				decorDispatcher.dispatchEvent(new Event("onLoaderResult"));
				decorDispatcher.doAction();
			}else{
			}
		}
		///////////////////////////////////////////////////////////////////
	}
}
