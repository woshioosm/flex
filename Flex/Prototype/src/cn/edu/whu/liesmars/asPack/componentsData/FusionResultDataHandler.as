package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.FusionResultObj;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.TFusionresult;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;
	
	public class FusionResultDataHandler extends DataHandler
	{
		public function FusionResultDataHandler(result:ArrayCollection)
		{
			super(result);
		}
//		public override function bindData(bindingData:ArrayCollection):void{
//			bindingData.removeAll();
//			addData(bindingData);
//		}
//		public function addData(bindingData:ArrayCollection):void{
//			if(bindingData.length>0){
//				bindingData.removeItemAt(bindingData.length-1);
//			}
//			for each(var tfusionResult:TFusionresult in this.dataFromServer){  // 遍历查询结果
//				
//				var xml:XML=GetDataFromXml.formatXmlString(tfusionResult.fusionXml);
//				var fusionResult:FusionResultObj=new FusionResultObj();
//				fusionResult.uuid=tfusionResult.fusionUuid;
//				fusionResult.imageArea=GetDataFromXml.getImageRange(xml);
//				fusionResult.imageDate=GetDataFromXml.getImageTime(xml);
//				fusionResult.imageWidth=GetDataFromXml.getFabricWidth(xml);
//				fusionResult.spacialResolution=GetDataFromXml.getSpatialResolution(xml);
//				fusionResult.timeResolution=GetDataFromXml.getTemporalResolution(xml);
//				fusionResult.spectrumResolution=GetDataFromXml.getSpectralResolution(xml);
//				fusionResult.sensorName=GetDataFromXml.getSensorName(xml);
//				fusionResult.sensorType=GetDataFromXml.getSensorType(xml);
//				fusionResult.task=GetDataFromXml.getTask(xml);
//				
//				bindingData.addItem(fusionResult);
//				
//			}
//			if( this.dataFromServer!=null && (this.dataFromServer as ArrayCollection).length>0){
//				var  fusionResultobj:FusionResultObj=new FusionResultObj();
//				fusionResultobj.uuid="moreFusionReslut";
//				bindingData.addItem(fusionResultobj);
//			}
//			
//			
//		}
		public function bindSingleData(tfusionResult:TFusionresult):FusionResultObj{
			var xml:XML=GetDataFromXml.formatXmlString(tfusionResult.fusionXml);
			var fusionResult:FusionResultObj=new FusionResultObj();
			fusionResult.uuid=tfusionResult.fusionUuid;
			fusionResult.imageArea=GetDataFromXml.getImageRange(xml);
			fusionResult.imageDate=GetDataFromXml.getImageTime(xml);
			fusionResult.imageWidth=GetDataFromXml.getFabricWidth(xml);
			fusionResult.spacialResolution=GetDataFromXml.getSpatialResolution(xml);
			fusionResult.timeResolution=GetDataFromXml.getTemporalResolution(xml);
			fusionResult.spectrumResolution=GetDataFromXml.getSpectralResolution(xml);
			fusionResult.sensorName=GetDataFromXml.getSensorName(xml);
			fusionResult.sensorType=GetDataFromXml.getSensorType(xml);
			fusionResult.task=GetDataFromXml.getTask(xml);
			
			return fusionResult;
		}
	}
}