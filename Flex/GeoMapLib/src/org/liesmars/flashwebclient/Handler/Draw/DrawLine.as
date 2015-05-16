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
	
	public class DrawLine extends Draw
	{
		//private var symbol:LineSymbol=null;
		
		public function DrawLine(map:GeoMap,options:Object)
		{
			this.transLevel=0.6;
			super(map,options);	
			// 当点击编辑面板后，this.map.evtObj.x的值被设为-10000，这样不能再监听双击事件
			// 所以这样要重新将this.map.evtObj.x的值设为0 updated_By_Chzx
//			this.map.evtObj.x = 0;	
			//this.layer.symbol = new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(20,0x00ff00,1),"_lineStyle":new LineStyle(10,3,5,2)});		
		}				
		//如果用Shape不行就换Sprite
		public override function MD(event:MouseEvent):void
		{
			
			trace("line_down:"+event.buttonDown);			
			this.mstate.isdown=true;
			if(isfirst){
				
				if(!this.layer)
			    {
					this.layer=this.map.vectorLayer;
				    //其实应该是this.map.AddLayer(this.layer)，但是目前Layer没有完全抽象出来
				    this.map.addLayer(this.layer);
				    this.layer.symbol = new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(3,0xff0000,1),"_lineStyle":new LineStyle(10,3,5,2)});		
			    }
			    isfirst = false;
			}
			if(event.buttonDown)//左键
			{
				drawState="Drawing";
				if(!this.currentShape)
				{
					this.drawState="DrawStart";
					this.currentShape=new GeoShape();
					this.currentShape.geotype=GEOTYPES.LINE;					
					this.layer.sprite.addChild(this.currentShape);
				}
				var pt:Point=new Point(event.stageX,event.stageY);
				var p:Point=this.layer.sprite.globalToLocal(pt);
				
				this.lastpt=p;
				
				var tmpArr:Array = new Array();
				tmpArr.push(lastpt.x); tmpArr.push(lastpt.y);
				tmpArr = antiPData(tmpArr);
			    lastpt.x = tmpArr[0]; lastpt.y = tmpArr[1];
			
				
				//双击时候会有两次md事件，那时候的坐标是重复的，所以我们取消那两个点
				if(this.obj.length>0 && this.obj[this.obj.length-2] == lastpt.x && this.obj[this.obj.length-1] == lastpt.y)
				{
					//this.obj.pop();this.obj.pop();
					
				}
				else{
					this.obj.push(lastpt.x,lastpt.y);	
				
				} 
				this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,lastpt.x ,lastpt.y ,"polyline",drawState));
				if(this.obj && this.obj.length>1)
				{ //使用Util中提供的全局变量
					
					//记得clear掉，否则会出问题的
					this.currentShape.graphics.clear();		
					this.DrawLn(this.currentShape,this.obj);//trace(this.obj);
					this.DrawLns(this.currentShape,this.objs);
				}					
			}	
					
		}
		public function DrawLn(shape:GeoShape,arr:Array):void
		{
			if(arr.length<2)return;
			var g:Graphics=shape.graphics;		
			////////////////////////////////////////////////////
			//use linesymbol method	
//			g.lineStyle(2,0xff00ff,0.8);		
//			for(var i:int=0;i<arr.length-1;i+=2)
//			{
//				if(i==0)g.moveTo(arr[i],arr[i+1]);
//				else g.lineTo(arr[i],arr[i+1]);
//			}
            //var symbol:LineSymbol=new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(20,0x00ff00,1),"_lineStyle":new LineStyle(10,3,5,2)});
            this.layer.symbol.DrawLine(shape,arr);
            //trace(this.layer.test);
		}
		public function DrawLns(shape:GeoShape,arr:Array):void
		{
			for(var i:int=0;i<arr.length;i++)
			{
				this.DrawLn(shape,arr[i] as Array);
			}
		}
		public override function MU(event:MouseEvent):void
		{
			if(this.mstate.isdown)
			{
				this.mstate.isdown=false;						
			}
		}
		public override function MM(event:MouseEvent):void
		{
//			return;
//			var p:Point=new Point(event.stageX,event.stageY);
//			p=this.layer.globalToLocal(lastpt);
//			if(!this.mstate.isdown)
//			{
//				if(this.line.length>0)
//				{
//					//this.currentShape.
//				}
//			}
//			else if(this.mstate.isdown)//暂时不处理太复杂的，需要监测KeyboardEvent
//			{
//				
//			}
            //updated_by_Chzx
//            if(!this.currentShape)
//			{
//				this.currentShape=new GeoShape();
//				this.currentShape.geotype=GEOTYPES.LINE;					
//				this.layer.addChild(this.currentShape);
//			}
            if(this.currentShape){
            	this.currentShape.graphics.clear();	
            }
            	
			this.DrawLn(this.currentShape,this.obj);//trace(this.obj);
			if(this.obj.length>=2){
//				var g:Graphics=this.currentShape.graphics;
//			    g.lineStyle(2,0xff00ff,0.8);
//			    var tmpX:Number = this.obj[this.obj.length-2];
//			    var tmpY:Number = this.obj[this.obj.length-1];
//			    var destP:Point = this.layer.globalToLocal(new Point(event.stageX,event.stageY));
//			    g.moveTo(tmpX,tmpY);
//			    g.lineTo(destP.x,destP.y);
                var destP:Point = this.layer.sprite.globalToLocal(new Point(event.stageX,event.stageY));
                var tmpArr:Array = new Array();
				tmpArr.push(destP.x); tmpArr.push(destP.y);
			    tmpArr = antiPData(tmpArr);
				destP.x = tmpArr[0]; destP.y = tmpArr[1];  
               
                this.obj.push(destP.x,destP.y);
			}
			this.DrawLn(this.currentShape,this.obj);
			this.DrawLns(this.currentShape,this.objs);
			this.obj.pop();this.obj.pop();
		}
		//没有检测到双击事件
		public override function DC(event:MouseEvent):void
		{
			trace(this.color);
			trace(this.transLevel);
			this.map.sprite.dispatchEvent(new DrawResultEvent(DrawResultEvent.DRAW_END,0,0,"polyline","DrawFinished"));
			super.DC(event);
		}	
		
		public function drawLines(shape:GeoShape,arr:Array):void{
			this.currentShape = shape;
			this.layer.sprite.addChild(this.currentShape);
			this.objs = arr;
			DrawLns(this.currentShape,arr);
			
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