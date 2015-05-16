package org.liesmars.flashwebclient.Handler.Draw
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoEvent.DrawResultEvent;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Handler.Draw;
	import org.liesmars.flashwebclient.Layer.Vector;
	import org.liesmars.flashwebclient.Layer.VectorLayer;
	import org.liesmars.flashwebclient.Symbol;
	import org.liesmars.flashwebclient.Symbol.*;
	
	public class DrawPolygon extends Draw//其实可以让DrawPolygon继承DrawLine
	{
		//private var symbol:PolygonSymbol = null;
		
		public function DrawPolygon(map:GeoMap,options:Object)
		{
			this.transLevel=0.4;
			super(map,options);	
			// 当点击编辑面板后，this.map.evtObj.x的值被设为-10000，这样不能再监听双击事件
			// 所以这样要重新将this.map.evtObj.x的值设为0 updated_By_Chzx
			//			this.map.evtObj.x = 0;
			//this.layer.symbol = new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xffff00,1),"_fillStyle":new FillStyle(0xff00ff,.5)});
			
		}

		public override function MD(event:MouseEvent):void
		{
			this.mstate.isdown=true;
			if(isfirst){
				if(!this.layer)
				{
					
					this.layer=this.map.vectorLayer;
					
					
					//其实应该是this.map.AddLayer(this.layer)，但是目前Layer没有完全抽象出来
					//this.map.addLayer(this.layer);
					this.layer.symbol = new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xff0000,0.5),"_fillStyle":new FillStyle(0xffffff,0.3)});
				}
				isfirst = false;
			}
			if(event.buttonDown)//左键
			{	
				var pt:Point=new Point(event.stageX,event.stageY);
				var p:Point=this.layer.globalToLocal(pt);
				if(!this.currentShape)
				{
				    this.drawState="DrawStart";
					this.currentShape=new GeoShape();
					this.currentShape.geotype=GEOTYPES.POLYGON;
					this.layer.addChild(this.currentShape);
					//this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,));
				}
				if(this.obj && this.obj.length>0)
				{
					this.drawState="Drawing";
					this.currentShape.graphics.clear();
		
					this.lastpt=p;
					var tmpArr:Array = new Array();
					tmpArr.push(lastpt.x); tmpArr.push(lastpt.y);
					tmpArr = antiPData(tmpArr);
					lastpt.x = tmpArr[0]; lastpt.y = tmpArr[1];		
					if(this.obj[this.obj.length-2] == lastpt.x && this.obj[this.obj.length-1] == lastpt.y)
					{
						//this.obj.pop();this.obj.pop();
					}
					else {
						this.obj.push(lastpt.x,lastpt.y);
					}				
					
					this.DrawRing(this.currentShape,this.obj,this.color,this.transLevel);
					
					this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,lastpt.x,lastpt.y,"polygon",drawState));
					//this.DrawRings(this.currentShape,this.objs);
					//右键和双击测试成功之后这里要换了
				}
				else
				{
					this.lastpt=p;
					var tmpArr:Array = new Array();
					tmpArr.push(lastpt.x); tmpArr.push(lastpt.y);
					tmpArr = antiPData(tmpArr);
					lastpt.x = tmpArr[0]; lastpt.y = tmpArr[1];
					this.obj.push(lastpt.x,this.lastpt.y);	
					this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,lastpt.x,lastpt.y,"polygon",drawState));
				}	
				
			}
			event.updateAfterEvent();
		}
		public override function MU(event:MouseEvent):void
		{}
		public override function MM(event:MouseEvent):void
		{
			//updated_by_Chzx
			//			if(!this.currentShape)
			//			{
			//				this.currentShape=new GeoShape();
			//				this.currentShape.geotype=GEOTYPES.POLYGON;					
			//				this.layer.addChild(this.currentShape);
			//			}
            //this.drawState="Moving";
			if(this.obj.length==2){
				var tmp:Point = this.layer.sprite.globalToLocal(new Point(event.stageX,event.stageY));
				//this.obj.push(tmp.x,tmp.y);
				this.currentShape.graphics.clear();
				this.currentShape.graphics.lineStyle(2,0xff00ff,0.8);
				
				var tmpArr:Array = new Array();
				tmpArr.push(this.obj[0],this.obj[1]);
				tmpArr = PData(tmpArr);
				
				this.currentShape.graphics.moveTo(tmpArr[0],tmpArr[1]);
				this.currentShape.graphics.lineTo(tmp.x,tmp.y);
//				this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,tmp.x,tmp.y,"polygon",drawState));
				//				this.obj.pop();
				//				this.obj.pop();
			}
			
			if(this.obj.length>=4){
				var tmpPoint:Point = this.layer.sprite.globalToLocal(new Point(event.stageX,event.stageY));
				
				var tmpArr:Array = new Array();
				tmpArr.push(tmpPoint.x); tmpArr.push(tmpPoint.y);
				tmpArr = antiPData(tmpArr);
				tmpPoint.x = tmpArr[0]; tmpPoint.y = tmpArr[1];			    
				
				this.obj.push(tmpPoint.x,tmpPoint.y);
				this.currentShape.graphics.clear();	
				this.DrawRing(this.currentShape,this.obj,this.color,this.transLevel);
				//this.DrawRings(this.currentShape,this.objs);
				this.obj.pop();
				this.obj.pop();
//				this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,tmpPoint.x,tmpPoint.y,"polygon",drawState));
			}
			
		}		
		
		//AS3.0可以绘制带岛的多边形，重复绘制区域都是透明的
		private function DrawRing(shape:GeoShape,lineRing:Array,color:uint,transLevel:Number):void
		{
			if(lineRing.length<2)return;
			var g:Graphics=shape.graphics;
			//////////////////////////////////////////////////
			//use polygonsymbol method
			//			g.beginFill(color,transLevel);
			//			for(var i:int=0;i<lineRing.length-1;i+=2)
			//			{
			//				if(i!=0)
			//				{
			//					g.lineTo(lineRing[i],lineRing[i+1]);
			//				}
			//				else
			//				{
			//					g.moveTo(lineRing[i],lineRing[i+1]);
			//				}
			//			}
			//			g.endFill();
			//var symbol:PolygonSymbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xffff00,1),"_fillStyle":new FillStyle(0xff00ff,.5)});
			
			this.layer.symbol.DrawPolygon(shape,lineRing);
		}
		private function DrawRings(shape:GeoShape,lineRings:Array):void
		{
			for(var i:int=0;i<lineRings.length;i++)
			{
				this.DrawRing(shape,lineRings[i],this.color,this.transLevel);
			}
		}
		//没有检测到双击事件
		public override function DC(event:MouseEvent):void
		{
//			if(this.drawState!="Finished"){
				this.drawState="DrawFinished";
//				var pt:Point=new Point(event.stageX,event.stageY);
//				var p:Point=this.layer.globalToLocal(pt);
//				this.lastpt=p;
//				var tmpArr:Array = new Array();
//				tmpArr.push(lastpt.x); tmpArr.push(lastpt.y);
//				tmpArr = antiPData(tmpArr);
//				lastpt.x = tmpArr[0]; lastpt.y = tmpArr[1];		
				this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,0,0,"polygon",drawState));
//			}
			super.DC(event);
			
		}
		
		//封装给用户调用的方法 updated by chzx just for testing
		public function drawRings(shape:GeoShape,lineRings:Array):void{
			this.currentShape = shape;
			this.layer.sprite.addChild(this.currentShape);
			this.objs = lineRings;
			DrawRings(this.currentShape,lineRings);
			
			var s:Sprite = this.map.layerContainer;
			var lcount:int = s.numChildren;
			var slayer:Sprite = s.getChildAt(lcount-1) as Sprite;
			//将绘制的图形绑定到容器中
			slayer.addChild(shape);
		}
		
		public function setSymbol(symbol:Symbol):void{
			this.layer.symbol = symbol;
		}
		
		public function getSymbol():Symbol{
			return this.layer.symbol;
		}
	}
}