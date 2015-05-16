package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	import cn.edu.whu.liesmars.asPack.userBaseModel.QueryResultObj;
	
	import valueObjects.TDeepframework;

	public class RequirementInputObj extends QueryResultObj
	{
		protected var _checked:Boolean=false; 
		protected var _task:String;
//		protected var _framework:TDeepframework=new TDeepframework();
		protected var _natureLang:String;
		
		
		public function RequirementInputObj(){
			
		}
//		public function RequirementInputObj(checked:Boolean=false,sequence:int=-1, queryTime:String=null,field:String=null,task:String=null,imageDate:String=null,imageArea:String=null,spacialResolution:String=null,timeResolution:String=null,spectrumResolution:String=null,id:int=-1)
//		{
//			this.checked=checked;
//			this.task=task;
//			super(sequence,queryTime,field,imageDate,imageArea,spacialResolution,timeResolution,spectrumResolution,id);
//		}

		public function get natureLang():String
		{
			return _natureLang;
		}

		public function set natureLang(value:String):void
		{
			_natureLang = value;
		}

//		public function get framework():TDeepframework
//		{
//			return _framework;
//		}
//
//		public function set framework(value:TDeepframework):void
//		{
//			_framework = value;
//		}

		public function get task():String
		{
			return _task;
		}

		public function set task(value:String):void
		{
			_task = value;
		}

		public function get checked():Boolean
		{
			return _checked;
		}

		public function set checked(value:Boolean):void
		{
			_checked = value;
		}

	}
}