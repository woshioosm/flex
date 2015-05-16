package org.liesmars.flashwebclient.Handler.Edit
{
	import org.liesmars.flashwebclient.Handler.Edit;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import org.liesmars.flashwebclient.Layer.Vector;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;	
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import flash.geom.Point;
	import flash.display.Graphics;
	import org.liesmars.flashwebclient.GEOTYPES;	
	import org.liesmars.flashwebclient.Util;	
	/*
	 *编辑矢量对象 
	 */
	public class EditShape extends Edit
	{	
		public var ctrIndex:Array=[-1,-1];
		public var currentCtrPt:GeoShape;	
		public var targetDrag:Boolean=false;
		public var settimeout:uint=0;
		
		public function EditShape(map:GeoMap,options:Object)
		{
			super(map,options);			
		}
		
		public override function Active():void
		{
			
			var s:Sprite=this.map.layerContainer;			
			var lcount:int=s.numChildren;//矢量图层数			
			var slayer:Sprite;//图层是Sprite
			var shape:GeoShape;
			
			trace("图层数："+lcount);
			//this.map.evtObj.parent.removeChild(this.map.evtObj);			
			for(var i:int=0;i<lcount;i++)
			{				
				slayer=s.getChildAt(i) as Sprite;	
				trace("图层"+i+"的元素个数:"+slayer.numChildren);	
				if(slayer) {
					for(var j:int=0;j<slayer.numChildren;j++)
					{
						shape=slayer.getChildAt(j) as GeoShape;
//						trace("coords:"+shape.coords);		
						
						if(shape) {
							if(shape.isLLcoords) {
						
								shape.coords = this.PMultiData(shape.coords as Array);
								shape.isLLcorrds = false;
							}
							shape.addEventListener(MouseEvent.MOUSE_OVER,mouseover);
							shape.addEventListener(MouseEvent.MOUSE_OUT,mouseout);	
							shape.addEventListener(MouseEvent.MOUSE_DOWN,this.mousedown);
							if(shape.geotype.toUpperCase().indexOf("POINT")<0){
								shape.addEventListener(MouseEvent.MOUSE_UP,this.mouseup);
							}	
						}			
			
					}					
				}
						

			}			
			super.Active();
		}		
		public override function Deactive():void
		{
			trace("edit deactive");
			var lcount:int=this.map.layerContainer.numChildren;
			var s:Sprite=this.map.layerContainer;
			var slayer:Sprite;
			var shape:GeoShape;
			for(var i:int=0;i<lcount;i++)
			{
				slayer=s.getChildAt(i) as Sprite;
				
				if(slayer) {
					for(var j:int=0;j<slayer.numChildren;j++)
					{
						shape=slayer.getChildAt(j) as GeoShape;	
						if(shape) {
							if(!shape.isLLcoords) {
								shape.coords = this.antiPMultiData(shape.coords as Array);
								shape.isLLcorrds = true;	
							}
							shape.removeEventListener(MouseEvent.MOUSE_OVER,mouseover);
							shape.removeEventListener(MouseEvent.MOUSE_OUT,mouseout);	
							shape.removeEventListener(MouseEvent.MOUSE_DOWN,this.mousedown);
							shape.removeEventListener(MouseEvent.MOUSE_UP,this.mouseup);
						}				
					
					}					
				}

			}
			//this.map.eHandler=null;			
			super.Deactive();
		}
		//js传代码进来
		public function doubleclick():void
		{}
		public function mouseover(e:MouseEvent):void
		{
			//this.mstate.isdown 正在拖动某个控制点
			//this.targetDrag 正在整体拖动某个GeoShape
			if(this.mstate.isdown || this.targetDrag)return;
			var target:GeoShape=e.target as GeoShape;
			if(!target)return;
			target.filters=this.filters;
			
			this.target=target;
			//trace(this.target.geotype);
			if(this.target.geotype==GEOTYPES.POINT)return;
						
			this.showControlPts(target.coords as Array);
			
		}
		public function mouseout(e:MouseEvent):void
		{
			if(this.mstate.isdown || this.targetDrag)return;
			var target:GeoShape=e.target as GeoShape;
			this.settimeout=setTimeout(lazyExec,100);
		}
		public function lazyExec():void
		{
			if(!this.target)return;
			this.ParentsMouse();
			this.target.filters=null;
			this.target=null;
			this.removeControlPts();
		}
		public function mousemove(e:MouseEvent):void	
		{}
		public function mousedown(e:MouseEvent):void
		{
			trace("down");
			if(!this.target)this.target=e.target as GeoShape;			
			this.targetDrag=true;
			
			//this.mstate.isdown=true;
			this.target.startDrag();
			this.mstate.x=e.stageX;
			this.mstate.y=e.stageY;				
			if(this.target.geotype==GEOTYPES.POINT)
			{
				this.map.sprite.stage.addEventListener(MouseEvent.MOUSE_UP,ptStop);
				return;
			}	
			if(this.controlPts)this.removeControlPts();
		}
		///点的编辑还要看看
		public function ptStop(e:MouseEvent):void
		{
			if(this.targetDrag)
			{
				this.targetDrag=false;
				this.target.stopDrag();
				
				for(var i:int=0;i<this.target.coords.length-1;i+=2)
				{
					this.target.coords[i]+=e.stageX-this.mstate.x;
					this.target.coords[i+1]+=e.stageY-this.mstate.y;
				}
				this.mstate.x=-10000;//随便去的比较小的负数
				this.mstate.y=-10000;
				//this.mstate.isdown=false;
			}
		}
		public function mouseup(e:MouseEvent):void
		{
			trace(this.targetDrag);
			if(this.targetDrag)
			{
				//整体拖动				
				//if(!this.target)return;
				this.target.stopDrag();
				this.targetDrag=false;				
				var arr:Array=this.target.coords as Array;
				for(var i:int=0;i<arr.length;i++)
				{
					var coord:Array=arr[i] as Array;
					for(var j:int=0;j<coord.length-1;j+=2)
					{
						coord[j]+=e.stageX-this.mstate.x;
						coord[j+1]+=e.stageY-this.mstate.y;
						trace(coord[j],coord[j+1]);
					}					
				}
				this.mstate.x=-10000;//随便去的比较小的负数
				this.mstate.y=-10000;
				//this.target.coords=arr;
				
				this.showControlPts(arr);					
			}
		}
		public function showControlPts(coords:Array):void
		{	
			if(this.controlPts.length>0)return;
			
			if(!coords)return;
			trace("showControlsPts:"+coords);
			var single:Boolean=false;
			for(var i:int=0;i<coords.length;i++)
			{
				trace("c:"+coords[i])
				var coord:Array=coords[i] as Array;
				if(coord)
				{
					for(var j:int=0;j<coord.length-1;j+=2)
					{
						var s:GeoShape=new GeoShape();
						this.controlPts.push(s);
						s.coords=[coord[j],coord[j+1]];
						
						s.graphics.beginFill(0xffff55,this.transLevel);
						s.graphics.drawCircle(coord[j],coord[j+1],this.raduis);
						s.graphics.endFill();
						this.target.parent.addChild(s);
						
						s.addEventListener(MouseEvent.MOUSE_OVER,this.controlMouseover,false,0,true);				
						
						//s.addEventListener(MouseEvent.MOUSE_DOWN,this.controlMD,false,0,true);
						//s.addEventListener(MouseEvent.MOUSE_OUT,this.controlMouseout,false,0,true);
					}
				}
				else
				{
					single=true;
				}
			}	
			if(single)
			{
				for(i=0;i<coords.length-1;i+=2)
				{					
					s=new GeoShape();
					this.controlPts.push(s);
					s.coords=[coords[i],coords[i+1]];
					
					s.graphics.beginFill(0xffff55,this.transLevel);
					s.graphics.drawCircle(coords[i],coords[i+1],this.raduis);
					s.graphics.endFill();
					this.target.parent.addChild(s);						
					s.addEventListener(MouseEvent.MOUSE_OVER,this.controlMouseover,false,0,true);				
				}	
			}		
		}
		public function controlMouseover(e:MouseEvent):void
		{	//e.stopImmediatePropagation();
			if(!this.settimeout==0){
				clearTimeout(this.settimeout);
			}
			
			var ctrpt:Sprite=e.target as Sprite;
			ctrpt.addEventListener(MouseEvent.MOUSE_DOWN,controlMD,false,0,true);
			ctrpt.addEventListener(MouseEvent.MOUSE_OUT,controlMouseout,false,0,true);	
			ctrpt.doubleClickEnabled=true;
			ctrpt.addEventListener(MouseEvent.DOUBLE_CLICK,this.controlDC);
			//ctrpt.addEventListener(MouseEvent.MOUSE_UP,controlMU);	
			this.map.sprite.stage.addEventListener(MouseEvent.MOUSE_UP,controlMU);
			
			this.ParentsMouse();
			/*
			trace(this.target.parent.mouseEnabled);
			trace(this.target.parent.name);
			trace(this.map.vector.contains(this.target.parent.parent));
			trace("pp:"+this.target.parent.parent.numChildren);
			trace(this.map.vector.contains(this.target.parent.parent.parent));
			trace("ppp:"+this.target.parent.parent.parent.numChildren);*/
		}
		public function ParentsMouse():void
		{
			var f:Boolean=!this.map.layerContainer.mouseEnabled;
			if(!this.target)return;
			this.target.parent.mouseEnabled=f;
			this.map.layerContainer.mouseEnabled=f;
			this.map.viewPort.mouseEnabled=f;
			this.map.sprite.mouseEnabled=f;
		}
		public function controlMouseout(e:MouseEvent):void
		{
			if(!this.mstate.isdown)
			this.lazyExec();
		}
		public function controlMD(e:MouseEvent):void
		{
			this.mstate.isdown=true;			
			this.currentCtrPt=e.target as GeoShape;
			this.ctrIndex=this.getCtrPtIndex(this.currentCtrPt,this.target.coords);
			this.currentCtrPt.startDrag();	
			
			this.target.stage.addEventListener(MouseEvent.MOUSE_UP,this.controlMU,false,0,true);
			this.target.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.controlMM,false,0,true);
					
		}
		public function controlMU(e:MouseEvent):void
		{
			//e.stopImmediatePropagation();
			if(this.mstate.isdown)
			{
				this.target.stage.removeEventListener(MouseEvent.MOUSE_UP,this.controlMU);
				this.target.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.controlMM);
			
				this.mstate.isdown=false;	
				this.ctrIndex=[-1,-1];
				this.currentCtrPt.stopDrag();
				this.currentCtrPt=null;
				this.removeControlPts();
			}		
		}
		public function controlMM(e:MouseEvent):void//在stage上的事件
		{
			//e.stopImmediatePropagation();
			if(this.mstate.isdown)
			{
				//if(!this.target)return;
				var p:Point=this.target.globalToLocal(new Point(e.stageX,e.stageY));
				this.target.coords[this.ctrIndex[0]][this.ctrIndex[1]]=p.x;
				this.target.coords[this.ctrIndex[0]][this.ctrIndex[1]+1]=p.y;
				this.target.graphics.clear();				
				this.ReDraw();
			}
		}
		public function ReDraw():void
		{
			var o:Array=this.target.coords as Array;
			if(this.target.geotype==GEOTYPES.POLYGON){
				this.DrawRings(this.target,o,this.color,this.transLevel);
			}
			else if(this.target.geotype==GEOTYPES.LINE){
				this.DrawLines(this.target,o,this.color,this.transLevel);
			}
		}
		public function controlDC(e:MouseEvent):void
		{
			trace("dc");
			var a:Array=Util.RemoveAItem(this.target.coords[this.ctrIndex[0]] as Array,this.ctrIndex[1]);
			this.target.coords[this.ctrIndex[0]]=a;
			this.ReDraw();
		}
		public function getCtrPtIndex(pt:GeoShape,coo:Object):Array
		{		//[[],[]]	
			var coords:Array=coo as Array;
			//var ptArr:Array=pt.coords as Array;
			for(var i:int=0;i<coords.length;i++)
			{
				var coord:Array=coords[i] as Array;
				for(var j:int=0;j<coord.length-1;j+=2)
				{
					if(pt.coords[0]==coord[j] && pt.coords[1]==coord[j+1])
					{trace([i,j]);return [i,j];}
				}				
			}
			return [-1,-1];
		}
		public function replaceAPt(pt:Array,index:int,coo:Object):Object
		{
			var coords:Array=coo as Array;
			if(index<0 || index>coords.length)return coo;
			coo[index]=pt;
			return coo;
		}
		//使用的是相对坐标
		private function DrawRings(shape:GeoShape,lineRings:Array,color:uint,transLevel:Number):void
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
		
		private function DrawLines(shape:GeoShape,lineRings:Array,color:uint,transLevel:Number):void
		{//[[],[]]	
			var g:Graphics=shape.graphics;
			shape.x=0;//因为当拖动之后，shape:GeoShape的x,y坐标发生了变化，但是它所带有的coords属性还是按照x=0,y=0计算的
			shape.y=0;
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
		
	}
}