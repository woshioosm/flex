package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.RequirementInputObj;
	import cn.edu.whu.liesmars.asPack.userBaseModel.QueryResultObj;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import valueObjects.TDeepFrameWithLang;
	import valueObjects.TDeepframework;

	/** 
	 * 用于绑定查询结果窗口 QueryResultWin
	 * */
	public class FusionInputWinDataHandler extends DataHandler
	{
		
		public function FusionInputWinDataHandler(result:ArrayCollection)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{  //传入需要绑定的 list
			bindingData.removeAll();
			for each(var deepFramwork:TDeepFrameWithLang in this.dataFromServer){  // 遍历查询结果
				var requirementInput:RequirementInputObj=new RequirementInputObj(); 
			
				requirementInput.checked=false;
				requirementInput.natureLang=deepFramwork.naturaLang;
				requirementInput.uuid=deepFramwork.uuid;
//				if(deepFramwork.tdeepFrameWork!=null&&deepFramwork.tdeepFrameWork.deepFrameXml!=null&&deepFramwork.tdeepFrameWork.deepFrameXml!=""){
//					var xml:XML=GetDataFromXml.formatXmlString(deepFramwork.tdeepFrameWork.deepFrameXml);
////					requirementInput.field=GetDataFromXml.getDomain(xml);
////					requirementInput.task=GetDataFromXml.getTask(xml);
//					requirementInput.imageArea=GetDataFromXml.getImageRange(xml);
////					requirementInput.imageDate=GetDataFromXml.getImageTime(xml);
////					requirementInput.spacialResolution=GetDataFromXml.getSpatialResolution(xml);
////					requirementInput.spectrumResolution=GetDataFromXml.getSpectralResolution(xml);
////					requirementInput.timeResolution=GetDataFromXml.getTemporalResolution(xml);
//				}
				bindingData.addItem(requirementInput);
			}
		
		}
		public function getDeepframeworkListFromUUID(idList:ArrayCollection):void{
			var list:ArrayCollection=new ArrayCollection();
			for each(var deepFramwork:TDeepframework in this.dataFromServer){
				for each(var id:String in idList){
					if(deepFramwork.searchUuid==id)
						list.addItem(deepFramwork);
				}
			}
		}
	
	}
}