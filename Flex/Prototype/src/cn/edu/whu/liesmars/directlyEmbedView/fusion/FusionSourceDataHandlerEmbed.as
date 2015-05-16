package cn.edu.whu.liesmars.directlyEmbedView.fusion
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.FusionResultObj;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.TDeepframework;
	import valueObjects.TFusionresult;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;

	public class FusionSourceDataHandlerEmbed extends DataHandler
	{
		public function FusionSourceDataHandlerEmbed(result:ArrayCollection)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			for each(var tfusionResult:TDeepframework in this.dataFromServer){ 
//				var count:int=tfusionResult.fusiontXml.length;
//				trace(count);
				    
				var xml:XML=GetDataFromXml.formatXmlString(tfusionResult.deepFrameXml);
				var fusionResult:FusionResultObj=new FusionResultObj();
				fusionResult.uuid=GetDataFromXml.getUUID(xml);
				fusionResult.imageArea=GetDataFromXml.getImageRange(xml);
				fusionResult.imageDate=GetDataFromXml.getImageTime(xml);
				fusionResult.imageWidth=GetDataFromXml.getFabricWidth(xml);
				fusionResult.spacialResolution=GetDataFromXml.getSpatialResolution(xml);
				fusionResult.timeResolution=GetDataFromXml.getTemporalResolution(xml);
				fusionResult.spectrumResolution=GetDataFromXml.getSpectralResolution(xml);
				bindingData.addItem(fusionResult);
			}
		}
	}
}