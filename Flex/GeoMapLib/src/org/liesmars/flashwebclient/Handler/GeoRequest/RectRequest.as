package org.liesmars.flashwebclient.Handler.GeoRequest
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GradientGlowFilter;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.containers.TitleWindow;
	import mx.controls.TextArea;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.liesmars.flashwebclient.*;
	import org.liesmars.flashwebclient.BaseTypes.*;
	
	public class RectRequest extends Handler
	{
		public var box:Sprite=null;
		public var lefttop:Point=new Point();
		public var ptCoord:Array = new Array();   //存储拉框矩形的顶点坐标
		public var nEffect:int = 0; 
		//pop up request information window
		public var dialog:TitleWindow;      
		public var data:TextArea = new TextArea();
		public var filter:Array = new Array();     //the object will be lighted when being selected
		public var pt:Point;
		public function RectRequest(map:GeoMap,options:Object)
		{
			super(map,options);
		}
		
		public override function Active():void
		{
			this.map.sprite.addEventListener(MouseEvent.MOUSE_DOWN,this.MD,false,0,true);
			this.map.sprite.addEventListener(MouseEvent.MOUSE_UP,this.MU,false,0,true);
			this.map.sprite.addEventListener(MouseEvent.MOUSE_MOVE,this.MM,false,0,true);
			super.Active();
			
		}
		public override function Deactive():void
		{
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_DOWN,this.MD);
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_UP,this.MU);
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_MOVE,this.MM);
			super.Deactive();
		}
		private function MD(e:MouseEvent):void
		{
			
				if(!this.box)
				{
					this.box=new Sprite();
					this.map.sprite.addChild(this.box);
					this.lefttop=new Point(e.stageX,e.stageY);
					this.ptCoord.push(this.lefttop);
					
				}
				trace("firstPT"+e.stageX+","+e.stageY);
			
		}
		private function MU(e:MouseEvent):void
		{
			var p:Point=new Point(e.stageX,e.stageY);
			trace("endPT:"+p)
			if(this.box&&this.box.parent)
			{
				this.box.parent.removeChild(this.box);
				this.lefttop=null;
				this.box = null;
			}
			this.ptCoord.push(p);
			this.pt = this.map.sprite.globalToLocal(p);
			var rightT:Pixel = new Pixel(this.ptCoord[1].x,this.ptCoord[0].y);
			var leftB:Pixel = new Pixel(this.ptCoord[0].x,this.ptCoord[1].y);
			var rightB:Pixel = new Pixel(this.ptCoord[1].x,this.ptCoord[1].y);
			var leftT:Pixel =  new Pixel(this.ptCoord[0].x,this.ptCoord[0].y);
			
			// mark rectangle request area
			var rect:Sprite = new Sprite();
			var graphics:Graphics = rect.graphics;
			this.map.sprite.addChild(rect);
			this.drawRectangle(rect,this.ptCoord[0],this.ptCoord[1],graphics);
			doRequest(rect);
			graphics.clear();  //控制最后一个矩形擦除与否
			
			this.ptCoord = new Array();   //清空存储数组
			trace("lonlat:"+leftT+rightT+leftB+rightB)
		}
		private function MM(e:MouseEvent):void
		{
			
			var rightbottom:Point=new Point(e.stageX,e.stageY);
			if(this.box)
			{
				var p:Point = new Point();
				p.x = this.ptCoord[0].x;
				p.y = this.ptCoord[0].y;
				var g:Graphics = this.box.graphics;
				this.DrawBox(this.box,p,rightbottom,g);
			}
		}
		private function DrawBox(s:Sprite,p1:Point,p2:Point,g:Graphics):void
		{
			
			if(s.parent)
			{
				g.clear();     //拉框效果
				drawRectangle(s,p1,p2,g);
			}
		}
		private function drawRectangle(s:Sprite,p1:Point,p2:Point,g:Graphics):void
		{
			var m:Number;
			//这里是为了保证p1在左上角，p2在右下角
			if(p1.x>p2.x){m=p2.x;p2.x=p1.x;p1.x=m;}
			if(p1.y>p2.y){m=p2.y;p2.y=p1.y;p1.y=m;}
			var width:Number=p2.x-p1.x;
			var height:Number=p2.y-p1.y;
			p1=s.parent.globalToLocal(p1);
			
			s.x=p1.x;
			s.y=p1.y;			
			
			g.lineStyle(1,0xff9966,0.8);
			g.beginFill(0xff0000,0.2);
			g.drawRect(0,0,width,height);
			g.endFill();
		}
		public override function Destroy():void
		{}
		
		private function closeWin(event:CloseEvent):void
		{
			PopUpManager.removePopUp(this.dialog);
			this.dialog = null;
			for(var i:int = 0; i < nEffect; i++)
			{
				if(filter[i]) filter[i].filters = null;  //no gradient filter effects when the window is closed
			}
			
		}
		
		private function doRequest(obj:Sprite):void
		{
			var ObjNames:String = new String();
			var lyrArr:Array = this.map.layers;
			var texts:String = new String();  // save the property of all the requested objects
			var n:int=0;   // count the number of requested objects 
			var charNum:int = 0;
			for(var i:int = 0; i < this.map.layers.length ; i++) //go throught all the layers 
			{
				var URL:String = lyrArr[i].url;
				//judge whether the layer is wfs layer and whether the layer is presented
				if((URL.charAt(URL.length-3)=="w")&&(URL.charAt(URL.length-2)=="f")&&(URL.charAt(URL.length-1)=="s")&&(lyrArr[i].visibility) ) 
				{
				  	var lyr:Layer = lyrArr[i];   // collect all the required layers
				  	for(var j:int = 0; j< lyr.numChildren; j++)
				  	{
//				  		trace(obj.hitTestObject(lyr.getChildAt(j)));
				  		if(obj.hitTestObject(lyr.getChildAt(j)))       // do the hitTest 
				  		{
							n++;
							this.nEffect++;
							var shp:GeoShape=lyr.getChildAt(j) as GeoShape;
							filter[this.nEffect-1] = shp;
							filter[this.nEffect-1].filters=[new GradientGlowFilter(2,45,[0xff0000,0x00ff00,0x0000ff],[1,0.4,1],[2,1,2],4,4,5)];//new GlowFilter(0xffff00,0.5,3,3,2)
							var text:String = new String();
							text+="第"+n+"个对象\r";
							text+="id:\t"+shp.id+"\r";
							text+="featuretype:\t"+shp.featuretype+"\r";
							text+="geotype:\t"+shp.geotype+"\r";
							text+="name:\t"+shp.name+"\r";	
							var dic:Dictionary=	shp.attributes as Dictionary;	
								
							for(var key:Object in dic)
							{
								text+=key+":\t"+dic[key]+"\r";
								if((shp.geotype == "line")&&(key.toString() == "name"))//deal with the condition that several objects shares one name
								{
									var ObjName:String = dic[key];
									ObjNames += ObjName;
									charNum += ObjName.length;
									trace("index:"+ObjNames.indexOf(ObjName))
									//judge if there are names repeated
									if((n > 1) && (ObjNames.indexOf(ObjName) >=0)&&(ObjNames.indexOf(ObjName)!= (charNum-ObjName.length)))
									{
										n -=1;
										text = "";
										break;
									}
									
								}
							}
							texts += text;					
							texts+="\r";	
											
						}
					}
			  		
				 }
			}  
			texts="对象总数:\t"+n+"\r\r"+texts;
			trace("text:"+texts);
			if(!this.dialog)
							{
								this.dialog=new TitleWindow();//这里是控件持有引用，不是handler
								PopUpManager.addPopUp(this.dialog,this.map.sprite,false);
							}
							this.dialog.x = pt.x;
							this.dialog.y = pt.y;
						    this.dialog.height = 240;
							this.dialog.title = "查询信息";
							this.dialog.showCloseButton = true;
							this.dialog.addEventListener(CloseEvent.CLOSE,closeWin);
				//			this.dialog.verticalScrollPolicy = ScrollPolicy.OFF;
							
							data.text = texts;
							data.height = 180;
							data.editable = false;
				//			data.horizontalScrollPolicy = ScrollPolicy.OFF;
				//			data.verticalScrollPolicy = ScrollPolicy.OFF;
							this.dialog.addChild(data);	
		}
		
		
	}
}