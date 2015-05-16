package org.liesmars.flashwebclient.Parser
{
	import flash.utils.Dictionary;
	
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.ParseToGS;
	import org.liesmars.flashwebclient.SimpleVector.SVector;
	import org.liesmars.flashwebclient.Util;
	
	public class AMFObjectToSV extends ParseToGS
	{
		private var map:GeoMap;
		private var amfobjs:Array;
		
		public function AMFObjectToSV(map:GeoMap, obj:Array)
		{
			super(map, obj);
			this.map = map;
			amfobjs = obj;
		}
		
		public override function Parse():Object{
			var result:Array = new Array();
			for(var i:int = 0;i<amfobjs.length;i++){
				var amfobj:Object = amfobjs[i] as Object;
				if(amfobj.GeoType == "Point"){
					result.push(ParseSVPoint(amfobj));
				}
				else if(amfobj.GeoType == "Polyline"){
					result.push(ParseSVPolyline(amfobj));
				}
				else if(amfobj.GeoType == "Polygon"){
					result.push(ParseSVPolygon(amfobj));
				}
			}
			return result;
		}
		
		public function ParseSVPoint(obj:Object):Array{
			var result:Array = new Array();
			var arrCoords:Array = obj.geom;
			var arrAttributes:Array = obj.name;
			for(var i=0;i<arrCoords.length;i++){
				var key:Object = new Object();
				key.toString = function() { return "name" }
				var keyname:String = arrAttributes[i] as String;
				var dic:Dictionary = new Dictionary();
				dic[key] = keyname;
				
				var pt:SVector = new SVector(map);
				pt.coords = arrCoords[i] as Array;
				pt.name = arrAttributes[i] as String;
				pt.attributes = dic;
				pt.geotype=(pt.coords.length<=2)?GEOTYPES.POINT:GEOTYPES.MULTIPOINT;
				pt.bbox = obj.bbox;
				result.push(pt);
			}
			return result;
		}
		
		public function ParseSVPolyline(obj:Object):Array{
			var result:Array = new Array();
			var arrCoords:Array = obj.geom;
			var arrAttributes:Array = obj.name;
			var featuretype:String = obj.FeatureType;
			for(var i=0;i<arrCoords.length;i++){
				var shp:SVector = new SVector(map);
				shp.featuretype = featuretype;
				shp.name = arrAttributes[i] as String;
				shp.bbox = obj.bbox;
				var coord:Array = arrCoords[i] as Array;
				var ar:Array = new Array();
				try{
					ar=coord[0] as Array;
				}
				catch(e:Error){trace(e.message);}
				if(ar && ar.length>0)
				{
//					var seg:Array=this.PMultiData(geom);
					shp.coords=coord;
					shp.geotype=GEOTYPES.MULTILINE;							
				}
				else 
				{	
//					var seg:Array=this.PData(geom);
					shp.coords=[coord];	
					shp.geotype=GEOTYPES.LINE;                      
				}
				result.push(shp);
			}
			return result;
		}
		
		public function ParseSVPolygon(obj:Object):Array{
			var result:Array = new Array();
			var arrCoords:Array = obj.geom;
			var arrAttributes:Array = obj.name;
			var featuretype:String = obj.FeatureType;
			for(var i=0;i<arrCoords.length;i++){
				var shp:SVector = new SVector(map);
				shp.featuretype = featuretype;
				shp.name = arrAttributes[i];
				shp.bbox = obj.bbox;
				var coord:Array = arrCoords[i] as Array;
				var ar:Array = new Array();
				try{
					ar=coord[0] as Array;
				}
				catch(e:Error){trace(e.message);}
				if(ar && ar.length>0)
				{
//					var seg:Array=this.PMultiData(geom);
					shp.coords=coord;
					shp.geotype=GEOTYPES.MULTIPOLYGON;							
				}
				else 
				{	
//					var seg:Array=this.PData(geom);
					shp.coords=[coord];	
					shp.geotype=GEOTYPES.POLYGON;                      
				}
				result.push(shp);
			}
			return result;
		}

	}
}