package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.userBaseModel.QueryResultObj;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ProgressBar;
	
	import valueObjects.NLSearchResult;
	import valueObjects.TDeepframework;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;

	/**
	 * 用于绑定查询结果窗口 QueryResultWin
	 * */
	public class QueryResultWinDataHandler extends DataHandler
	{
		private var _prograss:ProgressBar;
		private var index:int=0;
		private var count:int;
		private  var timer:Timer;
		public function QueryResultWinDataHandler(result:ArrayCollection)
		{
			super(result);
		}

		public function get prograss():ProgressBar
		{
			return _prograss;
		}

		public function set prograss(value:ProgressBar):void
		{
			_prograss = value;
		}

		public override function bindData(bindingData:ArrayCollection):void{  //传入需要绑定的 list
			bindingData.removeAll();
			addData(bindingData);
		}
	    public function addData(bindingData:ArrayCollection):void{
//			if(bindingData.length>0){
//				bindingData.removeItemAt(bindingData.length-1);
//			}
			for each(var theData:NLSearchResult in this.dataFromServer){  // 遍历查询结果
				
				
				var queryResult:QueryResultObj=new QueryResultObj();  

				
				queryResult.inputStr=theData.nlString;
				queryResult.uuid=theData.searchUUID;
				queryResult.queryTime=theData.searchTime;
				if(theData.deepFramework!=null&&theData.deepFramework!=""){
					var xml:XML=GetDataFromXml.formatXmlString(theData.deepFramework);	
					queryResult.deepFrame=theData.deepFramework;
					queryResult.shallowFrame=theData.shallowFramework;
					queryResult.imageDate=GetDataFromXml.getImageTime(xml);
					queryResult.imageArea=GetDataFromXml.getImageRange(xml);
					queryResult.field=GetDataFromXml.getDomain(xml);
				}
				
				
//				queryResult.field=GetDataFromXml.getDomain(xml);
//				queryResult.imageArea=GetDataFromXml.getImageRange(xml);
//				queryResult.imageDate=GetDataFromXml.getImageTime(xml);
//				queryResult.spacialResolution=GetDataFromXml.getSpatialResolution(xml);
//				queryResult.spectrumResolution=GetDataFromXml.getSpectralResolution(xml);
//				queryResult.timeResolution=GetDataFromXml.getTemporalResolution(xml);
				
				bindingData.addItem(queryResult);
				
			}
//		    if( this.dataFromServer!=null && (this.dataFromServer as ArrayCollection).length>0){
//				var  queryObj:QueryResultObj=new QueryResultObj();
//				queryObj.uuid="moreInfo";
//				bindingData.addItem(queryObj);
//			}
	
			
		}
		
	
	}
}