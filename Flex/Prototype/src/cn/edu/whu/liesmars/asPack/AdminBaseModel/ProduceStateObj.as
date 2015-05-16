package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	import cn.edu.whu.liesmars.asPack.userBaseModel.BaseObj;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;

	public class ProduceStateObj extends BaseObj
	{
		protected var _productId:String;
		protected var _imageArea:ArrayCollection=new ArrayCollection();
		protected var _produceState:String;
		public function ProduceStateObj(){
			
		}
//		public function ProduceStateObj(id:int=-1,sequence:int=-1,productId:String=null,produceState:String=null,imageDate:String=null,imageArea:String=null,spacialResolution:String=null,timeResolution:String=null,spectrumResolution:String=null)
//		{
//			this.productId=productId;
//			this.imageArea=imageArea;
//			this.produceState=produceState;
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

		public function get produceState():String
		{
			return _produceState;
		}

		public function set produceState(value:String):void
		{
			_produceState = value;
		}

		
		public function get productId():String
		{
			return _productId;
		}

		public function set productId(value:String):void
		{
			_productId = value;
		}

	}
}