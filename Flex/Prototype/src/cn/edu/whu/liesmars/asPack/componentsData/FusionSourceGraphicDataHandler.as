package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.FusionSourceDataObj;
	
	import valueObjects.DeepFrameWithLang;
	import valueObjects.FusionResultMap;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;

	public class FusionSourceGraphicDataHandler extends DataHandler
	{
		import cn.edu.whu.liesmars.asPack.AdminBaseModel.FusionResultObj;
		
		import mx.collections.ArrayCollection;
		
		import valueObjects.TDeepframework;
		import valueObjects.TFusionresult;
		
		public function FusionSourceGraphicDataHandler(result:ArrayCollection)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			addData(bindingData);
		}
		public  function addData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			for each(var tfusionResult:DeepFrameWithLang in this.dataFromServer){ 
				var xml:XML=GetDataFromXml.formatXmlString(tfusionResult.frame);
				var fusionSource:FusionSourceDataObj=new FusionSourceDataObj();
				
				fusionSource.naturalLang=tfusionResult.naturalLang;
				fusionSource.sensorName=GetDataFromXml.getSensorName(xml);
				fusionSource.sensorType=GetDataFromXml.getSensorType(xml);
				fusionSource.task=GetDataFromXml.getTask(xml);
				fusionSource.imageDate=GetDataFromXml.getImageTime(xml);
				fusionSource.imageArea=GetDataFromXml.getImageRange(xml);
				
				bindingData.addItem(fusionSource);
			}
		}
	}
}