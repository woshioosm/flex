package com.poyanghu.wfs
{
	import com.poyanghu.entity.*;
	import com.poyanghu.wfs.events.WFSEvent;
	import com.poyanghu.wfs.util.*;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.utils.Base64Encoder;
	
	public class WFSQuerior extends EventDispatcher
	{
		public static var EPSG:String = "900913";
		
		public var method:String = URLRequestMethod.GET;
		public var url:String = "http://localhost:8080/geoserver/wfs";
		public var typename:String = "jxcnty2000";
		public var tag:Object = null;
		public var outputFormat:String = OutputFormat.GML2;
		
		public var maxFeatures:int = 0;
		
		/**
		 * queryMode和properties字段联合确定查询返回哪些属性的信息，querymode为QueryMode.GEOGRAPHY_ONLY时
		 * 只取得'the_geom'字段信息，即地理信息,properties字段不起作用,当其为QueryMode.MIXED时，代表取得限定的一个或多个属性，由properties给定
		 * 当其为QueryMode.MIXED_WITH_GEOGRAPHY时，代表取得限定的一个或多个属性，由properties给定以及地理信息
		 * 当queryMode为QueryMode.ALL时,返回所有属性信息,properties字段不起作用,暂只支持post模式,get模式只默认为QueryMode.ALL
		 */
		public var queryMode:int = WFSQueryMode.GEOGRAPHY_ONLY;
		public var properties:ArrayCollection = null;//对应取得哪些字段
		public var callback:Function = null;
		
		private var stream:URLStream = null;
		private var urlRequest:URLRequest ;
		private var wfsResponse:WFSResponse = null;
		
		public function WFSQuerior(newTypeName:String,newCallBack:Function,newEpsg:String="900913",newQueryMode:int=1,newProperties:ArrayCollection=null,tag:Object = null,
									newOutputFormat:String = "GML2")
		{	
			this.tag = tag;
			this.typename = newTypeName;
			EPSG = newEpsg;
			queryMode = newQueryMode;
			callback = newCallBack;
			properties = newProperties;
			outputFormat = newOutputFormat;
			
			stream = new URLStream();
			urlRequest = new URLRequest();
			stream.addEventListener(Event.COMPLETE, loadComplete);
			stream.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			if(this.callback!=null)
			{
				//stream.addEventListener(Event.COMPLETE,callback);
				this.addEventListener(WFSEvent.WFS_LOADED,callback);
			}
		}
		
		public function queryByDistrict(district:*,propertyName:String,uselike:Boolean):void
		{
			try
			{
				var filter:String = FilterBuilder.buildFromDistrictName(district,propertyName,uselike);
				
				this.query(filter,propertyName);
			}
			catch(e:Error)
			{
				trace("<Error> " + e.message);
			}
		}
		
		public function queryByDistricts(districts:Array,propertyName:String,uselike:Boolean):void
		{
			try
			{
				var filter:String = FilterBuilder.buildFromDistrictCode(districts,propertyName,uselike);
				
				//该方法中propertyName是指图形元素，在geoserver中固定为"the_geom“
				this.query(filter,"the_geom");
			}
			catch(e:Error)
			{
				trace("<Error> " + e.message);
			}
		}
		
		public function queryByShape(shape:IShape,propertyName:String):void
		{
			try
			{
				var filter:String = FilterBuilder.buildFromShape(shape,propertyName);
				
				this.query(filter,propertyName);
			}
			catch(e:Error)
			{
				trace("<Error> " + e.message);
			}
		}
		
		
		private function initializeQuery():void
		{
			if(this.stream == null)
			{
				stream = new URLStream();
				stream.addEventListener(Event.COMPLETE, loadComplete);
				stream.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				if(this.callback!=null)
				{
					//stream.addEventListener(Event.COMPLETE,callback);
					this.addEventListener(WFSEvent.WFS_LOADED,callback);
				}
			}
			if(this.urlRequest == null)
			{
				urlRequest = new URLRequest();
			}
			
			if(stream.connected){
				stream.close();
			}
			wfsResponse = null;
			urlRequest.method = this.method;
			urlRequest.data = null;
		}
		
		public function query(filter:String,propertyName:String = "the_geom"):void
		{
			//把服务端的用户名密码放到用户端终究不安全
//			//对url加密,参加 http://stackoverflow.com/questions/509219/flex-3-how-to-support-http-authentication-urlrequest
//			var up:String = "wfs:wfs";
//			var b64Encoder:Base64Encoder = new Base64Encoder();
//			b64Encoder.encode(up);
//			var authHeader:String =  "Basic " + b64Encoder.toString();
//			var securityHeader:URLRequestHeader = new URLRequestHeader("Authorization",authHeader);
//			urlRequest.requestHeaders.push(securityHeader);
			
			CursorManager.setBusyCursor();
			
			this.initializeQuery();
			if(this.method == URLRequestMethod.GET)
			{
				var urlStr:String = this.url;
				urlStr+="?request=getfeature&service=wfs&version=1.0.0&typename="+this.typename+"&filter=";
				urlStr+=filter;
				
				urlRequest.url = encodeURI(urlStr);
				
			}
			else if(this.method == URLRequestMethod.POST)
			{
				urlRequest.url = this.url;
				var postStr:String = "<wfs:GetFeature service=\"WFS\" version=\"1.0.0\""+
							  " outputFormat=\""+outputFormat+"\"";
				if(this.maxFeatures >0)
				{
					postStr += " maxFeatures=\""+this.maxFeatures+"\"";
				}
				postStr +=	  " xmlns:wfs=\"http://www.opengis.net/wfs\""+
							  " xmlns:ogc=\"http://www.opengis.net/ogc\""+
							  " xmlns:gml=\"http://www.opengis.net/gml\""+
							  " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""+
							  " xsi:schemaLocation=\"http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.0.0/WFS-basic.xsd\">"+
							  " <wfs:Query typeName=\""+this.typename+"\">";
							  
				if(this.queryMode == WFSQueryMode.GEOGRAPHY_ONLY)
				{
					postStr+="<wfs:PropertyName>"+propertyName+"</wfs:PropertyName>";			  
				}
				else if(this.queryMode == WFSQueryMode.MIXED)
				{
					postStr+=PropertyNameBuilder.buildFromArrayCollection(this.properties);
				}
				else if(this.queryMode == WFSQueryMode.MIXED_WITH_GEOGRAPHY)
				{
					postStr+=PropertyNameBuilder.buildFromArrayCollection(this.properties);
					postStr+="<wfs:PropertyName>"+propertyName+"</wfs:PropertyName>";
				}
				
				postStr+=filter;
				postStr+= "</wfs:Query></wfs:GetFeature>";
				
				var postXML:XML = new XML(postStr);
				urlRequest.contentType="application/xml";
				urlRequest.data = postXML;
			}
			
			try {
				trace("start: "+(new Date()).toTimeString());
			    stream.load(urlRequest);
			} catch (error:Error) {
			    trace("WFSQuerior_query_Unable to load requested URL.");
			}
			
		}
		
	    private function loadComplete(e:Event):void
	    {
			CursorManager.removeBusyCursor();
			
	    	try
	    	{
	    		trace("end: "+(new Date()).toTimeString());
	    		
			    if(this.outputFormat == "GML2"){
		     		var ba:ByteArray = new ByteArray();
				    if (stream.bytesAvailable > 0) {
				        stream.readBytes(ba);
				    }
				    var wfsResStr:String = ba.toString();
				    this.wfsResponse =  new WFSResponse(new XML(wfsResStr),null,this.outputFormat);
			    }else{
					try{
				    	var obj:Object = stream.readObject();
				    	this.wfsResponse =  new WFSResponse(null,obj,this.outputFormat);
					}
					catch(e:Error)
					{
						var ba:ByteArray = new ByteArray();
						if (stream.bytesAvailable > 0) {
							stream.readBytes(ba);
						}
						var wfsResStr:String = ba.toString();
						trace(wfsResStr);
					}
					
			    }
			    stream.close();
			    var we:WFSEvent = new WFSEvent(this,WFSEvent.WFS_LOADED);
			    this.dispatchEvent(we);
		    }
			catch(e:Error)
			{
				trace("WFSQuerior_loadComplete_Error " + e.message);
			}
			finally
			{
				if(stream.connected){
					stream.close();
				}
				this.dispose();
			}
	    }
	    private function ioErrorHandler(e:Event):void
	    {
			CursorManager.removeBusyCursor();
			
	    	trace("WFSQuerior_ioErrorHandler_Error " + e.toString());
	    	if(stream.connected)
	    	{
				stream.close();
			}
			this.dispose();
			var we:WFSEvent = new WFSEvent(this,WFSEvent.WFS_IO_ERROR);
		    this.dispatchEvent(we);
	    }
		
		private function dispose():void
		{
			if(this.callback!=null)
			{
				stream.removeEventListener(Event.COMPLETE,callback);
			}
			stream.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			//释放资源
			stream = null;
			urlRequest = null;
		}
		
		public function get WfsResponse():WFSResponse
		{
			return this.wfsResponse;
		}
	}
}