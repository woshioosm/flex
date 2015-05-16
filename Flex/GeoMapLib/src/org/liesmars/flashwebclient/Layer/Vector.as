package org.liesmars.flashwebclient.Layer
{
//	import GeoEvent.LayerEvent.*;
	
	import com.adobe.serialization.json.*;
	
	import flash.display.Graphics;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.liesmars.flashwebclient.BaseTypes.*;
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Index.GridIndex;
	import org.liesmars.flashwebclient.Layer;
	import org.liesmars.flashwebclient.ParseToGS;
	import org.liesmars.flashwebclient.Parser.*;
	import org.liesmars.flashwebclient.SimpleVector.SVector;
	import org.liesmars.flashwebclient.Symbol;
	import org.liesmars.flashwebclient.Symbol.*;
	import org.liesmars.flashwebclient.Util;

//	[Event(name="loaded", type="GeoEvent.LayerEvent.DataEvent")]//
//	[Event(name="begindraw", type="GeoEvent.LayerEvent.DataEvent")]
//	[Event(name="beginload", type="GeoEvent.LayerEvent.DataEvent")]//
	
	//其实可以让整个map拥有一个解析器，而不是每个矢量图层一个
	public class Vector extends Layer
	{
	
	    /**
	     * Constant: DEFAULT_PARAMS
	     * {Object} Hashtable of default parameter key/value pairs 
	     */
	    private const DEFAULT_PARAMS:Object = { service: "WFS",
	                      version: "1.1.1",
	                      request: "GetFeature",
	                      outputFormat: "geojson"
	                     };
	    /**
	     * APIProperty: encodeBBOX
	     * {Boolean} Should the BBOX commas be encoded? The WMS spec says 'no', 
	     * but some services want it that way. Default false.
	     */
	    private var encodeBBOX:Boolean = false;
	    		
		public var json:Object=null;
		public var amfobject:Array = null;
		public var xml:XML = null;
		//用这个东西来绘图，每个矢量图层都可以拥有一个，因而可以选择不同的渲染器
		//如果觉得这样为每个矢量图层分配一个渲染器太浪费了，那么可以将渲染器放到Util中，让所有矢量图层共用
		public var symbol:Symbol=null;	
		public var loaded:String="";	
//		public var clear:Boolean=false;
		private var parser:ParseToGS = null;
		private var p_lefttop:Pixel=null;
		private var p_rightbottom:Pixel=null;
		//各个图层的索引
		public var index:GridIndex;

		// 论文测试
		var sendTime:Date;
		var recvTime:Date;
		//
		private var loader:URLLoader=new URLLoader();//和栅格图加载用到的对象不同
		
		public function Vector(name:String, url:String, params:Object, options:Object)
		{	
	        params = Util.upperCaseObject(params);

	        super(name, url, params, options);
			
	        Util.applyDefaults(
	                       this.params, 
	                       Util.upperCaseObject(this.DEFAULT_PARAMS)
	                       );					
	
		}
		
	    public override function moveTo(bounds:Bounds, zoomChanged:Boolean, dragging:Boolean):void {  
			super.moveTo(bounds, zoomChanged, dragging);
			
			if(Util.UseLocalMode){
				//if(Util.GeoMapIndex){
					while(this.numChildren>0){
						this.removeChildAt(0);
					}
					
					var lonlat1:LonLat = map.getLonLatFromPixel(new Pixel(map.sprite.x,map.sprite.y));
					var lonlat2:LonLat = map.getLonLatFromPixel(new Pixel(map.sprite.x+map.sprite.width,map.sprite.y+map.sprite.height));
					var lb_x:Number = lonlat1.lon;
					var lb_y:Number = lonlat2.lat;
					var rt_x:Number = lonlat2.lon;
					var rt_y:Number = lonlat1.lat;
					trace("region is :",lb_x,rt_x,lb_y,rt_y);
					var objs:Array = index.getVectorsInArea(rt_x,lb_x,rt_y,lb_y);
					// 开始绘制
					var shps:Array = new Array();
					if(objs){
						trace("vector num is :"+objs.length);
						for(var i:int=0;i<objs.length;i++){
							var tmp:SVector = objs[i];
							//tmp.draw(this.graphics);
							switch(tmp.geotype){
								case GEOTYPES.POINT :
									var shp:GeoShape = new GeoShape();
									shp.featuretype = tmp.featuretype;
									shp.attributes = tmp.attributes;
									shp.coords = [tmp.coords];
									shp.geotype = tmp.geotype;
									shps.push(shp);
									break;
								case GEOTYPES.LINE:
									var shp:GeoShape = new GeoShape();
									shp.featuretype = tmp.featuretype;
									shp.coords = tmp.coords;
									shp.geotype = GEOTYPES.LINE;
									shps.push(shp);
									break;
								case GEOTYPES.MULTILINE	:
									var shp:GeoShape = new GeoShape();
									shp.featuretype = tmp.featuretype;
									shp.coords = tmp.coords;
									shp.geotype = GEOTYPES.MULTILINE;
									shps.push(shp);
									break;
								case GEOTYPES.RECT:
									var shp:GeoShape = new GeoShape();
									shp.featuretype = tmp.featuretype;
									shp.coords = tmp.coords;
									shp.geotype = GEOTYPES.RECT;
									shps.push(shp);
									break;
								case GEOTYPES.POLYGON:
									var shp:GeoShape = new GeoShape();
									shp.featuretype = tmp.featuretype;
									shp.coords = tmp.coords;
									shp.geotype = GEOTYPES.POLYGON;
									shps.push(shp);
									break;
								case GEOTYPES.MULTIPOLYGON:
									var shp:GeoShape = new GeoShape();
									shp.featuretype = tmp.featuretype;
									shp.coords = tmp.coords;
									shp.geotype = GEOTYPES.MULTIPOLYGON;
									shps.push(shp);
									break;
								default:
									trace("Undefined Type...");
									return ;
							}
						}
						trace(shps.length);
						if(!this.symbol)this.symbol=new Default(this.map,{});
						
						this.symbol.DrawLocalData(shps,this);
						//this.symbol.Draw(shps,this);
					}
					else{
						trace("屏幕范围内无数据");
					}
					//trace(objs.length);
					return;
				//}
			}

			if(url) {
				if(!zoomChanged) {
				if(this.p_lefttop && this.p_rightbottom) {
					var lefttop:Pixel = this.map.getViewPortPxFromLayerPx(this.p_lefttop);
					var rightbottom:Pixel = this.map.getViewPortPxFromLayerPx(this.p_rightbottom);
					
		            if (lefttop.x <= 0 && rightbottom.x >= this.map.getSize().w && lefttop.y <= 0 && rightbottom.y >= this.map.getSize().h) {
		            	return;
		            }
				}	
				}
		        var center:LonLat = bounds.getCenterLonLat();
		        var tileWidth:Number = bounds.getWidth() ;
		        var tileHeight:Number = bounds.getHeight() ;
		        var resolution:Number = this.map.getResolution();
		        var tilelon:Number = resolution * this.map.TILE_WIDTH;
		        var tilelat:Number = resolution * this.map.TILE_HEIGHT;
		           
	        	var bufferBounds:Bounds = 
	            new Bounds(center.lon - (tileWidth/2 + buffer * tilelon),
	                                  center.lat - (tileHeight/2+ buffer * tilelat),
	                                  center.lon + (tileWidth/2 + buffer * tilelon),
	                                  center.lat + (tileHeight/2+ buffer * tilelat));
		        trace("extent" + this.map.getExtent().toString());
		        trace("bounds" + bounds.toString());
		        
				var request:String = this.getURL(bufferBounds);
				trace(request);
			    this.Load(request);
			    //
			    sendTime = new Date();
			} else {
//				this.clear();
                this.Redraw();
			}
	    }
		
		
	    /**
	     * Method: getURL
	     * Return a GetMap query string for this layer
	     *
	     * Parameters:
	     * bounds - {<OpenLayers.Bounds>} A bounds representing the bbox for the
	     *                                request.
	     *
	     * Returns:
	     * {String} A string with the layer's url and parameters and also the
	     *          passed-in bounds and appropriate tile size specified as 
	     *          parameters.
	     */
	    public override function getURL(bounds:Bounds):String {
	        bounds = this.adjustBounds(bounds);
	         
	        var bbox:Object;
	        if(encodeBBOX) {bbox = bounds.toBBOX();}
	        else bbox = bounds.toArray();
	        
	        var newParams:Object = {
	            'BBOX': (bbox, encodeBBOX? bounds.toBBOX():bounds.toArray())
	        };
	        var requestString:String = this.getFullRequestString(newParams);
	        return requestString;
	    }
	    
		private  function Load(request:String):void
		{
			//if(this.map.GetZoom()<13)return;//武汉的数据只有14级，我们显示两级
//			this.dispatchEvent(new DataEvent_(DataEvent_.VECTOR_BEGINLOAD,this,false,false));
			var urlrequest:URLRequest=new URLRequest(request);
//			if(this.params.OUTPUTFORMAT == "AMF"){
//				loader.dataFormat=URLLoaderDataFormat.BINARY;//默认就是TEXT
//			}
//			else{
//				loader.dataFormat=URLLoaderDataFormat.TEXT;
//			}
			loader.dataFormat=URLLoaderDataFormat.BINARY;//geojson目前也是用amf传过来的
			loader.addEventListener(Event.COMPLETE,RecvData);
			loader.addEventListener(IOErrorEvent.IO_ERROR,IoError);
			this.loaded="LOADING";
			loader.load(urlrequest);
		}
		private function IoError(event: ErrorEvent):void
		{
			trace("调用矢量数据出错！");
		}
		
		
		private function RecvData(event:Event):void
		{	
			recvTime = new Date();
			trace("传输时间为: ",(recvTime.time - sendTime.time))	
//			this.dispatchEvent(new DataEvent_(DataEvent_.VECTOR_LOADED,this,false,false));			
//			trace("data:"+event.target.data);	
			if(!event.target.data) {
				trace("event target data-- null");
				return;
			}
			
			if(event.target.data) {
			}

            if(this.params.OUTPUTFORMAT == "json"){
			    var obj:String = loader.data.toString();//传数组回来
			    var test:ByteArray = new ByteArray();
			    test.writeObject(obj);
			    trace("data size of geojson is "+test.length);
			    var beginSerialize:Date = new Date();
			    var json:Object = JSON.decode(obj) as Object;
			    var endSerialize:Date = new Date();
			    trace("time cost for geojson serializing is ",endSerialize.time-beginSerialize.time);
			    this.json=json;	
			    this.loaded="LOADED";
            }
            else if(this.params.OUTPUTFORMAT == "AMF"){
            	var byte:ByteArray = loader.data as ByteArray;
            	// 测试传输的字节数
            	trace("data size of amf is :"+byte.bytesAvailable);
            	//var amfobj:Array= byte.readObject() as Array;
            	var beginSerialize:Date = new Date();
            	var res:Array = byte.readObject() as Array;
            	var amfobj:Array = res.slice(0,res.length-1);
            	var endSerialize:Date = new Date();
            	trace("time cost for amf serializing is ",endSerialize.time-beginSerialize.time);
            	this.amfobject = amfobj;
            	//trace("vector length :"+amfobj.length);
            	var bound:Object = res.pop();
            	var bbox:Array = bound.bbox;
            	this.loaded = "LOADED";
            }
            else if(this.params.OUTPUTFORMAT == "GML2"){
            	var beginSerialize:Date = new Date();
            	this.xml = new XML(loader.data.toString());
            	var endSerialize:Date = new Date();
			    trace("time cost for gml2 serializing is ",endSerialize.time-beginSerialize.time);
            	var test:ByteArray = new ByteArray();
			    test.writeObject(xml);
			    trace("data size of gml2 is "+test.length);
            	this.loaded = "LOADED";
            }
			
			
			//this.symbol=new Symbol_Icon(this.map,{});
			//符号化后很慢
			if(layername=="四川县市" || layername == "world cities(wfs)") this.symbol=new PointSymbol(this.map,{"_strokeStyle":new StrokeStyle(1,0xF1B8FC,1)});
			if(layername=="四川河流" || layername == "world rivers(wfs)" || layername == "china_river1_ln(wfs)") 
			{
				//this.symbol=new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(8,0x000000,1),"_lineStyle":new LineStyle(15,0,0,1)});
				this.symbol=new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(4,0x66ccff,1),"_lineStyle":new LineStyle(15,0,0,1)});
			}
			if(layername == "四川行政区划" || layername == "world countries(wfs)")
			{
				this.symbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,1),"_fillStyle":new FillStyle(0xffffff,.3)});
				
			}
			if(layername == "四川边界线")
			{
				this.symbol=new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,1),"_lineStyle":new LineStyle(15,0,0,1)});
				
			}
