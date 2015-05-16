package com.poyanghu.wfs.util
{
	import com.poyanghu.entity.*;
	public class FilterBuilder
	{
		public static function buildFromDistrictName(district:*,propertyName:String,useLike:Boolean):String
		{
//			var filter:String = "<ogc:Filter xmlns:ogc=\"http://ogc.org\" xmlns:gml=\"http://www.opengis.net/gml\">" + 
//					"<ogc:PropertyIsEqualTo><ogc:PropertyName>"+propertyName+"</ogc:PropertyName><ogc:Literal>"+district.Name+"</ogc:Literal></ogc:PropertyIsEqualTo></ogc:Filter>";
			var filter:String = null;
			if(!useLike)
			{
				 filter = "<Filter>" + 
					"<PropertyIsEqualTo><PropertyName>"+propertyName+"</PropertyName><Literal>"+district.Name+"</Literal></PropertyIsEqualTo></Filter>";
			}
			else
			{
				filter = "=<ogc:Filter><ogc:PropertyIsLike wildCard=\"*\""+
							" singleChar=\"?\""+
							" escape=\"\\\"><ogc:PropertyName>"+propertyName+"</ogc:PropertyName><ogc:Literal>" + "*"+district.Name+"*"+
							" </ogc:Literal></ogc:PropertyIsLike></ogc:Filter>";
			}
			return filter;
		}
		
		public static function buildFromDistrictCode(districts:Array,propertyName:String,useLike:Boolean):String
		{
			if(districts == null||districts.length == 0)
				return "";
			
			var filter:String = "<Filter>";
			if(districts.length > 1)
				filter+="<Or>";
				
			var count:int = districts.length;
			for(var i:int = 0;i<count;i++)
			{
				var codeValue:String = districts[i].@code;
				if(!useLike)
				{
					 filter +="<PropertyIsEqualTo><PropertyName>"+propertyName+"</PropertyName><Literal>"+codeValue+"</Literal></PropertyIsEqualTo>";
				}
				else
				{
					filter += "<ogc:PropertyIsLike wildCard=\"*\""+
								" singleChar=\"?\""+
								" escape=\"\\\"><ogc:PropertyName>"+propertyName+"</ogc:PropertyName><ogc:Literal>" + "*"+codeValue+"*"+
								" </ogc:Literal></ogc:PropertyIsLike>";
				}
			}
			if(districts.length > 1)
				filter+="</Or>";
			filter += "</Filter>";

			return filter;
		}
		
		public static function buildFromShape(shape:IShape,propertyName:String):String
		{
			if(shape == null)
				return "";
				
			var filter:String = "";
			if(shape is Polygon||shape is Point)
			{
				filter = "<ogc:Filter><ogc:Intersects><ogc:PropertyName>"+propertyName+"</ogc:PropertyName>";
			}
			else if(shape is Circle||shape is LineString)
			{
				filter = "<ogc:Filter><ogc:DWithin><ogc:PropertyName>"+propertyName+"</ogc:PropertyName>";
			}
			else if(shape is Envelope)
			{
				filter = "<ogc:Filter><ogc:BBOX><ogc:PropertyName>"+propertyName+"</ogc:PropertyName>";
			}
			filter+=shape.coordinatesGml();
			
			if(shape is Polygon||shape is Point)
			{
				filter+="</ogc:Intersects></ogc:Filter>";
			}
			else if(shape is Circle||shape is LineString)
			{
				filter+="</ogc:DWithin></ogc:Filter>";
			}
			else if(shape is Envelope)
			{
				filter+="</ogc:BBOX></ogc:Filter>";
			}
			return filter;
		}
	}
}