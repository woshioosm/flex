package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.ProductPublishObj;
	import cn.edu.whu.liesmars.asPack.util.Config;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.ImageQueryResultToAdm;

	public class ImageQueryResultToAdmDataHandler extends DataHandler
	{
		public function ImageQueryResultToAdmDataHandler(result:Object)
		{
			super(result);
		}
	
		public override function bindData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			for each(var data:ImageQueryResultToAdm in this.dataFromServer as ArrayCollection){
				var productPublish:ProductPublishObj=new ProductPublishObj();
//				productPublish.productID=data.productUUID;
			    
//				productPublish.userName=data.username;
				productPublish.arr=data.detailCompareInfo;
				productPublish.imageUrl=Config.imagePath+data.imagePath;
				productPublish.sensorName=data.sensorName;
				try{
					if(data.detailCompareInfo!=null&&data.detailCompareInfo.length==2){
						var  item:Array=data.detailCompareInfo.getItemAt(0) as Array;
						productPublish.bandInfo=item[5]==null?"":item[5].toString();
//						var bandReStr:String="";
//						var bandReStrArr:Array=productPublish.bandInfo.split(",");
//						for(var i:int=0;i<bandReStrArr.length;i++){
//							if(i==3){
//								bandReStr+=bandReStrArr[i]+"/n";
//							}
//							else if(i!=bandReStr.length-1){
//								bandReStr+=bandReStrArr[i]+",";
//							}else{
//								bandReStr+=bandReStrArr[i];
//							}
//						}
					}
				}catch(err:Error){
			 		
			    }
			    
				
				productPublish.time=data.imageTime;
				productPublish.spatialResolution=data.imageSpatialResol;
				productPublish.sensor=data.imageSensorType;
				productPublish.similarityValues=data.similarityValues;
				bindingData.addItem(productPublish);
			}
		}
	}
}