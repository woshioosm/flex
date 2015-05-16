package cn.edu.whu.liesmars.directlyEmbedView.fusion
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.FusionSourceDataObj;
	import cn.edu.whu.liesmars.asPack.componentsData.DataHandler;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;
	
	import valueObjects.DeepFrameWithLang;
	import valueObjects.FusionMapResultFlex;
	import valueObjects.FusionResultMap;
	import valueObjects.FusionSrcFlex;

	public class FusionSourceGraphicDataHandlerEmbed extends DataHandler
	{
		import cn.edu.whu.liesmars.asPack.AdminBaseModel.FusionResultObj;
		
		import mx.collections.ArrayCollection;
		
		import valueObjects.TDeepframework;
		import valueObjects.TFusionresult;
		
		public function FusionSourceGraphicDataHandlerEmbed(result:ArrayCollection)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			addData(bindingData);
		}
		public  function addData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			for each(var tfusionResult:FusionSrcFlex in this.dataFromServer){ 
				//var xml:XML=GetDataFromXml.formatXmlString(tfusionResult.frame);
				var fusionSource:FusionSourceDataObjEmbed=new FusionSourceDataObjEmbed();
				
				fusionSource.naturalLang=tfusionResult._nl;
				fusionSource.sensorName=tfusionResult._sensor;
				
				//fusionSource.sensorType=GetDataFromXml.getSensorType(xml);
				
				fusionSource.task=tfusionResult._task;
				
				if(tfusionResult._stime != null)
				{
					var dateAC:ArrayCollection = new ArrayCollection();
					dateAC.addItem(tfusionResult._stime + "至" + tfusionResult._etime);
					fusionSource.imageDate=dateAC;
				}
				
				fusionSource.srcUUID = tfusionResult._srcUUID;
				fusionSource.imageArea=tfusionResult._coordLst;
				fusionSource.uuid=tfusionResult._fusionUUID;
				bindingData.addItem(fusionSource);
			}
		}
	}
}