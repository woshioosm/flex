package org.liesmars.flashwebclient.Handler 
{
	import flash.events.KeyboardEvent;
//	import org.aswing.event.FocusKeyEvent;
	import flash.events.FocusEvent;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import org.liesmars.flashwebclient.Handler;
	import org.liesmars.flashwebclient.GeoMap;
		
	/*
	 *通过键盘操作地图 
	 */
	public class KeyMoveMap extends Handler
	{
		private var _timer:Number=-1;
		
		public function KeyMoveMap(map:GeoMap,options:Object)
		{
			super(map,options)
		}
		public override function Active():void
		{			
			this.map.sprite.stage.addEventListener(KeyboardEvent.KEY_UP,this.KeyUp);
			this.map.sprite.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.KeyDown);
		}
		public override function Deactive():void
		{			
			this.map.sprite.stage.removeEventListener(KeyboardEvent.KEY_UP,this.KeyUp);
			this.map.sprite.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.KeyDown);
		}	
		
		public function KeyDown(e:KeyboardEvent):void
		{
			var code:Number=e.keyCode;
			if(e.ctrlKey)
			{
				if(this._timer>=0)
					clearInterval(this._timer);
					
				if(code==37)
					this._timer=setInterval(Move,100,"left",20);
				else if(code==38)
					this._timer=setInterval(Move,100,"up",20);
				else if(code==39)
					this._timer=setInterval(Move,100,"right",20);
				else if(code==40)
					this._timer=setInterval(Move,100,"down",20);
				
			}
		}
		public function Move(po:String,dx:Number):void
		{
//			if(po.toUpperCase()=="LEFT")
//				this.map.firstCantainer.x+=dx;
//			else if(po.toUpperCase()=="RIGHT")
//				this.map.firstCantainer.x-=dx;
//			else if(po.toUpperCase()=="UP")
//				this.map.firstCantainer.y+=dx;
//			else if(po.toUpperCase()=="DOWN")
//				this.map.firstCantainer.y-=dx;
		}
		
		public function KeyUp(e:KeyboardEvent):void
		{
			var code:Number=e.keyCode;
			if(this._timer>=0 && !e.ctrlKey)
				clearInterval(this._timer);
			if(!e.ctrlKey)
			{
				if(code==37)
					Move("left",250);
				else if(code==38)
					Move("up",250);
				else if(code==39)
					Move("right",250);
				else if(code==40)
					Move("down",250);
			}
		}
	}
}