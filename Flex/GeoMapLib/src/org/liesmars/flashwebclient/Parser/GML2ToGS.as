package org.liesmars.flashwebclient.Parser
{
	import flash.utils.Dictionary;
	
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.ParseToGS;
	
	public class GML2ToGS extends ParseToGS
	{
		private var map:GeoMap;
		private var xml:XML;
		private var gml:Namespace;
		private var user:Namespace;
		// test
		private var pts_num:int = 0;
		
		public function GML2ToGS(_map:GeoMap, _xml:XML)
		{
			super(map,_xml);
			map = _map;
			xml = _xml;
		}
		
		public override function Parse():Object{
			var result:Array = new Array();
			
			var nss:Array = xml.namespaceDeclarations();
			var tmpNS:Namespace;
			var tmpPrefix:String;
			for(var i:int = 0; i<nss.length; i++){
				tmpNS = nss[i] as Namespace;
				tmpPrefix = tmpNS.prefix;
				if(tmpPrefix == "gml"){
					gml = tmpNS;
				}
				else if(!(tmpPrefix == "" || tmpPrefix == "wfs" || tmpPrefix == "xsi")){
					user = tmpNS;
				}
			}
			if(gml == null || user == null)
				return null;
					
			var list:XMLList = xml.gml::featureMember as XMLList;
			var geom:XML = ((list[0] as XML)..user::the_geom as XMLList)[0];
			if((geom.gml::Point as XMLList).length() != 0)
				result.push(parsePoint(list));
			else if((geom.gml::MultiLineString as XMLList).length() != 0)
				result.push(parseMultiLineString(list));
			else if((geom.gml::MultiPolygon as XMLList).length() != 0)
				result.push(parseMultiPolygon(list));
			//test
			trace("pts number of gml2 is ", pts_num);
			return result;
		}
		
		private function parsePoint(points:XMLList):Array{
			var result:Array = new Array();
			for(var i:int=0;i<points.length();i++){
				var point:XML = points[i];
				var txtCoordinates:String = (point..gml::coordinates[0] as XML).text();
				var coord:Array = txtCoordinates.split(",");
				var name:String = (point..user::NAME[0] as XML).text();
				
				var key:Object = new Object();
				key.toString = function() { return "name" };
				var dic:Dictionary = new Dictionary();
				dic[key] = name;
				var pt:GeoShape = new GeoShape();
				pt.attributes = dic;
				pt.coords = [coord];
				pt.geotype = GEOTYPES.POINT;
				result.push(pt);
				// test
				pts_num += 1;
			}
			return result;
		}
		
		private function parseMultiLineString(lines:XMLList):Array{
			var result:Array = new Array();
			for(var i:int=0;i<lines.length();i++){
				var line:XML = lines[i];
				// 多线的话是多个gml:lineStringMember标签
				var coords:Array = new Array();
				var lineStringMembers:XMLList = line..gml::lineStringMember as XMLList;
				for(var j:int=0;j<lineStringMembers.length();j++){
					var lineStringMember:XML = lineStringMembers[j];
					var txtCoordinates:String = ((lineStringMember..gml::coordinates as XMLList)[0] as XML).text();
					var tmpCoords:Array = txtCoordinates.split(" ");
					var coord:Array = new Array();
					for(var k:int = 0;k<tmpCoords.length;k++){
						var txtCoordinate:String = tmpCoords[k];
						var txtCoord:Array = txtCoordinate.split(",");
						coord.push(txtCoord[0]);
						coord.push(txtCoord[1]);
						// test
						pts_num += 1;
					}
					coords.push(coord);
				}
				var shp:GeoShape = new GeoShape();
				shp.coords = coords;
				lineStringMembers.length()>1?shp.geotype = GEOTYPES.MULTILINE:shp.geotype = GEOTYPES.LINE;
				result.push(shp);
			}
			return result;
		}
		
		private function parseMultiPolygon(polygons:XMLList):Array{
			var result:Array = new Array();
			for(var i:int = 0;i<polygons.length();i++){
				var polygon:XML = polygons[i];
				var coords:Array = new Array();
				var polygonMembers:XMLList = polygon..gml::polygonMember as XMLList;
				for(var j:int=0;j<polygonMembers.length();j++){
					var polygonMember:XML = polygonMembers[j];
					var txtCoordinates:String = ((polygonMember..gml::coordinates as XMLList)[0] as XML).text();
					var tmpCoords:Array = txtCoordinates.split(" ");
					var coord:Array = new Array();
					for(var k:int = 0;k<tmpCoords.length;k++){
						var txtCoordinate:String = tmpCoords[k];
						var txtCoord:Array = txtCoordinate.split(",");
						coord.push(txtCoord[0]);
						coord.push(txtCoord[1]);
						// test
						pts_num += 1;
					}
					coords.push(coord);
				}
				var shp:GeoShape = new GeoShape();
				shp.coords = coords;
				polygonMembers.length()>1?shp.geotype = GEOTYPES.MULTIPOLYGON:shp.geotype = GEOTYPES.POLYGON;
				result.push(shp);
			}
			return result;
		}
	}
}