package cn.edu.whu.liesmars.asPack.componentsData
{

	import cn.edu.whu.liesmars.asPack.userBaseModel.QueryResultObj;
	import cn.edu.whu.liesmars.asPack.userBaseModel.SuggestionObj;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.TSimulateproduct;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;

	public class UserSuggestionDataHandler extends DataHandler
	{
		public function UserSuggestionDataHandler(result:Object)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{  //传入需要绑定的 list
			bindingData.removeAll();
			for each(var simulateproduct:TSimulateproduct in this.dataFromServer){  // 遍历查询结果
				var xml:XML=GetDataFromXml.formatXmlString(simulateproduct.simulateXml);
				var suggestion:SuggestionObj=new SuggestionObj();  
				suggestion.deepFrame=simulateproduct.simulateXml;
				suggestion.checked=false;
				suggestion.uuid=simulateproduct.simulateUuid;                 // 设置uuid
				suggestion.imageArea=GetDataFromXml.getImageRange(xml);
				suggestion.imageDate=GetDataFromXml.getImageTime(xml);
				suggestion.spacialResolution=GetDataFromXml.getSpatialResolution(xml);
				suggestion.spectrumResolution=GetDataFromXml.getSpectralResolution(xml);
				suggestion.timeResolution=GetDataFromXml.getTemporalResolution(xml);
			
				
				bindingData.addItem(suggestion);
			}
		}
	}
}