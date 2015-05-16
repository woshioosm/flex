package org.liesmars.flashwebclient.Parser
{
	import flash.utils.Dictionary;
	
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.ParseToGS;

	public class AMFObjectToGS extends ParseToGS
	{
		private var map:GeoMap;
		private var amfobjs:Array;
		// test
		private var pts_num:int = 0;
		
		public function AMFObjectToGS(map:GeoMap, obj:Array)
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
					result.push(ParsePoint(amfobj));
				}
				else if(amfobj.GeoType == "Polyline"){
					result.push(ParsePolyline(amfobj));
				}
				else if(amfobj.GeoType == "Polygon"){
					result.push(ParsePolygon(amfobj));
				}
			}
			//test
			trace("pts number of amf is ", pts_num);
			return result;
		}
		
		public function ParsePoint(obj:Object):Array{
			var result:Array = new Array();
			var arrCoords:Array = obj.geom;
			//var arrAttributes:Array = obj.name;
			for(var i=0;i<arrCoords.length;i++){
				var key:Object = new Object();
				key.toString = function() { return "name" }
				var keyname:String = obj.name;//arrAttributes[i] as String;
				var dic:Dictionary = new Dictionary();
				dic[key] = keyname;
				var pt:GeoShape = new GeoShape();
				var coord:Array = arrCoords[i] as Array;
	
				pt.attributes = dic;
				pt.coords = [coord];
				pt.geotype=(coord.length<=2)?GEOTYPES.POINT:GEOTYPES.MULTIPOINT;
				result.push(pt);
				// test
				pts_num += 1;
			}
			return result;
		}
		
		public function ParsePolyline(obj:Object):Array{
			var result:Array = new Array();
			var arrCoords:Array = obj.geom;
			//var arrAttributes:Array = obj.name;
			var featuretype:String = obj.FeatureType;
			for(var i=0;i<arrCoords.length;i++){
				var key:Object = new Object();
				key.toString = function() { return "name" }
				var keyname:String = obj.name;
				var dic:Dictionary = new Dictionary();
				dic[key] = keyname;
				
				var shp:GeoShape = new GeoShape();
				shp.featuretype = featuretype;
				shp.attributes = dic;
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
					//test
					for(var j:int=0;j<coord.length;j++){
						pts_num += (coord[j] as Array).length/2;
					}						
				}
				else 
				{	
//					var seg:Array=this.PData(geom);
					shp.coords=[coord];	
					shp.geotype=GEOTYPES.LINE;    
					//test 
					pts_num += coord.length/2;                 
				}
				result.push(shp);
			}
			return result;
		}
		
		public function ParsePolygon(obj:Object):Array{
			var result:Array = new Array();
			var arrCoords:Array = obj.geom;
			//var arrAttributes:Array = obj.name;
			var featuretype:String = obj.FeatureType;
			for(var i=0;i<arrCoords.length;i++){
				var key:Object = new Object();
				key.toString = function() { return "name" }
				var keyname:String = obj.name;
				var dic:Dictionary = new Dictionary();
				dic[key] = keyname;
				
				var shp:GeoShape = new GeoShape();
				shp.featuretype = featuretype;
				shp.attributes = dic;
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
					//test
					for(var j:int=0;j<coord.length;j++){
						pts_num += (coord[j] as Array).length/2;
					}
				}
				else 
				{	
//					var seg:Array=this.PData(geom);
					shp.coords=[coord];	
					shp.geotype=GEOTYPES.POLYGON; 
					//test  
					pts_num += coord.length/2;                    
				}
				result.push(shp);
			}
			return result;
		}
	}	
}
