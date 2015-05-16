package org.liesmars.flashwebclient.SearchImp
{
	import flash.events.Event;
	import flash.net.*;
	
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.Layer;
		
	public class SearchPoint
	{
		private var map:GeoMap;
		private var layername:String;
		private var featurename:String;
		private var zoomLevel:int;
		
		public function SearchPoint(map:GeoMap,layername:String,featurename:String)
		{
			this.map = map;
			this.layername = layername;
			this.featurename = featurename;
		}
		
		public function Active():void{
			var layer:Layer = this.map.getLayerByName(layername);
    	    if(layer){
    		    var obj:Object = layer.params;
    		    var typename:String = obj.TYPENAME as String;		
//    		var minZoomLevel:int = layer.minZoomLevel as int;
//    		var maxZoomLevel:int = layer.maxZoomLevel as int;
    		    zoomLevel = (layer.minZoomLevel+layer.maxZoomLevel)/2;
    		    var url:String = "http://localhost:8088/geoserver/wfs";
    		    var request:URLRequest=new URLRequest(url);
			    request.method="post";
			    var data:String="<wfs:GetFeature service=\"WFS\" version=\"1.0.0\"";
			    data += " outputFormat=\"GML2\"";
			    data += " xmlns:topp=\"http://www.openplans.org/topp\"";
			    data += " xmlns:wfs=\"http://www.opengis.net/wfs\"";
			    data += " xmlns:ogc=\"http://www.opengis.net/ogc\"";
			    data += " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"";
			    data += " xsi:schemaLocation=\"http://www.opengis.net/wfs"
			    data += " http://schemas.opengis.net/wfs/1.0.0/WFS-basic.xsd\">";
			    data += " <wfs:Query typeName=\""+typename+"\">";
			    data += " <ogc:Filter>"
			    data += " <PropertyIsEqualTo>";
//			    data += " <PropertyName>kml_name</PropertyName>";
			    data += " <PropertyName>name</PropertyName>";
			    data += " <Literal>"+featurename+"</Literal>";
			    data += " </PropertyIsEqualTo>"
			    data += " </ogc:Filter>";
			    data += " </wfs:Query>";
			    data += " </wfs:GetFeature>";
			    request.data=data;//this.getSendData();
			    var loader:URLLoader=new URLLoader();
			    loader.dataFormat=URLLoaderDataFormat.BINARY;//默认就是TEXT
			    loader.addEventListener(Event.COMPLETE,getPoint);//getPoint,getL
			    loader.load(request);
    	    }
    	    else{
    		    return;
    	    } 
		}
		
		private function getPoint(e:Event):void{
    	    var xml:XML=new XML(e.target.data);
    	    trace(xml);
    	    var result:String = "";
		    for each (var i:XML in xml.children()){
			    if(i.localName().toString().toUpperCase()=="FEATUREMEMBER")
			    {
				    var xl:XMLList = i.children();			
				    for each(var j:XML in xl.children()){
					    trace(j.localName());
					    if(j.localName().toString()=="the_geom"){
						    result = j.child(0).child(0);
						    var arr:Array = result.split(',');
						    var ll:LonLat = new LonLat(arr[0],arr[1]);
			                this.map.setCenter(ll,zoomLevel);
					    }
				    }
			    }				
		    }
        }

	}
}