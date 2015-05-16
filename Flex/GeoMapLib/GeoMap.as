package
{
	//如无非常必要，请勿修改此类
	
	//现在坐标都弄准了，不调了,栅格坐标是没有问题的，取的教准
/*<<<<<<< GeoMap.as*/
	import GeoEvent.ControlEvent;
	import GeoEvent.LayerEvent;
	import GeoEvent.MapEvent.*;
	
	import Handler.*;
	import Handler.Draw.*;
	import Handler.Edit.*;
	
	import Layer.PatchLayer;
	import Layer.Raster;
	import Layer.Raster.*;
	import Layer.Vector;
	import Control.*;
	import Symbol;
	
	import com.adobe.serialization.json.*;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.effects.*;
	import mx.events.TweenEvent;
	
	import org.aswing.*;
	
	[Event(name="addlayer", type="GeoEvent.MapEvent.MapLayerEvent")]
	[Event(name="removelayer", type="GeoEvent.MapEvent.MapLayerEvent")]
	[Event(name="movelayer", type="GeoEvent.MapEvent.MapLayerEvent")]
	[Event(name="hidelayer", type="GeoEvent.MapEvent.MapLayerEvent")]
	[Event(name="showlayer", type="GeoEvent.MapEvent.MapLayerEvent")]
	
	[Event(name="addcontrol", type="GeoEvent.MapEvent.MapControlEvent")]
	[Event(name="removecontrol", type="GeoEvent.MapEvent.MapControlEvent")]
	[Event(name="hidecontrol", type="GeoEvent.MapEvent.MapControlEvent")]
	[Event(name="showcontrol", type="GeoEvent.MapEvent.MapControlEvent")]	
	
	public class GeoMap extends UIComponent
	{		
		public var imgs:Array;
		public var hitObjs:Array=new Array();
		private var canvasMovedX:Number=0; //初始化时候要把canvas的初始偏移量搞进去
		private var canvasMovedY:Number=0;
		private var WIDTH_:Number=1024;
		private var HEIGHT_:Number=768;
		
		private var startCol:int=3;//起始列号 左上角
		private var startRow:int=8;//起始行号
		private var rowsCount:int=0;
		private var colsCount:int=0;
		private var colsMoved:int=0;//x方向移动的格数
		private var rowsMoved:int=0;//y方向移动的格数
		private var startDx:int=0;//x初始偏移，不足一个栅格的偏移量
		private var startDy:int=0;//y初始偏移，不足一个栅格的偏移量
//		public var urlHost:String="http://192.168.1.229";//"http://202.114.114.27";
		public var urlHost:String="http://192.168.2.235";
		//http://202.114.114.27?T=GloImage&L=2&X=11&Y=14
		
		public var canvas:Label = null;//总容器
		public var evtObj:Sprite=null;//用于接收所有的鼠标事件，它不在this.canvas里头
		public var firstCantainer:Sprite=null;//处理图层滑动,容器包含矢量和栅格容器
		//20080706 by zhangxu
		public var background:Sprite = null;
		//
		public var raster:Sprite;//栅格容器，包含在总容器中
		public var vector:Sprite;//矢量容器，包含在总容器中
		public var mark:Sprite;//markImage容器,该图层是必须的，因为raster中某一时刻只能有一个活动图层，但是mark是需要和栅格图层同时显示的
		public var vectorctrpts:Array;//控制矢量加载区域的两个控制点，还是以半个或者一个栅格大小为临界
		private var IMG_WIDTH:int=256;
		private var IMG_HEIGHT:int=256;
		private var ErrImage:String="error.png";
		private var buffer:int=1;
		//private var mstate:Object={"isdown":false,"x":0,"y":0};	//不会装箱拆箱
		private var zooms:Object={"min":0,"max":16};
		public 	var zoom:int=4;  //L  wuhan 14
		private var json:Object=null;
		//如果使用哪个栅格图就把它放在数组的最前面
		private var raster_data:Object=[{"name":"geoglobe","maxRes":0.0703125,"levels":17},{"name":"google","maxRes":1.40625,"levels":17}];
		//GeoGlobal 最开始是18/256=0.0703125
		private var resolutions:Array=[1.40625,0.703125,0.3515625,0.17578125,0.087890625,
							0.0439453125,0.02197265625,0.010986328125,0.0054931640625,0.00274658203125,
							0.001373291015625,0.0006866455078125,0.00034332275390625,0.000171661376953125,
							0.0000858306884765625];
		//美国经纬度范围 ： -124.731422，24.955967   -66.969849，49.371735
		//控件部分
		public var handler:Handler;
		public var dHandler:Draw;
		public var eHandler:Handler;
		public var drawObjects:Array=[];
		//符号化部分
		public var symbol:Symbol;
		public var layers:Array=[];		
		public var controls:Array=[];		
		public var ctrLayer:Sprite;
		public var loadFun:Function=null;
		
		// snapshot 20080703
		private var snapShot:Image;
		
		public function dbclick(e:MouseEvent):void
		{ExternalInterface.call("alert","clk");}
		public function EmptyFn(e:MouseEvent):void
		{/*该函数是用于给this.evtObj绑定处理事件的，本身不做任何处理*/}
		
		public function GeoMap(panel:Label) 
		{	//http://192.168.1.92:8081/Web/wfs?request=GetFeature&typename=topp:states&srs=EPSG:4326&outputFormat=geojson
			//武汉 ：  bbox=114.2,30.5,114.25,30.57
//			Security.allowDomain("*");
//			Security.allowInsecureDomain("*");			
//			AsWingManager.setRoot(this);	
//			
//			this.canvas=panel;		
//			var g:Graphics=this.canvas.graphics;	
			
			//汶川 东经103.4,31.0度 ，GeoBlobe上提供的汶川栅格图到zoom=8  104.291015625,31.904296875  104.4448,31.8255
			//Init();//114.22909955978396,30.606085395812983//-84.7265625, 43.171875

			//20080706 by zhangxu ---divide add layer && control from map's first constructor
			
		//	this.LoadRasterToCenter(new Point(104.291015625,31.904296875));//-84,43  114.21,30.60			
							
		//	this.AddLayer(new Disaster(this,{"layername":"四川地震","hidden":false}));
			
		//	var mlyr:PatchLayer=new PatchLayer(this,{"layername":"补丁OverLayers"});
		//	this.AddLayer(mlyr);	
		//	var amk:PatchImage=new PatchImage(mlyr,{"url":"img/sc.gif","bbox":[104.02734375,31.67578125,104.5546875,32.203125],"minZoom":5,"maxZoom":10});
		//	mlyr.addMark(amk);	       
		//	amk=new PatchImage(mlyr,{"url":"http://202.114.114.41:81/?T=SC4&L=0&X=8086&Y=3468","bbox":[104.2734375,31.88671875,104.30859375,31.921875],"minZoom":7,"maxZoom":12,"alpha":0.8});
		//	mlyr.addMark(amk);			
			//amk=new PatchImage(mlyr,{"url":"frame.gif","bbox":[104.2734375,31.88671875,104.30859375,31.921875],"minZoom":7,"maxZoom":12,"alpha":0.8});
			//mlyr.addMark(amk);		
			
//			var url:String="http://192.168.1.229:8081/geoserver/wfs?bbox=114.2,30.55,114.25,30.6&request=getfeature&service=wfs&version=1.0.0&typename=topp:sc_jinjie&outputFormat=geojson";
//			//var url:String="http://192.168.1.229:8081/geoserver/wfs?bbox=0,0,0,0.6&request=getfeature&service=wfs&version=1.0.0&typename=topp:sc_jinjie&outputFormat=geojson";
//			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
//			this.AddLayer(new Vector(this,{"url":url,"layername":"四川境界","hidden":true,"minZoom":0,"maxZoom":14}));
//			
//			//topp:sc_rivers 
//			url="http://192.168.1.229:8081/geoserver/wfs?bbox=114.2,30.55,114.25,30.6&request=getfeature&service=wfs&version=1.0.0&typename=topp:sc_rivers&outputFormat=geojson";
//			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
//			this.AddLayer(new Vector(this,{"url":url,"layername":"四川河流","hidden":true,"minZoom":3,"maxZoom":14}));
//						
//			url="http://192.168.1.229:8081/geoserver/wfs?bbox=114.2,30.55,114.25,30.6&request=getfeature&service=wfs&version=1.0.0&typename=topp:sc_xianshi&outputFormat=geojson";
//			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
//			this.AddLayer(new Vector(this,{"url":url,"layername":"四川县市","hidden":true,"minZoom":4,"maxZoom":14}));
//			
//			url="http://192.168.1.229:8081/geoserver/wfs?bbox=114.2,30.55,114.25,30.6&request=getfeature&service=wfs&version=1.0.0&typename=topp:sc_wenchuan_respt&outputFormat=geojson";
//			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
//			this.AddLayer(new Vector(this,{"url":url,"layername":"汶川respt","hidden":true,"minZoom":8,"maxZoom":14}));
//			
//			url="http://192.168.1.229:8081/geoserver/wfs?bbox=114.2,30.55,114.25,30.6&request=getfeature&service=wfs&version=1.0.0&typename=topp:sc_cunzhen&outputFormat=geojson";
//			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
//			this.AddLayer(new Vector(this,{"url":url,"layername":"四川村镇","hidden":true,"minZoom":8,"maxZoom":14}));
						
			//this.AddControls([new LayerPanel(this,{}),new DragPan(this,{}),new DrawPanel(this,{}),new EditPanel(this,{})]);//,new DrawPanel(this,{}),new Meansure(this,{}),new EditPanel(this,{})]);
			
			this.SetEvtObj();//主要是检测双击的
			//this.RemoveEvtObj();
			
			this.handler=new Drag(this,null);
			this.handler.Active();			
			
			var key:KeyMoveMap=new KeyMoveMap(this,{});
			key.Active();
			var wheel:WheelZoom=new WheelZoom(this,{});
			wheel.Active();
			//其实所有的事件都可以依然由this.canvas来完成，只是this.evtObj需要捕获这些事件，但是它可以不做任何处理
			//不能让this.evtObj把控件都给盖住了，因此需要注意加载时刻，不过this.canvas和this.ctrLayer属于同一级的容器，可以交换深度
			
			//this.BindContextMenu(this.canvas);	//右键菜单暂时失效了		
			
			this.canvas.doubleClickEnabled=true;
			//this.canvas.addEventListener(MouseEvent.DOUBLE_CLICK,dbclick,false,0,true);					//alert();	
			
			/*加载矢量检测段,放在drag中了*/
			this.SetVectorCtrPts(256,256);
			
			/**/
			/////测试区
			this.canvas.addEventListener(MouseEvent.DOUBLE_CLICK,LL);		//setCentrer()	
						
			//trace(this.GetViewCenterLonLat());
			//trace(this.GetGlobalPixelFromLonLat(new Point(104.291015625,31.904296875)));
			
		}
		
		public function DeactiveAllControl():void
		{
			//trace(this.controls.length);
			for(var i:int=0;i<this.controls.length;i++)
			{
				var ctr:Control=this.controls[i] as Control;
				//trace(ctr[i].toString());
				ctr.Deactive();
			}
		}
		public function DeactiveAllControlExcept(control:Control):void
		{
			trace(this.controls.length);
			for(var i:int=0;i<this.controls.length;i++)
			{
				var ctr:Control=this.controls[i] as Control;
				if(control!=ctr){
					ctr.Deactive();
				}
			}
		}
		public function DeactiveAllBehavior():void
		{
			
		}
		public function LL(e:MouseEvent):void
		{
			var ep:Point=new Point(e.stageX,e.stageY);
			var p:Point=this.GetLonLatFromGlobalPixel(ep);			
			
			trace(p);
			this.SetCenter(p,this.zoom,false);
		}
		
		private function Init():void
		{		    
		    this.firstCantainer=new Label();
		    this.canvas.addChild(this.firstCantainer);
		   //20080706 by zhangxu
			background = new Sprite();
			//this.canvas.addChild(background);
			
			var g:Graphics = background.graphics;
			g.lineStyle(4,0x0099ff,1);
			g.moveTo(0,0);
			g.lineTo(this.canvas.width, 0 );
			g.lineTo(this.canvas.width, this.canvas.height);
			g.lineTo(0,this.canvas.height);
			g.lineTo(0,0);
			
			g.beginFill(0x85db18,1);	
			g.drawCircle(this.canvas.width / 2, this.canvas.height / 2, 5);
			g.endFill();	
			//	

		    if(!this.ctrLayer)
			{
				this.ctrLayer=new Sprite();
				this.canvas.stage.addChild(this.ctrLayer); 
			}
			
			if(!this.raster)
			{
				this.raster=new Sprite();   
				this.firstCantainer.addChild(this.raster);
			}
			if(!this.mark)
			{
				this.mark=new Sprite();
				this.firstCantainer.addChild(this.mark);
			}	
			if(!this.vector)
			{
				this.vector=new Sprite();
				this.firstCantainer.addChild(this.vector);
			}	
			this.firstCantainer.setChildIndex(this.raster,0);
			this.firstCantainer.setChildIndex(this.mark,1);
			this.firstCantainer.setChildIndex(this.vector,2);	
			////////////////设置碰撞对象，检测栅格图位置，看是否需要搬动img/////////////////////////////
			
			//this.SetHitObjs();//--------------------------------------  1 in 3
			
			this.SetResolutions();
		}
		//有些事件要绑定到canvas上
		public function BindContextMenu(s:DisplayObject):void
		{
			var names:Array=["drag","zoomin","zoomout","DrawPoint","DrawLine","DrawPolygon","Edit"];
			var fns:Array=[DragDefault,ZoomIn,ZoomOut,DrawPt,DrawLn,DrawPl,EditVector];
			Util.SetContextMenu(names,fns,s);
		}
		//绑定到专有的事件接收器上，尤其是需要双击的，某人是使用的这个
		public function SetEvtObj():void
		{
			this.evtObj=new Sprite();
			this.evtObj.graphics.beginFill(0xbbb,0);
			this.evtObj.graphics.drawRect(0,0,this.canvas.width,this.canvas.height);
			this.evtObj.graphics.endFill();			
			this.canvas.addChild(this.evtObj);
			
			this.evtObj.doubleClickEnabled=true;
			this.evtObj.addEventListener(MouseEvent.DOUBLE_CLICK,this.EmptyFn,false,0,true);
			//this.evtObj.addEventListener(MouseEvent.CLICK,this.EmptyFn);
			/*this.evtObj.addEventListener(MouseEvent.MOUSE_DOWN,this.EmptyFn);
			this.evtObj.addEventListener(MouseEvent.MOUSE_MOVE,this.EmptyFn);
			this.evtObj.addEventListener(MouseEvent.MOUSE_UP,this.EmptyFn);
			this.evtObj.addEventListener(MouseEvent.MOUSE_OUT,this.EmptyFn);
			this.evtObj.addEventListener(MouseEvent.MOUSE_OVER,this.EmptyFn);*/
		}
		//尚未有数据进行测试，暂且不调试
		//只需要添加进来就行了，不用绑定什么事件,加载或者是重新调整控制点的位置
		public function SetVectorCtrPts(dx:Number,dy:Number):void
		{//lefttop,rightbottom确定的矩形区域就是矢量数据的范围，我们发送请求时候也是要取这么大范围的数据
			var lefttop:Sprite;
			var rightbottom:Sprite;
			if(!this.vectorctrpts || !this.vectorctrpts.length)
			{
				this.vectorctrpts=[];
				lefttop=new Sprite();
				rightbottom=new Sprite();
				this.vectorctrpts.push(lefttop);
				this.firstCantainer.addChild(lefttop);
				this.firstCantainer.addChild(rightbottom);	
				this.vectorctrpts.push(rightbottom);	
			}
			else
			{
				lefttop=this.vectorctrpts[0] as Sprite;
				rightbottom=this.vectorctrpts[1] as Sprite;
			}
			var lt:Point=new Point(this.canvas.x-dx,this.canvas.y-dy);
			var p:Point=this.firstCantainer.globalToLocal(lt);
			lefttop.x=p.x;
			lefttop.y=p.y;
			
			var rb:Point=new Point(this.canvas.x+this.canvas.width+dx,this.canvas.y+this.canvas.height+dy);
			var p1:Point=this.firstCantainer.globalToLocal(rb);
			rightbottom.x=p1.x;
			rightbottom.y=p1.y;
			
		}
		
		/*ok 如何加载的问题*/
		public function VectorDetect(e:MouseEvent):void
		{
			var d:Number=0;
			var x3:int=this.canvas.x-d;
			var y3:int=this.canvas.y-d;
			var x4:int=this.canvas.x+this.canvas.width+d;
			var y4:int=this.canvas.y+this.canvas.height+d;
			
			var lefttop:Point=this.firstCantainer.localToGlobal(new Point(this.vectorctrpts[0].x,this.vectorctrpts[0].y));
			var rb:Point=this.firstCantainer.localToGlobal(new Point(this.vectorctrpts[1].x,this.vectorctrpts[1].y));
			//trace(lefttop);
			if(lefttop.x>x3 || rb.x<x4 ||lefttop.y>y3 ||rb.y<y4)
			{
				this.SetVectorCtrPts(256,256);//SetVectorCtrPts和GetVectorRecToLoad的参数是一样的
				trace("该Reload了<><><><><><><><><><>");
				trace(this.firstCantainer.localToGlobal(new Point(this.vectorctrpts[0].x,this.vectorctrpts[0].y)));
				this.ReLoad(null);
				//this.LoadArea(this.GetVectorRecToLoad(1024,1024));
			}		
		}
		public function GetVectorUrl(box:Array,url:String):String
		{
			if(!box.length==2 || !url)return "";//updated_by_Chzx ???
			var bbox:String="";
			bbox+=box[0].x+",";
			bbox+=box[0].y+",";
			bbox+=box[1].x+",";
			bbox+=box[1].y;
			trace(bbox);
			// ???
			var reg:RegExp=/([\S]+bbox=)([0-9,.,\,]+)([\S]*)/;
			//http://192.168.1.72:8081/geoserver/wfs?bbox=114.2,30.55,114.25,30.6&request=GetFeature&typename=topp:point&srs=EPSG:4326&outputFormat=geojson
			
			return url.replace(reg,"$1"+bbox+"$3");
		}
		//这个暂时不用
		public function LoadArea(arr:Array):void
		{//URL需要根据传进来的参数构建，应该还需要图层之类的
			
			var url:String=this.GetVectorUrl(arr,"");
			
			var request:URLRequest=new URLRequest(url);
			var loader:URLLoader=new URLLoader();//和栅格图加载用到的对象不同
			loader.dataFormat=URLLoaderDataFormat.TEXT;//默认就是TEXT
			loader.addEventListener(Event.COMPLETE,ReLoad,false,0,true);
			loader.addEventListener(IOErrorEvent.IO_ERROR,IoError,false,0,true);
			loader.load(request);
		}
		public function ReLoad(e:Event):void//RecvVector
		{
			//等新的数据到了之后再	再移去图层添加新图层；	removealllayers=true即可
			//199K还是有点卡	
			var urls:Array=[];
			for(var i:int=0;i<this.vector.numChildren;i++)
			{
				var l:Vector=this.vector.getChildAt(i) as Vector;
				urls.push(l.url);
			}			
			//this.RemoveAllLayers();
			
			for(i=0;i<urls.length;i++)
			{
				var url:String=this.GetVectorUrl(this.GetVectorRecToLoad(),urls[i]);	
				//this.AddLayer(new Vector(this,{"url":url,"removealllayers":false}));
				l=this.vector.getChildAt(i) as Vector;
				if(l.visible && l.isValidate(this.zoom))//!l.hidden && l.isValidate(this.zoom)
				{					
					l.Load(url);
				}
				else
				{
					l.Clear();
				}								
			}	
		}	
		public function RemoveAllLayers():void
		{
			for(var i:int=0;i<this.layers.length;i++)
			{
				var l:Vector=this.layers[i] as Vector;
				l.parent.removeChild(l);
			}
			this.layers=[];
		}	
		public function GetVectorRecToLoad():Array
		{//这个也是对的
			var dx_:Number=-0.001745;
        	var dy_:Number=0.000860;
        	
        	var dx:Number=256;//免得外部传入
        	var dy:Number=256;
			var p:Point=new Point();
			var pt:Point=new Point();
			
			var center:Point=this.GetViewCenterLonLat();
			var r:Number=this.GetResolution();
			p.x=center.x-(this.canvas.width/2+dx)*r;
			p.y=center.y-(this.canvas.height/2+dy)*r;
			pt.x=center.x+(this.canvas.width/2+dx)*r;
			pt.y=center.y+(this.canvas.height/2+dy)*r;
			//本来是根据栅格图算准了，但是服务器本身提供的矢量数据有偏差,如果矢量数据配准了，这个就不需要了
			p.x+=dx_;p.y+=dy_;
			pt.x+=dx_;pt.y+=dy_;//这里改了4.14
			
			return [p,pt];
		}
		public function RemoveEvtObj():void
		{
			if(this.canvas.stage.contains(this.evtObj))
			{
				this.evtObj.parent.removeChild(this.evtObj);
				this.BindContextMenu(this.canvas);
			}
		}
		public function DragDefault(event:ContextMenuEvent):void
		{
			//if(this.evtObj.x<0)this.EvtObjRecover();
			
			this.DeactiveAllControl();
			this.handler=new Drag(this,null);
			this.handler.Active();
		}
		
		/**
		 * 
		 * 
		*/
		public function DrawPt():void
		{
			if(this.evtObj.x<0)this.EvtObjRecover();
			
			//this.DeactiveAllControl();
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			this.dHandler=new DrawPoint(this,null);			
			this.dHandler.Active();
		}
		public function DrawLn():void
		{
			if(this.evtObj.x<0)this.EvtObjRecover();
			
			//this.DeactiveAllControl();
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			this.dHandler=new DrawLine(this,null);
			this.dHandler.Active();
		}
		public function DrawPl():void
		{
			if(this.evtObj.x<0)this.EvtObjRecover();
			
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.eHandler){this.eHandler.Deactive();}
			
			//this.DeactiveAllControl();
			this.dHandler=new DrawPolygon(this,{"color":0xcc5599,"transLevel":0.6});
			this.dHandler.Active();
		}
		public function StopDraw():void{
			if(this.dHandler){
			    this.dHandler.Deactive();
			    this.dHandler.Destroy();
			}
		}
		public function EditVector():void
		{
			this.EvtObjMoveAway();
			
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new EditShape(this,{});
			this.eHandler.Active();
			//Util.SetContextMenu(["exit edit"],[ExitEdit],this.canvas);			
		}
		
		public function EditCtrPts():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new EditPoint(this,{});
			this.eHandler.Active();
		}
		
		public function Rotate():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new RotateVector(this,{});
			this.eHandler.Active();
		}
		
		public function Enlarge():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new EnlargeVector(this,{});
			this.eHandler.Active();
		}
		
		
		
		public function Narrow():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			this.eHandler=new NarrowVector(this,{});
			this.eHandler.Active();
		}
		
		public function StopEdit():void{
			this.EvtObjMoveAway();
			//this.DeactiveAllControl();
			if(this.eHandler){this.eHandler.Deactive();this.eHandler.Destroy();}
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			if(this.handler){this.handler.Deactive();this.handler.Destroy();}
			Redraw();
		}
		
		public function ExitEdit(event:ContextMenuEvent):void
		{
			this.canvas.contextMenu=null;//
			
			this.eHandler.Deactive();			
			if(this.dHandler){this.dHandler.Deactive();this.dHandler.Destroy();}
			
			this.DeactiveAllControl();
			this.EvtObjRecover();
			this.handler=new Drag(this,null);
			this.handler.Active();
		}
		// 移走用于接受鼠标事件的Sprite
		public function EvtObjMoveAway():void
		{	
			//trace(this.evtObj.x);		
			if(this.evtObj)this.evtObj.x=-10000;			
		}
		public function EvtObjRecover():void
		{
			if(this.evtObj)this.evtObj.x=0;
		}
		public function ZoomIn(event:ContextMenuEvent,...arg):void
		{
			if(this.evtObj.x<0)this.EvtObjRecover();
			
			if(!this.IsValidate(this.zoom+1))return;
			var p:Point=this.GetViewCenterLonLat();
			if(arg && arg[0]){p=arg[0] as Point;p=this.GetLonLatFromGlobalPixel(p);}
			this.SetCenter(p,this.zoom+1,false);
		}
		public function ZoomOut(event:ContextMenuEvent,...arg):void
		{
			if(this.evtObj.x<0)this.EvtObjRecover();
			
			if(!this.IsValidate(this.zoom-1))return;
			var p:Point=this.GetViewCenterLonLat();
			if(arg && arg[0]){p=arg[0] as Point;p=this.GetLonLatFromGlobalPixel(p);}
			this.SetCenter(p,this.zoom-1,false);
		}
		
		public function Zoom2Level(level:int):void {
			if(!this.IsValidate(level)) {
				trace("the zoom level you set is: invalid");
				return;
			}
			var p:Point=this.GetViewCenterLonLat();
			this.SetCenter(p,level,false);
		}
		
		public function ZoomGlobe():void
		{
			var p:Point=new Point(114.22,30.57);//this.GetViewCenterLonLat();
			this.SetCenter(p,0,false);
		}		
		public function AddControl(control:Control):void
		{
			if(!this.ctrLayer)
			{this.ctrLayer=new Sprite();this.canvas.stage.addChild(this.ctrLayer);}
			
			control.dispatchEvent(new ControlEvent(ControlEvent.CONTROL_ADD,control,false,false));
			this.dispatchEvent(new MapControlEvent(MapControlEvent.MAP_ADDCONTROL,control,false,false));
			
			this.ctrLayer.addChild(control);//控件的位置由控件的x,y坐标控制
			this.controls.push(control);			
		}
		public function AddControls(ctrs:Array):void
		{
			for(var i:int=0;i<ctrs.length;i++)
			{
				this.AddControl(ctrs[i]);
			}
		}
		
		//如果图层都抽象出来了就可以
		public function RemoveLayer(layer:Layer):void
		{	
			for(var i:int=0;i<this.layers.length;i++)
			{
				if(layer.layername==this.layers[i].layername)
				{
					layer.dispatchEvent(new LayerEvent(LayerEvent.LAYER_REMOVE,layer,false,false));
					this.dispatchEvent(new MapLayerEvent(MapLayerEvent.MAP_REMOVELAYER,layer,false,false));
					
					this.layers.splice(i,1);
					
					for(var t:int=0;t<this.layers.length;t++)
					{trace(this.layers[t].layername);}
					
					/*if(layer.parent)*/layer.parent.removeChild(layer);
					return;
				}
			}
		}
		//只要开始调整好了raster,layer容器的位置就行了
		public function AddLayer(layer:Layer):void
		{
			//this.dispatchEvent(new MapEvent(MapEvent.MAP_ADDLAYER,this,false,false));
						
			if(layer.id.toUpperCase().indexOf("RASTER")>=0)
			{
				this.raster.addChild(layer);
			}
			else if(layer.id.toUpperCase().indexOf("VECTOR")>=0)
			{
				var v:Vector=layer as Vector;
				/*if(v.url)
				{
					for(var i:int=0;i<this.layers.length;i++)//免得重新加载，不过这样还是有图层实例化的动作
					{
						var vct:Vector=this.layers[i] as Vector;
						if(vct.url.toUpperCase()==v.url.toUpperCase() && vct.loaded=="LOADING")
						return;
					}
				}*/
				//如果图层不加到地图中是不会绘制的
				
				if(v.hidden)v.visible=false;
				if(!v.drawn && !v.hidden &&v.isValidate(this.zoom))v.Load("");
				this.vector.addChild(v);
			}			
			else if(layer.id.toUpperCase().indexOf("PATCHLAYER")>=0)
			{
				this.mark.addChild(layer);
			}
			this.layers.push(layer);
			
			this.dispatchEvent(new MapLayerEvent(MapLayerEvent.MAP_ADDLAYER,layer,false,false));
			this.dispatchEvent(new LayerEvent(LayerEvent.LAYER_ADD,layer,false,false));
		}

		public function RemoveControls(ctrs:Array):void
		{
			
		}
		public function RemoveControl(ctr:Control):void
		{	
			this.ctrLayer.removeChild(ctr);		
			for(var i:int=0;i<this.controls.length;i++)
			{
				if(ctr==this.controls[i] as Control)
				{
					ctr.dispatchEvent(new ControlEvent(ControlEvent.CONTROL_REMOVE,ctr,false,false));
					this.dispatchEvent(new MapControlEvent(MapControlEvent.MAP_REMOVECONTROL,ctr,false,false));
					
					Util.RemoveAItem(this.controls,i);
				}
			}	
		}
		public function LayersMove(e:MouseEvent):void
		{
			this.dispatchEvent(new MapLayerEvent(MapLayerEvent.MAP_MOVELAYER,null,false,false));
			
			//如此高频率的发送事件会让程序变慢，所以最多只能Map发送一次移动事件
			/*for(var i:int;i<this.layers.length;i++)
			{
				var l:Layer=this.layers[i] as Layer;
				l.dispatchEvent(new LayerEvent(LayerEvent.LAYER_MOVE,l,false,false));
			}*/
		}
		//OK
		public function SetResolutions():void
		{
			var ras:Object=this.raster_data[0];
			this.resolutions=new Array();			
			for(var i:int=0;i<ras.levels;i++)
			{
				this.resolutions.push(ras.maxRes*Math.pow(0.5,i));
			}			
		}
		//碰撞对象就是4个sprite，上下两个主要把y坐标定好，左右两个主要把x坐标定好，4个条状的碰撞对象相交成一个位于视图矩形内的矩形范围
		//这4个碰撞对象不用添加到舞台中就可以检测了
		public function SetHitObjs():void{
			//左边的碰撞对象
			this.hitObjs.push(this.GetSprite(new Rectangle(this.IMG_WIDTH*0.5,-4/2*this.IMG_HEIGHT,1,this.canvas.height+4*this.IMG_HEIGHT)));
			//右边的
			this.hitObjs.push(this.GetSprite(new Rectangle(this.canvas.width-this.IMG_WIDTH*0.5,-4/2*this.IMG_HEIGHT,1,this.canvas.height+4*this.IMG_HEIGHT)));
			//上面的
			this.hitObjs.push(this.GetSprite(new Rectangle(-this.IMG_WIDTH*2,0.5*this.IMG_HEIGHT,this.IMG_WIDTH*4+this.canvas.width,1)));
			//下面的
			this.hitObjs.push(this.GetSprite(new Rectangle(-this.IMG_WIDTH*2,this.canvas.height-0.5*this.IMG_HEIGHT,this.IMG_WIDTH*4+this.canvas.width,1)));
		}
		public function GetSprite(rec:Rectangle):Sprite{
			var s:Sprite=new Sprite();
			s.x=rec.x;
			s.y=rec.y;
			//不能指定s的宽高，否则会出错，画出透明的矩形代替Sprite
			s.graphics.beginFill(0x111,0);
			s.graphics.drawRect(0,0,rec.width,rec.height);
			s.graphics.endFill();
			return s;
		}
		//主要是计算偏移量,计算没有问题
		public function ParamsInit(center:Point):void
		{
			var xspan:Number=360/this.GetXCount();
			var xcenter:int=Math.floor((center.x+180)/xspan);
			var dx:Number=center.x+180-xcenter*xspan;			
			//trace(xcenter+","+xspan+","+dx);
			var addx:int=1;//dx==0?0:1;		//多缓存一点，直接取1算了	
			var colsC:int=Math.floor(this.canvas.width/this.IMG_WIDTH)+addx+2*this.buffer;
			var startc:int=xcenter-Math.floor((colsC-1)/2);//开始的列号
			var canvasDx:Number=-(Math.floor((colsC-1)/2)+dx/xspan)*this.IMG_WIDTH+this.canvas.width/2;//-dx*(this.IMG_WIDTH/xspan)-this.buffer*this.IMG_WIDTH;
			
			//计算Y的时候方向不同		
			var yspan:Number=180/this.GetYCount();
			var ycenter:int=Math.floor((center.y+90)/yspan);
			var dy:Number=Math.ceil((center.y+90)/yspan)*yspan-(center.y+90);
			var addy:int=1;//dy==0?0:1;		//多缓存一点，直接取1算了
			var rowsC:int=Math.floor(this.canvas.height/this.IMG_HEIGHT)+addy+2*this.buffer;	
			var startr:int=ycenter+Math.floor((rowsC-1)/2);//开始的行号，减去的1是center落在的栅格图
			var canvasDy:Number=-(Math.floor((rowsC-1)/2)+dy/yspan)*this.IMG_HEIGHT+this.canvas.height/2;//-dy*(this.IMG_HEIGHT/yspan)-this.buffer*this.IMG_HEIGHT;
			/*
			 *这里还缺一段对 startr和startc的越界处理
			 */
			//trace("ycenter:"+ycenter+" dy:"+dy+",canvasDy:"+canvasDy);
			//要保存的几个变量
			//trace("xspan:"+xspan+","+"yspan:"+yspan);
			this.colsCount=colsC;
			this.rowsCount=rowsC;
			this.startCol=startc;
			this.startRow=startr;	
			
			this.startDx=canvasDx;
			this.startDy=canvasDy;
			
			this.colsMoved=0;
			this.rowsMoved=0;
		}
		
		public function SetImgSrc():void
		{
			var startc:Number= this.startCol;
			var startr:Number=this.startRow;
			var colsC:Number=this.colsCount;
			var rowsC:Number=this.rowsCount;
			var loader:Loader;
			var request:URLRequest ;
			var path:String="";
			this.firstCantainer.x=this.startDx;
			this.firstCantainer.y=this.startDy;
			//如果this.imgs为空，则是初次加载，否则是缩放时候重新加载
			
			var sprite:GeoGlobe;
			if(this.imgs==null)
			{
				this.imgs=new Array();				
				//最开始raster的位置是和屏幕左上角对其的，但是其中的img不一定
				//其实this.raster搞成一个sprite， GeoGlobe放进去比较好，或者直接放在一个容器
	            sprite=new GeoGlobe(this,{"layername":"GeoGlobe","hidden":false});	 
	            this.layers.push(sprite);	            
	            this.raster.addChild(sprite);        
	            sprite.x=-startc*this.IMG_WIDTH;
	            sprite.y=-(this.GetYCount()-startr)*this.IMG_HEIGHT;
	            //左上角开始的	          	
	            for(var i:int=startr;i>startr-rowsC;i--)
	            {
	            	var arr:Array=new Array();
	            	for(var j:int=startc;j<startc+colsC;j++)
	            	{	//http://202.114.114.27?T=GloImage&L=0&X=1&Y=4
	            		//启动的时候所有栅格图都能够调到
	            		path=this.urlHost+"?T=GloImage&L="+(this.zoom)+"&X="+j+"&Y="+i;
	            		request = new  URLRequest(path);
	            		loader = new Loader();
	            		
	            		loader.x=j*this.IMG_WIDTH;
	            		loader.y=(this.GetYCount()-i)*this.IMG_HEIGHT;
	            		loader.cacheAsBitmap=true;//缓存一下图像，IE不会缓存这个东西的
	            							
	            		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,sprite.IoError,false,0,true); //加了这个以后，catch失效
	            		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,sprite.Complete);

	            		if(!sprite.hidden)
	            		loader.load(request);
			            sprite.addChild(loader);
	            		arr.push(loader);
	            	}
	            	this.imgs.push(arr);
	            } 
			}
			else
			{				
	            for(var c:int=0;c<this.raster.numChildren;c++)
	            {
	            	var rst:Raster=this.raster.getChildAt(c) as Raster;
	            	if(!rst.hidden)
	            	{
	            		trace("not hidden:"+rst.layername);
	            		//if(!this.IsValidate(this.zoom))return;
	            		rst.x=-startc*this.IMG_WIDTH;
	           			rst.y=-(this.GetYCount()-startr)*this.IMG_HEIGHT;
	            		rst.SetImgSrc();
	            	}
	            }
			}			
		}
		public function Complete(e:Event):void
		{
			var loaderInfo:LoaderInfo=e.target as LoaderInfo;
			trace(e.target+"-->>"+loaderInfo.url);
		}
		public function RasteComplete(e:Event,...arg):void
		{
			var map:Bitmap=e.target.content as Bitmap;			
			var x:Number=arg[0] as Number;
			var y:Number=arg[1] as Number;
			map.x=x;map.y=y;
			this.raster.addChild(map);
		}
		//ok，其实很大一部分应该写到栅格图层里头去，让抽象栅格类持有this.SetImgSrc()方法比较好
		public function LoadRasterToCenter(center:Point):void
		{
			//按照给定经纬度中心点加载，缩放比例还是读取全局变量			
			//计算出这种缩放级别的startCol
			this.ParamsInit(center);
			this.SetImgSrc();			
		}
		
		public function ChangeSrcFromVar(p:String):void
		{
			//trace("time to change:"+p);
			var length:int=this.imgs[0].length;	
			p=p.toUpperCase();
			//x方向left发生碰撞就是XL			
			if(p=="XL"||p=="LX")
			{
				var d:Number=this.startCol+this.colsMoved-1;
				if(d<0){return;}//坐标超界就不用搬动了	  trace("xl越界")				
				for(var i:int=0;i<this.raster.numChildren;i++)
				{
					var rst:Raster=this.raster.getChildAt(i) as Raster;
					if(!rst.hidden)
					{
						//if(!rst.isInRange(d,this.startRow+this.rowsMoved))break;
						rst.ChangeSrcFromVar(p);
					}
				}
				this.colsMoved--;				
			}
			else if(p=="XR"||p=="RX")
			{		
				d=(this.startCol+this.colsCount-1)+this.colsMoved+1;					
				if(d>20*Math.pow(2,this.zoom)-1){return;}//右边超界			
				for(i=0;i<this.raster.numChildren;i++)
				{
					rst=this.raster.getChildAt(i) as Raster;
					if(!rst.hidden)
					{
						//if(!rst.isInRange(d,this.startRow+this.rowsMoved))break;
						rst.ChangeSrcFromVar(p);
					}
				}
				this.colsMoved++;
			}
			//顶上撞了，src里头的y与img的y坐标是反向变化的
			else if(p=="YT"||p=="TY")
			{
				d=this.startRow+this.rowsMoved+1;
				if(d>10*Math.pow(2,this.zoom)-1){return;}
				for(i=0;i<this.raster.numChildren;i++)
				{
					rst=this.raster.getChildAt(i) as Raster;
					if(!rst.hidden)
					{
						//if(!rst.isInRange(this.startCol+this.colsCount,d))break;
						rst.ChangeSrcFromVar(p);
					}
				}
				this.rowsMoved++;
			}			
			else if(p=="YD"||p=="DY")
			{
				d=(this.startRow-this.rowsCount+1)+this.rowsMoved-1;
				if(d<0){return;}
				for(i=0;i<this.raster.numChildren;i++)
				{
					rst=this.raster.getChildAt(i) as Raster;
					if(!rst.hidden)
					{
						//if(!rst.isInRange(this.startCol+this.colsCount,d))break;
						rst.ChangeSrcFromVar(p);
					}
				}
				this.rowsMoved--;			
			}			
			
			//因为this.imgs里头img的位置发生了变化，所以我们要重新绑定碰撞事件,
			//this.canvas.removeEventListener(MouseEvent.MOUSE_MOVE,BindHitEvent);
			//this.canvas.addEventListener(MouseEvent.MOUSE_MOVE,NewBindHitEvent);//-----------  2
		}
		//在Drag中绑定MM，在鼠标按下并移动的时候检测栅格
		public function NewBindHitEvent(e:MouseEvent):void
		{
			var b:Number=128;//256;
			var x3:int=this.canvas.x-128-b;
			var y3:int=this.canvas.y-128-b;
			var x4:int=this.canvas.x+this.canvas.width-128+b;
			var y4:int=this.canvas.y+this.canvas.height-128+b;
			
			var x_index:int=this.imgs.length-1;
			var y_index:int=this.imgs[0].length-1;
			var p_tl:Point=new Point(this.imgs[0][0].x,this.imgs[0][0].y);
			//p_tl=this.imgs[0][0].parent.localToGlobal(p_tl);
			p_tl=this.imgs[0][0].localToGlobal(new Point(0,0));
			var p_br:Point=new Point(this.imgs[x_index][y_index].x,this.imgs[x_index][y_index].y);
			//p_br=this.imgs[0][0].parent.localToGlobal(p_br);
			p_br=this.imgs[x_index][y_index].localToGlobal(new Point(this.IMG_WIDTH_,this.IMG_HEIGHT_));
			
			//trace("p_tl:"+p_tl);
			//trace("p_br:"+p_br);
			if(p_tl.x>x3){this.ChangeSrcFromVar("XL");trace("xl");}
			if(p_tl.y>y3){this.ChangeSrcFromVar("YT");trace("yt");}
			if(p_br.x<x4){this.ChangeSrcFromVar("XR");/*trace("xr");*/}
			if(p_br.y<y4){this.ChangeSrcFromVar("YD");/*trace("yd");*/}
			
		}
		//以this.hitObjs中存储的对象为参考绑定检测碰撞的事件,碰撞参考是左右上下
		//this.canvas.addEventListener(MouseEvent.MOUSE_MOVE,bindHitEvent);
		//是否移动中的重新绑定
		public function BindHitEvent(isdown:Boolean):void{//本来是要传event:MouseEvent的
			//尽量使用中间点进行检测，this.hitObjs左右上下
			
//这里还可以加一个flag，让

			//需要检测碰撞的
			if(!isdown)return;//this.mstate.isdown
			//trace("BindHitEvent");
			var length:int=this.imgs[0].length;
			var horizontalM:int=Math.round(length/2);
			var verticalM:int=Math.round(this.imgs.length/2);
			
			if(this.imgs[verticalM][0].hitTestObject(this.hitObjs[0]))
			{this.ChangeSrcFromVar("XL");}
			else if(this.imgs[verticalM][length-1].hitTestObject(this.hitObjs[1]))
			{this.ChangeSrcFromVar("XR");}
			
			if(imgs[0][horizontalM].hitTestObject(this.hitObjs[2]))
			{this.ChangeSrcFromVar("YT");}//
			else if(this.imgs[this.imgs.length-1][horizontalM].hitTestObject(this.hitObjs[3]))
			{this.ChangeSrcFromVar("YD");}			
		}
		
		public function IoError(event: ErrorEvent):void
		{
			trace(event.text+","+event.target.url);
			//event.target.loader.load(new URLRequest(this.ErrImage));
			//trace(event.target.loaderURL);
		}		
		
		public function CloneSprite(sprite:Sprite):Sprite
		{
			var newSpt:Sprite=new Sprite();
			for(var key:Object in sprite)
			{
				newSpt[key]=sprite[key];
			}
			return newSpt;
		}
		public function getLayerByLayerName(lyrname:String):Layer
		{
			for(var i:Number=0;i<this.layers.length;i++)
			{
				var lyr:Layer=this.layers[i] as Layer;
				if(lyr.layername.toUpperCase()==lyrname.toUpperCase())
				return lyr;
			}
			return null;
		}
		
	 	/**
	 	 * get RasterLayer by layername in the map's layers
	 	 */  				
		public function GetRasterLayerByName(name:String):Raster
		{

			var layer:Layer = getLayerByLayerName(name);
			if (layer.id.toUpperCase().indexOf("RASTER")>=0)
			return (layer as Raster);				
			return null;
		}
		
		public function GetDestRec():Rectangle
		{
			var x:Number=-(this.startCol)*this.IMG_WIDTH;
			var y:Number=-(10*Math.pow(2,this.zoom)-this.startRow-1)*this.IMG_HEIGHT;
			//两个容器并没有完全对齐，
			var startc:Number= this.startCol;
			var startr:Number=this.startRow;
			x=-startc*this.IMG_WIDTH;;
			y=-(this.GetYCount()-startr)*this.IMG_HEIGHT+this.IMG_HEIGHT_;
			var width:Number=20*Math.pow(2,this.zoom)*this.IMG_WIDTH;
			var height:Number=10*Math.pow(2,this.zoom)*this.IMG_HEIGHT;
			return new Rectangle(x,y,width,height);
		}
		
		//鲂鱮
