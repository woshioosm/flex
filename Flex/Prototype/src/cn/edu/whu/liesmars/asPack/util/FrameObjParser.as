package cn.edu.whu.liesmars.asPack.util
{
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import valueObjects.AdvancedDoubleMinMaxDescribe;
	import valueObjects.AdvancedFrame;
	import valueObjects.AdvancedImageParameter;
	import valueObjects.AdvancedTime;

	public class FrameObjParser
	{
		private var advancedFrame:AdvancedFrame=null;
		private  static var emptyStr:String="无";
		public function FrameObjParser(advancedFrame:AdvancedFrame)
		{
			this.advancedFrame=advancedFrame;
		}
	    public  function ImageParametersExist(advancedFrame:AdvancedFrame):Boolean{
			if(advancedFrame!=null&&advancedFrame.imageParameters!=null&&advancedFrame.imageParameters.length>0)
				return true;
			else
				return false;
		}
		public static function arrayCollectionToString(arr:ArrayCollection):String{
			var arrStr:String="";
			if(arr!=null&&arr.length>0){
				for(var i:int=0;i<arr.length;i++){
					if(i!=arr.length-1)
						arrStr+=arr.getItemAt(i).toString()+"; ";
					else
						arrStr+=arr.getItemAt(i).toString();
				}
			}
			return arrStr==""?emptyStr:arrStr;
		}
		public  function getAdvancedTaskName():String{
			try{
				var taskName:String="";
				if(advancedFrame!=null){
					taskName=advancedFrame.taskName;
				}
				return taskName==""?emptyStr:taskName;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedDate():String{
			try{
				var advancedDateStr:String="";
				if(advancedFrame!=null){
					if(advancedFrame.imageTimes!=null&&advancedFrame.imageTimes.length>0){
						for(var i:int=0;i<advancedFrame.imageTimes.length;i++){
							var advancedDate:AdvancedTime=advancedFrame.imageTimes.getItemAt(i) as AdvancedTime;
							if(advancedDate==null)
								continue;
							if(i==advancedFrame.imageTimes.length-1){	
								advancedDateStr+=advancedDate.startTime+"-"+advancedDate.endTime;
							}else{
								advancedDateStr+=advancedDate.startTime+"-"+advancedDate.endTime+"; ";
							}
						}
					}
				}
				return advancedDateStr==""?emptyStr:advancedDateStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedSensorName():String{
			try{
				var sensorName:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						if(i==advancedFrame.imageParameters.length-1){
							sensorName+=arrayCollectionToString(advancedImage.sensorNames);
						}else{
							sensorName+=arrayCollectionToString(advancedImage.sensorNames)+"; ";
						}
					}
				}
				return sensorName==""?emptyStr:sensorName;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
			
		}
		public  function getAdvancedSensorType():String{
			try{
				var sensorType:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						if(i==advancedFrame.imageParameters.length-1){
							sensorType+=arrayCollectionToString(advancedImage.sensorType);
						}else{
							sensorType+=arrayCollectionToString(advancedImage.sensorType)+"; ";
						}
					}
				}
				return sensorType==""?emptyStr:sensorType;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedSpatialRes():String{
			try{
				var spatialResStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var spatialResolution:AdvancedDoubleMinMaxDescribe=advancedImage.spatialResolution as AdvancedDoubleMinMaxDescribe ;
						if(spatialResolution==null)
							continue;
						
						if(spatialResolution.minDoubleValue==-1&&spatialResolution.maxDoubleValue==-1)
							continue;
						if(spatialResolution.minDoubleValue==-1)
							spatialResolution.minDoubleValue=0;
						if(spatialResolution.maxDoubleValue==-1)
							spatialResolution.maxDoubleValue=0;
						
						if(i==advancedFrame.imageParameters.length-1){
							spatialResStr+=spatialResolution.minDoubleValue+"-"+spatialResolution.maxDoubleValue ;
						}else{
							spatialResStr+=spatialResolution.minDoubleValue+"-"+spatialResolution.maxDoubleValue+"; " ;
						}
					}
				}
				return spatialResStr==""?emptyStr:spatialResStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedRadiometricRes():String{
			try{
				var radiometricResStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var radiometricRes:AdvancedDoubleMinMaxDescribe=advancedImage.radiometricResolution as AdvancedDoubleMinMaxDescribe ;
						if(radiometricRes==null)
							continue;
						if(radiometricRes.minDoubleValue==-1&&radiometricRes.maxDoubleValue==-1)
							continue;
						if(radiometricRes.minDoubleValue==-1)
							radiometricRes.minDoubleValue=0;
						if(radiometricRes.maxDoubleValue==-1)
							radiometricRes.maxDoubleValue=0;
						
						if(i==advancedFrame.imageParameters.length-1){
							radiometricResStr+=radiometricRes.minDoubleValue+"-"+radiometricRes.maxDoubleValue ;
						}else{ 
							radiometricResStr+=radiometricRes.minDoubleValue+"-"+radiometricRes.maxDoubleValue+"; " ;
						}
					}
				}
				return radiometricResStr==""?emptyStr:radiometricResStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedTemporalRes():String{
			try{
				var temporalResStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var temporalRes:AdvancedDoubleMinMaxDescribe=advancedImage.temporalResolution as AdvancedDoubleMinMaxDescribe ;
						if(temporalRes==null)
							continue;
						if(temporalRes.minDoubleValue==-1&&temporalRes.maxDoubleValue==-1)
							continue;
						if(temporalRes.minDoubleValue==-1)
							temporalRes.minDoubleValue=0;
						if(temporalRes.maxDoubleValue==-1)
							temporalRes.maxDoubleValue=0;
						
						if(i==advancedFrame.imageParameters.length-1){
							temporalResStr+=temporalRes.minDoubleValue+"-"+temporalRes.maxDoubleValue ;
						}else{
							temporalResStr+=temporalRes.minDoubleValue+"-"+temporalRes.maxDoubleValue+"; " ;
						}
					}
				}
				return temporalResStr==""?emptyStr:temporalResStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedSpectralRes():String{
			try{
				var spectralResStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						
						
						var spectralRes:AdvancedDoubleMinMaxDescribe=advancedImage.spectralresolution as AdvancedDoubleMinMaxDescribe ;
						if(spectralRes==null)
							continue;
						if(spectralRes.minDoubleValue==-1&&spectralRes.maxDoubleValue==-1)
							continue;
						if(spectralRes.minDoubleValue==-1)
							spectralRes.minDoubleValue=0;
						if(spectralRes.maxDoubleValue==-1)
							spectralRes.maxDoubleValue=0;
						
						if(i==advancedFrame.imageParameters.length-1){
							spectralResStr+=spectralRes.minDoubleValue+"-"+spectralRes.maxDoubleValue ;
						}else{
							spectralResStr+=spectralRes.minDoubleValue+"-"+spectralRes.maxDoubleValue+"; " ;
						}
					}
				}
				return spectralResStr==""?emptyStr:spectralResStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedFabricWidth():String{
			try{
				var  fabricWidthStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var fabricWidth:AdvancedDoubleMinMaxDescribe=advancedImage.fabricWidth as AdvancedDoubleMinMaxDescribe ;
						if(fabricWidth==null)
							continue;
						if(fabricWidth.minDoubleValue==-1&&fabricWidth.maxDoubleValue==-1)
							continue;
						if(fabricWidth.minDoubleValue==-1)
							fabricWidth.minDoubleValue=0;
						if(fabricWidth.maxDoubleValue==-1)
							fabricWidth.maxDoubleValue=0;
						if(i==advancedFrame.imageParameters.length-1){
							fabricWidthStr+=fabricWidth.minDoubleValue+"-"+fabricWidth.maxDoubleValue ;
						}else{
							fabricWidthStr+=fabricWidth.minDoubleValue+"-"+fabricWidth.maxDoubleValue+"; " ;
						}
					}
				}
				return fabricWidthStr==""?emptyStr:fabricWidthStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedSNR():String{
			try{
				var  SNRStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var SNR:AdvancedDoubleMinMaxDescribe=advancedImage.snr as AdvancedDoubleMinMaxDescribe ;
						if(SNR==null)
							continue;
						if(SNR.minDoubleValue==-1&&SNR.maxDoubleValue==-1)
							continue;
						if(SNR.minDoubleValue==-1)
							SNR.minDoubleValue=0;
						if(SNR.maxDoubleValue==-1)
							SNR.maxDoubleValue=0;
						if(i==advancedFrame.imageParameters.length-1){
							SNRStr+=SNR.minDoubleValue+"-"+SNR.maxDoubleValue ;
						}else{
							SNRStr+=SNR.minDoubleValue+"-"+SNR.maxDoubleValue+"; " ;
						}
					}
				}
				return SNRStr==""?emptyStr:SNRStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		
		public  function getAdvancedEncounterAngle():String{
			try{
				var  encounterAngleStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var encounterAngle:AdvancedDoubleMinMaxDescribe=advancedImage.encounterAngle as AdvancedDoubleMinMaxDescribe ;
						if(encounterAngle==null)
							continue;
						if(encounterAngle.minDoubleValue==-1&&encounterAngle.maxDoubleValue==-1)
							continue;
						if(encounterAngle.minDoubleValue==-1)
							encounterAngle.minDoubleValue=0;
						if(encounterAngle.maxDoubleValue==-1)
							encounterAngle.maxDoubleValue=0;
						if(i==advancedFrame.imageParameters.length-1){
							encounterAngleStr+=encounterAngle.minDoubleValue+"-"+encounterAngle.maxDoubleValue ;
						}else{
							encounterAngleStr+=encounterAngle.minDoubleValue+"-"+encounterAngle.maxDoubleValue+"; " ;
						}
					}
				}
				return encounterAngleStr==""?emptyStr:encounterAngleStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedScale():String{
			try{
				var  scaleStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var scale:int=advancedImage.scale as int ;
						if(scale<0)
							continue;
						if(i==advancedFrame.imageParameters.length-1){
							scaleStr+="1:"+scale;
						}else{
							scaleStr+="1:"+scale+"; " ;
						}
					}
				}
				return scaleStr==""?emptyStr:scaleStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public  function getAdvancedFrequency():String{
			try{
				var  frequencyStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var frequency:AdvancedDoubleMinMaxDescribe=advancedImage.frequency as AdvancedDoubleMinMaxDescribe ;
						if(frequency==null)
							continue;
						if(frequency.minDoubleValue==-1&&frequency.maxDoubleValue==-1)
							continue;
						if(frequency.minDoubleValue==-1)
							frequency.minDoubleValue=0;
						if(frequency.maxDoubleValue==-1)
							frequency.maxDoubleValue=0;
						if(i==advancedFrame.imageParameters.length-1){
							frequencyStr+=frequency.minDoubleValue+"-"+frequency.maxDoubleValue ;
						}else{
							frequencyStr+=frequency.minDoubleValue+"-"+frequency.maxDoubleValue+"; " ;
						}
					}
				}
				return frequencyStr==""?emptyStr:frequencyStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		
		public  function getAdvancedBand():String{
			try{
				var  bandStr:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						var bands:ArrayCollection=advancedImage.bands as ArrayCollection ;
						if(bands==null||bands.length==0)
							continue;
						for(var k:int;k<bands.length;k++){
							var band:AdvancedDoubleMinMaxDescribe=bands.getItemAt(i) as AdvancedDoubleMinMaxDescribe;
							if(band.minDoubleValue==-1&&band.maxDoubleValue==-1)
								continue;
							if(band.minDoubleValue==-1)
								band.minDoubleValue=0;
							if(band.maxDoubleValue==-1)
								band.maxDoubleValue=0;
							if(i==advancedFrame.imageParameters.length-1&&k==bands.length-1){
								bandStr+=band.minDoubleValue+"-"+band.maxDoubleValue ;
							}else{
								bandStr+=band.minDoubleValue+"-"+band.maxDoubleValue+"; " ;
							}
						}
						
						

					}
				}
				return bandStr==""?emptyStr:bandStr;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		public function getSensorSARPolarLst():ArrayCollection{
			try{
				var sensorSARPolarList:ArrayCollection=new ArrayCollection();
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						if(advancedImage.sensorSARPolarLst!=null&&advancedImage.sensorSARPolarLst.length>0){
							for each(var polar:String in advancedImage.sensorSARPolarLst){
								sensorSARPolarList.addItem(polar);
							}
						}
					}
				}
				return sensorSARPolarList;
			}catch(err:Error){
				return null;
			}
			return null;
		}
		public function getSensorSARPolarType():String{
			try{
				var  sensorSARPolarType:String="";
				if(ImageParametersExist(advancedFrame)){
					for(var i:int=0;i<advancedFrame.imageParameters.length;i++){
						var advancedImage:AdvancedImageParameter=advancedFrame.imageParameters.getItemAt(i) as AdvancedImageParameter;
						if(advancedImage==null)
							continue;
						
						if(i==advancedFrame.imageParameters.length-1){
							sensorSARPolarType+=advancedImage.sensorSARPloarType;
						}else{
							sensorSARPolarType+=advancedImage.sensorSARPloarType+"; " ;
						}
					}
				}
				return sensorSARPolarType==""?emptyStr:sensorSARPolarType;
			}catch(err:Error){
				return emptyStr;
			}
			return emptyStr;
		}
		
		
	}
}