package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.util.FrameObj;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.TDeepframework;
	import valueObjects.TShallowframework;
	
	public class FeedbackDataHandler extends DataHandler
	{
		
		public function FeedbackDataHandler(result:Object)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{
			var xml:XML;
	
			var topItem:FrameObj=new FrameObj();
			topItem.canInput=false;
			if(this.dataFromServer!=null){
				if(this.dataFromServer is TDeepframework){
					xml=new XML((this.dataFromServer as TDeepframework).deepFrameXml);
					topItem.tagName="advancedFrame";
					topItem.name="深层框架";
				}
				else if(this.dataFromServer is TShallowframework){
					xml=new XML((this.dataFromServer as TShallowframework).shallowFrameXml);
					topItem.tagName="primaryFrame";
					topItem.name="浅层框架";
				}
			}
			
			constructInputArrayList2(xml,topItem);
			bindingData.addItem(topItem);
			
		}
		
		protected function constructInputArrayList2(xml:XML,item:FrameObj=null):void{  //递归函数
			for each(var param:XML in xml.children()){
				if(param.children()!=null && param.children().length()>0 && param.hasComplexContent() ){
					var paramItem:FrameObj=new FrameObj();
					paramItem.name=param.@cname;
					paramItem.tagName=param.name().localName;
					paramItem.show=param.@show;
					paramItem.unit=param.@unit;
					paramItem.canInput=false;
					if( paramItem.show!="false"){
						item.children.addItem(paramItem);	
					}	
					else{
						item.unvisiableChildren.addItem(paramItem);	 //添加unvisiableChildren 不显示但保存 用于最后的写出
					}
					constructInputArrayList2(param,paramItem);		
				}
				else{
					if(param!=null){
						var paramItem2:FrameObj=new FrameObj();
						paramItem2.name=param.@cname;
						paramItem2.show=param.@show;
						paramItem2.unit=param.@unit;
						paramItem2.tagName=param.name().localName;
						paramItem2.canInput=true;
						paramItem2.content=param;
						if( paramItem2.show!="false"){
							item.children.addItem(paramItem2);
						}else{
							item.unvisiableChildren.addItem(paramItem2);
						}
						
					}
				}
			}
		}
		
		
		//将获取的xml构建 成 datagrid的dataprovider   采用递归的方法遍历XML
		protected function constructInputArrayList(dataGirdArray:ArrayCollection,xml:XML,item:FrameObj=null):void{  //递归函数
			for each(var param:XML in xml.children()){
				if(param.children()!=null && param.children().length()>0 && param.hasComplexContent() ){
					var paramItem:FrameObj=new FrameObj();
					paramItem.name=param.@cname;
					paramItem.tagName=param.name().localName;
					paramItem.show=param.@show;
					paramItem.unit=param.@unit;
					paramItem.canInput=false;
					if( paramItem.show!="false"){
						if(item!=null){
							item.children.addItem(paramItem);	
						}
						if(item==null){							
							dataGirdArray.addItem(paramItem);
						}
						constructInputArrayList(dataGirdArray,param,paramItem);		
					}	
					else{
						if(item!=null){
							item.unvisiableChildren.addItem(paramItem);	 //添加unvisiableChildren 不显示但保存 用于最后的写出
						}
						if(item==null){							
							dataGirdArray.addItem(paramItem);
						}
						constructInputArrayList(dataGirdArray,param,paramItem);		
					}
				}
				else{
					if(param!=null){
						var paramItem2:FrameObj=new FrameObj();
						paramItem2.name=param.@cname;
						paramItem2.show=param.@show;
						paramItem2.unit=param.@unit;
						paramItem2.tagName=param.name().localName;
						paramItem2.canInput=true;
						paramItem2.content=param;
						if( paramItem2.show!="false"){
							if(paramItem2.content!="" && item==null)
								dataGirdArray.addItem(paramItem2);
							if(item!=null){
								item.children.addItem(paramItem2);
							}
						}else{
							if(paramItem2.content!="" && item==null )
								dataGirdArray.addItem(paramItem2);
							if(item!=null){
								item.unvisiableChildren.addItem(paramItem2);
							}
						}
						
					}
				}
			}
		}
		// 讲datagrid修改过的内容 构建成XML 采用递归的方法
		protected function constructXmlStringFromDatagrid(param:FrameObj):String{
			var paramString:String="";
			if(param.unvisiableChildren.length>0){
				paramString+="<"+param.tagName+" cname=\""+param.name+"\" show=\"false\"";
				if(param.unit.length>0){
					paramString+=" unit=\""+param.unit+"\"";
				}
				paramString+=">"
				for each(var p3:FrameObj in param.children){
					paramString+=constructXmlStringFromDatagrid(p3);
				}
				for each(var p4:FrameObj in param.unvisiableChildren){
					paramString+=constructXmlStringFromDatagrid(p4);
				}
				
			}
			else if(param.children.length>0 ){
				paramString+="<"+param.tagName+" cname=\""+param.name+"\"";
				if(param.show=="false")
					paramString+=" show=\"false\"" ;
				if(param.unit.length>0){
					paramString+=" unit=\""+param.unit+"\"";
				}
				paramString+=">";
				for each(var p1:FrameObj in param.children){
					paramString+=constructXmlStringFromDatagrid(p1);      //遍历可见的子元素
				}
				for each(var p2:FrameObj in param.unvisiableChildren){  // 遍历不可见的子元素
					paramString+=constructXmlStringFromDatagrid(p2);
				}
			}
			else{
				paramString+="<"+param.tagName+" cname=\""+param.name+"\"";
				
				if(param.show=="false"){
				}	
				if(param.unit.length>0){
					paramString+=" unit=\""+param.unit+"\"";
				}
				paramString+=">"+param.changeContent;
			}
			paramString+="</"+param.tagName+">";
			return paramString;
		}
		//构建xml的入口 
		public function XMlFromCollecton(array:ArrayCollection,type:String):String{
			var frameStr:String="<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
			if(type=="primaryFrame")
				frameStr+="<"+ type +" cname=\"浅层框架\""+">";
			else
				frameStr+="<"+ type +" cname=\"深层框架\""+">";
			for each(var param:FrameObj in array){
				frameStr+=constructXmlStringFromDatagrid(param);
			}
			frameStr+="</"+ type +">";
			var xml:XML=new XML(frameStr);
			return xml.toString();
		}
		
		public function XMlFromCollecton2(array:ArrayCollection,type:String):String{
			if(array==null||array.length==0){
				return "";
			}
			var param:FrameObj=array.getItemAt(0) as FrameObj;
			
			var frameStr:String="<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
//			if(type=="primaryFrame")
//				frameStr+="<"+ type +" cname=\"浅层框架\""+">";
//			else
//				frameStr+="<"+ type +" cname=\"深层框架\""+">";
			
			frameStr+=constructXmlStringFromDatagrid(param);
			
			
			var xml:XML=new XML(frameStr);
			return xml.toString();
		}
	}
}