//////////////////////////////////////放大///////////////////////////////////////
		
		//这里以地图为基础，其他栅格图层跟着变化
		public function SetCenter(pt:Point,zoomLevel:int,isPx:Boolean):void
		{//isPx默认为false
			//trace("zoomLevel:"+zoomLevel);
			if(zoomLevel==this.zoom || !this.IsValidate(zoomLevel))
			{
				if(isPx)this.MoveToPx(pt);
				else this.MoveToLonLat(pt);				
			}
			else
			{
				//20080703--snapshot
				var dz:int=zoomLevel-this.zoom;
				this.showSnapShot(dz);	
				//-----				
				
				//trace("zoom:"+this.zoom+","+"zoomLevel:"+zoomLevel);
				this.zoom=zoomLevel;	
										
				if(isPx)pt=this.GetLonLatFromGlobalPixel(pt);	
				this.LoadRasterToCenter(pt);
				//GEOGLOBE是底图，底图不需要再搞，其他栅格图和这个对其就行了
				this.ResetMarkLayer();
				this.ReLoad(null);
				//trace("set center");				
			}			
		}
		
		public function showSnapShot(dz:int):void
		{
	        /**
	         * date: 	2008-07-03
	         * 
	         * zoom effect
	         * (1) move the snapshot 
	         * (2) resize it by scale 
	         * 
	         * results:
	         * (1) resize time controlled within 100-200-250ms, can appear closely to the loading data time
	         * larger than that, may feel loading data quicker than the resize
	         * slower than that, may feel resizing so quick that when it ends the data not loaded finished yet
	         * (2) need let no one feel the image before moving && the moving process
	         *  especially when zooming in
	         *  zooming out seems fine
	         */
	         
	         
			if(!this.snapShot)
			{
				this.snapShot=new Image();
				this.canvas.addChild(this.snapShot);
				this.snapShot.width=this.canvas.width;
				this.snapShot.height=this.canvas.height;	
				this.canvas.setChildIndex(this.snapShot,0);
			}
			
			var img:Image=this.snapShot;
			
			var s:Snapshot=new Snapshot();
			s.setLayer(this.canvas);// just raster, or the whole map (this.canvas)
			// if use this.raster as image, image location incorrect && error when no raster data
			if(!s.print(50))return;
			img.source=s.print(50);
			img.x = 0;
			img.y = 0;
			img.width = this.canvas.width;
			img.height = this.canvas.height;
			
			var scale:Number=Math.pow(2,dz);
						
			trace("img.width: " + img.width + " img.height: " + img.height);
			var dx:Number= -(img.width * scale - img.width) / 2;//this.canvas.width*(1-scale)/2;
			var dy:Number= -(img.height * scale - img.height) / 2;//this.canvas.height*(1-scale)/2;
			
			
			var m:Move=new Move(img);
			m.xFrom = img.x;
			m.yFrom = img.y;
			m.xTo = img.x + dx;
			m.yTo = img.x + dy;
			m.duration=5;
			m.end();
			m.play();
			
			var r:Resize=new Resize(img);
			r.widthFrom = img.width;
			r.widthTo = img.width * scale;
			r.heightFrom = img.height;
			r.heightTo = img.height * scale;
			r.duration = 100;
			r.end();
			r.play();
			
			//this.snapShot.width=this.canvas.width;
			//this.snapShot.height=this.canvas.height;	

			
			trace("scale:"+scale+"-->img.width"+img.width);
		}
		
		public function ResetMarkLayer():void
		{
			//this.mark.x=this.raster.x;
			//this.mark.y=this.raster.y;
			
			for(var i:int=0;i<this.mark.numChildren;i++)
			{
				var mkl:PatchLayer=this.mark.getChildAt(i) as PatchLayer;
				for(var j:int;j<mkl.numChildren;j++)
				{
					var mkImg:PatchImage=mkl.getChildAt(j) as PatchImage;
					if(mkImg.isValidate(this.zoom))
					{
						var p:Point=mkImg.leftTopGlobalPx;
						p=mkl.globalToLocal(p);
						mkImg.x=p.x;
						mkImg.y=p.y;
						mkImg.setScale();
						mkImg.visible=true;
					}
					else
					{
						mkImg.visible=false;
					}
				}
			}
		}
		public function IsValidate(zoom:int):Boolean
		{
			return (zoom>this.zooms.min-1) && (zoom<this.zooms.max+1);
		}
		//将中心点移到某个经纬度
		public function MoveToLonLat(lonlatPt:Point):void
		{
			var p:Point=new Point();
			p=this.GetGlobalPixelFromLonLat(lonlatPt);
			this.MoveToPx(p);
		}
		//px为全局坐标
		public function MoveToPx(px:Point):void
		{//不用对越界判断
			var v:Point=this.GetViewCenterPx();
			var goMove:Move=new Move(this.firstCantainer);
			goMove.addEventListener(TweenEvent.TWEEN_UPDATE,isMoving,false,0,true);
			goMove.xFrom=this.firstCantainer.x;
			goMove.yFrom=this.firstCantainer.y;
			goMove.xTo=this.firstCantainer.x+v.x-px.x;
			goMove.yTo=this.firstCantainer.y+v.y-px.y;
			goMove.duration=1000;
			
			goMove.end();
			goMove.play();
		}
		public function isMoving(e:TweenEvent):void
		{
			this.NewBindHitEvent(null);
			this.VectorDetect(null);
		}
		//是由栅格图层计算得来
		public function GetLonLatFromGlobalPixel(pxPt:Point):Point
		{	//以this.raster为局部坐标系，this.imgs[0][0]为参考点
			//坐标从全局转换到局部坐标系	
			
        	
			pxPt=this.activeRaster.globalToLocal(pxPt);
			var startlonlat:Point=this.GetStartLonLat();
			//trace("pxPt:"+pxPt);
			//trace(this.colsCount+","+this.rowsCount);
			var x_local:Number=this.imgs[0][0].x;
			var y_local:Number=this.imgs[0][0].y;
			//trace("xy_local:"+x_local+","+y_local);
			var lefttop_xindex:int=this.startCol+this.colsMoved;
			var lefttop_yindex:int=this.startRow+this.rowsMoved;
			//trace("leftyop_index:"+lefttop_xindex+","+lefttop_yindex);
			var lon:Number=this.GetLonFromXIndex(lefttop_xindex);
			var lat:Number=this.GetLatFromYIndex(lefttop_yindex);
			
			var lonlatPt:Point=new Point();
			lonlatPt.x=lon+(pxPt.x-x_local)*this.GetResolution();
			//Y是从顶上往下的，所以应该还要加一个单位，从而把计算起始点从底下移到顶上 
			lonlatPt.y=lat-(pxPt.y-y_local)*this.GetResolution();
			
			return lonlatPt;
		}
		
		public function ParseFromGlobalPxToLonLat(pts:Array):Array
		{
			var arr:Array=[];		
			for(var i:int=0;i<pts.length;i++)
			{
				arr.push(this.GetLonLatFromGlobalPixel(pts[i]));
			}
			return arr;
		}
		//从栅格图的X索引得到其左上角的经度
		public function GetLonFromXIndex(x:int):Number
		{
			var xcount:Number=this.GetXCount();
			return x/xcount*360-180;
		}
		//从栅格图的Y索引得到其左上角的纬度,Y方向要注意
		public function GetLatFromYIndex(y:int):Number
		{
			var ycount:Number=this.GetYCount();
			return (y+1)/ycount*180-90;
		}
		//当前缩放级别下X方向上有多少个栅格图
		public function GetXCount():Number
		{
			return 20*Math.pow(2,this.zoom);
		}
		public function GetYCount():Number
		{
			return 10*Math.pow(2,this.zoom);
		}
		public function GetZoom():int
		{
			return this.zoom;
		}
		//返回this.raster的经纬度
		public function GetStartLonLat():Point
		{
			var lon:Number=this.GetLonFromXIndex(this.startCol);
			var lat:Number=this.GetLatFromYIndex(this.startRow);
			return new Point(lon,lat);
		}
		//先转换到this.raster的局部坐标系中，然后再转行到屏幕坐标系
		public function GetGlobalPixelFromLonLat(lonlatPt:Point):Point
		{
			var pxPt:Point=new Point();
			var startlonlat:Point=this.GetStartLonLat();
			
			var x_local:Number=this.imgs[0][0].x;
			var y_local:Number=this.imgs[0][0].y;
			var lefttop_x:int=this.startCol+this.colsMoved;
			var lefttop_y:int=this.startRow+this.rowsMoved;
			var lon:Number=this.GetLonFromXIndex(lefttop_x);
			var lat:Number=this.GetLatFromYIndex(lefttop_y);
			//trace("--"+y_local+","+lat+","+this.GetLatFromYIndex(lefttop_y+1));
			//y的256搞这里真是龌龊
			pxPt.x=x_local+(lonlatPt.x-lon)/this.GetResolution();
			pxPt.y=y_local-(lonlatPt.y-lat)/this.GetResolution();
			return this.activeRaster.localToGlobal(pxPt);
		}
		//ok
		public function GetViewCenterPx():Point
		{
			var p:Point=new Point(this.canvas.width/2,this.canvas.height/2);			
			p=this.canvas.localToGlobal(p);
			return p;
		}
		public function GetViewCenterLonLat():Point
		{
			var p:Point=new Point(this.canvas.x+this.canvas.width/2,this.canvas.y+this.canvas.height/2);
			//将视图容器中间点的位置转行到栅格图容器中
			//p=this.GetPointFromLayerToLayer(p,this.canvas,this.ratser);
			return this.GetLonLatFromGlobalPixel(this.GetViewCenterPx());			
		}
		
		//容器间的坐标转换,有问题
		public function GetPointFromLayerToLayer(p:Point,source:Sprite,destination:Sprite):Point{
			var point:Point=new Point();
			point=source.localToGlobal(p);
			point=destination.globalToLocal(point);
			return point;
		}
		/////////////////////////测距，屏幕二维坐标和球面经纬度坐标///////////////////////////////
		public function GetLength(pts:Array,isGlobe:Boolean):Number
		{
			return Util.GetLengthFromPts(pts,isGlobe);
		}
		
		//不对，没有正确的将经纬度转换的算法，这里暂时用100公里代替，
		//在Util中有计算距离的方法
		//纬度 1°经度差对应的东西距离 
		//20° 104公里 
		//26° 100公里 
		//30° 96公里 
		//36° 90公里 
		//40° 85公里 
		//44° 80公里 
		//51° 70公里
		//向屏幕坐标x的正方向，栅格图的索引值是越来越大的，y的正方向栅格索引越来越小，
		//所以栅格图的坐标是反的，每个栅格图坐标都是顶上小，下面大，即整个坐标系在y方向反过来了
		public function ParseLengthToReal(l:Number):Number
		{
			return l*this.GetResolution()*100000;
		}
		public function GetResolution():Number
		{
			return this.resolutions[this.zoom];
		}
		
   /////////////////////////////数据集/////////////////////////////////////		
		public function LoadWuhan():void
		{
			//this.RemoveAllVectors();
			
			//var url:String="http://192.168.1.72:8081/geoserver/wfs?bbox=-124.731422,24.955967,-66.969849,49.371735&request=GetFeature&typename=topp:states&srs=EPSG:4326&&outputFormat=geojson";
			var url:String="http://192.168.1.229:8081/geoserver/wfs?bbox=-124.731422,24.955967,-66.969849,49.371735&request=GetFeature&typename=topp:states&srs=EPSG:4326&&outputFormat=geojson";
			var bbox:String="114.2,30.60,114.22,30.605";//武汉
			//bbox="-124.731422,24.955967,-66.969849,49.371735";//美国
			var server:String="http://192.168.1.229:8081/geoserver/wfs?bbox=";
			url=server+bbox+"&request=GetFeature&typename=topp:wuhan_buildings&srs=EPSG:4326&outputFormat=geojson";
			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
			this.AddLayer(new Vector(this,{"url":url,"layername":"wuhan_buildings","hidden":false}));
			
			url=server+bbox+"&request=GetFeature&typename=topp:wuhan_roads&srs=EPSG:4326&outputFormat=geojson";
			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
			this.AddLayer(new Vector(this,{"url":url,"layername":"wuhan_roads","hidden":false}));
			
			url=server+bbox+"&request=GetFeature&typename=topp:wuhan_dimings&srs=EPSG:4326&outputFormat=geojson";
			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
			var v:Vector=new Vector(this,{"url":url,"layername":"wuhan_dimings","hidden":false})
			this.AddLayer(v);
						
			/*url=server+bbox+"&request=GetFeature&typename=topp:wuhan_dimings&srs=EPSG:4326&outputFormat=geojson";
			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
			this.AddLayer(new Vector(this,{"url":url,"layername":"wuhan_dimings","hidden":true}));		
			*/
			//这个是GeoRSS数据
			//this.AddLayer(new RSSLayer(this,{"url":"reflect.xml","layername":"usa_georss","hidden":true}));
			
			//this.SetCenter(new Point(114.22909955978396,30.606085395812983),14,false);
			
		}
		//114.22909955978396,30.606085395812983//-84.7265625, 43.171875
		public function LoadUSA():void
		{	
			/*
			this.RemoveAllVectors();
			var url:String="http://192.168.1.229:8081/geoserver/wfs?bbox=-124.731422,24.955967,-66.969849,49.371735&request=GetFeature&typename=topp:states&srs=EPSG:4326&&outputFormat=geojson";
			var bbox:String="-124.731422,24.955967,-66.969849,49.371735";//美国
			var server:String="http://192.168.1.229:8081/geoserver/wfs?bbox=";
			url=server+bbox+"&request=GetFeature&typename=topp:states&srs=EPSG:4326&outputFormat=geojson";
			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
			this.AddLayer(new Vector(this,{"url":url,"layername":"USA","hidden":false}));
			this.SetCenter(new Point(-84.7265625, 43.171875),1,false);
			*/
		}
		public function LoadWorld():void
		{
			this.RemoveAllVectors();
			this.SetCenter(new Point(-84.7265625, 43.171875),0,false);
			
			var url:String="http://192.168.1.229:8081/geoserver/wfs?bbox=-124.731422,24.955967,-66.969849,49.371735&request=GetFeature&typename=topp:states&srs=EPSG:4326&&outputFormat=geojson";
			var bbox:String="-124.731422,24.955967,-66.969849,49.371735";//美国
			var server:String="http://192.168.1.229:8081/geoserver/wfs?bbox=";
			url=server+bbox+"&request=GetFeature&typename=topp:world_countries&srs=EPSG:4326&outputFormat=geojson";
			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
			this.AddLayer(new Vector(this,{"url":url,"layername":"world_countries","hidden":false}));
			
			url=server+bbox+"&request=GetFeature&typename=topp:world_rivers&srs=EPSG:4326&outputFormat=geojson";
			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
			this.AddLayer(new Vector(this,{"url":url,"layername":"world_rivers","hidden":true}));
			
			url=server+bbox+"&request=GetFeature&typename=topp:world_cities&srs=EPSG:4326&outputFormat=geojson";
			url=this.GetVectorUrl(this.GetVectorRecToLoad(),url);
			this.AddLayer(new Vector(this,{"url":url,"layername":"world_cities","hidden":true}));
			
		}
		public function RemoveAllVectors():void
		{
			/*//this.layers.length会变，所以不能
			for(var i:int=0;i<this.layers.length;i++)
			{
				var id:String=this.layers[i].id;
				if(id.toUpperCase().indexOf("VECTOR")>=0)
				this.RemoveLayer(this.layers[i]);
			}*/
			//栅格图只有一层
			while(this.layers.length>0)
			{
				var id:String=this.layers[0].id;
				if(id.toUpperCase().indexOf("VECTOR")>=0)
				this.RemoveLayer(this.layers[0]);
				else if(this.layers.length>=1 && this.layers[1].toUpperCase().indexOf("VECTOR")>=0)
				this.RemoveLayer(this.layers[1]);
			}
		}
		
		public function get  startCol_():int//起始列号 左上角
		{
			return this.startCol;
		}
		public function get  startRow_():int//起始行号
		{
			return this.startRow;
		}
		public function get  rowsCount_():int
		{
			return this.rowsCount;
		}
		public function get  colsCount_():int
		{
			return this.colsCount;
		}
		public function get  colsMoved_():int//x方向移动的格数
		{
			return this.colsMoved;
		}
		public function get  startDx_():int//x初始偏移，不足一个栅格的偏移量
		{
			return this.startDx;
		}
		public function get  startDy_():int//y初始偏移，不足一个栅格的偏移量
		{
			return this.startDy;
		}
		public function get resolutions_():Array
		{
			return this.resolutions;
		}
		public function get Width():Number
		{
			return this.canvas.width;
		}	
		public function get Height():Number
		{
			return this.canvas.height;
		}
		public function get IMG_WIDTH_():Number
		{
			return this.IMG_WIDTH
		}
		public function get IMG_HEIGHT_():Number
		{
			return this.IMG_HEIGHT
		}
		public function get rowsMoved_():Number
		{
			return this.rowsMoved;
		}
		public function get activeRaster():Raster
		{
			/*for(var i:int=0;i<this.raster.numChildren;i++)
			{
				var r:Raster=this.raster.getChildAt(i) as Raster;
				if(!r.hidden)return r;
			}*/
			//return this.raster.getChildAt(0) as Raster;
			return getRasterByLayername("geoglobe");
		}
		public function  getRasterByLayername(layername:String):Raster
		{
			for(var i:int=0;i<this.raster.numChildren;i++)
			{
				var r:Raster=this.raster.getChildAt(i) as Raster;
				if(r.layername.toUpperCase()==layername.toUpperCase())
				return r;
			}
			return null;
		}
		
		/**
		 * 
		 * 
		*/
		// 当结束编辑后，将所有适量对象进行重绘，即 使所有适量对象的外观为编辑前的状态
		private function Redraw():void{
			var vectors:Sprite=this.vector;			
			var lcount:int=vectors.numChildren;//矢量图层数			
			var slayer:Vector;//图层是Sprite
			var shape:GeoShape;
			
			for(var i:int=0;i<lcount;i++){
				slayer = vectors.getChildAt(i) as Vector;
				for(var j:int=0;j<slayer.numChildren;j++){
					shape = slayer.getChildAt(j) as GeoShape;
					if(shape.coords){
						//trace((shape.coords as Array).length);
					    var g:Graphics = shape.graphics;
					    if(shape.geotype == GEOTYPES.POLYGON){
					    	shape.x=0;//因为当拖动之后，shape:GeoShape的x,y坐标发生了变化，但是它所带有的coords属性还是按照x=0,y=0计算的
			                shape.y=0;
						    g.clear();
						   
						    DrawRings(shape,shape.coords as Array,slayer.symbol);
						}
						else if(shape.geotype == GEOTYPES.LINE){
							shape.x = 0;
							shape.y = 0;
							g.clear();
							g.lineStyle(2,0xff00ff,0.8);
							//DrawLines(shape,shape.coords as Array,13391257,0.6);
							var lineRing:Array;
							var total:Array = shape.coords as Array;
							DrawLns(shape,total,slayer.symbol);
						}
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
		
		//deal with the button event related to the  map
		public function upMMove(dy:Number):void
		{
			this.firstCantainer.y += dy;
			this.NewBindHitEvent(null);
			//this.VectorDetect(null);
		}

		public function downMMove(dy:Number):void
		{
			this.firstCantainer.y -=dy;
			this.NewBindHitEvent(null);
		}
		public function leftMMove(dx:Number):void
		{
			this.firstCantainer.x +=dx;
			this.NewBindHitEvent(null);
		}
		public function rightMMove(dx:Number):void
		{
			this.firstCantainer.x -=dx;
			this.NewBindHitEvent(null);
		}

	}
}