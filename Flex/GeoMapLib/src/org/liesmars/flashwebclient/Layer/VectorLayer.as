package org.liesmars.flashwebclient.Layer
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Label;
	import mx.controls.ToolTip;
	import mx.core.UIComponent;
	import mx.managers.CursorManager;
	
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Symbol.FillStyle;
	import org.liesmars.flashwebclient.Symbol.LineStyle;
	import org.liesmars.flashwebclient.Symbol.LineSymbol;
	import org.liesmars.flashwebclient.Symbol.PointStyle;
	import org.liesmars.flashwebclient.Symbol.PointSymbol;
	import org.liesmars.flashwebclient.Symbol.PolygonSymbol;
	import org.liesmars.flashwebclient.Symbol.StrokeStyle;
	import org.liesmars.flashwebclient.Util;
	
	public class VectorLayer extends Vector
	{
		[Embed(source="assert/open.png")]
		private var clickHand:Class;
		
		
		
		private var shapeClick:Function;
		private var cursorID:Number;
		private var polygon:GeoShape;
		private var pointShape:GeoShape;
		private var lineShape:GeoShape;
		private var shps:Array;
		
		private var isRandomColor:Boolean=false; // 组合多边形 是否用多种色彩显示
		
		
		public function VectorLayer(name:String, params:Object, options:Object,fun:Function)
		{
			shapeClick=fun;
			polygon=new GeoShape();
			pointShape=new GeoShape();
			lineShape=new GeoShape();
//			polygon.addEventListener(MouseEvent.CLICK,shapeClick);
//			polygon.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
//			polygon.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
//			this.addChild(polygon);
//			this.addChild(pointShape);
//			this.addChild(lineShape);
			
			super(name,"", params, options);
		}
		public function mouseOver(e:MouseEvent):void{
			
			cursorID=CursorManager.setCursor(clickHand);
			this.map.stopDrag();
			//mouseOverEffect();
		//	this.redraw();
		}
		public function mouseOut(e:MouseEvent):void{
			CursorManager.removeCursor(cursorID);
			//mouseOutEffect();
			this.map.drag();
		//	this.redraw();
		}
		public function drawPointByCoord(CoordsString:String):Bounds{
			
			var left:Number=10000;
			var right:Number=-10000;
			var top:Number=-10000;
			var bottom:Number=10000;
			
			
			this.map.EvtObjMoveAway();
			
			this.symbol = new PointSymbol(this.map,{"_strokeStyle":new StrokeStyle(1,0xff0000,1)});
			//this.symbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,0.5),"_fillStyle":new FillStyle(0xffffff,0.3)});
			var coordss:Array=new Array();
			
			
			var pointList:Array=CoordsString.split("|"); 
			for(var t:int=0;t<pointList.length;t++){
				var coordString:String=pointList[t];
				var coords:Array = new Array();
				var points:Array=coordString.split(";");  // 截取一个个点
				
				
				for(var i:int=0;i<points.length;i++){
					var point:Array=points[i].split(",");
					if(point!=null && point.length==2){
						coords.push(point[0]);
						coords.push(point[1]);
						
						var numX:Number=Number(point[0]);
						var numY:Number=Number(point[1]);
						if(numX<left)
							left=numX;
						if(numX>right)
							right=numX;
						if(numY<bottom)
							bottom=numY;
						if(numY>top)
							top=numY;
					}	
				}	
				coordss.push(coords);
			}
			
			pointShape.geotype=GEOTYPES.POINT;	
			
			
			
			pointShape.coords=coordss;
			
			var points:Array=new Array();
			points.push(pointShape);
			
			shps=new Array();
			shps.push(points);
			
			
			this.symbol.DrawLocalData(shps,this);
			//this.redraw();
			
			var bounds:Bounds=new Bounds(left,bottom,right,top);
			return bounds;
		}
		public function drawLineByCoordsStr(CoordsString:String):Bounds{
			var left:Number=10000;
			var right:Number=-10000;
			var top:Number=-10000;
			var bottom:Number=10000;
			
		
			this.map.EvtObjMoveAway();
	
			this.symbol = new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(3,0xff0000,1),"_lineStyle":new LineStyle(10,3,5,2)});		
			var coordss:Array=new Array();
			
			
			var pointList:Array=CoordsString.split("|"); 
			for(var t:int=0;t<pointList.length;t++){
				var coordString:String=pointList[t];
				var coords:Array = new Array();
				var points:Array=coordString.split(";");  // 截取一个个点
				
				
				for(var i:int=0;i<points.length;i++){
					var point:Array=points[i].split(",");
					if(point!=null && point.length==2){
						coords.push(point[0]);
						coords.push(point[1]);
						
						var numX:Number=Number(point[0]);
						var numY:Number=Number(point[1]);
						if(numX<left)
							left=numX;
						if(numX>right)
							right=numX;
						if(numY<bottom)
							bottom=numY;
						if(numY>top)
							top=numY;
					}	
				}	
				coordss.push(coords);
			}
			
			lineShape.geotype=GEOTYPES.LINE;		
			
			
			
			lineShape.coords=coordss;
			
			var polyline:Array=new Array();
			polyline.push(lineShape);
			
			shps=new Array();
			shps.push(polyline);
			
			
			this.symbol.DrawLocalData(shps,this);
			//this.redraw();
			
			var bounds:Bounds=new Bounds(left,bottom,right,top);
			return bounds;
			
		}
		
		public function drawAreaByCoordsStr(CoordsString:String,randomColor:Boolean=false):Bounds{
			isRandomColor=isRandomColor;
			
			
			var left:Number=10000;
			var right:Number=-10000;
			var top:Number=-10000;
			var bottom:Number=10000;
			
			
			this.map.EvtObjMoveAway();
			this.symbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,0.5),"_fillStyle":new FillStyle(0xffff00,0.3)});
			var coordss:Array=new Array();
			
			
			var pointList:Array=CoordsString.split("|"); 
			for(var t:int=0;t<pointList.length;t++){
				var coordString:String=pointList[t];
				var coords:Array = new Array();
				var points:Array=coordString.split(";");  // 截取一个个点
				
				
				for(var i:int=0;i<points.length;i++){
					var point:Array=points[i].split(",");
					if(point!=null && point.length==2){
						coords.push(point[0]);
						coords.push(point[1]);
						
						var numX:Number=Number(point[0]);
						var numY:Number=Number(point[1]);
						if(numX<left)
							left=numX;
						if(numX>right)
							right=numX;
						if(numY<bottom)
							bottom=numY;
						if(numY>top)
							top=numY;
					}	
				}	
				coordss.push(coords);
			}
			
			polygon.geotype=GEOTYPES.POLYGON;		
			
			
			
			polygon.coords=coordss;
			
			var polygons:Array=new Array();
			polygons.push(polygon);
			
			shps=new Array();
			shps.push(polygons);
			

			this.symbol.DrawLocalData(shps,this);
			//this.redraw();
			
			var bounds:Bounds=new Bounds(left,bottom,right,top);
			return bounds;
		
		}
		
		public  function drawMutiArea(CoordsStringUnit:String,CoordsString:ArrayCollection):Bounds{
			
			
			
			var left:Number=10000;
			var right:Number=-10000;
			var top:Number=-10000;
			var bottom:Number=10000;
			this.map.EvtObjMoveAway();
			this.symbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0x0000f0,0.4),"_fillStyle":new FillStyle(0xff0000,0.1)});
			
			var polygons:Array=new Array();
			var polygonShape:GeoShape=new GeoShape();
			polygonShape.geotype=GEOTYPES.POLYGON;	
			var coordss:Array=new Array();
			
			var pointList:Array=CoordsStringUnit.split("|"); 
			for(var t:int=0;t<pointList.length;t++){
				var coordString:String=pointList[t];
				var coords:Array = new Array();
				var points:Array=coordString.split(";");  // 截取一个个点
				
				
				for(var i:int=0;i<points.length;i++){
					var point:Array=points[i].split(",");
					if(point!=null && point.length==2){
						coords.push(point[0]);
						coords.push(point[1]);
						
						var numX:Number=Number(point[0]);
						var numY:Number=Number(point[1]);
						if(numX<left)
							left=numX;
						if(numX>right)
							right=numX;
						if(numY<bottom)
							bottom=numY;
						if(numY>top)
							top=numY;
					}	
				}	
				coordss.push(coords);
			}
			polygonShape.coords=coordss;
			polygonShape.colorCode=0;
			
			if(CoordsString!=null && CoordsString.length>0){
				
				for(var j:int=0;j<CoordsString.length;j++){
					var polygonShp:GeoShape=new GeoShape();
					polygonShp.geotype=GEOTYPES.POLYGON;
					var coordss2:Array=new Array();
					var coords2:Array=new Array();
					var pointList2:Array=CoordsString[j].split("|"); 
					for(var k:int=0;k<pointList2.length;k++){
						var coordString2:String=pointList2[k];
						var coords2:Array = new Array();
						var points2:Array=coordString2.split(";");  // 截取一个个点
						
						
						for(var i:int=0;i<points2.length;i++){
							var point:Array=points2[i].split(",");
							if(point!=null && point.length==2){
								coords2.push(point[0]);
								coords2.push(point[1]);
							}	
						}	
						coordss2.push(coords2);
					}
					polygonShp.coords=coordss2;
					polygonShp.colorCode=1;
					polygons.push(polygonShp);
				}
			}
			
			polygons.push(polygonShape);
			
			
			shps=new Array();
			shps.push(polygons);
			
			
			this.symbol.DrawLocalData(shps,this);
			
			var bounds:Bounds=new Bounds(left,bottom,right,top);
			return bounds;
		}
		
		public function drawRectArea(minLonLat:LonLat, maxLonLat:LonLat):void{    // sm 2012 2 4
			
			this.map.EvtObjMoveAway();
			this.symbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,0.5),"_fillStyle":new FillStyle(0xffffff,0.3)});
			var coords:Array = new Array();
			coords.push(minLonLat.lon);
			coords.push(minLonLat.lat);
			
			coords.push(maxLonLat.lon);
			coords.push(minLonLat.lat);
			
			coords.push(maxLonLat.lon);
			coords.push(maxLonLat.lat);
			
			coords.push(minLonLat.lon);
			coords.push(maxLonLat.lat);
			
			polygon.geotype=GEOTYPES.POLYGON;
			polygon.name="选择框";
			var coordss:Array=new Array();
			coordss.push(coords);
			polygon.coords=coordss;
			
			var polygons:Array=new Array();
			polygons.push(polygon);
			
			shps=new Array();
			shps.push(polygons);
			this.symbol.DrawLocalData(shps,this);
		}
	
		public function mouseOverEffect():void{
			this.symbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,1),"_fillStyle":new FillStyle(0xffff55,.3)});
			this.symbol.DrawLocalData(shps,this);
			this.map.pan(0,0,null);
		}
		public function mouseOutEffect():void{
			this.symbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,1),"_fillStyle":new FillStyle(0xffffff,.3)});
			this.symbol.DrawLocalData(shps,this);
			
		}
		public  override function clear():void{
			polygon.graphics.clear();
			if(shps!=null)
				for(var i:int=0;i<shps.length;i++){
					for(var j:int=0;j<(shps[i] as Array).length;j++){
						(shps[i][j] as GeoShape).graphics.clear();
					}
				}
			
			this.sprite.graphics.clear();
			
			while(this.numChildren>0){
				this.removeChild(this.getChildAt(0));}		
		}
		
	}
}