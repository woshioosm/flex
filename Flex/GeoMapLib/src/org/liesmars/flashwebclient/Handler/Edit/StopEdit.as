package  org.liesmars.flashwebclient.Handler.Edit
{
	import org.liesmars.flashwebclient.Handler.Edit;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import org.liesmars.flashwebclient.Layer.Vector;
	import org.liesmars.flashwebclient.GeoMap;
	
	public class StopEdit extends Edit
	{
		public function StopEdit(map:GeoMap, options:Object)
		{
			super(map, options);
		}
		
		public override function Active():void{
		}
		
		public override function Deactive():void{
			//super.Deactive();
		}
		
		
		
	}
}