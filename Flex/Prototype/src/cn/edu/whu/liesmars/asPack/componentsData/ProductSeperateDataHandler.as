package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.ProductSeperateObj;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.TFusionresult;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;

	public class ProductSeperateDataHandler extends DataHandler
	{
		public function ProductSeperateDataHandler(result:Object)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			for each(var tFusionresult:TFusionresult in this.dataFromServer as ArrayCollection){
				
				
				var xml:XML=GetDataFromXml.formatXmlString(tFusionresult.fusionXml);
				
				var produceState:ProductSeperateObj=new ProductSeperateObj();
				produceState.uuid=tFusionresult.fusionUuid;
				produceState.productId=tFusionresult.projUuid;
				produceState.field=GetDataFromXml.getDomain(xml);
				produceState.task=GetDataFromXml.getTask(xml);
				produceState.imageArea=GetDataFromXml.getImageRange(xml);
				produceState.imageDate=GetDataFromXml.getImageTime(xml);
				produceState.spacialResolution=GetDataFromXml.getSpatialResolution(xml);
				produceState.timeResolution=GetDataFromXml.getTemporalResolution(xml);
				produceState.spectrumResolution=GetDataFromXml.getSpectralResolution(xml);
				bindingData.addItem(produceState);
			}
		}
	}
}