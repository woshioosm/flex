package org.liesmars.flashwebclient.Handler
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Image;
	import mx.graphics.ImageSnapshot;
	
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.Handler;
	import org.liesmars.flashwebclient.Layer;
	import org.liesmars.flashwebclient.MapUIEvent.DispatchValueEvent;
		
	public class WheelZoom extends Handler
	{
		var zoomvalue:int = 0;
		var t:Timer = new Timer(300,1);
		var img:Image;
		
		public function WheelZoom(map:GeoMap,options:Object)
		{
			super(map,options);	
			t.addEventListener(TimerEvent.TIMER,timerHander);
		}
		public override function Active():void
		{
			trace("active wm!");
			this.map.sprite.addEventListener(MouseEvent.MOUSE_WHEEL,this.MW);			
		}
		public override function Deactive():void
		{
			trace("deactive wm!");
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_WHEEL,this.MW);
		}
		public function MW(e:MouseEvent):void
		{	
//			if(this.map.evtObj.x<0)this.map.EvtObjRecover();			
//			if(!this.map.IsValidate(this.map.zoom+1))return;
//			var p:Point=this.map.GetViewCenterLonLat();

//			if(e.delta>0)
//			{
//			  map.zoomIn();
//			}
//			else if(e.delta<0)
//			{
//				map.zoomOut();
//			}
//			this.map.sprite.dispatchEvent(new DispatchValueEvent(DispatchValueEvent.GET_WHEELVALUE,this.map.zoom));
//			trace("zoom="+this.map.zoom);

			if((map.getZoom() == 14 && e.delta > 0) || (map.getZoom() == 0 && e.delta < 0))
				return;
			
			if(!img){
				var bitmap:Bitmap = new Bitmap(ImageSnapshot.captureBitmapData(this.map.sprite));
				img = new Image();
				img.source = bitmap;
				img.width = this.map.sprite.width;
				img.height = this.map.sprite.height;
				img.x = this.map.sprite.x;
				img.y = this.map.sprite.y;
				this.map.sprite.addChildAt(img,this.map.sprite.numChildren);
			}
			else{
			}
			
			t.reset();
			// 记录图片的中心点，在缩放过程中，中心点保持不变
			var centerx:Number = img.x + img.width/2;
			var centery:Number = img.y + img.height/2;
			
			if(e.delta > 0){
				zoomvalue += 1;
				img.width = img.width *2;
				img.x = centerx - img.width/2;
				img.height = img.height*2;
				img.y = centery - img.height/2;
			}
			else if(e.delta < 0){
				zoomvalue -= 1;
				img.width = img.width/2;
				img.x = centerx - img.width/2;
				img.height = img.height/2;
				img.y = centery - img.height/2;
			}
			t.start();
			
			for(var i:int=0;i<this.map.layerContainer.numChildren;i++){
				var layer:Layer = this.map.layerContainer.getChildAt(i) as Layer;
				if(layer &&layer.visible == true){
					layer.visible = false;
				}
			}
		}
		
		public function timerHander(e:TimerEvent):void{
			if(img.parent){
				img.parent.removeChild(img);
			}
			var tmp:int = map.getZoom();
			if((tmp + zoomvalue)<0){
				map.zoomTo(0);
			}
			else if((tmp + zoomvalue)>17){
				map.zoomTo(7);
			}
			else{
				map.zoomTo(tmp + zoomvalue);
			}
			
			this.map.sprite.dispatchEvent(new DispatchValueEvent(DispatchValueEvent.GET_WHEELVALUE,this.map.zoom));
			img = null;
			zoomvalue = 0;
		}
	}
}