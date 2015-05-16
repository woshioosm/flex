package cn.edu.whu.liesmars.asPack.util
{
	import cn.edu.whu.liesmars.asPack.event.EventManager;
	import cn.edu.whu.liesmars.asPack.event.LoadXMLEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
    
	public  class XmlParser extends EventDispatcher
	{

		private  var request:URLRequest;
		private  var urlLoader:URLLoader;
		private  var parserType:String;
		private  var targetXml:XML;
		
		public  function parse(type:String,xmlUrl:String):void{
			
			parserType=type;
			request=new URLRequest(xmlUrl);
			urlLoader=new URLLoader();
			urlLoader.load(request);
			urlLoader.addEventListener(Event.COMPLETE,onComplete);	
		}
		private  function onComplete(event:Event):void{
			
		   targetXml=new XML(event.target.data);   
		   switch(parserType)
		   {
		        case ParserType.DEPARTMENT_PARSER:
				    Config.depratments=targetXml;
					//EventManager.dispatchEvent(this,new LoadXMLEvent(targetXml));
					break;
				case ParserType.URL_PARSER:
					parserConfigUrl(targetXml);
					break;
				default:
					break;
		   }
		}
		private function parserConfigUrl(xml:XML):void{
			var targetXML:XML=xml;
			var urlList:XMLList=targetXML.children();
			for each(var url:XML in urlList){
				if(url.@name=="TileServer"){  // 瓦片服务器
					Config.tileServerUrl=url.@value;
				}
				if(url.@name=="Server"){      // 后台服务
					Config.serverUrl=url.@value;
				}
				if(url.@name=="CrossDomain"){
					Config.crossDomainUrl=url.@value;
				}
				if(url.@name=="imagePath"){
					Config.imagePath=url.@value;
				}
			}
			trace(Config.serverUrl+"  "+Config.tileServerUrl);
		}
		private function parserURL(xml:XML,urlName:String):void{
			var targetXML:XML=xml;
			var urlList:XMLList=targetXML.children();
			for each(var serverUrl:XML in urlList){
				if(serverUrl.@name==urlName){
					Config.tileServerUrl=serverUrl.@value;
				}
			}
		}
		
		//private static function departMent
	}
}