package org.liesmars.flashwebclient
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.liesmars.flashwebclient.GeoEvent.MapEvent;
	
	public class OverviewMap extends Sprite
	{
		// first 
		private var canvas:Sprite;//:Label;
		private var ovmap:GeoMap;
		private var map:GeoMap;
		private var panObj:Sprite;
		private var background:Sprite;
		
		// second button
		
		// size
		private var size:Point;
		
		private var pan:Sprite;
		private var dragflag:Boolean = false;
		private var threshold:int = 25;

		private var start:Point;
		private var end:Point;
		
		public function OverviewMap(sprite:Sprite, map:GeoMap, options:Object)//(l:Label, map:GeoMap, options:Object) 
		{
			//this.size.x = l.width;
			//this.size.y = l.height;

			
			//this.x = this.map.canvas.width - size.x;
			//this.y = this.map.canvas.height - size.y;
			
			// first 
			//canvas = new Label();
			//canvas = l;
			//canvas.width = this.size.x;
			//canvas.height = this.size.y;
			//canvas.x = this.map.canvas.width - size.x;
			//canvas.y = this.map.canvas.height - size.y;
			//map.canvas.addChild(canvas);//this.addChild(canvas);
			canvas = sprite;
			this.map = map;
				// background
			background = new Sprite();
			canvas.addChild(background);

			
			var g:Graphics = background.graphics;
			g.lineStyle(1,0x990000,1);
			g.moveTo(0,0);
			g.lineTo(canvas.width, 0 );
			g.lineTo(canvas.width, canvas.height);
			g.lineTo(0,canvas.height);
			g.lineTo(0,0);	
			
				// ovmap
			ovmap = new GeoMap(sprite, {});//(this.canvas);
//			var layer:Layer = new Layer(map.baseLayer.layername, map.baseLayer.url,map.baseLayer.maxExtent);
			
			ovmap.addLayer(map.baseLayer);
//			ovmap.setCenter(map.center, map.zoom);
	
			this.setOvmapZoom();	
	
			
				// panObj
			pan = new Sprite();	
			canvas.addChild(pan);
			this.setDragListener();
			
			
       		map.sprite.addEventListener(MapEvent.MAP_DRAG_MOVE, this.movepan);
		   	map.sprite.addEventListener(MapEvent.MAP_DRAG_STOP, this.moveOrZoomOvmap);
		   	map.sprite.addEventListener(MapEvent.MAP_MOVE_STOP, this.moveOrZoomOvmap);
		   	map.sprite.addEventListener(MapEvent.MAP_ZOOM, this.redrawOvmap);			

//			trace("ovmap center: " + ovmap.GetViewCenterLonLat());
//			trace("map center: " + map.GetViewCenterLonLat());
		}

		public function setOvmapZoom():void {
			// first set the zoom, by map's width and ovmap's width
			var dlevel:Number = ovmap.getSize().w / map.getSize().w;
			var d:int = Math.log( dlevel);
			
			if(map.zoom + d < 0) {
				ovmap.setCenter(map.center, 0);
			} else
				ovmap.setCenter(map.center, map.zoom + d);			
		
		} 
		
		public function setDragListener():void
		{
			if(this.pan)
			{
				this.pan.addEventListener(MouseEvent.MOUSE_DOWN,dragStart,false,0,true);
				this.pan.addEventListener(MouseEvent.MOUSE_UP,dragStop,false,0,true);
				this.pan.addEventListener(MouseEvent.MOUSE_MOVE,dragMove,false,0,true);
			}
		}	
		
		public function movepan(event:MapEvent):void {
			
		}
		
		public function moveOrZoomOvmap(event:MapEvent):void {
			setOvmapZoom();
//			ovmap.SetCenter(map.GetViewCenterLonLat(),ovmap.zoom,false);	
			ovmap.setCenter(map.center, map.zoom);
			recoverpan();
		}
		
		public  function redrawOvmap(event:MapEvent):void {
			moveOrZoomOvmap(event);
			redrawpan();	
		}
		
		public function recoverpan():void {
			pan.x = 0;
			pan.y = 0;
		}

		public function redrawpan():void {
			var width:Number;
			var height:Number;
			var d_bounds:Point;
			var bounds:Array;
			
			width = map.getSize().w * Math.pow(2, ovmap.zoom / map.zoom);
			height = map.getSize().h * Math.pow(2, ovmap.zoom / map.zoom);
			
			if(width < 20) width = 20;
			if(height < 20) height = 20;
			
			//if (height < this.threshold) height = threshold;
			trace("redrawPanRect" + ovmap.zoom + " height: " + height);
			

			
			var g:Graphics = this.pan.graphics;
			g.clear();			
			
			
			this.pan.graphics.beginFill(0x85db18,0.1);	
			this.pan.graphics.drawRect((canvas.width - width) / 2, (canvas.height - height) / 2, width, height);
			this.pan.graphics.endFill();		
			
			/*
			g.lineStyle(1,0x85db18,1);
			g.moveTo((size.x - width) / 2,(size.y - height) / 2);
			g.lineTo((size.x + width) / 2, (size.y - height) / 2 );
			g.lineTo((size.x + width) / 2, (size.y + height) / 2);
			g.lineTo((size.x - width) / 2,(size.y + height) / 2);
			g.lineTo((size.x - width) / 2,(size.y - height) / 2);	
			*/
			this.pan.graphics.beginFill(0x0099ff,1);	
			this.pan.graphics.drawCircle(size.x / 2, size.y / 2, 5);
			this.pan.graphics.endFill();		
		}
		
		public function dragStart(e:MouseEvent):void
		{
				this.dragflag=true;
				this.pan.startDrag();
				
				start = new Point(e.stageX, e.stageY)//mouseX, mouseY
				//p0.x = e.localX;
				//p0.y = e.localY;
				
				trace("mouse starting point: " + start);
		}
		
		public function dragMove(e:MouseEvent):void {
			
			if(dragflag) {	
			//p1.x = e.localX;
			//p1.y = e.localY;
			
			end = new Point(e.stageX, e.stageY)//mouseX, mouseY
			//trace(mouseX + 'and'+mouseY);
			trace("--point: " + end);
			}
		}
		
		public function dragStop(e:MouseEvent):void
		{
				this.dragflag=false;
				this.pan.stopDrag();
				recoverpan();
				
				//p1 = new Point(e.stageX, e.stageY)//mouseX, mouseY
				trace("ending point: " + end);
				
				var deta:Point = new Point((end.x - start.x), (end.y - start.y));
//				trace("deta.x: " + deta.x + " deta.y: " + deta.y);
//				trace("overview: moving overview && geomap");
//				
//				var centerpx:Point = ovmap.GetViewCenterPx();
//				centerpx.x += deta.x;
//				centerpx.y += deta.y;
//				
//				var center:Point = ovmap.GetLonLatFromGlobalPixel(centerpx);
//				trace("lon: " + center.x + " lat: " + center.y);	
//				//trace("---" );
				ovmap.pan(deta.x, deta.y, {});
//				ovmap.SetCenter(center, ovmap.zoom, false);
				map.setCenter(ovmap.center, map.zoom);
		}
		
	}
}