//			if(layername=="world rivers(wfs)") 
//			{
//				//this.symbol=new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(8,0x000000,1),"_lineStyle":new LineStyle(15,0,0,1)});
//				Util.UseSymbolization = true;
//				this.symbol=new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(4,0xd2bd98,1),"_lineStyle":new LineStyle(8,0,0,1)});
//			    this.symbol.isDbLine = true;   
//			}
			if(Util.UseSymbolization)
			{
				if(layername=="world rivers(wfs)") 
				{
					this.symbol=new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(4,0xffffff,1),"_lineStyle":new LineStyle(8,8,10,1)});
				}
			}

			if(!this.symbol)this.symbol=new Default(this.map,{});
			
			this.p_lefttop = this.map.getLayerPxFromViewPortPx(new Pixel(-buffer*this.tileSize.w, -buffer*this.tileSize.h));
			this.p_rightbottom = this.map.getLayerPxFromViewPortPx(new Pixel((this.map.getSize().w + buffer*this.tileSize.w), (this.map.getSize().h + buffer*this.tileSize.h)));
					
			this.Draw();
			// 测试开始绘制的时间
			//var d2:Date = new Date();
			//trace("endtime:"+d2.getTime());	
		}
		
		private function Draw():void
		{
			//this.symbol=new Symbol_Icon(this.map,{});//
			
			this.clear();
			if(this.json )//&& !this.drawn)
			{
	            parser = new JsonToGS(this.map,this.json);
	            var beginParse:Date = new Date();
			    var shps:Array = parser.Parse() as Array;
			    var endParse:Date = new Date();
				trace("time cost for geojson parsing is:",endParse.time - beginParse.time);
				this.symbol.Draw(shps,this);
			}
			else if(this.amfobject){
				parser = new AMFObjectToGS(this.map,this.amfobject);
				var beginParse:Date = new Date();
				var shps:Array = parser.Parse() as Array;
				var endParse:Date = new Date();
				trace("time cost for amf parsing is:",endParse.time - beginParse.time);
				this.symbol.Draw(shps,this);
			}
			else if(this.root){
				parser = new GML2ToGS(this.map, this.xml);
				var beginParse:Date = new Date();
				var shps:Array = parser.Parse() as Array;
				var endParse:Date = new Date();
				trace("time cost for gml2 parsing is:",endParse.time - beginParse.time);
				this.symbol.Draw(shps,this);
			}
		}	
		
		public function Redraw():void{
				for(var j:int=0;j<this.numChildren;j++){
					var shape:GeoShape = this.getChildAt(j) as GeoShape;
					if(shape.coords){
					    if(shape.geotype == GEOTYPES.POLYGON){
					    	shape.x=0;//因为当拖动之后，shape:GeoShape的x,y坐标发生了变化，但是它所带有的coords属性还是按照x=0,y=0计算的
			                shape.y=0;
						    shape.graphics.clear();
						    //DrawRings(shape,shape.coords as Array,this.symbol);
						    var lineRing:Array = null;
						    var total:Array = shape.coords as Array;
							var g:Graphics=shape.graphics;
							if(shape.colorCode==0)
							   g.beginFill(this.symbol._fillStyle._fillColor,this.symbol._fillStyle._fillAlpha);
							else
								g.beginFill(0xffffff,0.2);
						    for(var i:int=0;i<total.length;i++)
			                {
			                	lineRing = total[i] as Array;
				                if(lineRing.length<2)return;
                                this.symbol.DrawPolygon2(shape,lineRing);   // here
			                }
							g.endFill();
						}
						else if(shape.geotype == GEOTYPES.RECT){
							shape.x=0;//因为当拖动之后，shape:GeoShape的x,y坐标发生了变化，但是它所带有的coords属性还是按照x=0,y=0计算的
							shape.y=0;
							shape.graphics.clear();
							//DrawRings(shape,shape.coords as Array,this.symbol);
							var lineRing:Array = null;
							var total:Array = shape.coords as Array;
							for(var i:int=0;i<total.length;i++)
							{
								lineRing = total[i] as Array;
								if(lineRing.length<2)return;
								this.symbol.DrawRectangular(shape,lineRing);
							}
						}
						else if(shape.geotype == GEOTYPES.LINE){
							shape.x = 0;
							shape.y = 0;
							shape.graphics.clear();
							shape.graphics.lineStyle(2,0xff00ff,0.8);
							//DrawLines(shape,shape.coords as Array,13391257,0.6);
							var lineRing:Array = null;
							var total:Array = shape.coords as Array;
							for(var i:int=0;i<total.length;i++)
			                {
			                	 lineRing = total[i] as Array;
				                 if(lineRing.length<2)return; 
								 
                                 this.symbol.DrawLine(shape,lineRing);
			                }
						}
						else if(shape.geotype == GEOTYPES.POINT){
							shape.x = 0;
							shape.y = 0;
							shape.graphics.clear();							
                            var total:Array = (shape.coords as Array);
                            for(var t:int =0;t<total.length;t ++){
								var pointArr:Array=(shape.coords as Array)[t];
                            	var p:Point = new Point();
                            	p.x = pointArr[0];
                            	p.y = pointArr[1];
                            	this.symbol.DrawPoint(shape,p,Util.radius,null);
                            }
						}
						else if(shape.geotype == GEOTYPES.MARKER){
							shape.x = 0;
							shape.y = 0;
							shape.graphics.clear();
							var m:Point = new Point();
							m = shape.coords.valueOf();
							this.symbol.DrawMarker(shape,m,20,shape.featuretype);
						}
					}
				}

		}		
		
		public override function clear():void
		{
			while(this.numChildren>0){
				this.removeChild(this.getChildAt(0));}		
		}
		
		protected override function destroy():void
		{
	        super.destroy();
		}
		
	}
}