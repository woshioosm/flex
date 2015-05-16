package org.liesmars.flashwebclient.Handler.Draw
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoEvent.DrawResultEvent;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Handler.Draw;
	import org.liesmars.flashwebclient.Layer.Vector;
	import org.liesmars.flashwebclient.Symbol;
	import org.liesmars.flashwebclient.Symbol.*;

	//import org.aswing.
	public class DrawPoint extends Draw
	{
		public var raduis:int=4;
		//private var symbol:PointSymbol = null;
		
		public function DrawPoint(map:GeoMap,options:Object)
		{
			this.transLevel=0.8;
			super(map,options);	
			// 当点击编辑面板后，this.map.evtObj.x的值被设为-10000，这样不能再监听双击事件
			// 所以这样要重新将this.map.evtObj.x的值设为0 updated_By_Chzx
//			this.map.evtObj.x = 0;
			//this.layer.symbol = new PointSymbol(this.map,{"_strokeStyle":new StrokeStyle(1,0x00ffff,1)});
		}
		
		public override function MD(event:MouseEvent):void
		{
			if(isfirst){
				if(!this.layer)
			    {
					this.layer=this.map.vectorLayer;
				    //其实应该是this.map.AddLayer(this.layer)，但是目前Layer没有完全抽象出来
				    this.map.addLayer(this.layer);
				    this.layer.symbol = new PointSymbol(this.map,{"_strokeStyle":new StrokeStyle(1,0xff0000,1)});
			    }
			    isfirst = false;
			}
			
			var lp:Point;//=this.map.GetPointFromLayerToLayer(new Point(event.localX,event.localY),this.can,this.map.canvas);//new Point(event.stageX,event.stageY);
			var stageP:Point=new Point(event.stageX,event.stageY);
			trace("stage" + stageP.toString());
			lp=this.layer.sprite.globalToLocal(stageP);
			trace("local" + lp.toString());			
			if(!this.currentShape)
			{
				this.currentShape=new GeoShape();
				this.currentShape.geotype=GEOTYPES.POINT;
				this.layer.sprite.addChild(this.currentShape);
			}
			
//			var s:GeoShape=this.currentShape;	
			
			if(this.obj.length>0 && this.obj[this.obj.length-2] == lp.x && this.obj[this.obj.length-1] == lp.y)
			{
				this.obj.pop();this.obj.pop();
			}
			else {
				var tmpArr:Array = new Array();
				tmpArr.push(lp.x); tmpArr.push(lp.y);
				tmpArr = antiPData(tmpArr);
				lp.x = tmpArr[0]; lp.y = tmpArr[1];
				this.obj.push(lp.x,lp.y);
				
				this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,lp.x ,lp.y ,"point","DrawStart"));
			}
			
			this.currentShape.graphics.clear();
			
			this.DrawPts(this.currentShape,this.obj);
			
			
			//this.objs.push(this.obj);
			this.obj=[];			
			this.lastpt=null;
			//this.currentShape.coords=this.objs;
			this.objs=[];
			this.currentShape=null;
		}
		private function DrawPts(shape:GeoShape,arr:Array):void
		{
			if(arr.length<2)return;
			var g:Graphics=shape.graphics;
			for(var i:int=0;i<arr.length-1;i+=2)
			{
//				//var g:Graphics=shape.graphics;
//				g.lineStyle(1,0xff0000);
//				g.beginFill(0xF1B8FC,0.8);
//				//g.beginFill(0xFFFFFF,0.8);
//				///////////////////////////////////////////////////
//				// use pointsymbol method
//				g.drawCircle(arr[i],arr[i+1],this.raduis);
//				g.endFill();
					
				//var symbol:PointSymbol = new PointSymbol(this.map,{"_strokeStyle":new StrokeStyle(1,0x00ffff,1)});
				var tp:Point = new Point(arr[i],arr[i+1]);
				this.layer.symbol.DrawPoint(shape,tp,this.raduis,null);
			}
		}
		public override function MU(event:MouseEvent):void
		{
			trace("up");			
		}
		public override function MM(event:MouseEvent):void
		{}
		public override function DC(event:MouseEvent):void
		{
			trace("------------dbc----------------------");
			super.DC(event);
		}
		
		public function drawPoints(shape:GeoShape,arr:Array):void{
			this.currentShape = shape;
			this.layer.sprite.addChild(this.currentShape);
			this.objs = arr;
			DrawPts(this.currentShape,arr);
			
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