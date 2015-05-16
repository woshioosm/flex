package cn.edu.whu.liesmars.asPack.util
{
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;

	public class GetDataFromXml
	{
        /**
		 * 抽取uuid
		 * */
		public static function getUUID(xml:XML):String{ 
			
			return xml.child("UUID").toString();
		}
		
		
		/**
		 * 获取查询时间
		 * */
		public static function getQueryTime(xml:XML):String{
			if(xml==null)
				return "";
			var dateFormatter:DateFormatter = new DateFormatter(); 
			dateFormatter.formatString = "YYYY-MM-DD JJ:NN:SS"; 
			var now:String= dateFormatter.format(new Date()); 
			return now;
		} 
		
		
		/**
		 * 抽取领域
		 * */
		public static function getDomain(xml:XML):String{
			if(xml==null)
				return "";
			return xml.child("domain").toString();
		}
		
		/**
		 * 抽取task
		 * */
		public static function getTask(xml:XML):String{
			if(xml==null)
				return "";
			if(xml.child("taskName")!=null)
			   return xml.child("taskName").toString();
			else
				return "";
		}

		/**
		 * 抽取影像时间
		 * */
		public static function getImageTime(xml:XML):ArrayCollection{
			if(xml==null)
				return new ArrayCollection();
			var childrenXml:XMLList=xml.child("imageTime").child("times").child("time");
			var times:ArrayCollection=new ArrayCollection();
			for each(var timeXml:XML in childrenXml){
				var startTime:String=timeXml.child("start").toString();
				var endTime:String=timeXml.child("end").toString();
				if(startTime!="" || endTime!="")
				   times.addItem(startTime+"至"+endTime);
			}
			return times;
		}
		
		/**
		 * 抽取地理范围
		 **/
		public static function getImageRange(xml:XML):ArrayCollection{
			if(xml==null)
				return new ArrayCollection();
			var childrenXml:XMLList=xml.child("imageRange").child("coordinateList");
			var imageRanges:ArrayCollection=new ArrayCollection();
			for each(var imageRange:XML in childrenXml){
				imageRanges.addItem(imageRange.child("coordinate").toString());
			}
			return imageRanges;
		}
		
		/**
		 * 抽取空间分辨率
		 * */
		public static function getSpatialResolution(xml:XML):ArrayCollection{
			if(xml==null)
				return new ArrayCollection();
			var childrenXml:XMLList=xml.child("imageParameters").child("imageParameter");
			var spatialResolutions:ArrayCollection=new ArrayCollection();
			for each(var spatialResolution:XML in childrenXml){
				var spatialXml:XMLList=spatialResolution.child("spatialResolution");
				var unit:String=spatialXml.attribute("unit").toString();
				var value:XMLList=spatialXml.child("value");
				if(value.child("min").toString()!="" || value.child("max").toString()!="")
			       spatialResolutions.addItem("min:"+(value.child("min")==""?"/":value.child("min"))+" | max:"+(value.child("max")==""?"/":value.child("max"))+" "+unit);
				else
					spatialResolutions.addItem("/");
			}
			return spatialResolutions;
		}
		
		/**
		 * 抽取时间分辨率
		 * */
		public static function getTemporalResolution(xml:XML):ArrayCollection{
			if(xml==null)
				return new ArrayCollection();
			var childrenXml:XMLList=xml.child("imageParameters").child("imageParameter");
			var temporalResolutions:ArrayCollection=new ArrayCollection();
			for each(var temporalResolution:XML in childrenXml){
				var temporalResolutionXml:XMLList=temporalResolution.child("temporalResolution");
				var unit:String=temporalResolutionXml.attribute("unit").toString();
				var value:XMLList=temporalResolutionXml.child("value");
				if(value.child("min").toString()!="" || value.child("max").toString()!="")
				   temporalResolutions.addItem("min:"+(value.child("min")==""?"/":value.child("min"))+" | max:"+(value.child("max")==""?"/":value.child("max"))+" "+unit);
				else
					temporalResolutions.addItem("/");
			}
			return temporalResolutions;
		}
		
		/**
		 * 抽取光谱分辨率
		 **/
		public static function getSpectralResolution(xml:XML):ArrayCollection{
			if(xml==null)
				return new ArrayCollection();
			var childrenXml:XMLList=xml.child("imageParameters").child("imageParameter");
			var spectralResolutions:ArrayCollection=new ArrayCollection();
			for each(var spectralResolution:XML in childrenXml){
				var spectralResolutionXml:XMLList=spectralResolution.child("spectralResolution");
				var unit:String=spectralResolutionXml.attribute("unit").toString();
				var value:XMLList=spectralResolutionXml.child("value");
				if(value.child("min").toString()!="" || value.child("max").toString()!="")
				   spectralResolutions.addItem("min:"+(value.child("min")==""?"/":value.child("min"))+" | max:"+(value.child("max")==""?"/":value.child("max"))+" "+unit);
				else
					spectralResolutions.addItem("/");
			}
			return spectralResolutions;
		}
		
		/**
		 * 抽取幅宽
		 **/
		public static function getFabricWidth(xml:XML):ArrayCollection{
			if(xml==null)
				return new ArrayCollection();
			var childrenXml:XMLList=xml.child("imageParameters").child("imageParameter");
			var fabricWidths:ArrayCollection=new ArrayCollection();
			for each(var fabricWidth:XML in childrenXml){
				var fabricWidthXml:XMLList=fabricWidth.child("fabricWidth");
				var unit:String=fabricWidthXml.attribute("unit").toString();
				var value:XMLList=fabricWidthXml.child("value");
				if(value.child("min").toString()!="" || value.child("max").toString()!="")
				   fabricWidths.addItem("min:"+(value.child("min")==""?"/":value.child("min"))+" | max:"+(value.child("max")==""?"/":value.child("max"))+" "+unit);
				else
					fabricWidths.addItem("/");
			}
			return fabricWidths;
		}
		
	    public static function getSensorType(xml:XML):String{
			if(xml==null)
				return "";
			var childrenXml:XMLList=xml.child("imageParameters").child("imageParameter");
			var sensorType:String="";
			if(childrenXml!=null&&childrenXml.length()>0){
				var sensor:XML=childrenXml[0];
				if(sensor.child("sensor")!=null)
				   sensorType=sensor.child("sensor").child("sensorType");
			}
			
			return sensorType;

		}
		public static function getSensorName(xml:XML):String{
			if(xml==null)
				return "";
			var childrenXml:XMLList=xml.child("imageParameters").child("imageParameter");
			var sensorName:String="";
			if(childrenXml!=null&&childrenXml.length()>0){
				var sensor:XML=childrenXml[0];
				if(sensor.child("sensor")!=null)
				   sensorName=sensor.child("sensor").child("sensorName");
			}
			
			return sensorName;
			
		}
		
		
		// 把xsi等信息去掉 否则 /法使用flex 中 xml解析的 直接获取指定标签的 功能  /奈！！
		public static function formatXmlString(xmlStr:String):XML{  
			if(xmlStr==null)
				return null;
			var startCut:int=xmlStr.indexOf("框架")+3;
			if(startCut==2)
				return null;
			var endCut:int=xmlStr.indexOf(">",startCut);
			var str1:String=xmlStr.substring(0,startCut);
			var str2:String=xmlStr.substring(endCut,xmlStr.length);
			trace(str2.length);
			var Str:String=(XML(str1+str2)).toString();
			return new XML(str1+str2);
		}
		
	}
}