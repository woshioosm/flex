package org.liesmars.flashwebclient.Handler.Draw
{
	import fl.motion.easing.Back;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.Layer;

	public class DrawRectOfArea
	{
		/*
		* 矩形框的实际坐标
		*/
        private var minCoordinate:Point=new Point();
		private var maxCoordinate:Point=new Point();
		
		private var map:GeoMap;
		private var option:Object;
		private var startPoint:Pixel;
		private var endPoint:Pixel;
		private var box:Sprite=new Sprite();

		public function DrawRectOfArea(map:GeoMap,options:Object)
		{
			this.map=map;
			this.option=option;
		
		}
		
		public function draw(minCoordinate:LonLat,maxCoordinate:LonLat){
			startPoint= (map.layers[0] as Layer).getViewPortPxFromLonLat(minCoordinate);
			endPoint= (map.layers[0] as Layer).getViewPortPxFromLonLat(maxCoordinate);
			
			this.drawBox(this.box,new Point(startPoint.x,startPoint.y),new Point(endPoint.x,startPoint.y),this.box.graphics);
		}
		public function drawBox(s:Sprite,p1:Point,p2:Point,g:Graphics){
			if(s.parent)
			{
				g.clear();     
				drawRectangle(s,p1,p2,g);
			}
		}
		private function drawRectangle(s:Sprite,p1:Point,p2:Point,g:Graphics):void
		{
			var m:Number;
			//这里是为了保证p1在左上角，p2在右下角
			if(p1.x>p2.x){m=p2.x;p2.x=p1.x;p1.x=m;}
			if(p1.y>p2.y){m=p2.y;p2.y=p1.y;p1.y=m;}
			var width:Number=p2.x-p1.x;
			var height:Number=p2.y-p1.y;
			p1=s.parent.globalToLocal(p1);
			
			s.x=p1.x;
			s.y=p1.y;			
			
			g.lineStyle(1,0xff9966,0.8);
			g.beginFill(0xff0000,0.2);
			g.drawRect(0,0,width,height);
			g.endFill();
		}
	}
}