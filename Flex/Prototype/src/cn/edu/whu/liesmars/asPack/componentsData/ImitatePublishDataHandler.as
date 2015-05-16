package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.ProductPublishObj;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.RecommendResultToAdmin;
	import valueObjects.TSimulateproduct;

	
	public class ImitatePublishDataHandler extends DataHandler
	{
		public function ImitatePublishDataHandler(result:Object)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			for each(var data:RecommendResultToAdmin in this.dataFromServer as ArrayCollection){
				var productPublish:ProductPublishObj=new ProductPublishObj();
				productPublish.productID=data.productUUID;
				productPublish.department=data.department;
				productPublish.userName=data.username;
				productPublish.accept=data.accept==0?"否":"是";
				productPublish.similarityValues=data.similarityValues;
				bindingData.addItem(productPublish);
			}
		}
	}
}