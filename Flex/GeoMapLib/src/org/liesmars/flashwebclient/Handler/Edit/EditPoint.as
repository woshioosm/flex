package org.liesmars.flashwebclient.Handler.Edit
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.liesmars.flashwebclient.GEOTYPES;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Handler.Edit;
	import org.liesmars.flashwebclient.Layer.Vector;
	import org.liesmars.flashwebclient.Util;
		
	public class EditPoint extends Edit
	{
		public var delPts:Array = new Array();
		public var delAddedPts:Array = new Array();
		
		public function EditPoint(map:GeoMap, options:Object)
		{
			super(map, options);
		}
		
		public override function Active():void
		{
			//以防编辑没有保存
			if(this.map.dHandler && this.map.dHandler.isActive){this.map.dHandler.Deactive();}
			
//			if(this.map.evtObj && this.map.evtObj.x>=0){this.map.EvtObjMoveAway();}
			if(this.map.eHandler && this.map.eHandler.isActive)
			{
				var edit:Edit=this.map.eHandler as Edit;
				edit.removeControlPts();
				edit.Deactive();
			}
			
			this.ShapeListeners(true);	
			this.map.sprite.addEventListener(MouseEvent.MOUSE_DOWN,this.canvasmd);
			super.Active();
		}
		
		public override function Deactive():void
		{
			this.RemoveExtraCtrlPst();
			this.ShapeListeners(false);
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_DOWN,this.canvasmd);
			super.Deactive();
		}
		
		public function canvasmd(e:MouseEvent):void
		{
			this.removeControlPts();
			this.target=null;
		}
		
		public function ShapeListeners(addListeners:Boolean):void
		{
			var s:Sprite=this.map.layerContainer;			
			var lcount:int=s.numChildren;//矢量图层数			
			var slayer:Vector;//图层是Sprite
			var shape:GeoShape;
			//trace(lcount);		
			for(var i:int=0;i<lcount;i++)
			{				
				slayer=s.getChildAt(i) as Vector;	
				if(slayer)				{
					for(var j:int=0;j<slayer.sprite.numChildren;j++)
					{
						shape=slayer.sprite.getChildAt(j) as GeoShape;		
						if(shape) {
							if(addListeners) {
								if(shape.isLLcoords){
								    shape.coords = this.PMultiData(shape.coords as Array);
								    shape.isLLcorrds = false;
							    }
								shape.addEventListener(MouseEvent.MOUSE_DOWN,this.BindAddAPt);		 
							} else {
								if(!shape.isLLcoords) {
								    shape.coords = this.antiPMultiData(shape.coords as Array);
								    shape.isLLcorrds = true;		
								}
							shape.removeEventListener(MouseEvent.MOUSE_DOWN,this.BindAddAPt);			
					    }	
					}			
					}
				}

			}			
		}
		
		public function AddByIndex(index:Array,p:Point):void
		{
		    trace("add by index");
			if(this.target)
			{
				var coords:Array=this.target.coords as Array;
				
                var a:Array = coords[0] as Array;
                trace(a.length);
                
				var arr:Array=Util.InsertArr(index[1]+2,coords[index[0]],[p.x,p.y]);
				//updated by chzx
				if(this.target.geotype ==GEOTYPES.POLYGON){arr.pop();arr.pop();}
				this.target.coords[index[0]]=arr;				
				
				//////
				var s:GeoShape=new GeoShape();			
				this.target.parent.addChild(s);				
				this.controlPts.push(s);
				s.coords=[p.x,p.y];					
				s.graphics.beginFill(0x00ff01,0.8);
				s.graphics.drawCircle(p.x,p.y,8);
				s.graphics.endFill();
				this.target.parent.addChild(s);				
				s.addEventListener(MouseEvent.MOUSE_DOWN,this.controlMD,false,0,true);
				//////
				//updated by chzx
				//this.map.delAddedPts.push(this.target,s);
				this.delAddedPts.push(this.target,s);
				
				if(this.target.geotype==GEOTYPES.LINE)
				this.DrawLines(this.target,this.target.coords as Array,Util.color.line,Util.transLevel.line);
				//else if(this.target.geotype==GEOTYPES.POLYGON)this.DrawRings(this.target,this.target.coords as Array,Util.color.polygon,Util.transLevel.polygon);
			    else if(this.target.geotype==GEOTYPES.POLYGON)this.DrawPolygons(this.target,this.target.coords as Array,Util.color.polygon,Util.transLevel.polygon);
			}
		}
		
		public function BindAddAPt(e:MouseEvent):void
		{			
			if(this.target!=e.target)
			{
				if(this.controlPts.length>0){
					this.removeControlPts();
				}
				
				this.target=e.target as GeoShape;
			}
//			trace(this.target.geotype );
//			var t:Array = this.target.coords as Array;
//			trace(t.length);
			if(this.controlPts.length==0){
			    this.showControlPts(this.target.coords as Array);	
			}
			
			var shp:GeoShape=e.target as GeoShape;
			var p:Point=shp.globalToLocal(new Point(e.stageX,e.stageY));
			
			var r:Array=this.OnWhichRing(p,shp.coords as Array);
			
			if(r[0]>=0)//返回结果有效，在边界线上
			{	
				this.AddByIndex(r,p);		//改变coords的方法有问题		
			}
			e.stopPropagation();
		}
		
		//二维数组
		public function OnWhichRing(p:Point,coords:Array):Array
		{
			//trace(coords.length); //coords.length = 1
			for(var i:int=0;i<coords.length;i++)
			{
				var coord:Array=coords[i] as Array;
				
				var index:Number=this.OnTheLine(p,coord);
				for(var j:int = 0;j<coord.length;j++){
					trace(coord[j])
				}
				if(index>=0)return [i,index];
			}
			return [-1,-1];
		}
		//一维数组,判断还需改进,尽量减少计算量
		public function OnTheLine(p:Point,cord:Array):int
		{
			//(x1-x2)(y-y0)=k  (y1-y2)(x-x0)=k
			var coord:Array=cord;
			if(this.target.geotype==GEOTYPES.POLYGON){coord.push(cord[0],cord[1]);}
			
			for(var i:int=0;i<coord.length-3;i+=2)
			{
				var x_ok:Boolean=p.x>Math.min(coord[i],coord[i+2]) && p.x<Math.max(coord[i],coord[i+2]);
				var y_ok:Boolean=p.y>Math.min(coord[i+1],coord[i+3]) && p.y<Math.max(coord[i+1],coord[i+3]);
				
				
				if(x_ok && y_ok)
				{
					var k:Number=10;//水平方向或者竖直方向的差距
					k=k*(Math.max(Math.abs(coord[i]-coord[i+2]),Math.abs(coord[i+1]-coord[i+3])));
					
					//直接叉乘算了，以减少计算量，关键是不能开方之类的
					var d:Number=(coord[i+1]-coord[i+3])*(p.x-coord[i])+(coord[i]-coord[i+2])*(coord[i+1]-p.y);
					
					if(Math.abs(d)<k)return i;
				}
				else 
				{
					var x_h_:Number=Math.abs(coord[i]-coord[i+2]);//垂直
					var y_v_:Number=Math.abs(coord[i+1]-coord[i+3]);//水平
					if(x_h_<8)
					{
						x_ok=p.x>Math.min(coord[i],coord[i+2]) -5&& p.x<Math.max(coord[i],coord[i+2])+5;
						
					}
					//else if(y_v_<8) updated by chzx ??
					if(y_v_<8)
					{
						y_ok=p.y>Math.min(coord[i+1],coord[i+3]) -5&& p.y<Math.max(coord[i+1],coord[i+3])-5;
					}
					if(x_ok && y_ok)
					{
						k=10;//水平方向或者竖直方向的差距
						k=k*(Math.max(Math.abs(coord[i]-coord[i+2]),Math.abs(coord[i+1]-coord[i+3])));
					
						//直接叉乘算了，以减少计算量，关键是不能开方之类的
						d=(coord[i+1]-coord[i+3])*(p.x-coord[i])+(coord[i]-coord[i+2])*(coord[i+1]-p.y);
					
						if(Math.abs(d)<k)return i;
					}
				}
			}
			
			if(this.target.geotype==GEOTYPES.POLYGON){coord.pop();coord.pop();}
			return -1;
		}
		
		public function showControlPts(coords:Array):void
		{			
			if(this.controlPts.length>0)return;
			if(!coords)return;
			//trace(coords.length);
			for(var i:int=0;i<coords.length;i++)
			{
				var coord:Array=coords[i] as Array;
				for(var j:int=0;j<coord.length-1;j+=2)
				{
					var s:GeoShape=new GeoShape();
					
					s.coords=[coord[j],coord[j+1]];
					this.controlPts.push(s);
					s.graphics.beginFill(0x00ff01,0.8);
					s.graphics.drawCircle(coord[j],coord[j+1],5);
					s.graphics.endFill();
					this.target.parent.addChild(s);
					
					//updated by chzx
					
					//this.map.delPts.push(this.target,s);
					this.delPts.push(this.target,s);
					
					s.addEventListener(MouseEvent.MOUSE_DOWN,this.controlMD,false,0,true);
				}
			}			
		}
		
		//删除之后重画
		public function controlMD(e:MouseEvent):void
		{
			trace("ctr md");
			var ctrpt:GeoShape=e.target as GeoShape;
			var localpt:Point=new Point(ctrpt.coords[0],ctrpt.coords[1]);
			var index:Array=this.WhichToDel(localpt,this.target.coords as Array);
			if(index[0]<0){trace("index=[-1,-1]");return;}
			this.RemoveByIndex(index);
			//先搞掉控制点
			for(var i:int=0;i<this.controlPts.length;i++)
			{
				if(this.controlPts[i]==e.target)
				{
					this.controlPts=Util.RemoveAItem(this.controlPts,i);
					var shp:GeoShape=e.target as GeoShape;
					shp.parent.removeChild(shp);
					break;
				}
			}
			//然后重绘
			if(this.target.geotype==GEOTYPES.LINE)
			this.DrawLines(this.target,this.target.coords as Array,Util.color.line,Util.transLevel.line);
			//else if(this.target.geotype==GEOTYPES.POLYGON)this.DrawRings(this.target,this.target.coords as Array,Util.color.polygon,Util.transLevel.polygon);
			else if(this.target.geotype==GEOTYPES.POLYGON)this.DrawPolygons(this.target,this.target.coords as Array,Util.color.polygon,Util.transLevel.polygon);
			e.stopImmediatePropagation();//免得canvas上的md把控制点都搞掉了
		}
		
		//二维数组
		public function WhichToDel(p:Point,coords:Array):Array
		{
			for(var i:int=0;i<coords.length;i++)
			{
				var coord:Array=coords[i] as Array;
				for(var j:int=0;j<coord.length-1;j+=2)
				{
					if(coord[j]==p.x && coord[j+1]==p.y)return [i,j];
				}
			}
			return [-1,-1];
		}
		
		public function RemoveByIndex(index:Array):void
		{
			if(this.target)
			{
				var coords:Array=this.target.coords as Array;
				var arr:Array=Util.RemoveMutiItems(coords[index[0]],index[1],index[1]+1);
				this.target.coords[index[0]]=arr;
			}
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
		
		// 删除多余的控制点，多余的控制点是 显示控制点 和添加控制点 这两个方法中添加到layer中，但没有被删去
		public function RemoveExtraCtrlPst():void{
//			for(var i:int = 0;i<this.map.delPts.length;i=i+2){
//				var src:GeoShape = this.map.delPts[i] as GeoShape;
//				var delTarget:GeoShape = this.map.delPts[i+1] as GeoShape;
//				//updated by Chzx 在removecontrolpts中 可能有些点已经从父容器中移除了
//				if(src.parent.contains(delTarget)){
//					src.parent.removeChild(delTarget);
//				}
//			}
//			this.map.delPts = [];
            for(var i:int = 0;i<this.delPts.length;i=i+2){
				var src:GeoShape = this.delPts[i] as GeoShape;
				var delTarget:GeoShape = this.delPts[i+1] as GeoShape;
				//updated by Chzx 在removecontrolpts中 可能有些点已经从父容器中移除了
				if(src.parent.contains(delTarget)){
					src.parent.removeChild(delTarget);
				}
			}
			this.delPts = [];
			
//			for(var i:int = 0;i<this.map.delAddedPts.length;i=i+2){
//				var src:GeoShape = this.map.delAddedPts[i] as GeoShape;
//				var delTarget:GeoShape = this.map.delAddedPts[i+1] as GeoShape;
//				//updated by Chzx 在removecontrolpts中 可能有些点已经从父容器中移除了
//				if(src.parent.contains(delTarget)){
//					src.parent.removeChild(delTarget);
//				}
//			}
//          this.map.delAddedPts = [];
            for(var i:int = 0;i<this.delAddedPts.length;i=i+2){
				var src:GeoShape = this.delAddedPts[i] as GeoShape;
				var delTarget:GeoShape = this.delAddedPts[i+1] as GeoShape;
				//updated by Chzx 在removecontrolpts中 可能有些点已经从父容器中移除了
				if(src.parent.contains(delTarget)){
					src.parent.removeChild(delTarget);
				}
			}
			this.delAddedPts = [];
            
		}	
		public override function removeControlPts():void
		{
			for(var i:int=0;i<this.controlPts.length;i++)
			{
				var p:Sprite=this.controlPts[i] as Sprite;
				if(p.parent){
					p.parent.removeChild(p);
				}
				
			}
			this.controlPts=[];
		}	
		
	}
}