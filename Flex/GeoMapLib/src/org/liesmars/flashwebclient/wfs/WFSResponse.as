package com.poyanghu.wfs
{
	public class WFSResponse
	{
		private var responseXML:XML;
		private var responseObj:Object;//when use amf3 object
		private var outputFormat:String;
		
		public function WFSResponse(newResponseXML:XML,newResponseObj:Object,newOutputFormat:String)
		{
			this.responseXML = newResponseXML;
			this.responseObj = newResponseObj;
			this.outputFormat = newOutputFormat;
		}
		
		public function get ResponseXML():XML
		{
			return this.responseXML;
		}
		
		public function get ResponseObj():Object
		{
			return this.responseObj;
		}
		
		public function get OutputFormat():String
		{
			return this.outputFormat;
		}
	}
}