package 
{
	import flash.display.DisplayObject;
	import flash.net.URLRequest
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.system.LoaderContext;	
	import flash.system.ApplicationDomain;
	import flash.display.Sprite
	import flash.utils.getDefinitionByName;
	import flash.text.TextField;
	Security.allowDomain("*");
	import flash.external.*;	

	

	


	/**
	 * ...
	 * @author oleg
	 */
	[Frame(factoryClass="Preloader")]
	public class Flash_launcher extends Sprite 
	{
	private var movieClip1:MovieClip=new MovieClip();
	private	var loader_1:Loader=new Loader();
	
	private	var loader_context:LoaderContext = new LoaderContext();
	private	var appDomainA:ApplicationDomain = new ApplicationDomain(); 
	private	var contextA:LoaderContext = new LoaderContext(false, appDomainA); 
	private	var appDomainB:ApplicationDomain = ApplicationDomain.currentDomain; 
	private	var contextB:LoaderContext = new LoaderContext(false, appDomainB); 
	private	var appDomainC:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain); 
	private	var contextC:LoaderContext = new LoaderContext(false, appDomainC);  
	public  var myName:String
	public  var my_socket:_socket = new _socket();
	public  var Obj:Object=new Object();
		
		
		public function Flash_launcher():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			
			var debutText:TextField = new TextField();
			
			debutText.text = "hello";
			debutText.background = true;
			addChild(debutText);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var url:String = this.loaderInfo.url ;
			debutText.text = "" + url;	
			
			if (ExternalInterface.available) {
			//var uid;
			//uid= ExternalInterface.call("getMyUid");
	

			}else{
			//trace("External interface is not available for this container."+ "\n");
            
			}
			
			
			
			
			// entry point
			trace("debug - function init");
			loader_1.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderHandler);
			var tmp:Array = url.split("?");
			trace("tmp[2]- " + tmp[2] + "***************")
			debutText.text = ""+tmp[2];	
			if (tmp[2] == null) {
				trace("**********************user mode- " + tmp[2] + "***************")
				loader_1.load(new URLRequest("http://37.57.234.41/container.swf?" + Math.random()), contextB);
				//loader_1.load(new URLRequest("http://37.57.234.41/container.swf"), contextB);
				debutText.text = ""+tmp[2];	
			}else {
				debutText.text = ""+tmp[2];
				loader_1.load(new URLRequest("https://googledrive.com/host/0B-lOxB6iLdGleE95Q00zbUNUNFE/containerGoogle.swf?" + Math.random()), contextB);
				//loader_1.load(new URLRequest("http://37.57.234.41/containerDebug.swf"),contextB);
			}
			
			
			
			
			
			
	
			
			
		}
		private function loaderHandler(event:Event):void 
		{ 
			//private	var loaderContent:DisplayObject;
			loader_1.contentLoaderInfo.removeEventListener(Event.COMPLETE,loaderHandler);
			movieClip1.addChild(loader_1.content);
			this.addChild(movieClip1);
			
			//loaderContent:lo=loader_1.content;
			var myUrl:String = loaderInfo.loaderURL;
			var tmp:Array=myUrl.split("/");
			myName=tmp[tmp.length-2].split(".swf")[0];
			var pattern:RegExp = /_/gi; 
			var pattern1:RegExp = /%5F/gi; 
			myName=myName.replace(pattern1, " ");
			myName = myName.replace(pattern, " ");
			Obj = loader_1.content;
			
			trace("name: "+ Obj);
			Obj.getFolder(myName);
			//Obj.startLoader();
			
			this.addEventListener(Event.ENTER_FRAME,changeString)
			//Obj.newString(myName);
			trace("loaded: "+ Obj);
		} 
		private function changeString(event:Event):void
		{
			
			var RunString:String = my_socket.readResponse();
			if (RunString != "")
			{                                                                                 
				Obj.m.SetmarquesinaText(RunString);
				
				//trace(RunString);
			}
		}


	}

}