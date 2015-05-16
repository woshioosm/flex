package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.UserFeedbackHandleObj;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.NLSearchFeedback;
	import valueObjects.TNlqueryfeedbackdeep;
	import cn.edu.whu.liesmars.asPack.util.GetDataFromXml;

	public class UserFeedBackDataHandler extends DataHandler
	{
		public function UserFeedBackDataHandler(result:ArrayCollection)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			for each(var theData:NLSearchFeedback in this.dataFromServer as ArrayCollection){  // 遍历查询结果
				var xml:XML=GetDataFromXml.formatXmlString(theData.feedbackDeepFrame.deepFrameXml);
				
				var feedbackHandleData:UserFeedbackHandleObj=new UserFeedbackHandleObj();  
				feedbackHandleData.uuid=theData.feedbackDeepFrame.searchUuid;   // 设置uuid
				feedbackHandleData.feedbackUser=theData.username;
				feedbackHandleData.task=GetDataFromXml.getTask(xml);
				feedbackHandleData.field=GetDataFromXml.getDomain(xml);
				feedbackHandleData.imageArea=GetDataFromXml.getImageRange(xml);
				feedbackHandleData.imageDate=GetDataFromXml.getImageTime(xml);
				feedbackHandleData.spacialResolution=GetDataFromXml.getSpatialResolution(xml);
				feedbackHandleData.spectrumResolution=GetDataFromXml.getSpectralResolution(xml);
				feedbackHandleData.timeResolution=GetDataFromXml.getTemporalResolution(xml);
			
				
				bindingData.addItem(feedbackHandleData);
			}
		} 
	}
}