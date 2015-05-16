package org.liesmars.flashwebclient.Handler.Edit
{
	import org.liesmars.flashwebclient.Handler.Edit;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.liesmars.flashwebclient.Layer.Vector;
	import flash.display.Graphics;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.Util;
			
	public class NarrowVector extends Edit
	{
		public function NarrowVector(map:GeoMap, options:Object)
		{
			super(map, options);
		}
		
		public override function Active():void{
			if(this.map.dHandler && this.map.dHandler.isActive){
			    this.map.dHandler.Deactive();
			}
			
//			if(this.map.evtObj && this.map.evtObj.x>=0){
//			    this.map.EvtObjMoveAway();
//			}
			
			if(this.map.eHandler && this.map.eHandler.isActive)
			{
				var edit:Edit=this.map.eHandler as Edit;
				edit.removeControlPts();
				edit.Deactive();
			}
			
			var s:Sprite=this.map.layerContainer;			
			var lcount:int=s.numChildren;//矢量图层数			
			var slayer:Vector;//图层是Sprite
			var shape:GeoShape;
					
			for(var i:int=0;i<lcount;i++)
			{				
				slayer=s.getChildAt(i) as Vector;
				if(slayer) {
					for(var j:int=0;j<slayer.sprite.numChildren;j++)
					{
						shape=slayer.sprite.getChildAt(j) as GeoShape;	
						
						if(shape.isLLcoords){
							shape.coords = this.PMultiData(shape.coords as Array);
							shape.isLLcorrds = false;
						}
						//shape.removeEventListener(MouseEvent.CLICK,Enlarge);
						if(shape.geotype != GEOTYPES.POINT){
							shape.addEventListener(MouseEvent.CLICK,Narrow);
						}				
									
					}	
				}					

			}		
		}
		
		public override function Deactive():void{
			RemoveResizeEvent();
		}
		
		public function Narrow(e:MouseEvent):void{
			this.removeControlPts();
			if(this.target!=e.target)
			{
				this.target=e.target as GeoShape;
			}
			
			var shp:GeoShape=e.target as GeoShape;
			var arr1:Array = shp.coords as Array;
			//var arr2:Array = null;
			var averagex:Number = 0;
			var averagey:Number = 0;
            var arr2:Array = arr1[0] as Array;
			for(var j:int =0;j<arr2.length;j=j+2){
				//trace(arr2[j],arr2[j+1]);
				averagex += arr2[j];
				averagey += arr2[j+1];
			}
			//trace(averagex,averagey);
			averagex = averagex/(arr2.length/2);
			averagey = averagey/(arr2.length/2);
			//trace(averagex,averagey);
			for(var i:int = 0;i<arr2.length;i=i+2){
				arr2[i] = ComputeCoordinate2(arr2[i],averagex);
				arr2[i+1] = ComputeCoordinate2(arr2[i+1],averagey);
				//trace("!!");
                //trace(arr2[i],arr2[i+1]);
			}
		    shp.graphics.clear();
		    if(shp.geotype == GEOTYPES.POLYGON){
		    	this.DrawPolygons(shp,shp.coords as Array,Util.color.polygon,Util.transLevel.polygon);
		    }
			else if(shp.geotype == GEOTYPES.LINE){
				this.DrawLines(shp,shp.coords as Array,Util.color.line,Util.transLevel.line);
			}
		}
		
		public function ComputeCoordinate2(target:Number,center:Number):Number{
			return 0.7*target+0.3*center;
		}
		
		// 面的编辑状态
		private function DrawPolygons(shape:GeoShape,lineRings:Array,color:uint,transLevel:Number):void
		{//[[],[]]	
			var g:Graphics=shape.graphics;
			shape.x=0;//因为当拖动之后，shape:GeoShape的x,y坐标发生了变化，但是它所带有的coords属性还是按照x=0,y=0计算的
			shape.y=0;
			g.clear();
			
			var lineRing:Array;
			g.beginFill(color,transLevel);			
			
			for(var i:int=0;i<lineRings.length;i++)
			{
				lineRing=lineRings[i] as Array;
				for(var j:int=0;j<lineRing.length;j+=2)
				{
					if(j!=0)
					{
						g.lineTo(lineRing[j],lineRing[j+1]);
					}
					else
					{
						g.moveTo(lineRing[j],lineRing[j+1]);
					}					
				}				
			}
			g.endFill();
		}
		
		// 线的编辑状态
		private function DrawLines(shape:GeoShape,lineRings:Array,color:uint,transLevel:Number):void
		{//[[],[]]	
			var g:Graphics=shape.graphics;
			shape.x=0;//因为当拖动之后，shape:GeoShape的x,y坐标发生了变化，但是它所带有的coords属性还是按照x=0,y=0计算的
			shape.y=0
			g.clear();
			g.lineStyle(Util.thick.line,Util.color.line,Util.transLevel.line);
			var lineRing:Array;
			for(var i:int=0;i<lineRings.length;i++)
			{
				lineRing=lineRings[i] as Array;
				for(var j:int=0;j<lineRing.length-1;j+=2)
				{
					if(j!=0)
					{
						g.lineTo(lineRing[j],lineRing[j+1]);
					}
					else
					{
						g.moveTo(lineRing[j],lineRing[j+1]);
					}					
				}
				
			}
		}
		
		//取消放缩的监听
		public function RemoveResizeEvent():void{
			var s:Sprite=this.map.layerContainer;			
			var lcount:int=s.numChildren;//矢量图层数			
			var slayer:Vector;//图层是Sprite
			var shape:GeoShape;
					
			for(var i:int=0;i<lcount;i++)
			{				
				slayer=s.getChildAt(i) as Vector;		
				if(slayer) {
					for(var j:int=0;j<slayer.sprite.numChildren;j++)
					{
						shape=slayer.sprite.getChildAt(j) as GeoShape;	
						if(!shape.isLLcoords){
							shape.coords = this.antiPMultiData(shape.coords as Array);
							shape.isLLcorrds = true;				
						}	
						//shape.removeEventListener(MouseEvent.CLICK,Enlarge);				
						shape.removeEventListener(MouseEvent.CLICK,Narrow);			
					}
				}			

			}	
		}

	}
}