package org.liesmars.flashwebclient
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import org.liesmars.flashwebclient.BaseTypes.*;
	import org.liesmars.flashwebclient.Symbol.FillStyle;
	import org.liesmars.flashwebclient.Symbol.LineStyle;
	import org.liesmars.flashwebclient.Symbol.StrokeStyle;
	
	//符号化
	public class Symbol
	{
		private var symbol_type_:String;
		public var map:GeoMap;
		public var layer:Layer;

		public var _strokeStyle:StrokeStyle;
		public var _lineStyle:LineStyle;
		public var _fillStyle:FillStyle;
		
		public function Symbol(map:GeoMap, options:Object)
		{
			this.map = map;
			this.symbol_type_=Util.GetClassName(this);
			Util.SetOptions(this,options);
		}

		//可以选择添加到哪一层上  !!!!和DrawLocalData的内容一样，但是两者都有用到 By WCZ 4-8
		public function Draw(arrs:Array,layer:Layer):void
		{
			if(!layer) return;
			this.layer=layer;
			
			this.layer.sprite.graphics.clear();//
			
			for(var i:int =0;i<arrs.length;i++){
				var arr:Array = arrs[i] as Array;
				for(var j:int = 0;j<arr.length;j++){
					var shape:GeoShape = arr[j] as GeoShape;
					
					if(shape.geotype == GEOTYPES.POINT){
//						this.DrawPoints(arr,this.layer);
//						break;
                        shape.fromServer = true;
				        var attribute:Array = shape.attributes[i];
				        var t:String="";
				        if(shape.attributes){
					        for(var key:Object in shape.attributes )
				            {
					            if(key.toString().indexOf("名")>=0 || key.toString().toUpperCase().indexOf("NAME")>=0)
					            {
						            t=shape.attributes[key];break;
					            }
				            }
				        }
				        layer.addChild(shape);					
				        var p:Point = new Point();
				        var tempArr:Array = shape.coords as Array;
				        for(var k:int = 0;k<tempArr.length;k++){
					        p.x = (tempArr[k] as Array)[0];
					        p.y = (tempArr[k] as Array)[1];
					        this.DrawPoint(shape, p, Util.radius,t);//Util.radius默认值为4 by WCZ 
				        }
					}
					else if(shape.geotype == GEOTYPES.LINE){
//						this.DrawLines(arr,this.layer);
//						break;      
				        shape.fromServer = true;
				        layer.sprite.addChild(shape);	 //modified for test			
				        shape.graphics.clear();
				        this.DrawLine(shape,(shape.coords as Array)[0]);
					}
					else if(shape.geotype == GEOTYPES.POLYGON){
//						this.DrawPolygons(arr,this.layer);
//						break;
                        shape.fromServer = true;
				        layer.sprite.addChild(shape);	 //modified for test			
				        shape.graphics.clear();
				        this.DrawPolygon(shape,(shape.coords as Array)[0]);
					}
					else if(shape.geotype == GEOTYPES.MULTILINE){
						shape.fromServer = true;
						layer.sprite.addChild(shape);
						shape.graphics.clear();
						this.DrawMultiLine(shape,(shape.coords as Array));
					}
					else if(shape.geotype ==GEOTYPES.MULTIPOLYGON){
						shape.fromServer = true;
						layer.sprite.addChild(shape);
						shape.graphics.clear();
						this.DrawMultiPolygon(shape,(shape.coords as Array));
					}
					else if(shape.geotype ==GEOTYPES.RECT){
						shape.fromServer = true;
						layer.sprite.addChild(shape);
						shape.graphics.clear();
						this.DrawRectangular(shape,(shape.coords as Array));
					}
				}
			}
		}	
		
		//可以选择添加到哪一层上
		public function DrawLocalData(arrs:Array,layer:Layer):void
		{
			if(!layer) return;
			this.layer=layer;
			
			this.layer.sprite.graphics.clear();//
			while(this.layer.numChildren>0){
				this.layer.removeChild(this.layer.getChildAt(0));}	
			
			for(var i:int =0;i<arrs.length;i++){
				var arr:Array = arrs[i] as Array;
				for(var j:int = 0;j<arr.length;j++){
					var shape:GeoShape = arr[j] as GeoShape;
					
					if(shape.geotype == GEOTYPES.POINT){
						//this.DrawPoints(arr,this.layer);
						//break;
						shape.fromServer = true;
						//var attribute:Array = shape.attributes[i];
//						var t:String="";
//						if(shape.attributes){
//							for(var key:Object in shape.attributes )
//							{
//								if(key.toString().indexOf("名")>=0 || key.toString().toUpperCase().indexOf("NAME")>=0)
//								{
//									t=shape.attributes[key];break;
//								}
//							}
//						}
						layer.addChild(shape);					
						var p:Point = new Point();
						var tempArr:Array = shape.coords as Array;
						for(var k:int = 0;k<tempArr.length;k++){
							p.x = (tempArr[k] as Array)[0];
							p.y = (tempArr[k] as Array)[1];
							this.DrawPoint(shape, p, Util.radius,"");//Util.radius默认值为4 by WCZ 
						}
					}
					else if(shape.geotype == GEOTYPES.LINE){
						//						this.DrawLines(arr,this.layer);
						//						break;      
						shape.fromServer = false;
						layer.sprite.addChild(shape);	 //modified for test			
						shape.graphics.clear();
						this.DrawLine(shape,(shape.coords as Array));
					}
					else if(shape.geotype == GEOTYPES.POLYGON){
						//						this.DrawPolygons(arr,this.layer);
						//						break;
						shape.fromServer = false;
						layer.sprite.addChild(shape);	 //modified for test			
						shape.graphics.clear();
						var g:Graphics=shape.graphics;
						if(shape.colorCode==0)
						   g.beginFill(this._fillStyle._fillColor,this._fillStyle._fillAlpha);
						else{
							g.beginFill(0xffffff,0.2);
							
						}
						for(var k:int=0;k<(shape.coords as Array).length;k++){
							this.DrawPolygon2(shape,(shape.coords as Array)[k]);
						}
						g.endFill();
						   
						
					}
					else if(shape.geotype == GEOTYPES.MULTILINE){
						shape.fromServer = false;
						layer.sprite.addChild(shape);
						shape.graphics.clear();
						this.DrawMultiLine(shape,(shape.coords as Array));
					}
					else if(shape.geotype ==GEOTYPES.MULTIPOLYGON){
						shape.fromServer = false;
						layer.sprite.addChild(shape);
						shape.graphics.clear();
						this.DrawMultiPolygon(shape,(shape.coords as Array));
					}
					else if(shape.geotype ==GEOTYPES.RECT){
						shape.fromServer = false;
						layer.sprite.addChild(shape);
						shape.graphics.clear();
						this.DrawRectangular(shape,(shape.coords as Array));
					}

				}
			}
		}	
		
		public function DrawPoint(shp:GeoShape, p:Point, radius:Number,s:String):void
		{}
		public function DrawMarker(shp:GeoShape, p:Point, size:Number,s:String):void
		{}
		public function DrawLine(shp:GeoShape,json:Array):void
		{}
		public function DrawMultiPolygon(shp:GeoShape,json:Array):void
		{}
		public function DrawMultiLine(shp:GeoShape,json:Array):void
		{}
		public function DrawPolygon(shp:GeoShape,json:Array):void
		{}	
		public function DrawPolygon2(shp:GeoShape,json:Array):void{
			
		}
		public function DrawRectangular(shp:GeoShape,json:Array):void
		{}
		
		public function DrawPoints(json:Array,layer:Layer):void
		{
			var geoms:Array=json;
			
			for(var i:int=0;i<geoms.length;i++)
			{
				//单个点对象包含多个点坐标
				var pt:GeoShape = geoms[i] as GeoShape;
				pt.fromServer = true;
				if(pt.attributes)
					var attribute:Array = pt.attributes[i];
				var t:String="";
				if(pt.attributes){
					for(var key:Object in pt.attributes )
				    {
					    if(key.toString().indexOf("名")>=0 || key.toString().toUpperCase().indexOf("NAME")>=0)
					    {
						    t=pt.attributes[key];break;
					    }
				    }
				}
				layer.addChild(pt);
				var p:Point = new Point();
				var tempArr:Array = pt.coords as Array;
				for(var j:int = 0;j<tempArr.length;j++){
					p.x = (tempArr[j] as Array)[0];
					p.y = (tempArr[j] as Array)[1];
					this.DrawPoint(pt, p, Util.radius,t);
				}
				
			}
		}	
		public function DrawLines(json:Object,layer:Layer):void
		{
			this.DrawLineOrPolygon(json,layer);
		}	
		public function DrawPolygons(json:Object,layer:Layer):void
		{
			this.DrawLineOrPolygon(json,layer);			
		}
		private function DrawLineOrPolygon(json:Object,layer:Layer):void
		{
			var geoms:Array=json as Array;		
				
			for(var i:int=0;i<geoms.length;i++)
			{
				//单个线对象包含多个线
				var shp:GeoShape=geoms[i] as GeoShape;
				shp.fromServer = true;
				//var shp:GeoShape=new GeoShape;
				layer.sprite.addChild(shp);	 //modified for test			
				shp.graphics.clear();
				if(shp.geotype==GEOTYPES.LINE){
					this.DrawLine(shp,(shp.coords as Array)[0]);
				}                   //modified for test
				else this.DrawPolygon(shp,(shp.coords as Array)[0]);                     //modified for test
			}
		}
		public function get symbol_type():String
		{
			return this.symbol_type_;
		}
		var a:Array;
		//buffer参数暂时留着而已
		public function PData(pts:Array):Array{
//			var bfr:uint=0;
//        	var x:Number=bounds.x-bounds.width*bfr;
//        	var y:Number=bounds.y-bounds.height*bfr;        	
//        	var realRec:Rectangle=new Rectangle(x,y,(2*bfr+1)*bounds.width,(2*bfr+1)*bounds.height);
//        	var proportion:Number=Math.min(Math.abs(realRec.width/bbox.width),Math.abs(realRec.height/bbox.height));
//        	
//        	var dx:Number=0.001745;
//        	var dy:Number=-0.000860;
//        	for(var i:uint=0;i<pts.length-1;i=i+2)
//        	{   
//        		pts[i]=(pts[i]-bbox.x+dx)*proportion + realRec.x;
//        		pts[i+1]=-(pts[i+1]-bbox.y+dy)*proportion + realRec.bottom;
//        	}
			// edit by zhangxu
//        	for(var i:uint=0;i<pts.length-1;i=i+2)
//        	{   
//        		var px:Pixel = this.map.getLayerPxFromLonLat(new LonLat(pts[i], pts[i+1]));
//        		pts[i] = px.x;
//        		pts[i+1] = px.y;
//        	}			
//        	return pts;
			// edit by chzx
			var resolution:Number = this.map.getResolution();
	        var extent:Bounds = this.map.getExtent();
			for(var i:uint=0;i<pts.length-1;i+=2){
  	            pts[i] = (1/resolution * (pts[i] - extent.left));
	            pts[i+1] = (1/resolution * (extent.top - pts[i+1]));
	            pts[i] = Math.round(pts[i]);
        		pts[i+1] = Math.round(pts[i+1]);
        		pts[i] = pts[i] - this.map.layerContainer.x;
        		pts[i+1] = pts[i+1] - this.map.layerContainer.y;
			}

			return pts;
	    }
	    
		public function PMultiData(arr:Array):Array
		{
			var r:Array=[];
			for(var i:int=0;i<arr.length;i++)
			{
				r.push(this.PData(arr[i]));
			}
			return r;
		}
				
	}
}