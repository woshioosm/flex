package org.liesmars.flashwebclient.Handler 
{
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	
	import org.liesmars.flashwebclient.BaseTypes.*;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Handler;
	import org.liesmars.flashwebclient.Layer.Vector;
	//能够处理多个不连续线段构成一条线的情况，双击则重新开始画线段，右键整个线对象才结束
	
	/*
	*矢量的绘制 
	*/
	public class Draw extends Handler
	{
		public var drawState:String;
		public var layer:Vector;//画出来的东西就放在这里头，这个容器是可以外部指定的
		public var rightMenu:ContextMenu=null;	
		public var objs:Array=[];//应该放到map中比较好
		public var obj:Array=[];//当前坐标串
		public var color:uint=0xcc0101;
		public var filter:Object={"mouseover":new DropShadowFilter(),"mouseout":null};//当鼠标经过时候的反应
		public var thick:int=1;
		public var lastpt:Point;
		public var currentShape:GeoShape;
		public var transLevel:Number;
		public var isfirst:Boolean=true;
		
		//public var g:Graphics=new Graphics();//
		
		public function Draw(map:GeoMap,options:Object)
		{
			super(map,options);	
			// 之前是在每次点击绘制按钮时加图层，但用户有可能点击了绘制按钮后不绘制，或者
			// 点击了一个绘制线的按钮后又点击绘制面的按钮，这样便导致了空的图层（没有任何矢量对象）
			// 现在改为当用户开始绘制后才添加图层 在Draw对象中添加了isfirst属性，用于判断用户是否
			// 第一次点击进行绘制，这时才添加一个新的图层
			// 所以将下面的代码进行注释
			//			if(!this.layer)
			//			{
			//				this.layer=new Vector(this.map,null);
			//				//其实应该是this.map.AddLayer(this.layer)，但是目前Layer没有完全抽象出来
			//				this.map.AddLayer(this.layer);
			//			}
		}
		//其实只要evtObj就够了，似乎不要绑定this.map.canvas
		public override function Active():void
		{
			var obj:Sprite;
			/*if(this.map.evtObj)
			{
			obj=this.map.evtObj;			
			obj.addEventListener(MouseEvent.CLICK,this.MD);
			this.map.canvas.stage.addEventListener(MouseEvent.MOUSE_UP,this.MU);
			obj.addEventListener(MouseEvent.MOUSE_MOVE,this.MM);
			
			obj.doubleClickEnabled=true;//为什么dbclick失灵了
			obj.addEventListener(MouseEvent.DOUBLE_CLICK,this.DC);
			}
			else
			{*/ trace("_active_");
			obj=this.map.sprite;			
			obj.addEventListener(MouseEvent.MOUSE_DOWN,this.MD,false,0,true);
			this.map.sprite.stage.addEventListener(MouseEvent.MOUSE_UP,this.MU,false,0,true);
			obj.addEventListener(MouseEvent.MOUSE_MOVE,this.MM,false,0,true);
			obj.doubleClickEnabled=true;
			obj.addEventListener(MouseEvent.DOUBLE_CLICK,this.DC);
			//}
			
			super.Active();
		}
		public override function Deactive():void
		{
			//有时候还没保存数据就离开了
			if(this.obj.length>0 || this.objs.length>0)
			{
				var p:Point=new Point(this.obj[this.obj.length-2],this.obj[this.obj.length-1]);
				//				p=this.map.vector.localToGlobal(p);
				this.ShowDialog(p.x,p.y);
			}
			/*if(this.map.evtObj)
			{
			var obj:Sprite=this.map.evtObj;
			obj.removeEventListener(MouseEvent.MOUSE_DOWN,this.MD);
			this.map.canvas.stage.removeEventListener(MouseEvent.MOUSE_UP,this.MU);
			obj.removeEventListener(MouseEvent.MOUSE_MOVE,this.MM);			
			obj.removeEventListener(MouseEvent.DOUBLE_CLICK,this.DC);
			}
			else
			{*/
			var jp:Sprite=this.map.sprite;			
			jp.removeEventListener(MouseEvent.MOUSE_DOWN,this.MD);
			this.map.sprite.stage.removeEventListener(MouseEvent.MOUSE_UP,this.MU);
			jp.removeEventListener(MouseEvent.MOUSE_MOVE,this.MM);				
			
			jp.removeEventListener(MouseEvent.DOUBLE_CLICK,this.DC);
			//}
			super.Deactive();
		}
		public override function Destroy():void
		{}
		public function MD(event:MouseEvent):void
		{}
		public function MU(event:MouseEvent):void
		{}
		public function MM(event:MouseEvent):void
		{}
		
		public function DC(event:MouseEvent):void
		{		
			trace("dc");	
			this.ShowDialog(event.stageX,event.stageY);
		}
		public function ShowDialog(globex:int,globey:int):void
		{	
			//最后时刻双击的那两点不算
			//this.obj.pop();this.obj.pop();this.obj.pop();this.obj.pop();
			
			this.objs.push(this.obj);
			
			this.obj=[];			
			
			this.lastpt=null;
			this.currentShape.coords=this.objs;
			this.objs=[];
			this.currentShape=null;
			//			var dialog:Dialog=new Dialog(this.map,{});
			//			var p:Point=this.map.ctrLayer.globalToLocal(new Point(globex,globey));
			//			dialog.x=p.x;
			//			dialog.y=p.y;
			//			dialog.v_coord.text=this.currentShape.coords.toString();
			//			this.map.ctrLayer.addChild(dialog);
			this.currentShape=null;
		}
		//		//注册以供回调的函数，其实可以把dbclick也交给js处理
		//		public function BindEvtForRightClick():void
		//		{			
		//			ExternalInterface.addCallback("RightClick",this.RC);
		//			ExternalInterface.call("GeoGlobe.CommWithAS.getEditState",Util.GetClassName(this));
		//		}
		//		//供js调用的函数
		//		public function RC(pt:Array):void
		//		{}	
		
		//buffer参数暂时留着而已
		public function antiPData(pts:Array):Array{
			
			for(var i:uint=0;i<pts.length-1;i=i+2)
			{   
				var px:LonLat = this.map.getLonLatFromLayerPx(new Pixel(pts[i], pts[i+1]));
				pts[i] = px.lon;
				pts[i+1] = px.lat;
			}			
			return pts;
		}	
		public function clear(){
			this.map.vectorLayer.clear();
		}
		public function PData(pts:Array):Array{
			//			var bfr:uint=0;
			//        	var x:Number=bounds.x-bounds.width*bfr;
			//        	var y:Number=bounds.y-bounds.height*bfr;        	
			//        	var realRec:Rectangle=new Rectangle(x,y,(2*bfr+1)*bounds.width,(2*bfr+1)*bounds.height);
			//        	var proportion:Number=Math.min(Math.abs(realRec.width/bbox.width),Math.abs(realRec.height/bbox.height));
			//        	
			//        	var dx:Number=0.001745;
			//        	var dy:Number=-0.000860;
			//        	for(var i:uint=0;i<pts.length-1;i=i+2)
			//        	{   
			//        		pts[i]=(pts[i]-bbox.x+dx)*proportion + realRec.x;
			//        		pts[i+1]=-(pts[i+1]-bbox.y+dy)*proportion + realRec.bottom;
			//        	}
			for(var i:uint=0;i<pts.length-1;i=i+2)
			{   
				var px:Pixel = this.map.getLayerPxFromLonLat(new LonLat(pts[i], pts[i+1]));
				pts[i] = px.x;
				pts[i+1] = px.y;
			}			
			return pts;
		}
		
		public function PMultiData(arr:Array):Array
		{
			var r:Array=[];
			for(var i:int=0;i<arr.length;i++)
			{
				r.push(this.PData(arr[i]));
			}
			return r;
		}
		
	}
}