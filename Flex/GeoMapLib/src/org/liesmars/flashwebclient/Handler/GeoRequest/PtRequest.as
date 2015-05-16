package org.liesmars.flashwebclient.Handler.GeoRequest
{
	import flash.events.MouseEvent;
	import flash.filters.GradientGlowFilter;
	import flash.geom.Point;
	import flash.utils.*;
	
	import mx.containers.TitleWindow;
	import mx.controls.TextArea;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.liesmars.flashwebclient.*;
	
	public class PtRequest extends Handler
	{
		public var dialog:TitleWindow;
		public var data:TextArea = new TextArea();
		public var filter:Array = new Array();     //the object will be lighted when being selected
		public var n:int;
		public function PtRequest(map:GeoMap,options:Object)
		{
			super(map,options);
			
		}
		
		private function reqPt(event:MouseEvent):void
		{
			ptProp(event.stageX,event.stageY);
		}
		
		private function ptProp(globex:int,globey:int):void
		{
//			var data:Date=new Date();
//			trace("start:"+data.getMilliseconds());
			var globeP:Point=new Point(globex,globey);
			var p:Point=this.map.sprite.globalToLocal(globeP);
			var shps:Array=this.map.sprite.stage.getObjectsUnderPoint(globeP);
			
			var text:String="";
			
			n=0;        //number of  objects under the point
			var shapes:Array=[];
			for(var i:int=0;i<shps.length;i++)
			{
				if(!shps[i].hasOwnProperty("id"))continue;
				var id:String=shps[i].id as String;
				if(id.indexOf("GeoShape")>=0)
				{	
					n++;
					var shp:GeoShape=shps[i] as GeoShape;
					shapes.push(shp);
					filter[n-1] = shp;
					filter[n-1].filters=[new GradientGlowFilter(2,45,[0xff0000,0x00ff00,0x0000ff],[1,0.4,1],[2,1,2],4,4,5)];//new GlowFilter(0xffff00,0.5,3,3,2)
					text+="第"+n+"个对象\r";
					text+="id:\t"+shp.id+"\r";
					text+="featuretype:\t"+shp.featuretype+"\r";
					text+="geotype:\t"+shp.geotype+"\r";
					text+="name:\t"+shp.name+"\r";	
					var dic:Dictionary=	shp.attributes as Dictionary;	
						
					for(var key:Object in dic)
					{
						text+=key+":\t"+dic[key]+"\r";						
					}					
					text+="\r";					
				}
			}
			text="对象总数:\t"+n+"\r\r"+text;
			trace("text:"+text);
			trace("end:"+new Date().getMilliseconds());
			if(n<=0)return;
			
			if(!this.dialog)
			{
				this.dialog=new TitleWindow();//这里是控件持有引用，不是handler
				PopUpManager.addPopUp(this.dialog,this.map.sprite,false);
			}
			this.dialog.x = p.x;
			this.dialog.y = p.y;
		    this.dialog.height = 240;
			this.dialog.title = "查询信息";
			this.dialog.showCloseButton = true;
			this.dialog.addEventListener(CloseEvent.CLOSE,closeWin);
//			this.dialog.verticalScrollPolicy = ScrollPolicy.OFF;
			
			data.text = text;
			data.height = 180;
			data.editable = false;
//			data.horizontalScrollPolicy = ScrollPolicy.OFF;
//			data.verticalScrollPolicy = ScrollPolicy.OFF;
			this.dialog.addChild(data);	
		}
		public override function Deactive():void
		{
			super.Deactive();
			this.map.sprite.removeEventListener(MouseEvent.CLICK,reqPt);
		}
		public override function Active():void
		{
			super.Active();
			this.map.sprite.addEventListener(MouseEvent.CLICK,reqPt);
		}
		private function closeWin(event:CloseEvent):void
		{
			PopUpManager.removePopUp(this.dialog);
			this.dialog = null;
			for(var i:int = 0; i < n; i++)
			{
				if(filter[i]) filter[i].filters = null;
			
			}
		}
		
	}
}