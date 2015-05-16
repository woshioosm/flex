package org.liesmars.flashwebclient.Handler
{
	import flash.geom.Point;
	import flash.events.*;
	import org.liesmars.flashwebclient.Handler;
	import org.liesmars.flashwebclient.GeoMap;
		
	public class ZoomOut extends Handler
	{
		public function ZoomOut(map:GeoMap,options:Object)
		{
			super(map,options);	
		}
		
		public override function Active():void
		{
			this.map.sprite.addEventListener(MouseEvent.MOUSE_DOWN,this.MD,false,0,true);	
			super.Active();		
		}
		public override function Deactive():void
		{
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_DOWN,this.MD);
			super.Deactive();
		}
		public function MD(e:MouseEvent):void
		{
			var p:Point=new Point(e.stageX,e.stageY);
			//this.map.ZoomOut(null,p);
		}
		public override function Destroy():void
		{}
	}
}