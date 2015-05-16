package  org.liesmars.flashwebclient.Layer.Raster
{
	import flash.events.MouseEvent;
	
	import org.liesmars.flashwebclient.BaseTypes.Bounds;
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.Layer.Raster;
	import org.liesmars.flashwebclient.Tile;
	import org.liesmars.flashwebclient.Tile.ImageTile;

	public class Tianditu extends Raster
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
		
		private var rsImageServerName:String=""; //天地图遥感图 不同的缩放级别 获取底图的get url方法不同
		private var annoRsServerName:String="";// 天地图遥感图的注记层
		private var annoMapServerName:String="";// 天地图普通地图的注记层
		private var mapServerName="";          //天地图的普通地图
		private var mapType="";  //包括底图 卫星影像 注记层
		
		public function MM(e:MouseEvent):void{
			
		}
		public function Tianditu(name:String, url:String, options:Object ,type:String)
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,MM);
			super(name, url, {}, options);
			mapType=type;
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
			
			if (obj == null) {
				obj = new Tianditu(this.name,
					this.url,
					this.options,this.mapType);
			}
			
	
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
			
//			var path:String =  "?T=" + this.serviceType + "&L=" + level + "&X=" + x + "&Y=" + y;
			
			var url:String = this.url;
			if (url is Array) {
			}
//			trace(url+path);
			var serverName:String="";
			switch(mapType){
				case "basemap":
					serverName=getMapServerName(this.map.zoom);
					break;
				case  "annoMap":
					serverName=getAnnoMapServerName(this.map.zoom);
					if(this.map.zoom>=9)
						this.visible=false;
					else
						this.visible=true;
					break;
				case "RsMap":
					serverName=getRsImageServerName(this.map.zoom);
					break;
				case "RsAnnoMap":
					serverName=getAnnoRsServerName(this.map.zoom);
					break;
				default:
					break;
			}
			//this.url="http://localhost:8080/examples/1.png"
			//var str:String="http://localhost:8080/examples/1.png";
			trace(url);
			var str:String=url+"/DataServer?T="+serverName+"&X=" + x + "&Y=" + y+"&L="+(this.map.zoom+2);
			trace(str);
			
//		var str2:String="http://202.114.118.150:12000/GeoGlobe/taiyuan/wmts?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=taiyuan&FORMAT=image/png&STYLE=&TILEMATRIXSET=taiyuan&TILEMATRIX="+level+"&TILECOL="+x+"&TILEROW="+y;
//			trace(str2);
			return str;
//			return "http://"+getTileServerName(x)+".tianditu.com/DataServer?T="+serverName+"&X=" + x + "&Y=" + y+"&L="+(this.map.zoom+2);
		}
		private function getTileServerName(x:int):String{
			return "tile"+x%8;
		}
		private function getRsImageServerName(zoom:int):String{  //天地图的level为2-18  则zoom为0-16 级    zoom为0即代表level2
			switch(zoom){
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
				case 7:
				case 8:
					rsImageServerName="sbsm0210";
					break;
				case 9:
					rsImageServerName="e11";
					break;
				case 10:
					rsImageServerName="e12";
					break;
				case 11:
					rsImageServerName="e13";
					break;
				case 12:
					rsImageServerName="eastdawnall";
					break;
				case 13:
				case 14:
				case 15:
				case 16:
					rsImageServerName="sbsm1518";
					break;
				default:
					break;
			}
			return rsImageServerName;
		}
		private function getAnnoRsServerName(zoom:int):String{
			switch(zoom){
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
				case 7:
				case 8:
					annoRsServerName="A0610_ImgAnno";
					break;
				case 9:
					annoRsServerName="B0530_eImgAnno ";
					break;
				case 10:
					annoRsServerName="B0530_eImgAnno";
					break;
				case 11:
					annoRsServerName="B0530_eImgAnno ";
					break;
				case 12:
					annoRsServerName="B0530_eImgAnno";
					break;
				case 13:
				case 14:
				case 15:
				case 16:
					annoRsServerName="siweiAnno68";
					break;
				default:
					break;
			}
			return annoRsServerName;
		}
		private function getMapServerName(zoom:int):String{
			switch(zoom){
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
				case 7:
				case 8:
					mapServerName="A0512_EMap";
					break;
				case 9:
				case 10:
					mapServerName="B0627_EMap1112";
					break;
				case 11:
				case 12:
				case 13:
				case 14:
				case 15:
				case 16:
					mapServerName="siwei0608";
					break;
				default:
					break;
			}
			return mapServerName;
		}
		private function getAnnoMapServerName(zoom:int):String{
			switch(zoom){
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
				case 7:
				case 8:
					annoMapServerName="AB0512_Anno";
					break;
                default:
					annoMapServerName="";
					break;
			}
			return annoMapServerName;
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