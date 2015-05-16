package org.liesmars.flashwebclient.Handler
{
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.liesmars.flashwebclient.Handler;
	import org.liesmars.flashwebclient.GeoMap;
		
	public class ZoomIn extends Handler
	{
		public function ZoomIn(map:GeoMap,options:Object)
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
			//this.map.ZoomIn(null,p);
		}
		public override function Destroy():void
		{}
	}
}