package cn.edu.whu.liesmars.asPack.util
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class ServerUrl extends Sprite 
	{
		public static var url:String="";
		public function ServerUrl()
		{
		
		}
		public static function getUrl(stage:DisplayObject):void{
			var doMain:String =stage.loaderInfo.url; 
			url= doMain.substring(0,doMain.lastIndexOf("/"));
		}
	}
}