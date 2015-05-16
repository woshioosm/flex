package org.liesmars.flashwebclient.Handler 
{
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.Graphics;
	import org.liesmars.flashwebclient.Handler;
	import org.liesmars.flashwebclient.GeoMap;	
	
	
	
	/*
	 *拉框查询
	 */
	public class ZoomBox extends Handler
	{
		public var box:Sprite=null;
		public var lefttop:Point=null;
		
		public function ZoomBox(map:GeoMap,options:Object)
		{
			super(map,options);	
		}
		public override function Active():void
		{
			this.map.sprite.addEventListener(MouseEvent.MOUSE_DOWN,this.MD,false,0,true);
			this.map.sprite.stage.addEventListener(MouseEvent.MOUSE_UP,this.MU,false,0,true);
			this.map.sprite.addEventListener(MouseEvent.MOUSE_MOVE,this.MM,false,0,true);
			super.Active();
		}
		public override function Deactive():void
		{
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_DOWN,this.MD);
			this.map.sprite.stage.removeEventListener(MouseEvent.MOUSE_UP,this.MU);
			this.map.sprite.removeEventListener(MouseEvent.MOUSE_MOVE,this.MM);
			super.Deactive();
		}
		public function MD(e:MouseEvent):void
		{
			if(!this.box)
			{
				this.box=new Sprite();
//				this.map.vector.addChild(this.box);
				this.lefttop=new Point(e.stageX,e.stageY);
			}
		}
		public function MU(e:MouseEvent):void
		{
			var p:Point=new Point(e.stageX,e.stageY);
			if(this.box)
			{
				this.box.parent.removeChild(this.box);
//				var zoom:Number=Math.min(this.map.canvas.width/Math.abs(p.x-this.lefttop.x),this.map.canvas.height/Math.abs(p.y-this.lefttop.y));
//				zoom=Util.Log(2,zoom);
//				zoom=this.map.GetZoom()+zoom;
//				this.map.SetCenter(p,zoom,true);
				
				this.lefttop=null;
			}
		}
		public function MM(e:MouseEvent):void
		{
			var rightbottom:Point=new Point(e.stageX,e.stageY);
			if(this.box)
			{
				var p:Point;
				this.DrawBox(this.box,this.lefttop,rightbottom);
			}
		}
		public function DrawBox(s:Sprite,p1:Point,p2:Point):void
		{
			//这里是为了保证p1在左上角，p2在右下角
			var m:Number;
			if(p1.x>p2.x){m=p2.x;p2.x=p1.x;p1.x=m;}
			if(p1.y>p2.y){m=p2.y;p2.y=p1.y;p1.y=m;}
			trace(p1,p2);
			var width:Number=p2.x-p1.x;
			var height:Number=p2.y-p1.y;
			
			var g:Graphics=s.graphics;
			p1=s.parent.globalToLocal(p1);
			s.x=p1.x;
			s.y=p1.y;			
			g.clear();
			g.lineStyle(1,0xff9966,0.8);
			//g.beginFill(0x159,0.3);
			g.drawRect(0,0,width,height);
			//g.endFill();
		}
		public override function Destroy():void
		{}
	}
}