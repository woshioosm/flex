package org.liesmars.flashwebclient.Handler.Edit
{
	import org.liesmars.flashwebclient.Handler.Edit;
	
	import org.liesmars.flashwebclient.Layer.Vector;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Symbol;
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.Util;	
			
	public class RotateVector extends Edit
	{
		public function RotateVector(map:GeoMap, options:Object)
		{
			super(map, options);
		}
		
		public override function Active():void{
			//this.removeControlPts
			
			//this.map.DeactiveAllControlExcept(this);
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
			trace(lcount);		
			var slayer:Vector;//图层是Sprite
			var shape:GeoShape;		
			for(var i:int=0;i<lcount;i++)
			{	
				trace(i);			
				slayer=s.getChildAt(i) as Vector;	
				if(slayer) {
				var symbol:Symbol = slayer.symbol;				
				for(var j:int=0;j<slayer.sprite.numChildren;j++)
				{
					shape=slayer.sprite.getChildAt(j) as GeoShape;	
					
						if(shape.isLLcoords){
							shape.coords = this.PMultiData(shape.coords as Array);
							shape.isLLcorrds = false;
						}
						
					if(shape.geotype == GEOTYPES.POINT){
						
					}
					else{
//						shape.x = 0;
//						shape.y = 0;
//						shape.graphics.clear();
   					    var arr:Array = new Array();
					    arr = shape.coords as Array;	
					    arr = arr[0];	   

//                        if(shape.geotype == GEOTYPES.POLYGON){
//                        	DrawRings(shape,shape.coords as Array,symbol);
//                        }
//					    else if(shape.geotype == GEOTYPES.LINE){
//					    	DrawLns(shape,shape.coords as Array,symbol);
//					    }
					    
					    shape.addEventListener(MouseEvent.CLICK,StartRotate);
					    var copyArr:Array = new Array();
					    copyArr.push(arr);

					    shape.coords = copyArr;	
					    	
					}
				}
				}

			}
			super.Active();		
			
		}
		
		public override function Deactive():void{
			RemoveRotateEvent();
			RedefineCoordinate();
			super.Deactive();
		}
		
		public function StartRotate(e:MouseEvent):void{
			var s:GeoShape = e.target as GeoShape;
			
			var a:Vector = s.parent as Vector;
			var arr:Array= s.coords as Array;
			arr = arr[0];
			if(!s.rotated){
				var c:Array = getCenter(arr);
				s.center = c;
				s.x = s.center[0];
				s.y = s.center[1];
				for(var k:int =0;k<arr.length;k=k+2){
					arr[k] = arr[k] - s.center[0];
					arr[k+1] = arr[k+1] - s.center[1];
				}
			}				
			s.rotated = true;
			trace(s.x,s.y);
			var tmpx:Number = 0;
			var tmpy:Number = 0;
			for(var i:int=0;i<arr.length;i=i+2){
				tmpx = arr[i];
				tmpy = arr[i+1];
				trace(tmpx,tmpy);
				arr[i] = tmpx*Math.cos(Math.PI/6)-tmpy*Math.sin(Math.PI/6);
				arr[i+1] = tmpx*Math.sin(Math.PI/6)+tmpy*Math.cos(Math.PI/6);
			}
			var copy:Array = new Array();
			copy.push(arr);
			s.coords = copy;
			if(s.geotype == GEOTYPES.POLYGON){
//				DrawRings(s,s.coords as Array,a.symbol);
				this.DrawPolygons(s,s.coords as Array,Util.color.polygon,Util.transLevel.polygon);
			}
			else if(s.geotype == GEOTYPES.LINE){
//				DrawLns(s,s.coords as Array,a.symbol);
				this.DrawLines(s,s.coords as Array,Util.color.line,Util.transLevel.line);				
			}		
		}
		
		public function getCenter(arr:Array):Array{
			var x:Number = 0;
			var y:Number = 0;
			for(var i:int=0;i<arr.length;i=i+2){
				x += arr[i];
				y += arr[i+1];
			}
			x = x/(arr.length/2);
			y = y/(arr.length/2);
			var a:Array = new Array();
			a.push(x);
			a.push(y);
			return a;
		}
		
//		private function DrawLns(shape:GeoShape,arr:Array,symbol:Symbol):void
//		{
//			var g:Graphics=shape.graphics;
//			
//			g.clear();
//			for(var i:int=0;i<arr.length;i++)
//			{
//				this.DrawLn(shape,arr[i] as Array,symbol);
//			}
//		}
//		
//		private function DrawLn(shape:GeoShape,arr:Array,symbol:Symbol):void
//		{
//			if(arr.length<2)return;
//			var g:Graphics=shape.graphics;		
//			////////////////////////////////////////////////////
//			//use linesymbol method	
////			g.lineStyle(2,0xff00ff,0.8);		
////			for(var i:int=0;i<arr.length-1;i+=2)
////			{
////				if(i==0)g.moveTo(arr[i],arr[i+1]);
////				else g.lineTo(arr[i],arr[i+1]);
////			}
//            //var symbol:LineSymbol=new LineSymbol(this.map,{"_strokeStyle":new StrokeStyle(20,0x00ff00,1),"_lineStyle":new LineStyle(10,3,5,2)});
//            symbol.DrawLine(shape,arr);
//		}
//		
//		//和EditPanel中重复了
//		private function DrawRings(shape:GeoShape,lineRings:Array,symbol:Symbol):void
//		{
//			var g:Graphics=shape.graphics;
//			
//			g.clear();
//
//			for(var i:int=0;i<lineRings.length;i++)
//			{
//				this.DrawRing(shape,lineRings[i],symbol);
//			}
//		}
//
//		private function DrawRing(shape:GeoShape,lineRing:Array,symbol:Symbol):void
//		{
//			if(lineRing.length<2)return;
//			var g:Graphics=shape.graphics;
//			//////////////////////////////////////////////////
//			//use polygonsymbol method
////			g.beginFill(color,transLevel);
////			for(var i:int=0;i<lineRing.length-1;i+=2)
////			{
////				if(i!=0)
////				{
////					g.lineTo(lineRing[i],lineRing[i+1]);
////				}
////				else
////				{
////					g.moveTo(lineRing[i],lineRing[i+1]);
////				}
////			}
////			g.endFill();
//            //symbol:PolygonSymbol=new PolygonSymbol(this.map,{"_strokeStyle":new StrokeStyle(2,0xffff00,1),"_fillStyle":new FillStyle(0xff00ff,.5)});
//             trace(shape.x,shape.y);
//						    for(var m:int=0;m<(shape.coords as Array).length;m++){
//						    	var tmp:Array = shape.coords[m] as Array;
//						    	for(var n:int=0;n<tmp.length;n=n+2){
//						    		trace("!! "+tmp[n],tmp[n+1]);
//						    	}
//						    } 
//            symbol.DrawPolygon(shape,lineRing);
//		}
		
		public function RemoveRotateEvent():void{
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
						
						shape.removeEventListener(MouseEvent.CLICK,StartRotate);					
					}					
				}				

			}
		}
		
		public function RedefineCoordinate():void{
			var s:Sprite=this.map.layerContainer;			
			var lcount:int=s.numChildren;//矢量图层数			
			var slayer:Vector;//图层是Sprite
			var shape:GeoShape;		
			for(var i:int=0;i<lcount;i++)
			{
				trace(lcount);				
				slayer=s.getChildAt(i) as Vector;	
				
				if(slayer) {
					var symbol:Symbol = slayer.symbol;				
					for(var j:int=0;j<slayer.sprite.numChildren;j++)
					{
						trace(slayer.sprite.numChildren);
						shape=slayer.sprite.getChildAt(j) as GeoShape;	
						//if(shape.x!=0||shape.y!=0){
						if(shape.rotated){
							shape.rotated = false;
							shape.x = 0;
						    shape.y = 0;
						    trace(shape.center[0],shape.center[1]);
						    var arr:Array = shape.coords as  Array;
						    arr = arr[0];
						    for(var k:int=0;k<arr.length;k=k+2){
						    	//trace(arr[i],arr[i+1]);
							    arr[k] = arr[k] + shape.center[0];
							    arr[k+1] = arr[k+1] + shape.center[1];
							    //trace(arr[i],arr[i+1]);
						    }
						    var copy:Array = new Array();
						    copy.push(arr);
						    shape.coords = copy;
						    if(shape.geotype == GEOTYPES.POLYGON){
//						    	DrawRings(shape,shape.coords as Array,symbol);
				    			this.DrawPolygons(shape,shape.coords as Array,Util.color.polygon,Util.transLevel.polygon);								   
						    }
						    else if(shape.geotype == GEOTYPES.LINE){
//						    	DrawLns(shape,shape.coords as Array,symbol);
				    
   								this.DrawLines(shape,shape.coords as Array,Util.color.line,Util.transLevel.line);						    
						    }
						}
						if(!shape.isLLcoords){
							shape.coords = this.antiPMultiData(shape.coords as Array);
							shape.isLLcorrds = true;				
						}	
					}
				}
			}
		}
		
		
	// 面的编辑状态
		private function DrawPolygons(shape:GeoShape,lineRings:Array,color:uint,transLevel:Number):void
		{//[[],[]]	
			var g:Graphics=shape.graphics;
//			shape.x=0;//因为当拖动之后，shape:GeoShape的x,y坐标发生了变化，但是它所带有的coords属性还是按照x=0,y=0计算的
//			shape.y=0;
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
//			shape.x=0;//因为当拖动之后，shape:GeoShape的x,y坐标发生了变化，但是它所带有的coords属性还是按照x=0,y=0计算的
//			shape.y=0
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
		
				private function DrawLns(shape:GeoShape,arr:Array,symbol:Symbol):void
		{
			var g:Graphics=shape.graphics;
			
			g.clear();
			for(var i:int=0;i<arr.length;i++)
			{
				DLine(shape,arr[i] as Array,symbol);
			}
		}
		
		private function DLine(shape:GeoShape,arr:Array,symbol:Symbol):void
		{
			if(arr.length<2)return;
			var g:Graphics=shape.graphics;		

            symbol.DrawLine(shape,arr);
		}
		
		//和EditPanel中重复了
		private function DrawRings(shape:GeoShape,lineRings:Array,symbol:Symbol):void
		{
			var g:Graphics=shape.graphics;
			
			g.clear();

			for(var i:int=0;i<lineRings.length;i++)
			{
				DrawRing(shape,lineRings[i],symbol);
			}
		}

		private function DrawRing(shape:GeoShape,lineRing:Array,symbol:Symbol):void
		{
			if(lineRing.length<2)return;
			var g:Graphics=shape.graphics;
			
						    for(var m:int=0;m<(shape.coords as Array).length;m++){
						    	var tmp:Array = shape.coords[m] as Array;
						    	for(var n:int=0;n<tmp.length;n=n+2){
						    		trace("!! "+tmp[n],tmp[n+1]);
						    	}
						    } 
            symbol.DrawPolygon(shape,lineRing);
		}				
	}
}