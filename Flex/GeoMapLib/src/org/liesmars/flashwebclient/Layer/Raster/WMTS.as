package org.liesmars.flashwebclient.Layer.Raster
{
	import flash.events.MouseEvent;
	
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.Layer.Raster;
	import org.liesmars.flashwebclient.Tile;
	import org.liesmars.flashwebclient.Tile.ImageTile;
	
	public class WMTS extends Raster
	{
		/**
		 * APIProperty: serviceVersion
		 * {String}
		 */
		public var serviceVersion:String = "1.0.0";
		
		/**
		 * APIProperty: serviceVersion
		 * {String}
		 */
		public var serviceType:String = "GloImage";
		
		/**
		 * APIProperty: tileOrigin
		 * {<OpenLayers.Pixel>}
		 */
		public var tileOrigin:LonLat = null;
		
		
		
		public function MM(e:MouseEvent):void{
			
		}
		public function WMTS(name:String, url:String, options:Object )
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,MM);
			super(name, url, {}, options);

		}
		/**
		 * APIMethod:destroy
		 */
		protected override function destroy():void {
			// for now, nothing special to do here. 
			//	        apply(this, arguments); 
			super.destroy();  
		}
		protected override function clone(obj:Object):Object {
			
//			if (obj == null) {
//				obj = new WMTS(this.name,
//					this.url,
//					this.options,this.mapType);
//			}
//			
			
			obj = super.clone(obj);
			return obj;
		}
		/**
		 * Method: getURL
		 * 
		 * Parameters:
		 * bounds - {<OpenLayers.Bounds>}
		 * 
		 * Returns:
		 * {String} A string with the layer's url and parameters and also the 
		 *          passed-in bounds and appropriate tile size specified as 
		 *          parameters
		 */
		public override function getURL(bounds:Bounds):String{
			bounds = this.adjustBounds(bounds);
			var res:Number = this.map.getResolution();
			
			var x:int = Math.ceil((bounds.left - this.tileOrigin.lon) / (res * this.tileSize.w));
			var y:int = Math.ceil((this.tileOrigin.lat-bounds.top) / (res * this.tileSize.h));
			
			
			var z:int = this.map.getZoomForResolution(this.resolutions[0] as Number);
			var level:int = this.map.zoom - z;
			
//			var path:String = constructParam(url,layername,level,x,y);
			var path:String = constructParam("http://202.114.118.99:8080/HelloWorld/hello","taiyuan",level,x,y);
			trace(path);
//			var url:String = this.url;
//		
//			var serverName:String="";
//	
//	
//			var str:String="http://"+url+"/DataServer?T="+serverName+"&X=" + x + "&Y=" + y+"&L="+(this.map.zoom+2);
			
			return path;
		}
		
		public function  constructParam(url:String,layer:String,zoom:int,tileCol:int,tileRow:int):String{
			var str:String=url+"?service=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER="
				+layer+"&FORMAT=image/png&STYLE=&TILEMATRIXSET="+layer+"&TILEMATRIX="
				+zoom+"&"+"TILECOL="+tileCol+"&TILEROW="+tileRow;
			return str;
		}
		/**
		 * Method: addTile
		 * addTile creates a tile, initializes it, and adds it to the layer div. 
		 * 
		 * Parameters:
		 * bounds - {<OpenLayers.Bounds>}
		 * position - {<OpenLayers.Pixel>}
		 * 
		 * Returns:
		 * {<OpenLayers.Tile.Image>} The added OpenLayers.Tile.Image
		 */
		protected override function addTile(bounds:Bounds, position:Pixel):Tile{
			return new ImageTile(this, position, bounds, 
				null, this.tileSize);
			
		}
		/** 
		 * APIMethod: setMap
		 * When the layer is added to a map, then we can fetch our origin 
		 *    (if we don't have one.) 
		 * 
		 * Parameters:
		 * map - {<OpenLayers.Map>}
		 */
		public override function setMap(map:GeoMap):void {
			super.setMap(map);
			if (!this.tileOrigin) { 
				this.tileOrigin = new LonLat(this.map.maxExtent.left,
					this.map.maxExtent.top);
			}                                       
		}
	}
}