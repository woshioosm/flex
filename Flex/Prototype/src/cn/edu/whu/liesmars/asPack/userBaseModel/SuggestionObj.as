package cn.edu.whu.liesmars.asPack.userBaseModel
{
	import mx.collections.ArrayCollection;

	public class SuggestionObj extends BaseObj
	{
		protected var _checked:Boolean;
		protected var _imageArea:ArrayCollection=new ArrayCollection();
		protected var _deepFrame:String;
		public function SuggestionObj(){
			
		}
//		public function SuggestionObj(id:int=-1,sequence:int=-1,checked:Boolean=false,imageDate:String=null,imageArea:String=null,spacialResolution:String=null,timeResolution:String=null,spectrumResolution:String=null)
//		{
//			this.checked=checked;
//			this.imageArea=imageArea;
//			
//			super(id,sequence,imageDate,spacialResolution,timeResolution,spectrumResolution);
//		}

		public function get deepFrame():String
		{
			return _deepFrame;
		}

		public function set deepFrame(value:String):void
		{
			_deepFrame = value;
		}

		public function get imageArea():ArrayCollection
		{
			return _imageArea;
		}

		public function set imageArea(value:ArrayCollection):void
		{
			_imageArea = value;
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