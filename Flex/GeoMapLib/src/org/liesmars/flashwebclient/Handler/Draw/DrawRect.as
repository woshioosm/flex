package org.liesmars.flashwebclient.Handler.Draw
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.liesmars.flashwebclient.*;
	import org.liesmars.flashwebclient.BaseTypes.*;
	import org.liesmars.flashwebclient.GeoEvent.DrawResultEvent;
	import org.liesmars.flashwebclient.Handler.Draw;
	import org.liesmars.flashwebclient.Layer.VectorLayer;
	import org.liesmars.flashwebclient.Symbol.FillStyle;
	import org.liesmars.flashwebclient.Symbol.PolygonSymbol;
	import org.liesmars.flashwebclient.Symbol.RectangularSymbol;
	import org.liesmars.flashwebclient.Symbol.StrokeStyle;
	
	public class DrawRect extends Draw
	{
		public var box:Sprite=null;
		public var lefttop:Point=new Point();
		public var ptCoord:Array = new Array();   //存储拉框矩形的顶点坐标
		public var nEffect:int = 0; 
        private var isKeyDown:Boolean=false;
		
		
		public function DrawRect(map:GeoMap,options:Object)
		{
			super(map,options);
		}
		
		public override function Active():void
		{
//			this.map.sprite.addEventListener(MouseEvent.MOUSE_DOWN,this.MD);
//			this.map.sprite.addEventListener(MouseEvent.MOUSE_UP,this.MU);
//			this.map.sprite.addEventListener(MouseEvent.MOUSE_MOVE,this.MM);

			this.map.sprite.addEventListener(MouseEvent.MOUSE_DOWN,this.MD,false,0,true);
			this.map.sprite.addEventListener(MouseEvent.MOUSE_UP,this.MU,false,0,true);
			this.map.sprite.addEventListener(MouseEvent.MOUSE_MOVE,this.MM,false,0,true);
			
//			trace(this.map.sprite.willTrigger(MouseEvent.MOUSE_DOWN));
//			this.map.sprite.addEventListener(MouseEvent.MOUSE_DOWN,this.MD);
//			this.map.sprite.addEventListener(MouseEvent.MOUSE_UP,this.MU);
//			this.map.sprite.addEventListener(MouseEvent.MOUSE_MOVE,this.MM);			
			super.Active();
			
		}
		public override function Deactive():void
		{
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_DOWN,this.MD);
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_UP,this.MU);
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_MOVE,this.MM);
			
			trace(this.map.sprite.hasEventListener(MouseEvent.MOUSE_DOWN));
			if(this.box){
			   this.box.parent.removeChild(this.box);
			   box=null;
			}
			super.Deactive();
		}
		
		override public function MD(event:MouseEvent):void
		{
			//this.currentShape=null;
			this.mstate.isdown=true;

			if(!this.layer)
			{
			   for(var i:int=0;i<this.map.layers.length;i++){
				  if(this.map.layers[i] is VectorLayer)
					this.layer=this.map.layers[i] as VectorLayer;
				  }
					
				//其实应该是this.map.AddLayer(this.layer)，但是目前Layer没有完全抽象出来
				//this.map.addLayer(this.layer);
		
				this.layer.symbol = new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,0.5),"_fillStyle":new FillStyle(0xffffff,0.3)});
			}

			if(event.buttonDown)//左键
			{	
				drawState="DrawStart";
				var pt:Point=new Point(event.stageX,event.stageY);
				var p:Point=this.layer.globalToLocal(pt);
				if(!this.currentShape)
				{
					this.currentShape=new GeoShape();
					this.currentShape.geotype=GEOTYPES.POLYGON;
					this.layer.addChild(this.currentShape);
				}
			
				var tmpArr:Array = new Array();
				tmpArr.push(p.x); tmpArr.push(p.y);
				tmpArr = antiPData(tmpArr);
				p.x = tmpArr[0]; p.y = tmpArr[1];
				this.obj.push(p.x,p.y);	
				this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,p.x ,p.y ,"rect",drawState));
			}
			event.updateAfterEvent();
			
			
			
		}
		
		override public function MU(e:MouseEvent):void
		{
			if(this.mstate.isdown==true){
				drawState="DrawFinished";
				var up:Point=new Point(e.stageX,e.stageY);
				var p:Point=this.layer.globalToLocal(up);
				var tmpArr:Array = new Array();
				tmpArr.push(p.x); tmpArr.push(p.y);
				tmpArr = antiPData(tmpArr);
				p.x = tmpArr[0]; p.y = tmpArr[1];
				
				this.obj.push(p.x,obj[1]);
				
				this.obj.push(p.x,p.y);
				this.obj.push(obj[0],p.y);
				
				this.objs.push(this.obj);
				
				this.obj=[];			
				
				this.lastpt=null;
				this.currentShape.coords=this.objs;
				this.objs=[];
				
				
				this.currentShape=null;
				this.mstate.isdown=false;
				this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,p.x ,p.y ,"rect",drawState));
			}
		}
		
		override public  function MM(e:MouseEvent):void
		{
			if(this.mstate.isdown){
				var rightbottom:Point=new Point(e.stageX,e.stageY);
				var p:Point=this.layer.globalToLocal(rightbottom);
				var tmpArr:Array = new Array();
				tmpArr.push(p.x); tmpArr.push(p.y);
				tmpArr = antiPData(tmpArr);
				p.x = tmpArr[0]; p.y = tmpArr[1];
				this.obj.push(p.x,p.y);	
				if(obj.length==4){
					this.currentShape.graphics.clear();
					this.currentShape.graphics.lineStyle(2,0xff00ff,0.8);
					this.layer.symbol.DrawRectangular(currentShape,obj);
					this.obj.pop();
					this.obj.pop();
				}
			}
			
		}
		
	
		public function extenderFunc(coords:Array):void
		{
			
		}

	}
}