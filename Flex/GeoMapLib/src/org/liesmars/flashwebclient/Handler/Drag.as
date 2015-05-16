package org.liesmars.flashwebclient.Handler
{
	//	import org.aswing.JPanel;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Image;
	import mx.graphics.ImageSnapshot;
	import org.liesmars.flashwebclient.Layer;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.Handler;
	
	/*
	*图层拖动 
	*/
	public class Drag extends Handler
	{
		private var startPoint:Point;
		private var endPoint:Point;
		private var startcontainer:Point;
		private var endcontainer:Point;	
		
		protected var img:Image;	
		
		public function Drag(map:GeoMap,options:Object)
		{
			super(map,options);	
			//			this.imgs=this.map.imgs;
			//			this.ChangeSrcFromVar=this.map.ChangeSrcFromVar;
			//			this.hitObjs=this.map.hitObjs;
		}
		public override function Active():void
		{
			this.map.sprite.addEventListener(MouseEvent.MOUSE_DOWN,this.MD,false,0,true);
			this.map.sprite.stage.addEventListener(MouseEvent.MOUSE_UP,this.MU,false,0,true);
			this.map.sprite.addEventListener(MouseEvent.MOUSE_MOVE,this.MM,false,0,true);
			super.Active();
		}
		public override function Deactive():void
		{
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_DOWN,this.MD);
			this.map.sprite.stage.removeEventListener(MouseEvent.MOUSE_UP,this.MU);
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_MOVE,this.MM);
			super.Deactive();
		}
		
		public override function Destroy():void
		{
			super.Destroy();
		}
		public function MD(event:MouseEvent):void
		{
//			trace( "down---- x: " + event.stageX + " y: " + event.stageY);
			
			//用程之兴的代码代替--20100613
			if(!this.mstate.isdown)
			{
				this.mstate.isdown=true;		
				//				this.startPoint = new Point(event.localX, event.localY);
				this.startPoint  =  new Point(event.stageX, event.stageY);	
				this.startcontainer = new Point(this.map.layerContainer.x, this.map.layerContainer.y);					
				this.map.layerContainer.startDrag();
								trace( "down---- x: " + event.stageX + " y: " + event.stageY);
				//				trace( "    ---- x: " + event.localX + " y: " + event.localY);	
				
//				 在平移的过程中生成图像
				var bitmap:Bitmap = new Bitmap(ImageSnapshot.captureBitmapData(this.map.sprite));
				img = new Image();
				img.source = bitmap;
				img.width = this.map.sprite.width;
				img.height = this.map.sprite.height;
				img.x = this.map.sprite.x;
				img.y = this.map.sprite.y;
				img.startDrag();
				this.map.sprite.addChildAt(img,this.map.sprite.numChildren);
				
				for(var i:int = 0;i<this.map.layerContainer.numChildren;i++){
					// 原是只隐藏Vector 但是如果影像层不隐藏在平移过程中造成两个影像层
					// 所以直接隐藏所有的Layer
					var vec:Layer = this.map.layerContainer.getChildAt(i) as Layer; //as Vector;
					if(vec){
						vec.visible = false;
					}
				}			
			}
		}
		public function MU(event:MouseEvent):void
		{
//			trace( "up---- x: " + event.stageX + " y: " + event.stageY);
			if(this.mstate.isdown)
			{
				if(this.mstate.isdown)
				{
					//					this.map.VectorDetect(event);
					//					this.map.LayersMove(event);
					endPoint =  new Point(event.stageX, event.stageY);	
					if(img.parent){
						img.parent.removeChild(img);
					}
					this.img.stopDrag();
					this.map.layerContainer.stopDrag();	
					
					
					
					trace( "up---- x: " + event.stageX + " y: " + event.stageY);
					endcontainer =  new Point(this.map.layerContainer.x, this.map.layerContainer.y);
					this.map.pan(startPoint.x - endPoint.x, startPoint.y - endPoint.y, {});
					startPoint = endPoint; 
					startcontainer = endcontainer; 		
				}
			}		
			
			this.mstate.isdown=false;
			
		}
		public function MM(event:MouseEvent):void
		{
			//this.map.BindHitEvent(this.mstate.isdown);	//----------- 3	
			if(this.mstate.isdown) 
			{	
				//					endPoint =  new Point(event.stageX, event.stageY);					
				//					endcontainer =  new Point(this.map.layerContainer.x, this.map.layerContainer.y);
				////			trace( " point move: x- " + (startPoint.x - endPoint.x).toString() + " y- " + (startPoint.y - endPoint.y).toString());	
				////			trace(" container move: x- " + (startcontainer.x - endcontainer.x).toString() + " y- " + (startcontainer.y - endcontainer.y).toString());					
				//					this.map.pan(startPoint.x - endPoint.x, startPoint.y - endPoint.y, {});
				//					startPoint = endPoint; 
				//					startcontainer = endcontainer; 					
			}				
			
			//			this.map.NewBindHitEvent(null);	
		}		
	}
}
