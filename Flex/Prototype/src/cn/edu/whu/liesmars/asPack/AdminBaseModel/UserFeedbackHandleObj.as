package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	import cn.edu.whu.liesmars.asPack.userBaseModel.BaseObj;
	
	import mx.collections.ArrayCollection;

	public class UserFeedbackHandleObj extends BaseObj
	{
		protected var _feedbackUser:String;
		protected var _field:String;
		protected var _task:String;
		protected var _imageArea:ArrayCollection=new ArrayCollection();
		
		public function UserFeedbackHandleObj(){
			
		}
//		public function QueryFeedbackHandleObj(id:int=-1,sequence:int=-1,feedbackUser:String=null,field:String=null,
//											   task:String=null,imageDate:String=null,imageArea:String=null,
//											   spacialResolution:String=null,
//											   timeResolution:String=null,spectrumResolution:String=null)
//		{
//			this.feedbackUser=feedbackUser;
//			this.field=field;
//			this.task=task;
//			this.imageArea=imageArea;
//			super(id,sequence,imageDate,spacialResolution,timeResolution,spectrumResolution);
//		}

		

		public function get imageArea():ArrayCollection
		{
			return _imageArea;
		}

		public function set imageArea(value:ArrayCollection):void
		{
			_imageArea = value;
		}

		public function get task():String
		{
			return _task;
		}

		public function set task(value:String):void
		{
			_task = value;
		}

		public function get field():String
		{
			return _field;
		}

		public function set field(value:String):void
		{
			_field = value;
		}

		public function get feedbackUser():String
		{
			return _feedbackUser;
		}

		public function set feedbackUser(value:String):void
		{
			_feedbackUser = value;
		}

	}
}