package org.liesmars.flashwebclient.Parser
{

	import flash.utils.Dictionary;
	
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.ParseToGS;
		
	public class JsonToGS extends ParseToGS
	{
		private var json_obj:Object;
		private var map:GeoMap;
		// test
		private var pts_num:int = 0;
		
		public function JsonToGS(map:GeoMap, obj:Object)
		{
			super(map,obj);
			this.map = map;
			json_obj = obj;
		}
		
		public override function Parse():Object{
			var result:Array = new Array();
			var json_arr:Array = json_obj.features as Array;
			if(!json_arr || json_arr.length == 0){
				trace("没有数据"+":"+json_arr);
				return null;
			}
			
			var type:String=json_arr[0].geometry.type as String;		

			if(type.toUpperCase().indexOf("POINT")>=0){
				result.push(this.ParsePoint(json_arr));
			}
			else if(type.toUpperCase().indexOf("MULTILINESTRING")>=0){
				result.push(this.ParseMultiLineString(json_arr));
			}
			else if(type.toUpperCase().indexOf("MULTIPOLYGON")>=0){//暂时未测试
				result.push(this.ParseMultiPolygon(json_arr));
			}
			//test
			trace("pts number of geojson is ", pts_num);
			return result;
		}
		
		private function ParsePoint(json:Array):Array{
			var result:Array = new Array();
			for(var i:int = 0;i<json.length;i++){
				var ft:Object = json[i];
				var geom:Object = ft.geometry;
				//var coord:Array = new Array();
				var coord:Array = geom.coordinates as Array;
				
				var key:Object = new Object();
				key.toString = function() { return "name" }
				var keyname:String = ft.properties.NAME?ft.properties.NAME:"";
				var dic:Dictionary = new Dictionary();
				dic[key] = keyname;
				
				var pt:GeoShape = new GeoShape();
				pt.coords = [coord];
				pt.attributes = dic;
				pt.geotype=(coord.length<=2)?GEOTYPES.POINT:GEOTYPES.MULTIPOINT;
				result.push(pt);
				// test
				pts_num += 1;
			}
			return result;
		}
		
		private function ParseMultiLineString(json:Array):Array{
			var result:Array = new Array();
			for(var i:int = 0;i<json.length;i++){
				var ft:Object = json[i];
				var geom:Object = ft.geometry;
				var featuretype:String = geom.type;
				
				var shp:GeoShape = new GeoShape();
				shp.featuretype = featuretype;
				var coordinates:Array = geom.coordinates as Array;
				var coords:Array = new Array();
				
				for(var j:int = 0;j < coordinates.length;j++){
					var lines:Array = coordinates[j];
					var coord:Array = new Array();
					for(var k:int = 0;k<lines.length;k++){
						var pt:Array = lines[k];
						coord.push(pt[0]);
						coord.push(pt[1]);
						// test
						pts_num += 1;
					}
					coords.push(coord);
				}
				if(coordinates.length == 1){
					shp.geotype = GEOTYPES.LINE;
				}
				else{
					shp.geotype = GEOTYPES.MULTILINE;
				}
				shp.coords = coords;
				result.push(shp);
			}
			return result;
		}
		
		private function ParseMultiPolygon(json:Array):Array{
			var result:Array = new Array();
			for(var i:int = 0;i<json.length;i++){
				var ft:Object = json[i];
				var geom:Object = ft.geometry;
				var featuretype:String = geom.type;
				
				var shp:GeoShape = new GeoShape();
				shp.featuretype = featuretype;
				var coordinates:Array = geom.coordinates as Array;
				var coords:Array = new Array();
				
				for(var j:int = 0;j < coordinates.length;j++){
					var rings:Array = coordinates[j];
					for(var k:int = 0;k<rings.length;k++){
						var coord:Array = new Array();
						var lines:Array = rings[k];
						for(var m:int=0;m<lines.length;m++){
							var pt:Array = lines[m];
							coord.push(pt[0]);
							coord.push(pt[1]);
							// test
							pts_num += 1;
						}
						coords.push(coord);
					}
				}
				if(rings.length == 1){
					shp.geotype = GEOTYPES.POLYGON;
				}
				else{
					shp.geotype = GEOTYPES.MULTIPOLYGON;
				}
				shp.coords = coords;
				result.push(shp);
			}
			return result;
		}
		
		private function ParseLine(obj:Object):Array{
			var result:Array = new Array();
			result = ParseLineOrPolygon(obj,true);
			return result;
		}
		
		private function ParsePolygon(obj:Object):Array{
			var result:Array = new Array();
			result = ParseLineOrPolygon(obj,false);
			return result;
		}
		
		private function ParseLineOrPolygon(json:Object,isLine:Boolean):Array{
			var result:Array = new Array();
			
			var geoms:Array=json.Geom as Array;
			var featuretype:String=json.FeatureType as String;
			var attributes:Array=[];	
			
			for(var j:int=0;j<geoms.length;j++)
			{
				var dic:Dictionary=new Dictionary();				
				for(var key:Object in json)
				{
					var att:Array=json[key] as Array;
					var upcase:String=key.toString().toUpperCase();
					var b:Boolean=upcase=="FEATURETYPE"||upcase=="GEOTYPE" ||upcase=="GEOM";
					if(!b)dic[key]=att[j];
				}
				attributes.push(dic);
			}
			
			for(var i:int=0;i<geoms.length;i++)
			{
				//单个线对象包含多个线
				var geom:Array=geoms[i] as Array;
				var shp:GeoShape=new GeoShape;
				if(isLine){
				    shp.geotype = GEOTYPES.LINE;
			    }
			    else{
				    shp.geotype = GEOTYPES.POLYGON;
			    }
				shp.attributes=attributes[i];
				
				shp.featuretype=featuretype;
				
				var ar:Array=new Array();
				
				try{
					ar=geom[0] as Array;
				}
				catch(e:Error){trace(e.message);}
				if(ar && ar.length>0)
				{
//					var seg:Array=this.PMultiData(geom);
					shp.coords=geom;
					shp.geotype=isLine?GEOTYPES.MULTILINE:GEOTYPES.MULTIPOLYGON;							
				}
				else 
				{	
//					var seg:Array=this.PData(geom);
					
					shp.coords=[geom];	
					shp.geotype=isLine?GEOTYPES.LINE:GEOTYPES.POLYGON;                      
				}
				result.push(shp);
			}
			return result;
		}
	}
}